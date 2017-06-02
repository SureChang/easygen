# easygen

a flexible code generate framework

一个灵活的代码生产框架

主要设计思路是分离模型与模板，达到模型重用的目的，并支持自定义模型构建器，满足多样的代码生成需求。

主要特色如下：

- 基于freemarker的模板语法
- 内置mysql、json模型构建器，并支持自定义。（mysql数据源可指定生成表）
- 支持同一模型对多模板（模型与模板的分离）
- 支持List类型的模型，批量生成文件。
- 支持自定义文件名生成规则
- 支持自定义输出路径
- 支持模板自定义参数

使用说明和示例请参加项目：[easygen-mybatis](https://github.com/BigMaMonkey/easygen-mybatis)