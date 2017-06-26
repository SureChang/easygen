### easygen

一个灵活的通用代码生成框架

主要设计思路为：
分离模型与模板，以达到模型重用的目的，模型的加载由模型构建器完成，模型构建器支持自定义，以满足多样的代码生成需求。

框架的执行流程主要是：
- 1.easygen框架加载主配置文件config.json
- 2.根据config.json中modelBuilders模型构建器配置创建模型构建器。
- 3.根据config.json中的templates模板配置，顺序执行生成任务。
    - 3.1 根据模板的modelBuilderName属性，找到模板关联的模型构建器，并加载模型数据。
    - 3.2 freemarker利用模型数据和ftl模板文件（templateFilename属性指定）生成代码。
    - 3.3 freemarker根据指定的文件名（outputFilenameRule）和输出路径（outputPath）写入文件。

主要特色如下：

- 基于freemarker的模板语法，上手简单
- 内置mysql、json模型构建器，并支持自定义
  - 支持生成指定表、去掉表前缀、转换大小写等
- 支持模型与模板的一对多关系（模型与模板的分离）
- 支持List类型的模型，支持批量生成，也支持List生成单个文件。
- 支持自定义文件名生成规则
- 支持自定义输出路径
- 支持模板自定义参数
- 支持根据数据库remarks生成注释

###以下示例演示了应用于mybatis的代码生成使用。

