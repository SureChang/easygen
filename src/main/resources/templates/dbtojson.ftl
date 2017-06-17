{
  "tableName": "${model.name}",
  "fields": [
    <#list model.fields as field>
    {
      "fieldName": "${field.name}",
      "fieldType": "${field.typeName}"
    }<#sep>,
    </#list>

  ]
}