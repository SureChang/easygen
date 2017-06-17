<template>
  <div id="ListWithFiltersPage">
    <!-- breadcrumb start  -->
    <Breadcrumb></Breadcrumb>
    <!-- breadcrumb end  -->
    <div class="db-content-inner">
      <!-- filters start -->
      <div class="filters">
        <div class="filter">
          <el-input placeholder="请输入设备名称" v-model.trim="filters.deviceName"></el-input>
        </div>
        <div class="filter">
          起止时间：
          <el-date-picker type="datetimerange" placeholder="选择时间范围" style="width:350px"
                          v-model="filters.startEndTime"></el-date-picker>
        </div>
        <el-button type="primary" @click="handleSearch()">搜索</el-button>
        <el-button type="primary" @click="createDialog = true">创建</el-button>
      </div>
      <!-- filters end -->

      <!-- table start  -->
      <el-table :data="cameras" ref="table" style="width: 100%" element-loading-text="数据加载中"
                stripe
                v-loading="loading"
                @selection-change="handleSelectionChange"
                @sort-change="handleSortChange">
        <el-table-column type="selection" width="55" :reserve-selection="reserveSelection"></el-table-column>
        <el-table-column prop="name" label="设备名称"></el-table-column>
        <el-table-column prop="code" label="设备编码"></el-table-column>
        <el-table-column prop="organization" label="所属机构"></el-table-column>
        <el-table-column prop="roadId" label="所属公路"></el-table-column>
        <el-table-column prop="posNo" label="桩号"></el-table-column>
        <el-table-column prop="productCode" label="设备型号"></el-table-column>
        <el-table-column prop="producer" label="生产厂商"></el-table-column>
        <el-table-column prop="acceptanceDate" label="验收日期"></el-table-column>
        <el-table-column prop="projectName" label="所属工程"></el-table-column>
        <el-table-column :context="_self" width="150" inline-template label="操作">
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
      <el-dialog title="编辑" v-model="editDialog" size="tiny">
        <el-form ref="editForm" :model="editForm" label-width="80px">
          <el-form-item label="设备名称">
            <el-input v-model.trim="editForm.name" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="设备编码">
            <el-input v-model.trim="editForm.code" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="所属机构">
            <el-input v-model.trim="editForm.organization" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="所属公路">
            <el-input v-model.trim="editForm.roadId" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="桩号">
            <el-input v-model.trim="editForm.posNo" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="设备型号">
            <el-input v-model.trim="editForm.productCode" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="生产厂商">
            <el-input v-model.trim="editForm.producer" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="验收日期">
            <el-date-picker class="el-col-24" type="datetime" placeholder="选择日期时间"
                            v-model="editForm.acceptanceDate">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="所属工程">
            <el-input v-model.trim="editForm.projectName" class="el-col-24"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editDialog = false">取 消</el-button>
          <el-button type="primary" @click="handleEditSave()">确 定</el-button>
        </span>
      </el-dialog>
      <!-- edit dialog end -->

      <!-- create dialog start -->
      <el-dialog title="保存" v-model="createDialog" size="tiny">
        <el-form ref="createFrom" :model="createForm" label-width="80px">
          <el-form-item label="设备名称">
            <el-input v-model.trim="createForm.name" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="设备编码">
            <el-input v-model.trim="createForm.code" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="所属机构">
            <el-input v-model.trim="createForm.organization" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="所属公路">
            <el-input v-model.trim="createForm.roadId" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="桩号">
            <el-input v-model.trim="createForm.posNo" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="设备型号">
            <el-input v-model.trim="createForm.productCode" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="生产厂商">
            <el-input v-model.trim="createForm.producer" class="el-col-24"></el-input>
          </el-form-item>
          <el-form-item label="验收日期">
            <el-date-picker class="el-col-24" type="datetime" placeholder="选择日期时间"
                            v-model="createForm.acceptanceDate">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="所属工程">
            <el-input v-model.trim="createForm.projectName" class="el-col-24"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="createDialog = false">取 消</el-button>
          <el-button type="primary" @click="handleSave()">确 定</el-button>
        </span>
      </el-dialog>
      <!-- create dialog end -->
    </div>
  </div>
