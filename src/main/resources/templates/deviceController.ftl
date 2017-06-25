/*
* Copyright (c) 2017. bigmamonkey zhangshuocool@163.com
* Unless required by applicable law or agreed to in writing, software distributed under
* the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
* ANY KIND, either express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

package org.bigmonkey.robot.controller.manage;

import org.bigmonkey.robot.controller.BaseController;
import org.bigmonkey.robot.entity.po.${model.upperCaseName}Search;
import org.bigmonkey.robot.entity.po.SYS_User;
import org.bigmonkey.robot.entity.vo.ServerResult;
import org.bigmonkey.robot.entity.vo.VO_${model.upperCaseSimpleName};
import org.bigmonkey.robot.entity.vo.VO_DeviceSearch;
import org.bigmonkey.robot.entity.vo.VO_PageResult;
import org.bigmonkey.robot.service.IBaseInfoService;
import org.bigmonkey.robot.service.I${model.upperCaseSimpleName}Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;

/**
* Created by bigmamonkey on 6/13/17.
*/
@RequestMapping("/manage/${model.simpleName}")
@Controller
public class ${model.upperCaseSimpleName}Controller extends BaseController {

    @Autowired
    private IBaseInfoService baseInfoService;

    @Autowired
    private I${model.upperCaseSimpleName}Service ${model.simpleName}Service;

    @PostMapping("/list")
    @ResponseBody
    public ServerResult listAll${model.upperCaseSimpleName}(@RequestBody VO_DeviceSearch search) throws IllegalAccessException {
    List<${model.upperCaseName}Search> ${model.name}s = ${model.simpleName}Service.selectBySearch(search.getRoadId(), search.getStartTime(), search.getEndTime(), search.getName(), search.getCode(), search.getPageNo(), 15);
        int total = ${model.simpleName}Service.selectFoundRows();
        return success(new VO_PageResult(${model.name}s, total));
    }

    @PostMapping("/add")
    @ResponseBody
    public ServerResult add${model.upperCaseSimpleName}(@RequestBody VO_${model.upperCaseSimpleName} vo) {
        if(baseInfoService.selectCountByCode(vo.getCode()) > 0) {
            return error("存在设备编码相同的设备");
        }
        SYS_User sys_user = getUserInfoFromSession();
        vo.setDeviceType("${model.simpleName}");
        vo.setOrgId(sys_user.getOrgId());
        vo.setCreator(sys_user.getId());
        vo.setCreateTime(new Date());
        vo.setModifier(sys_user.getId());
        vo.setModifyTime(new Date());
        baseInfoService.insertSelective(vo);
        ${model.simpleName}Service.insertSelective(vo);
        return success(vo);
    }

    @PostMapping("/edit")
    @ResponseBody
    public ServerResult edit${model.upperCaseSimpleName}(@RequestBody VO_${model.upperCaseSimpleName} vo) throws IllegalAccessException {
        if(baseInfoService.selectCountByCodeAndId(vo.getCode(), vo.getId()) > 0) {
            return error("存在设备编码相同的设备");
        }
        vo.setModifier(getUserInfoFromSession().getId());
        vo.setModifyTime(new Date());
        baseInfoService.updateByPrimaryKeySelective(vo);
        if(checkNull(vo)) {
            ${model.simpleName}Service.updateByPrimaryKeySelective(vo);
        }
        return success();
    }

    @PostMapping("/remove")
    @ResponseBody
    public ServerResult remove${model.upperCaseSimpleName}(int id) {
        baseInfoService.deleteByPrimaryKey(id);
        ${model.simpleName}Service.deleteByPrimaryKey(id);
        return success();
    }
}