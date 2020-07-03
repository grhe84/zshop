<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>backend</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/file.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrapvalidator.min.css /">
  <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
  <script src="${pageContext.request.contextPath}/js/userSetting.js"></script>
  <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrapvalidator.min.js"></script>
  <script src="${pageContext.request.contextPath}/js/bootstrap-paginator.js"></script>
  <script>
    $(function(){
      //上传图像预览
      $('#product-image').on('change',function() {
        $('#img').attr('src', window.URL.createObjectURL(this.files[0]));
      });
      $('#pro-image').on('change',function() {
        $('#img2').attr('src', window.URL.createObjectURL(this.files[0]));
      });
    });
  </script>
</head>
<body>
<div class="panel panel-default" id="userPic">
  <div class="panel-heading">
    <h3 class="panel-title">商品管理</h3>
  </div>
  <div class="panel-body">
    <input type="button" value="添加商品" class="btn btn-primary" id="doAddPro">
    <br>
    <br>
    <div class="show-list text-center">
      <table class="table table-bordered table-hover" style='text-align: center;'>
        <thead>
          <tr class="text-danger">
            <th class="text-center">编号</th>
            <th class="text-center">商品</th>
            <th class="text-center">价格</th>
            <th class="text-center">产品类型</th>
            <th class="text-center">状态</th>
            <th class="text-center">操作</th>
          </tr>
        </thead>
        <tbody id="tb">
          <c:forEach items="${pageInfo.list}" var="product">
            <tr>
              <td>${product.id}</td>
              <td>${product.name}</td>
              <td>${product.price}</td>
              <td>${product.productTypePO.name}</td>
              <td>
                <c:if test="${product.productTypePO.status == 1}">有效商品</c:if>
                <c:if test="${product.productTypePO.status == 0}">无效商品</c:if>
              </td>
              <td class="text-center">
                <input
                  type="button"
                  class="btn btn-warning btn-sm doProModify"
                  onclick="showProduct(${product.id})"
                  value="修改"
                >
                <input
                  type="button"
                  class="btn btn-danger btn-sm doProDelete"
                  onclick="removeProduct(${product.id})"
                  value="删除"
                >
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <ul class="pagination"></ul>
    </div>
  </div>
</div>

<!-- 添加商品 start -->
<div class="modal fade" tabindex="-1" id="Product">
  <!-- 窗口声明 -->
  <div class="modal-dialog modal-lg">
    <!-- 内容声明 -->
    <form
      action="${pageContext.request.contextPath}/backend/product/add"
      class="form-horizontal"
      method="post"
      enctype="multipart/form-data"
      id="frmAddProduct"
    >
      <div class="modal-content">
        <!-- 头部、主体、脚注 -->
        <div class="modal-header">
          <button class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">添加商品</h4>
        </div>
        <div class="modal-body text-center row">
          <div class="col-sm-8">
            <div class="form-group">
              <label for="product-name" class="col-sm-4 control-label">商品名称：</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="product-name" name="name">
              </div>
            </div>
            <div class="form-group">
              <label for="product-price" class="col-sm-4 control-label">商品价格：</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="product-price" name="price">
              </div>
            </div>
            <div class="form-group">
              <label for="product-image" class="col-sm-4 control-label">商品图片：</label>
              <div class="col-sm-8">
                <a href="javascript:;" class="file">选择文件
                  <input type="file" name="file" id="product-image">
                </a>
              </div>
            </div>
            <div class="form-group">
              <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
              <div class="col-sm-8">
                <select class="form-control" name="productTypeId">
                  <option value="">--请选择--</option>
                  <c:forEach items="${productTypes}" var="productType">
                      <option value="${productType.id}">${productType.name}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
          </div>
          <div class="col-sm-4">
            <!-- 显示图像预览 -->
            <img style="width: 160px;height: 180px;" id="img">
          </div>
        </div>
        <div class="modal-footer">
          <button class="btn btn-primary" type="submit">添加</button>
          <button class="btn btn-primary cancel" data-dismiss="modal">取消</button>
        </div>
      </div>
    </form>
  </div>
</div>
<!-- 添加商品 end -->