</template>

<script type="text/ecmascript-6">
  import {
    fetchCameraList,
    addCamera,
    removeCamera,
    editCamera
  } from '../../api/index'

  export default {
    data () {
      return {
        cameras: [],
        total: 0,
        page: 0,
        loading: true,
        multipleSelection: [],
        reserveSelection: false,
        editDialog: false,
        createDialog: false,
        filters: {
          sortWay: {
            prop: 'createTime',
            order: 'descending'
          },
          deviceName: '',
          startEndTime: ''
        },
        editForm: {
          id: '',
          name: '',
          code: '',
          organization: '',
          roadId: '',
          posNo: '',
          productCode: '',
          producer: '',
          acceptanceDate: '',
          projectName: ''
        },
        createForm: {
          name: '',
          code: '',
          organization: '',
          roadId: '',
          posNo: '',
          productCode: '',
          producer: '',
          acceptanceDate: '',
          projectName: ''
        }
      }
    },

    methods: {
      formatDate (row) {
        return new Date(row.date).toLocaleDateString()
      },
      handleSortChange (sortWay) {
        this.filters.sortWay = {
          prop: sortWay.prop,
          order: sortWay.order
        }
        this.fetchData()
      },

      handleEditSave () {
        editCamera(this.editForm).then(() => {
          this.fetchData()
          this.editDialog = false

          this.$message({
            message: '编辑成功',
            type: 'success'
          })
        })
      },

      handleSave () {
        addCamera(this.createForm).then(() => {
          this.fetchData()
          this.createDialog = false

          this.$message({
            message: '保存成功',
            type: 'success'
          })
        })
      },

      handleEdit ($index, row) {
        this.editForm.id = row.id
        this.editForm.name = row.name
        this.editForm.code = row.code
        this.editForm.organization = row.organization
        this.editForm.roadId = row.roadId
        this.editForm.posNo = row.posNo
        this.editForm.productCode = row.productCode
        this.editForm.producer = row.producer
        this.editForm.acceptanceDate = row.acceptanceDate
        this.editForm.projectName = row.projectName
        this.editDialog = true
      },

      handleDelete ($index, row) {
        this.$confirm('是否删除此条数据?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          removeCamera({
            id: row.id
          }).then(() => {
            this.fetchData()
            this.$message({
              message: '删除成功',
              type: 'success'
            })
          })
        })
      },

      handleSelectionChange (val) {
        this.multipleSelection = val
      },

      handleSearch () {
        this.fetchData()
      },

      handleCurrentChange (val) {
        this.fetchData(val)
      },

      fetchData (page) {
        // param: sort way
        let sortWay = this.filters.sortWay && this.filters.sortWay.prop ? this.filters.sortWay : ''

        // param: page
        this.page = page || this.page

        // param: start time and end end time
        let startTime = (this.filters.startEndTime && this.filters.startEndTime[0] && this.filters.startEndTime[0].getTime()) || ''
        let endTime = (this.filters.startEndTime && this.filters.startEndTime[1] && this.filters.startEndTime[1].getTime()) || ''
        let options = {
          page: this.page,
          deviceName: this.filters.deviceName,
          startTime: startTime,
          endTime: endTime,
          sortWay: sortWay
        }

        this.loading = true

        fetchCameraList(options).then((res) => {
          // clear selection
          this.$refs.table.clearSelection()
          // lazy render data
          this.cameras = res.data.cameras
          this.total = res.data.total
          this.loading = false
        })
      }
    },

    mounted () {
      this.fetchData()
    }
  }
</script>

<style lang="stylus" rel="stylesheet/stylus">
  #ListWithFiltersPage
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

</style>