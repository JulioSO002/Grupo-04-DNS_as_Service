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

# Eliminar las máquinas virtuales
az vm delete --resource-group $RESOURCE_GROUP_NAME --name $MAQUINA1 --yes
az vm delete --resource-group $RESOURCE_GROUP_NAME --name $MAQUINA2 --yes

# Eliminar la zona DNS privada
az network private-dns zone delete --resource-group $RESOURCE_GROUP_NAME --name $ZONE_NAME --yes

# Eliminar las Vnets y Subnets
az network vnet delete --resource-group $RESOURCE_GROUP_NAME --name $VNET1_NAME --yes
az network vnet delete --resource-group $RESOURCE_GROUP_NAME --name $VNET2_NAME --yes

# Eliminar el grupo de recursos
az group delete --name $RESOURCE_GROUP_NAME --yes
