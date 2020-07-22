<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>backend</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapvalidator.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" />
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
  <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrapvalidator.min.js"></script>
  <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
</head>
<body>
<!-- 系统用户管理 -->
<div class="panel panel-default" id="adminSet">
  <div class="panel-heading">
    <h3 class="panel-title">系统用户管理</h3>
  </div>
  <div class="panel-body">
    <div class="showmargersearch">
      <form
        class="form-inline"
        action="${pageContext.request.contextPath}/backend/sysuser/findByParam"
        method="post"
      >
        <div class="form-group">
          <label for="userName">姓名:</label>
          <input
            type="text"
            class="form-control"
            id="userName"
            placeholder="请输入姓名"
            name="name"
            value="${sysuserParam.name}"
          >
        </div>
        <div class="form-group">
          <label for="loginName">帐号:</label>
          <input
            type="text"
            class="form-control"
            id="loginName"
            placeholder="请输入帐号"
            name="loginName"
            value="${sysuserParam.loginName}"
          >
        </div>
        <div class="form-group">
          <label for="phone">电话:</label>
          <input
            type="text"
            class="form-control"
            id="phone"
            placeholder="请输入电话"
            name="phone"
            value="${sysuserParam.phone}"
          >
        </div>
        <div class="form-group">
          <label for="role">角色</label>
          <select class="form-control" name="roleId" id="role">
            <option
              value=""
              <c:if test="${sysuserParam.roleId == ''}">selected</c:if>
            >全部</option>
            <option
              value="1"
              <c:if test="${sysuserParam.roleId == 1}">selected</c:if>
            >商品专员</option>
            <option
              value="2"
              <c:if test="${sysuserParam.roleId == 2}">selected</c:if>
            >营销经理</option>
            <option
              value="3"
              <c:if test="${sysuserParam.roleId == 3}">selected</c:if>
            >超级管理员</option>
          </select>
        </div>
        <div class="form-group">
          <label for="status">状态</label>
          <select class="form-control" name="isValid" id="status">
            <option
              value="-1"
              <c:if test="${sysuserParam.isValid == ''}">selected</c:if>
            >全部</option>
            <option
              value="1"
              <c:if test="${sysuserParam.isValid == 1}">selected</c:if>
            >有效</option>
            <option
              value="0"
              <c:if test="${sysuserParam.isValid == 0}">selected</c:if>
            >无效</option>
          </select>
        </div>
        <input type="submit" value="查询" class="btn btn-primary" id="doSearch">
      </form>
    </div>
    <br>
    <input type="button" value="添加系统用户" class="btn btn-primary" id="doAddManger">
    <div class="show-list text-center" style="position: relative; top: 10px;">
      <table class="table table-bordered table-hover" style='text-align: center;'>
        <thead>
          <tr class="text-danger">
            <th class="text-center">序号</th>
            <th class="text-center">姓名</th>
            <th class="text-center">帐号</th>
            <th class="text-center">电话</th>
            <th class="text-center">邮箱</th>
            <th class="text-center">状态</th>
            <th class="text-center">注册时间</th>
            <th class="text-center">角色</th>
            <th class="text-center">操作</th>
          </tr>
        </thead>
        <tbody id="tb">
          <c:forEach items="${pageInfo.list}" var="sysuser">
            <tr>
              <td>${sysuser.id}</td>
              <td>${sysuser.name}</td>
              <td>${sysuser.loginName}</td>
              <td>${sysuser.phone}</td>
              <td>${sysuser.email}</td>
              <td>
                <c:if test="${sysuser.isValid == 1}">有效</c:if>
                <c:if test="${sysuser.isValid == 0}">无效</c:if>
              </td>
              <td>
                <fmt:formatDate value="${sysuser.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
              </td>
              <td>${sysuser.rolePO.name}</td>
              <td class="text-center">
                <input
                  type="button"
                  class="btn btn-warning btn-sm doMangerModify"
                  value="修改"
                  onclick="showSysuser(${sysuser.id})"
                >
                <c:if test="${sysuser.isValid == 1}">
                  <input
                    type="button"
                    class="btn btn-danger btn-sm doMangerDisable"
                    value="禁用"
                    onclick="modifySysuserStatus(${sysuser.id}, this)"
                  >
                </c:if>
                <c:if test="${sysuser.isValid == 0}">
                  <input
                    type="button"
                    class="btn btn-success btn-sm doMangerDisable"
                    value="启用"
                    onclick="modifySysuserStatus(${sysuser.id}, this)"
                  >
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <ul class="pagination"></ul>
    </div>
  </div>
