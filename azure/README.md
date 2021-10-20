# Azure

## Tips:
On `azure.tf` you have a `count` in both modules. This is used to create `n` instances from only one call. Do not remove it directly, instead, change the variable `number_of_instances` in the file `variables.tf` to the number os instances you want to create. 

### Advice
This is not very good yet, we are creating a LOT of network resources with no purpose. There is no necessity to create more than one `subnet` or `virtual network`. Probally we should create other module and dive the resources of the `azure_network_settings`, but this would create more complexity to the configuration. Let's check it further to see what we can achieve.