<template>
  <div id="${model.upperCaseSimpleName}ListWithFiltersPage">

    <!-- breadcrumb start  -->
    <Breadcrumb></Breadcrumb>
    <!-- breadcrumb end  -->

    <div class="db-content-inner">
      <div class="tree-content">
        <div class="operation">
          <label>请选择设备所属的高速公路：</label>
        </div>
        <el-tree ref="orgTree" :data="roadInfos" :props="defaultProps" node-key="id" :default-expanded-keys="[1]"
                 :highlight-current="true" :expand-on-click-node="false"
                 @current-change="handleCurrentNodeChange"></el-tree>
      </div>
      <div class="grid-content">
        <!-- filters start -->
        <div class="filters">
          <div class="filter">
            <el-input placeholder="请输入设备名称" v-model.trim="filters.deviceName"></el-input>
          </div>
          <div class="filter">
            <el-input placeholder="请输入设备编码" v-model.trim="filters.deviceCode"></el-input>
          </div>
          <div class="filter">
            起止时间：
            <el-date-picker type="daterange" placeholder="选择时间范围" style="width:350px"
                            v-model="filters.startEndTime"></el-date-picker>
          </div>
          <el-button type="primary" @click="handleSearch()">搜索</el-button>
          <el-button type="primary" @click="handleAdd()">创建</el-button>
        </div>
        <!-- filters end -->

        <!-- table start  -->
        <el-table :data="${model.simpleName}s" ref="table" style="width: 100%" element-loading-text="数据加载中"
                  stripe v-loading="loading">
          <el-table-column prop="code" label="设备编码" width="110px"></el-table-column>
          <el-table-column prop="name" label="设备名称"></el-table-column>
          <!--<el-table-column prop="orgName" label="所属机构"></el-table-column>-->
          <el-table-column prop="roadName" label="所属公路"></el-table-column>
          <el-table-column prop="posNo" label="桩号" width="80px"></el-table-column>
          <el-table-column prop="productName" label="设备型号"></el-table-column>
          <!--<el-table-column prop="projectName" label="所属工程"></el-table-column>-->
          <el-table-column prop="acceptDate" label="验收日期" :formatter="formatTime" width="110px"></el-table-column>
          <!--<el-table-column prop="builderName" label="承建商"></el-table-column>-->
          <el-table-column :context="_self" width="140px" inline-template label="操作">
            <div>
              <el-button size="small" @click="handleEdit($index, row)">编辑</el-button>
              <el-button size="small" type="danger" @click="handleDelete($index, row)">删除</el-button>
            </div>
          </el-table-column>
        </el-table>
        <!-- table end  -->

        <!-- pagination start  -->
        <div class="pagination-wrapper" v-show="!loading">
          <el-pagination
            layout="prev, pager, next"
            @current-change="handleCurrentChange"
            :total="total"
            :page-size="15">
          </el-pagination>
        </div>
        <!-- pagination end  -->

        <!-- edit dialog start -->
        <el-dialog title="编辑" v-model="editDialog" size="large" top="5%">
          <el-form ref="editForm" :model="editForm" :rules="${model.simpleName}Rules" label-width="100px">
            <el-row :gutter="50">
              <el-col :span="8">
                <el-form-item label="所属工程" prop="projectId">
                  <el-select v-model="editForm.projectId" placeholder="请选择">
                    <el-option
                      v-for="item in projects"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="设备名称" prop="name">
                  <el-input v-model.trim="editForm.name" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="设备编码" prop="code">
                  <el-input v-model.trim="editForm.code" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="设备型号" prop="productId">
                  <el-select v-model="editForm.productId" placeholder="请选择">
                    <el-option
                      v-for="item in products['${model.simpleName}']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="桩号" prop="posNo">
                  <el-input v-model.trim="editForm.posNo" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="安装位置" prop="installPos">
                  <el-select v-model="editForm.installPos" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['12']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="生产日期" prop="productDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="editForm.productDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="安装日期" prop="installDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="editForm.installDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="验收日期" prop="acceptDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="editForm.acceptDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="质保日期" prop="serviceDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="editForm.serviceDate">
                  </el-date-picker>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="供应商" prop="providerId">
                  <el-select v-model="editForm.providerId" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['13']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="承建商" prop="builderId">
                  <el-select v-model="editForm.builderId" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['11']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯方式" prop="lanType">
                  <el-select v-model="editForm.lanType" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['14']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯地址" prop="commAddress">
                  <el-input v-model.trim="editForm.commAddress" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="通讯运营商" prop="lanProvider">
                  <el-select v-model="editForm.lanProvider" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['15']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯号码" prop="lanPhoneNo">
                  <el-input v-model.trim="editForm.lanPhoneNo" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="图片" prop="posNo">
                  <el-upload
                    class="avatar-uploader"
                    action="/api/system/upload/device"
                    :multiple="false"
                    :show-file-list="false"
                    :on-success="handleEditImageSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="editForm.image" :src="'/api/images/' + editForm.image" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                </el-form-item>
              </el-col>
              <el-col :span="8">
              <#list model.fields as field>
                <#if field?index != 0>
                <#if field.dictType == 0>
                <#switch field.type>
                <#case "VARCHAR">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#case "INTEGER">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" type="number" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#case "FLOAT">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" type="number" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#default>
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" class="el-col-24"></el-input>
                </el-form-item>
                </#switch>
                <#else>
                <el-form-item label="${field.remarks}" prop="${field.name}">
                    <el-select v-model="createForm.${field.name}" placeholder="请选择">
                        <el-option
                                v-for="item in dictDatas['${field.dictType}']"
                                :key="item.id"
                                :label="item.name"
                                :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                </#if>
                </#if>
                </#list>
              </el-col>
            </el-row>
          </el-form>
          <span slot="footer" class="dialog-footer">
        <el-button @click="handleEditCancel()">取 消</el-button>
        <el-button type="primary" @click="handleEditSave()">确 定</el-button>
      </span>
        </el-dialog>
        <!-- edit dialog end -->

        <!-- create dialog start -->
        <el-dialog title="保存" v-model="createDialog" size="large" top="5%">
          <el-form ref="createForm" :model="createForm" :rules="${model.simpleName}Rules" label-width="100px">
            <el-row :gutter="50">
              <el-col :span="8">
                <el-form-item label="所属工程" prop="projectId">
                  <el-select v-model="createForm.projectId" placeholder="请选择">
                    <el-option
                      v-for="item in projects"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="设备名称" prop="name">
                  <el-input v-model.trim="createForm.name" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="设备编码" prop="code">
                  <el-input v-model.trim="createForm.code" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="设备型号" prop="productId">
                  <el-select v-model="createForm.productId" placeholder="请选择">
                    <el-option
                      v-for="item in products['${model.simpleName}']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.id">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="桩号" prop="posNo">
                  <el-input v-model.trim="createForm.posNo" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="安装位置" prop="installPos">
                  <el-select v-model="createForm.installPos" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['12']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="生产日期" prop="productDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="createForm.productDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="安装日期" prop="installDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="createForm.installDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="验收日期" prop="acceptDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="createForm.acceptDate">
                  </el-date-picker>
                </el-form-item>
                <el-form-item label="质保日期" prop="serviceDate">
                  <el-date-picker class="el-col-24" type="date" placeholder="选择日期时间"
                                  v-model="createForm.serviceDate">
                  </el-date-picker>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item label="供应商" prop="providerId">
                  <el-select v-model="createForm.providerId" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['13']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="承建商" prop="builderId">
                  <el-select v-model="createForm.builderId" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['11']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯方式" prop="lanType">
                  <el-select v-model="createForm.lanType" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['14']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯地址" prop="commAddress">
                  <el-input v-model.trim="createForm.commAddress" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="通讯运营商" prop="lanProvider">
                  <el-select v-model="createForm.lanProvider" placeholder="请选择">
                    <el-option
                      v-for="item in dictDatas['15']"
                      :key="item.id"
                      :label="item.name"
                      :value="item.value">
                    </el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="通讯号码" prop="lanPhoneNo">
                  <el-input v-model.trim="createForm.lanPhoneNo" class="el-col-24"></el-input>
                </el-form-item>
                <el-form-item label="图片" prop="posNo">
                  <el-upload
                    class="avatar-uploader"
                    action="/api/system/upload/device"
                    :multiple="false"
                    :show-file-list="false"
                    :on-success="handleAddImageSuccess"
                    :before-upload="beforeAvatarUpload">
                    <img v-if="createForm.image" :src="'/api/images/' + createForm.image" class="avatar">
                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                  </el-upload>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <#list model.fields as field>
                <#if field?index != 0>
                <#if field.dictType == 0>
                <#switch field.type>
                <#case "VARCHAR">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#case "INTEGER">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" type="number" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#case "FLOAT">
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" type="number" class="el-col-24"></el-input>
                </el-form-item>
                <#break>
                <#default>
                <el-form-item label="${field.remarks}" prop="${field.name}">
                  <el-input v-model.trim="createForm.${field.name}" class="el-col-24"></el-input>
                </el-form-item>
                </#switch>
                <#else>
                <el-form-item label="${field.remarks}" prop="${field.name}">
                    <el-select v-model="createForm.${field.name}" placeholder="请选择">
                        <el-option
                                v-for="item in dictDatas['${field.dictType}']"
                                :key="item.id"
                                :label="item.name"
                                :value="item.value">
                        </el-option>
                    </el-select>
                </el-form-item>
                </#if>
                </#if>
                </#list>
              </el-col>
            </el-row>
          </el-form>
          <span slot="footer" class="dialog-footer">
        <el-button @click="handleAddCancel()">取 消</el-button>
        <el-button type="primary" @click="handleAddSave()">确 定</el-button>
      </span>
        </el-dialog>
        <!-- create dialog end -->
      </div>
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  import {
    fetch${model.upperCaseSimpleName}List,
    add${model.upperCaseSimpleName},
    remove${model.upperCaseSimpleName},
    edit${model.upperCaseSimpleName}
  } from '../../api/manage'

  import {
    fetchRoadList,
    fetchProjectList,
    fetchProductList
  } from '../../api/common'

  import {
    fetchDictDataList
  } from '../../api/system'

  export default {
    data () {
      return {
        roadInfos: [],
        defaultProps: {
          children: 'children',
          label: 'name'
        },
        currentRoad: null,
        ${model.simpleName}s: [],
        total: 0,
        page: 0,
        loading: false,
        editDialog: false,
        createDialog: false,
        filters: {
          deviceName: '',
          deviceCode: '',
          startEndTime: ''
        },
        editForm: {
          id: '',
          projectId: '',
          name: '',
          code: '',
          productId: '',
          orgId: '',
          roadId: '',
          posNo: '',
          installPos: '',
          productDate: '',
          installDate: '',
          acceptDate: '',
          serviceDate: '',
          providerId: '',
          builderId: '',
          image: '',
          preDevice: '',
          nextDevice: '',
          lanType: '',
          commAddress: '',
          lanProvider: '',
          lanPhoneNo: '',
          <#list model.fields as field>
          <#if field?index != 0>
          <#if field.type == "VARCHAR">
          ${field.name}: ''<#sep>,
          <#elseif field.type == "INTEGER">
          ${field.name}: 0<#sep>,
          <#elseif field.type == "FLOAT">
          ${field.name}: 0<#sep>,
          <#else>
          ${field.name}: ''<#sep>,
          </#if>
          </#if>
          </#list>

        },
        createForm: {
          projectId: '',
          name: '',
          code: '',
          productId: '',
          orgId: '',
          roadId: '',
          posNo: '',
          installPos: '',
          productDate: '',
          installDate: '',
          acceptDate: '',
          serviceDate: '',
          providerId: '',
          builderId: '',
          image: '',
          preDevice: '',
          nextDevice: '',
          lanType: '',
          commAddress: '',
          lanProvider: '',
          lanPhoneNo: '',
          <#list model.fields as field>
          <#if field?index != 0>
          <#if field.type == "VARCHAR">
          ${field.name}: ''<#sep>,
          <#elseif field.type == "INTEGER">
          ${field.name}: 0<#sep>,
          <#elseif field.type == "FLOAT">
          ${field.name}: 0<#sep>,
          <#else>
          ${field.name}: ''<#sep>,
          </#if>
          </#if>
          </#list>

        },
        ${model.simpleName}Rules: {
          name: [
            { type: 'string', required: true, message: '请输入设备名称', trigger: 'blur' }
          ],
          code: [
            { type: 'string', required: true, message: '请输入设备编码', trigger: 'blur' }
          ],
          productId: [
            { type: 'integer', required: true, message: '请选择产品类型', trigger: 'change' }
          ],
          <#list model.fields as field>
          <#if field?index != 0>
          <#if field.type == "INTEGER">
          ${field.name}: [
              { type: 'integer', message: '${field.remarks}必须为整数', trigger: 'blur' }
          ]<#sep>,
          <#elseif field.type == "FLOAT">
          ${field.name}: [
              { type: 'number', message: '${field.remarks}必须为小数', trigger: 'blur' }
          ]<#sep>,
          </#if>
          </#if>
          </#list>

        },
        projects: [],
        products: [],
        dictDatas: [],
        fileList: []
      }
    },

    methods: {
      formatTime (row, column) {
        return new Date(row[column.property]).Format('yyyy-MM-dd')
      },
      handleAdd () {
        if (!this.currentRoad) {
          this.$message({
            message: '请先选择一个公路',
            type: 'warning'
          })
          return
        }
        this.createDialog = true
      },

      handleAddSave () {
        this.$refs['createForm'].validate((valid) => {
          if (!valid) {
            return false
          } else {
            this.createForm.roadId = this.currentRoad.id
            add${model.upperCaseSimpleName}(this.createForm).then(result => {
              this.handleAddCancel()
              this.load${model.upperCaseSimpleName}ByRoadId()
              this.$message({
                message: '创建成功',
                type: 'success'
              })
            })
          }
        })
      },

      handleAddCancel () {
        this.$refs['createForm'].resetFields()
        this.createForm.roadId = ''
        this.createDialog = false
      },

      handleEdit ($index, row) {
        this.editForm.id = row.id
        this.editForm.projectId = row.projectId
        this.editForm.name = row.name
        this.editForm.code = row.code
        this.editForm.productId = row.productId
        this.editForm.orgId = row.orgId
        this.editForm.roadId = row.roadId
        this.editForm.posNo = row.posNo
        this.editForm.installPos = row.installPos
        this.editForm.productDate = new Date(row.productDate)
        this.editForm.installDate = new Date(row.installDate)
        this.editForm.acceptDate = new Date(row.acceptDate)
        this.editForm.serviceDate = new Date(row.serviceDate)
        this.editForm.providerId = row.providerId
        this.editForm.builderId = row.builderId
        this.editForm.image = row.image
        this.editForm.preDevice = row.preDevice
        this.editForm.nextDevice = row.nextDevice
        this.editForm.lanType = row.lanType
        this.editForm.commAddress = row.commAddress
        this.editForm.lanProvider = row.lanProvider
        this.editForm.lanPhoneNo = row.lanPhoneNo

        <#list model.fields as field>
        <#if field?index != 0>
        this.editForm.${field.name} = row.${field.name}
        </#if>
        </#list>
        this.editDialog = true
      },

      handleEditSave () {
        this.$refs['editForm'].validate((valid) => {
          if (!valid) {
            return false
          } else {
            edit${model.upperCaseSimpleName}(this.editForm).then(result => {
              this.handleEditCancel()
              this.load${model.upperCaseSimpleName}ByRoadId()
              this.$message({
                message: '编辑成功',
                type: 'success'
              })
            })
          }
        })
      },

      handleEditCancel () {
        this.$refs['editForm'].resetFields()
        this.editForm.id = ''
        this.editForm.projectId = ''
        this.editForm.name = ''
        this.editForm.code = ''
        this.editForm.productId = ''
        this.editForm.orgId = ''
        this.editForm.roadId = ''
        this.editForm.posNo = ''
        this.editForm.installPos = ''
        this.editForm.productDate = ''
        this.editForm.installDate = ''
        this.editForm.acceptDate = ''
        this.editForm.serviceDate = ''
        this.editForm.providerId = ''
        this.editForm.builderId = ''
        this.editForm.image = ''
        this.editForm.preDevice = ''
        this.editForm.nextDevice = ''
        this.editForm.lanType = ''
        this.editForm.commAddress = ''
        this.editForm.lanProvider = ''
        this.editForm.lanPhoneNo = ''
        <#list model.fields as field>
        <#if field?index != 0>
        <#switch field.type>
        <#case "VARCHAR">
        this.editForm.${field.name} = ''
        <#break>
        <#case "INTEGER">
        this.editForm.${field.name} = 0
        <#break>
        <#case "FLOAT">
        this.editForm.${field.name} = 0
        <#break>
        <#default>
        this.editForm.${field.name} = ''
        </#switch>
        </#if>
        </#list>
        this.editDialog = false
      },

      handleDelete ($index, row) {
        this.$confirm('是否删除此条数据?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          remove${model.upperCaseSimpleName}({
            id: row.id
          }).then(() => {
            this.load${model.upperCaseSimpleName}ByRoadId()
            this.$message({
              message: '删除成功',
              type: 'success'
            })
          })
        })
      },

      handleSearch () {
        this.load${model.upperCaseSimpleName}ByRoadId()
      },

      handleCurrentChange (val) {
        this.load${model.upperCaseSimpleName}ByRoadId(val)
      },

      load${model.upperCaseSimpleName}ByRoadId (page) {
        this.page = page || this.page

        let startTime = (this.filters.startEndTime && this.filters.startEndTime[0] && this.filters.startEndTime[0].getTime()) || ''
        let endTime = (this.filters.startEndTime && this.filters.startEndTime[1] && this.filters.startEndTime[1].getTime()) || ''

        let conditions = {
          roadId: this.currentRoad.id,
          name: this.filters.deviceName,
          code: this.filters.deviceCode,
          startTime: startTime,
          endTime: endTime,
          pageNo: this.page
        }

        this.loading = true

        fetch${model.upperCaseSimpleName}List(conditions).then((res) => {
          this.${model.simpleName}s = res.data.result
          this.total = res.data.total
        }).finally(() => {
          this.loading = false
        })
      },

      loadInitData () {
        fetchRoadList().then(result => {
          this.roadInfos.splice(0, this.roadInfos.length)
          this.roadInfos.push(result.data)
        })

        fetchProjectList().then(result => {
          this.projects.splice(0, this.projects.length)
          result.data.forEach(p => this.projects.push(p))
        })

        fetchProductList().then(result => {
          this.products = result.data
        })

        fetchDictDataList().then(result => {
          this.dictDatas = result.data
        })
      },

      handleCurrentNodeChange (data, node) {
        this.currentRoad = data
        this.page = 1
        this.load${model.upperCaseSimpleName}ByRoadId()
      },

      handleAddImageSuccess (res, file) {
        this.createForm.image = res.data
      },

      handleEditImageSuccess (res, file) {
        this.editForm.image = res.data
      },

      beforeAvatarUpload (file) {
        const isJPG = file.type === 'image/jpeg'
        const isLt2M = file.size / 1024 / 1024 < 2

        if (!isJPG) {
          this.$message.error('上传头像图片只能是 JPG 格式!')
        }
        if (!isLt2M) {
          this.$message.error('上传头像图片大小不能超过 2MB!')
        }
        return isJPG && isLt2M
      }
    },

    mounted () {
      this.loadInitData()
    }
  }
</script>

<style lang="stylus" rel="stylesheet/stylus">
  #${model.upperCaseSimpleName}ListWithFiltersPage
    .tree-content
      float left
      top 0px
      left 0px
      width 250px
      margin 62px 10px 0px 0px
      .operation
        margin 0px 0px 20px 0px
    .grid-content
      margin-left 270px
      .filters
        margin 0 0 20px 0
        border 1px #efefef solid
        padding 10px
        background #f9f9f9
        .filter
          display inline-block
          width auto
          padding 10px
          border-radius 5px
          .el-select
            display inline-block
        .el-input
          width 150px
          display inline-block
      .pagination-wrapper
        text-align center
        padding 30px
      .avatar-uploader .el-upload {
        border 1px dashed #d9d9d9
        border-radius 6px
        cursor pointer
        position relative
        overflow hidden
      }
      .avatar-uploader .el-upload:hover {
        border-color #20a0ff
      }
      .avatar-uploader-icon {
        font-size: 28px
        color #8c939d
        width 178px
        height 178px
        line-height 178px
        text-align center
      }
      .avatar {
        width 300px
        height 300px
        display block
      }
</style>
