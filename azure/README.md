# Azure

## Tips:
On `azure.tf` you have a `count` in both modules. This is used to create `n` instances from only one call. Do not remove it directly, instead, change the variable `number_of_instances` in the file `variables.tf` to the number os instances you want to create. 