<!-- 修改商品 start -->
<div class="modal fade" tabindex="-1" id="myProduct">
  <!-- 窗口声明 -->
  <div class="modal-dialog modal-lg">
    <!-- 内容声明 -->
    <form
      action="${pageContext.request.contextPath}/backend/product/modify"
      method="post"
      enctype="multipart/form-data"
      class="form-horizontal"
      id="frmModifyProduct"
    >
      <div class="modal-content">
        <!-- 头部、主体、脚注 -->
        <div class="modal-header">
          <button class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">修改商品</h4>
        </div>
        <div class="modal-body text-center row">
          <div class="col-sm-8">
            <div class="form-group">
              <label for="pro-num" class="col-sm-4 control-label">商品编号：</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="pro-num" name="id" readonly>
              </div>
            </div>
            <div class="form-group">
              <label for="pro-name" class="col-sm-4 control-label">商品名称：</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="pro-name" name="name">
              </div>
            </div>
            <div class="form-group">
              <label for="pro-price" class="col-sm-4 control-label">商品价格：</label>
              <div class="col-sm-8">
                <input type="text" class="form-control" id="pro-price" name="price">
              </div>
            </div>
            <div class="form-group">
              <label for="pro-image" class="col-sm-4 control-label">商品图片：</label>
              <div class="col-sm-8">
                <a class="file">
                  选择文件 <input type="file" name="file" id="pro-image">
                </a>
              </div>
            </div>
            <div class="form-group">
              <label for="product-type" class="col-sm-4 control-label">商品类型：</label>
              <div class="col-sm-8">
                <select class="form-control" id="pro-typeId" name="productTypeId">
                  <option value="">--请选择--</option>
                  <c:forEach items="${productTypes}" var="productType">
                      <option value="${productType.id}">${productType.name}</option>
                  </c:forEach>
                </select>
              </div>
            </div>
          </div>
          <div class="col-sm-4">
            <!-- 显示图像预览 -->
            <img style="width: 160px;height: 180px;" id="img2" src="" alt="无法显示图片">
          </div>
        </div>
        <div class="modal-footer">
            <button class="btn btn-primary updatePro" type="submit">修改</button>
            <button class="btn btn-default cancel" data-dismiss="modal">取消</button>
        </div>
      </div>
    </form>
  </div>
  <!-- 修改商品 end -->
</div>
</body>
</html>
<script type="text/javascript">
  if ('${addMsg}' == '添加成功') {
    layer.alert('${addMsg}', {
      icon: 1
    });
  } else if ('${addMsg}' == '添加失败') {
    layer.alert('${addMsg}', {
      icon: 2
    });
  }

  if ('${modifyMsg}' == '修改成功') {
    layer.alert('${modifyMsg}', {
      icon: 1
    });
  } else if ('${modifyMsg}' == '修改失败') {
    layer.alert('${modifyMsg}', {
      icon: 2
    });
  }

  // 分页插件
  $('.pagination').bootstrapPaginator({
    bootstrapMajorVersion: 3,
    currentPage: ${pageInfo.pageNum},
    totalPages: ${pageInfo.pages},
    pageUrl: function (type, page, current) {
      return '${pageContext.request.contextPath}/backend/product/findAll?pageNum=' + page;
    }
  });

  // 添加商品表单校验
  $('#frmAddProduct').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      name: {
        validators: {
          notEmpty: {
            message: '商品名称不能为空'
          },
          remote: {
            url: '${pageContext.request.contextPath}/backend/product/checkName',
            message: '该商品名称已存在'
          }
        }
      },
      price: {
        validators: {
          notEmpty: {
            message: '商品价格不能为空'
          },
          regexp: {
            regexp: /^\d+(\.\d+)?$/,
            message: '商品价格格式不正确'
          }
        }
      },
      file: {
        validators: {
          notEmpty: {
            message: '情选择商品图片'
          }
        }
      },
      productTypeId: {
        validators: {
          notEmpty: {
            message: '请选择商品类型'
          }
        }
      }
    }
  });

  // 修改商品表单校验
  $('#frmModifyProduct').bootstrapValidator({
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    fields: {
      name: {
        validators: {
          notEmpty: {
            message: '商品名称不能为空'
          }
        }
      },
      price: {
        validators: {
          notEmpty: {
            message: '商品价格不能为空'
          },
          regexp: {
            regexp: /^\d+(\.\d+)?$/,
            message: '商品价格格式不正确'
          }
        }
      },
      productTypeId: {
        validators: {
          notEmpty: {
            message: '请选择商品类型'
          }
        }
      }
    }
  });

  // 显示商品信息
  function showProduct(id) {
    $.post(
      '${pageContext.request.contextPath}/backend/product/findById',
      {'id': id},
      function (result) {
        if (result.status == 1) {
          $('#pro-num').val(result.data.id);
          $('#pro-name').val(result.data.name);
          $('#pro-price').val(result.data.price);
          $('#pro-typeId').val(result.data.productTypePO.id);
          $('#img2').attr('src', '${pageContext.request.contextPath}/backend/product/findImage?path=' +
            result.data.image);
        }
      }
    );
  }

  // 删除商品
  function removeProduct(id) {
    layer.confirm('是否删除该商品', {
      icon: 3,
      btn: ['确定', '取消']
    }, function () {
      $.post(
        '${pageContext.request.contextPath}/backend/product/removeById',
        {
          'id': id
        },
        function (result) {
          if (result.status == 1) {
            layer.alert(result.message, {
              icon: 1
            }, function () {
              location.href = '${pageContext.request.contextPath}/backend/product?pageNum=${pageInfo.pageNum}';
            });
          } else {
            layer.alert('删除失败', {
              icon: 2
            });
          }
        }
      );
    });
  }
</script>