</div>

<!-- 添加系统用户 start -->
<div class="modal fade" tabindex="-1" id="myMangerUser">
  <!-- 窗口声明 -->
  <div class="modal-dialog">
    <!-- 内容声明 -->
    <form id="frmAddSysuser">
      <div class="modal-content">
        <!-- 头部、主体、脚注 -->
        <div class="modal-header">
          <button class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">添加系统用户</h4>
        </div>
        <div class="modal-body text-center">
          <div class="row text-right">
            <label for="marger-username" class="col-sm-4 control-label">用户姓名：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="marger-username" name="name">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="marger-loginName" class="col-sm-4 control-label">登录帐号：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="marger-loginName" name="loginName">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="marger-password" class="col-sm-4 control-label">登录密码：</label>
            <div class="col-sm-4">
              <input type="password" class="form-control" id="marger-password" name="password">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="marger-phone" class="col-sm-4 control-label">联系电话：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="marger-phone" name="phone">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="marger-email" class="col-sm-4 control-label">联系邮箱：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" id="marger-email" name="email">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="role" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
            <div class="col-sm-4">
              <select class="form-control" name="roleId">
                <option value="">--请选择--</option>
                <option value="1">商品专员</option>
                <option value="2">营销经理</option>
                <option value="3">超级管理员</option>
              </select>
            </div>
          </div>
          <br>
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary add-Manger" type="button" onclick="addSysuser()">添加</button>
          <button class="btn btn-primary cancel" data-dismiss="modal" type="button">取消</button>
        </div>
      </div>
    </form>
  </div>
</div>
<!-- 添加系统用户 end -->

<!-- 修改系统用户 start -->
<div class="modal fade" tabindex="-1" id="myModal-Manger">
  <!-- 窗口声明 -->
  <div class="modal-dialog">
    <!-- 内容声明 -->
    <div class="modal-content">
      <!-- 头部、主体、脚注 -->
      <div class="modal-header">
        <button class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">系统用户修改</h4>
      </div>
      <form id="frmModifySysuser">
        <div class="modal-body text-center">
          <div class="row text-right">
            <label for="MargerStaffId" class="col-sm-4 control-label">用户编号：</label>
            <div class="col-sm-4">
              <input
                type="text"
                class="form-control"
                id="MargerStaffId"
                readonly="readonly"
                name="id"
              >
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="MargerStaffname" class="col-sm-4 control-label">用户姓名：</label>
            <div class="col-sm-4">
              <input
                type="text"
                class="form-control"
                id="MargerStaffname"
                name="name"
              >
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="MargerLoginName" class="col-sm-4 control-label">登录帐号：</label>
            <div class="col-sm-4">
              <input
                type="text"
                class="form-control"
                id="MargerLoginName"
                readonly="readonly"
                name="loginName"
              >
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="MargerPhone" class="col-sm-4 control-label">联系电话：</label>
            <div class="col-sm-4">
              <input
                type="text"
                class="form-control"
                id="MargerPhone"
                name="phone"
              >
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="MargerAdrees" class="col-sm-4 control-label">联系邮箱：</label>
            <div class="col-sm-4">
              <input
                type="text"
                class="form-control"
                id="MargerAdrees"
                name="email"
              >
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="MargerRole" class="col-sm-4 control-label">角&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;色：</label>
            <div class=" col-sm-4">
              <select class="form-control" id="MargerRole" name="roleId">
                <option value="">--请选择--</option>
                <option value="1">商品专员</option>
                <option value="2">营销经理</option>
                <option value="3">超级管理员</option>
              </select>
            </div>
          </div>
          <br>
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary doMargerModal" type="submit">修改</button>
          <button class="btn btn-default cancel" data-dismiss="modal">取消</button>
        </div>
      </form>
    </div>
  </div>