1.首先下载easygen发布包 [下载](https://github.com/BigMaMonkey/easygen/releases)

解压后，包含以下几部分：
- easygen-1.0-SNAPSHOT.jar：这是easygen主程序，负责读取配置文件并生成代码
- config.json：这是easy主配置文件
- modelBuildrs：这里存放的是模型构建器的配置文件
- templates：这是里存放的是模板文件
- lib：这里存放的是easygen引用的第三方jar包

2.编写主配置文件

目录下的config.json为主配置文件, 发布包已经给出了一个比较完整的配置，包括型构建器配置和模板配置，包括生成bean、mapperclass、mapperxml、serviceInterface、serviceImpl、view、dbtojson（生成数据库元数据）很简单自己看配置和代码就行了。。。

```json
{
  "modelBuilders": [
    {
      "name": "mysql", // 构建器名称要唯一
      "type": "db:mysql", // 构建器类型目前只支持mysql和json两种
      "configPath": "modelBuilders/mysql.json" // 数据库配置和生成表指定
    },
    {
      "name": "json",
      "type": "json",
      "configPath": "modelBuilders/jsonModel.json" // 与mysql构建器不同的是，这里直接是模型数据，注意Json模型必须是数组,参考data.json
    },
    {
      "name": "http",
      "type": "custom", // 自定义的构建器
      "configPath": "modelBuilders/xxx.json", // 这个json反序列化类型需要在IModelBuilder的泛型参数中指出。
      "modelBuilderClassName": "org.BigMaMonkey.XXX.XXX" // 自定义的构建器需要实现类，实现org.bigmamonkey.core.IModelBuilder接口
    }
  ],
  "templates": [
    {
      "name": "jsonModel",
      "modelBuilderName": "json", // 关联的构建器名称，不是类型
      "templateFilename": "jsonModel.ftl", // ftl模板文件
      "outputPath": "output/jsonModel", // 输出目录，会自动递归创建目录。
      "outputFilenameRule": "jsonModel_{name}.xml", // 输出文件名规则，{}内变量为模型的字段field
      "options": {} // 自定义模板参数，可以在模板中使用，请自由发挥。
    },
    {
      "name": "dbToJson", //输出数据库元数据到Json
      "modelBuilderName": "mysql",
      "templateFilename": "dbToJson.ftl",
      "outputPath": "output/dbToJson",
      "outputFilenameRule": "dbToJson.json",
      "oneFile": true, //通过设置这个属性，可以将所有表的元数据输出到一个Template
      "options": {}
    },
    {
      "name": "mapperXml",
      "modelBuilderName": "mysql",
      "templateFilename": "mapperXml.ftl",
      "outputPath": "output/mapperXml",
      "outputFilenameRule": "{upperCaseName}Mapper.xml",
      "options": {
        "mapperns": "org.bigmonkey.robot.mapper",
        "pons": "org.bigmonkey.robot.entity.po"
      }
    },
    {
      "name": "beanClass",
      "modelBuilderName": "mysql",
      "templateFilename": "beanClass.ftl",
      "outputPath": "output/bean",
      "outputFilenameRule": "{upperCaseName}.java",
      "options": {
        "pons": "org.bigmonkey.robot.entity.po"
      }
    },
    {
      "name": "mapperClass",
      "modelBuilderName": "mysql",
      "templateFilename": "mapperClass.ftl",
      "outputPath": "output/mapper",
      "outputFilenameRule": "{upperCaseName}Mapper.java",
      "options": {
        "pons": "org.bigmonkey.robot.entity.po",
        "mpns": "org.bigmonkey.robot.mapper"
      }
    },
    {
      "name": "serviceInterface",
      "modelBuilderName": "mysql",
      "templateFilename": "serviceInterface.ftl",
      "outputPath": "output/service",
      "outputFilenameRule": "I{upperCaseSimpleName}Service.java",
      "options": {
        "pons": "org.bigmonkey.robot.entity.po",
        "itns": "org.bigmonkey.robot.service"
      }
    },
    {
      "name": "serviceImpl",
      "modelBuilderName": "mysql",
      "templateFilename": "serviceImpl.ftl",
      "outputPath": "output/service",
      "outputFilenameRule": "{upperCaseSimpleName}ServiceImpl.java",
      "options": {
        "pons": "org.bigmonkey.robot.entity.po",
        "imns": "org.bigmonkey.robot.service.impl"
      }
    },
    {
      "name": "view",
      "modelBuilderName": "mysql",
      "templateFilename": "view.ftl",
      "outputPath": "output/view",
      "outputFilenameRule": "{name}view.vue",
      "options": {}
    },
    {
      "name": "db-to-json",
      "modelBuilderName": "mysql",
      "templateFilename": "dbToJson.ftl",
      "outputPath": "output/json",
      "outputFilenameRule": "{name}.json",
      "options": {}
    }
  ]
}
```
3.编写模板
其实模板的编写很简单，你只需要掌握freemarker的ftl语法，以及基本的json知识就可以了。
这里只讲解mybatis内置构建器的使用

3.1.首先是构建器配置
```json
{
  "name": "mysql", // 构建器名称要唯一
  "type": "db:mysql", // 构建器类型目前只支持mysql和json两种
  "configPath": "modelBuilders/mysql.json" // 数据库配置和生成表指定
}
```
type中db:mysql指定使用内置的mysql构建器，configPath指定构建器的配置文件，配置如下：
```json
{
  "dbUrl": "jdbc:mysql://localhost:3306/device_manage",
  "driverClassName": "com.mysql.jdbc.Driver",
  "username": "root",
  "password": "root",
  "tables": "sys_user,pub_dict" // 用,分割指定生成的表名，也可以留空表示生成所有表
}
```
3.2.需要给出的是内置mysql构建器的模型结构，你才能在ftl中使用
```json
{
  "name": "sys_user", // 原始表名
  "upperCaseName": "SYS_User", // 前缀大写+首字符大写表名，用于创建PO、Mapper等
  "simpleName": "user", // 去掉前缀的表名，目前只支持_分割的表名，如sys_user
  "upperCaseSimpleName": "User", // simpleName的首字母大写形式
  "remarks": "系统用户", // 表注释
  "pkgs": [
    "java.util.Date" // 字段类型对应的Java包，import到java文件
  ],
  "fields": [
    {
      "name": "name", // 原始字段名
      "upperCaseName": "Name", // 首字母大写字段名
      "dataType": "12", // 字段类型值，对应 java.sql.Types中的枚举值
      "typeName": "VARCHAR", // 字段数据库类型，其他类型参见源码：TableField.java
      "columnSize": "32", // 字段大小
      "remarks": "名称", // 字段注释
      "columnType": {
        "javaType": "String", // 对应的java类型
        "pkg": null  // 基础类型为null，不需要import
      }
    }
  ],
  "primaryKey": {
    // 同field中的元素属性
  }
}
```
在ftl中模型的跟是model，例如你要在ftl中输出一个表名${model.name}, 又或者是主键的名称${model.primaryKey.name}

如果你在模板配置中设置了自定义模板参数options，请这样使用它${options.xxx}

通过在outputFilenameRule中使用{XXX}可以引用model中根属性，来自定义输出文件名，如{upperCaseName}Mapper.java

4.最后使用方式相当简单：

```cmd
java -jar easygen-0.0.2-SNAPSHOT.jar 
```
当然你也可以把代码的执行集成到你自己的项目或工具：

```java
public class App {
    public static void main(String[] args) {
        GeneratorManager generatorManager = new GeneratorManager();
        try {
            generatorManager.Start();
        } catch (Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
}
```