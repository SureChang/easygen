/*
* Copyright (c) 2017. bigmamonkey zhangshuocool@163.com
* Unless required by applicable law or agreed to in writing, software distributed under
* the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
* ANY KIND, either express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

package ${options.imns};

import ${options.pons}.${model.upperCaseName};
import ${options.mpns}.${model.upperCaseName}Mapper;
import ${options.itns}.I${model.upperCaseSimpleName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ${model.upperCaseSimpleName}ServiceImpl implements I${model.upperCaseSimpleName}Service {

    @Autowired
    ${model.upperCaseName}Mapper ${model.name}Mapper;

    @Override
    public int deleteByPrimaryKey(${model.primaryKey.columnType.javaType} ${model.primaryKey.name}) {
        return ${model.name}Mapper.deleteByPrimaryKey(${model.primaryKey.name});
    }

    @Override
    public int insert(${model.upperCaseName} record) {
        return ${model.name}Mapper.insert(record);
    }

    @Override
    public int insertSelective(${model.upperCaseName} record) {
        return ${model.name}Mapper.insertSelective(record);
    }

    @Override
    public List<${model.upperCaseName}> selectAll() {
        return ${model.name}Mapper.selectAll();
    }

    @Override
    public ${model.upperCaseName} selectByPrimaryKey(${model.primaryKey.columnType.javaType} ${model.primaryKey.name}) {
        return ${model.name}Mapper.selectByPrimaryKey(${model.primaryKey.name});
    }

    @Override
    public int updateByPrimaryKeySelective(${model.upperCaseName} record) {
        return ${model.name}Mapper.updateByPrimaryKeySelective(record);
    }

    @Override
    public int updateByPrimaryKey(${model.upperCaseName} record) {
        return ${model.name}Mapper.updateByPrimaryKey(record);
    }
}