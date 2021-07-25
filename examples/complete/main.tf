module "hdinsight" {
  //  source  = "kumarvna/hdinsight/azurerm"
  //  version = "1.0.0"
  source = "../../"

  # By default, this module will not create a resource group. Location will be same as existing RG.
  # proivde a name to use an existing resource group, specify the existing resource group name, 
  # set the argument to `create_resource_group = true` to create new resrouce group.
  resource_group_name = "rg-shared-westeurope-01"

}
