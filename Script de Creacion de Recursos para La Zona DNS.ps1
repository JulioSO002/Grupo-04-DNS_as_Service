
# Declaración de variables
$RESOURCE_GROUP_NAME = "PRACTICAS1"
$LOCATION_1 = "eastus"
$LOCATION_2 = "westus"
$VNET1_NAME = "VNET1"
$SUBNET1_NAME = "SubNet1"
$VNET2_NAME = "VNET2"
$SUBNET2_NAME = "SubNet2"
$MAQUINA1 = "VM1"
$MAQUINA2 = "VM2"
$USER_NAME_1 = "usermp01"
$USER_NAME_2 = "usermp02"
$ZONE_NAME = "dominionuevoparadns01.com"

# Crear grupo de Recursos
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION_1

# Crear la zona DNS privada
az network private-dns zone create --resource-group $RESOURCE_GROUP_NAME --name $ZONE_NAME

# Crear la primera Vnet y SubNet en la región $LOCATION_1
az network vnet create --resource-group $RESOURCE_GROUP_NAME --name $VNET1_NAME --address-prefixes 10.1.0.0/16 --subnet-name $SUBNET1_NAME --subnet-prefixes 10.1.1.0/24 --location $LOCATION_1

# Crear la segunda Vnet y SubNet en la región $LOCATION_2
az network vnet create --resource-group $RESOURCE_GROUP_NAME --name $VNET2_NAME --address-prefixes 10.2.0.0/16 --subnet-name $SUBNET2_NAME --subnet-prefixes 10.2.1.0/24 --location $LOCATION_2

# Crear la primera máquina virtual asociada a $VNET1_NAME y con autenticación SSH
az vm create --resource-group $RESOURCE_GROUP_NAME --name $MAQUINA1 --location $LOCATION_1 --vnet-name $VNET1_NAME --subnet $SUBNET1_NAME --image UbuntuLTS --size Standard_DS1_v2 --authentication-type ssh --generate-ssh-keys --admin-username $USER_NAME_1

# Vincular la primera máquina virtual a la zona DNS privada
az network private-dns link vnet create --resource-group $RESOURCE_GROUP_NAME --zone-name $ZONE_NAME --name ${MAQUINA1}-link --virtual-network $VNET1_NAME --registration-enabled false

# Crear la segunda máquina virtual asociada a $VNET2_NAME y con autenticación SSH
az vm create --resource-group $RESOURCE_GROUP_NAME --name $MAQUINA2 --location $LOCATION_2 --vnet-name $VNET2_NAME --subnet $SUBNET2_NAME --image UbuntuLTS --size Standard_DS1_v2 --authentication-type ssh --generate-ssh-keys --admin-username $USER_NAME_2

# Vincular la segunda máquina virtual a la zona DNS privada
az network private-dns link vnet create --resource-group $RESOURCE_GROUP_NAME --zone-name $ZONE_NAME --name ${MAQUINA2}-link --virtual-network $VNET2_NAME --registration-enabled false

# Crear la configuración de Azure DNS
az network dns zone create --resource-group $RESOURCE_GROUP_NAME --name midominio.com

# Comprobar la resolución DNS para las máquinas virtuales
MAQUINA1_PRIVATE_IP=$(az vm show -g $RESOURCE_GROUP_NAME -n $MAQUINA1 --query "privateIps" -o tsv)
MAQUINA2_PRIVATE_IP=$(az vm show -g $RESOURCE_GROUP_NAME -n $MAQUINA2 --query "privateIps" -o tsv)

# Resolución DNS para la primera máquina virtual
az network dns record-set a list --resource-group $RESOURCE_GROUP_NAME --zone-name $ZONE_NAME --query "[?name=='${MAQUINA1}'].arecords[].ipv4Address" -o tsv

# Resolución DNS para la segunda máquina virtual
az network dns record-set a list --resource-group $RESOURCE_GROUP_NAME --zone-name $ZONE_NAME --query "[?name=='${MAQUINA2}'].arecords[].ipv4Address" -o tsv