</div>
<!-- 修改系统用户 end -->
</body>
</html>
<script type="text/javascript">
  $('.pagination').bootstrapPaginator({
    bootstrapMajorVersion: 3,
    currentPage: ${pageInfo.pageNum},
    totalPages: ${pageInfo.pages},
    pageUrl: function (type, page, current) {
      return '${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum=' + page;
    }
  });

  // 修改系统用户表单校验
  $('#frmModifySysuser').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      name: {
        validators: {
          notEmpty: {
            message: '系统用户姓名不能为空'
          }
        }
      },
      phone: {
        validators: {
          notEmpty: {
            message: '联系电话不能为空'
          },
          regexp: {
            regexp: /^1[3456789]\d{9}$/,
            message: '联系电话格式不正确'
          }
        }
      },
      email: {
        validators: {
          notEmpty: {
            message: '联系邮箱不能为空'
          },
          regexp: {
            regexp: /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/,
            message: '联系邮箱格式不正确'
          }
        }
      },
      roleId: {
        validators: {
          notEmpty: {
            message: '角色不能为空'
          }
        }
      }
    }
  }).on('success.form.bv', function (e) {
    e.preventDefault();
    let $form = $(e.target);
    let bv = $form.data('bootstrapValidator');
    $.post(
      '${pageContext.request.contextPath}/backend/sysuser/modify',
      $form.serialize(),
      function (result) {
        if (result.status == 1) {
          layer.alert(
            result.message,
            {
              icon: 1
            },
            function () {
              location.href =
                '${pageContext.request.contextPath}/backend/sysuser/findByParam?pageNum=${pageInfo.pageNum}';
            }
          );
        } else {
          layer.alert(
            result.message,
            {
              icon: 2
            }
          );
        }
      }
    );
  });

  // 添加系统用户
  function addSysuser() {
    $.post(
      '${pageContext.request.contextPath}/backend/sysuser/add',
      $('#frmAddSysuser').serialize(),
      function (result) {
        if (result.status == 1) {
          layer.alert(result.message, {
            icon: 1
          }, function () {
            location.href = '${pageContext.request.contextPath}/backend/sysuser/findAll?pageNum=' + ${pageInfo.pageNum}
          });
        }
      }
    );
  }

  // 修改系统用户状态
  function modifySysuserStatus(id, btn) {
    $.post(
      '${pageContext.request.contextPath}/backend/sysuser/modifyStatus',
      {'id': id},
      function (result) {
        if (result.status == 1) {
          let $status = $(btn).parent().parent().children().eq(5);
          if ($status.text().trim() == '有效') {
            $status.text('无效');
            $(btn).val('启用').removeClass('btn-danger').addClass('btn-success');
          } else if ($status.text().trim() == '无效') {
            $status.text('有效');
            $(btn).val('禁用').removeClass('btn-success').addClass('btn-danger');
          }
        }
      }
    );
  }

  // 点击修改显示系统用户信息
  function showSysuser(id) {
    $.post(
      '${pageContext.request.contextPath}/backend/sysuser/findById',
      {'id': id},
      function (result) {
        if (result.status == 1) {
          $('#MargerStaffId').val(result.data.id);
          $('#MargerStaffname').val(result.data.name);
          $('#MargerLoginName').val(result.data.loginName);
          $('#MargerPhone').val(result.data.phone);
          $('#MargerAdrees').val(result.data.email);
          $('#MargerRole').val(result.data.rolePO.id);
        }
      }
    );
  }
</script>