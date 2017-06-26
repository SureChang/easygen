[<#list model as table>{
  "name": "${table.name}",
  "upperCaseName": "${table.upperCaseName}",
  "simpleName": "${table.simpleName}",
  "upperCaseSimpleName": "${table.upperCaseSimpleName}",
  "fields": [
    <#list table.fields as field>
    {
      "name": "${field.name}",
      "type": "${field.typeName}",
      "dictType": 0,
      "remarks": "${field.remarks}"
    }<#sep>,</#list>]
}<#sep>,</#list>]