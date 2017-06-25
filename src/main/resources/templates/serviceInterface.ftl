/*
* Copyright (c) 2017. bigmamonkey zhangshuocool@163.com
* Unless required by applicable law or agreed to in writing, software distributed under
* the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
* ANY KIND, either express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

package ${options.itns};

import ${options.pons}.${model.upperCaseName};
import java.util.List;

public interface I${model.upperCaseSimpleName}Service {

    int deleteByPrimaryKey(${model.primaryKey.columnType.javaType} ${model.primaryKey.name});

    int insert(${model.upperCaseName} record);

    int insertSelective(${model.upperCaseName} record);

    List<${model.upperCaseName}> selectAll();

    ${model.upperCaseName} selectByPrimaryKey(${model.primaryKey.columnType.javaType} ${model.primaryKey.name});

    int updateByPrimaryKeySelective(${model.upperCaseName} record);

    int updateByPrimaryKey(${model.upperCaseName} record);
}