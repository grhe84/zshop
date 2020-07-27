<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>backend</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css"/>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapvalidator.min.css"/>
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
  <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
  <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrapvalidator.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
</head>
<body>
<div class="panel panel-default" id="userInfo">
  <div class="panel-heading">
    <h3 class="panel-title">客户管理</h3>
  </div>
  <div class="panel-body">
    <div class="showusersearch">
      <form class="form-inline" method="post">
        <div class="form-group">
          <label for="customer_name">姓名:</label>
          <input
            type="text"
            class="form-control"
            id="customer_name"
            name="name"
            placeholder="请输入姓名"
            size="15px"
          >
        </div>
        <div class="form-group">
          <label for="customer_loginName">帐号:</label>
          <input
            type="text"
            class="form-control"
            id="customer_loginName"
            name="loginName"
            placeholder="请输入帐号"
            size="15px"
          >
        </div>
        <div class="form-group">
          <label for="customer_phone">电话:</label>
          <input type="text" class="form-control" id="customer_phone" name="phone" placeholder="请输入电话" size="15px">
        </div>
        <div class="form-group">
          <label for="customer_address">地址:</label>
          <input type="text" class="form-control" id="customer_address" name="address" placeholder="请输入地址">
        </div>
        <div class="form-group">
          <label for="customer_isValid">状态:</label>
          <select class="form-control" id="customer_isValid" name="isValid">
            <option value="-1">全部</option>
            <option value="1">有效</option>
            <option value="0">无效</option>
          </select>
        </div>
        <input type="button" value="查询" class="btn btn-primary" id="doSearch">
      </form>
    </div>
    <br>
    <input type="button" value="添加客户" class="btn btn-primary" id="doAddCustomer">
    <div class="show-list text-center" style="position: relative;top: 30px;">
      <table class="table table-bordered table-hover" style='text-align: center;'>
        <thead>
        <tr class="text-danger">
          <th class="text-center">序号</th>
          <th class="text-center">姓名</th>
          <th class="text-center">帐号</th>
          <th class="text-center">电话</th>
          <th class="text-center">地址</th>
          <th class="text-center">状态</th>
          <th class="text-center">操作</th>
        </tr>
        </thead>
        <tbody id="tb">
        <c:forEach items="${pageInfo.list}" var="customer">
          <tr>
            <td>${customer.id}</td>
            <td>${customer.name}</td>
            <td>${customer.loginName}</td>
            <td>${customer.phone}</td>
            <td>${customer.address}</td>
            <td>
              <c:if test="${customer.isValid == 1}">有效</c:if>
              <c:if test="${customer.isValid == 0}">无效</c:if>
            </td>
            <td class="text-center">
              <input type="button" class="btn btn-primary btn-sm doModify" value="修改">
              <c:if test="${customer.isValid == 1}">
                <input type="button" class="btn btn-danger btn-sm doDisable" value="禁用">
              </c:if>
              <c:if test="${customer.isValid == 0}">
                <input type="button" class="btn btn-success btn-sm doDisable" value="启用">
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
<!-- 添加客户 start -->
<div class="modal fade" tabindex="-1" id="myModal-Customer">
  <!-- 窗口声明 -->
  <div class="modal-dialog">
    <!-- 内容声明 -->
    <form
      id="frmAddCustomer"
      class="form-horizontal"
      action="${pageContext.request.contextPath}/backend/customer/add"
      method="post"
    >
      <div class="modal-content">
        <!-- 头部、主体、脚注 -->
        <div class="modal-header">
          <button class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">添加客户</h4>
        </div>
        <div class="modal-body text-center">
          <div class="row text-right">
            <label for="name" class="col-sm-4 control-label">姓名：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" name="name">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="loginName" class="col-sm-4 control-label">帐号：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" name="loginName">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="phone" class="col-sm-4 control-label">电话：</label>
            <div class="col-sm-4">
              <input type="text" class="form-control" name="phone">
            </div>
          </div>
          <br>
          <div class="row text-right">
            <label for="adrees" class="col-sm-4 control-label">地址：</label>
            <div class="col-sm-4">
              <input type="email" class="form-control" name="address">
            </div>
          </div>
          <br>
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary add-Customer" type="submit">添加</button>
          <button class="btn btn-default cancel" data-dismiss="modal">取消</button>
        </div>
      </div>
    </form>
  </div>
</div>
<!-- 添加客户 end -->
<!-- 修改客户信息 start -->
<div class="modal fade" tabindex="-1" id="myModal">
  <!-- 窗口声明 -->
  <div class="modal-dialog">
    <!-- 内容声明 -->
    <div class="modal-content">
      <!-- 头部、主体、脚注 -->
      <div class="modal-header">
        <button class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">修改客户</h4>
      </div>
      <div class="modal-body text-center">
        <div class="row text-right">
          <label for="id" class="col-sm-4 control-label">编号：</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="id">
          </div>
        </div>
        <br>
        <div class="row text-right">
          <label for="name" class="col-sm-4 control-label">姓名：</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="name">
          </div>
        </div>
        <br>
        <div class="row text-right">
          <label for="loginName" class="col-sm-4 control-label">帐号：</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="loginName">
          </div>
        </div>
        <br>
        <div class="row text-right">
          <label for="phone" class="col-sm-4 control-label">电话：</label>
          <div class="col-sm-4">
            <input type="text" class="form-control" id="phone">
          </div>
        </div>
        <br>
        <div class="row text-right">
          <label for="adrees" class="col-sm-4 control-label">地址：</label>
          <div class="col-sm-4">
            <input type="email" class="form-control" id="adrees">
          </div>
        </div>
        <br>
      </div>
      <div class="modal-footer">
        <button class="btn btn-primary updateOne">修改</button>
        <button class="btn btn-default cancel" data-dismiss="modal">取消</button>
      </div>
    </div>
  </div>
</div>
<!-- 修改客户信息 end -->
</body>
</html>
<script type="text/javascript">
  // 分页插件
  $('.pagination').bootstrapPaginator({
    bootstrapMajorVersion: 3,
    currentPage: ${pageInfo.pageNum},
    totalPages: ${pageInfo.pages},
    pageUrl: function (type, page, current) {
      return '${pageContext.request.contextPath}/backend/customer/findAll?pageNum=' + page;
    }
  });

  if ('${updateMsg}' != '') {
    layer.msg('${updateMsg}', {
      icon: 1
    });
  }

  // 添加客户表单校验
  $('#frmAddCustomer').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      name: {
        validators: {
          notEmpty: {
            message: '姓名不能为空'
          }
        }
      },
      loginName: {
        validators: {
          notEmpty: {
            message: '账号不能为空'
          },
          remote: {
            url: '${pageContext.request.contextPath}/backend/customer/checkLoginName',
            message: '账号已存在'
          }
        }
      },
      phone: {
        validators: {
          notEmpty: {
            message: '电话不能为空'
          },
          regexp: {
            regexp: /^1[3456789]\d{9}$/,
            message: '电话格式不正确'
          }
        }
      },
      address: {
        validators: {
          notEmpty: {
            message: '地址不能为空'
          }
        }
      }
    }
  });
</script>