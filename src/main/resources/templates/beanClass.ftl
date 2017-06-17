/*
* Copyright (c) 2017. bigmamonkey zhangshuocool@163.com
* Unless required by applicable law or agreed to in writing, software distributed under
* the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
* ANY KIND, either express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

package ${options.pons};

<#list model.pkgs as pkg>
import ${pkg};
</#list>

public class ${model.upperCaseName} {

    <#list model.fields as field>
    private ${field.columnType.javaType} ${field.name};
    </#list>

    <#list model.fields as field>
    public ${field.columnType.javaType} get${field.upperCaseName}() {
        return ${field.name};
    }

    public void set${field.upperCaseName}(${field.columnType.javaType} ${field.name}) {
        this.${field.name} = ${field.name}<#if field.columnType.javaType == "String"> == null ? null : ${field.name}.trim()</#if>;
    }
    <#sep>

    </#list>
}