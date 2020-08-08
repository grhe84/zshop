<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>在线商城-后台管理系统</title>
  <meta charset="utf-8">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapvalidator.min.css" />
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/js/bootstrapvalidator.min.js"></script>
  <script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
</head>
<body>
<!-- 使用自定义css样式 div-signin 完成元素居中-->
<div class="container div-signin">
  <div class="panel panel-primary div-shadow">
    <!-- h3标签加载自定义样式，完成文字居中和上下间距调整 -->
    <div class="panel-heading">
      <h3>在线商城系统 3.0</h3>
      <span>ZSHOP Manager System</span>
    </div>
    <div class="panel-body">
      <!-- login form start -->
      <form
        class="form-horizontal"
        id="frmLogin"
        action="${pageContext.request.contextPath}/backend/sysuser/login"
        method="post"
      >
        <div class="form-group">
          <label class="col-sm-3 control-label">用户名：</label>
          <div class="col-sm-9">
            <input
              class="form-control"
              type="text"
              placeholder="请输入用户名"
              name="loginName"
            >
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">密&nbsp;&nbsp;&nbsp;&nbsp;码：</label>
          <div class="col-sm-9">
            <input
              class="form-control"
              type="password"
              placeholder="请输入密码"
              name="password"
            >
          </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label">验证码：</label>
          <div class="col-sm-4">
            <input
              id="verificationCode"
              class="form-control"
              type="text"
              placeholder="验证码"
              name="code"
            >
          </div>
          <div class="col-sm-2">
            <!-- 验证码 -->
            <img
              id="codeImage"
              class="img-rounded"
              src="${pageContext.request.contextPath}/backend/code/image"
              style="height: 32px; width: 70px;"
            />
          </div>
          <div class="col-sm-2">
            <button
              type="button"
              class="btn btn-link"
              onclick="reloadCode()"
            >
              看不清
            </button>
          </div>
        </div>
        <div class="form-group">
          <div class="col-sm-3"></div>
          <div class="col-sm-9 padding-left-0">
            <div class="col-sm-4">
              <button type="submit" class="btn btn-primary btn-block">登&nbsp;&nbsp;陆</button>
            </div>
            <div class="col-sm-4">
              <button type="reset" class="btn btn-primary btn-block">重&nbsp;&nbsp;置</button>
            </div>
            <div class="col-sm-4">
              <button type="button" class="btn btn-link btn-block">忘记密码？</button>
            </div>
          </div>
        </div>
      </form>
      <!-- login form end -->
    </div>
  </div>
</div>
<!-- 页尾 版权声明 -->
<div class="container">
  <div class="col-sm-12 foot-css">
    <p class="text-muted credit">
      Copyright 南京网博 版权所有
    </p>
  </div>
</div>
</body>
</html>
<script>
  if ('${loginMsg}' != '') {
    layer.msg('${loginMsg}', {
      icon: 2
    });
  }

  // 重新加载验证码
  function reloadCode() {
    $('#codeImage').attr('src', '${pageContext.request.contextPath}/backend/code/image?num=' + Math.random());
    $('#verificationCode').val('');
    $('#frmLogin').data('bootstrapValidator').resetForm();
  }

  // 登陆表单校验
  $('#frmLogin').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      loginName: {
        validators: {
          notEmpty: {
            message: '用户名不能为空'
          }
        }
      },
      password: {
        validators: {
          notEmpty: {
            message: '密码不能为空'
          }
        }
      },
      code: {
        validators: {
          notEmpty: {
            message: '验证码不能为空'
          },
          remote: {
            url: '${pageContext.request.contextPath}/backend/code/check',
            message: '验证码不正确'
          }
        }
      }
    }
  });
</script>