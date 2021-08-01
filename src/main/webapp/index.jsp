<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: xc
  Date: 2021/7/30/030
  Time: 21:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>homePage</title>

    <%
        /*不以/开始的目录,找资源是从当前目录为基准
         * 以/开始的目录,找资源是从当前项目服务器的路径(http://localhost:3306/)为基准*/
        pageContext.setAttribute("APP_PATH",request.getContextPath()); // http://localhost:3306/projectName
    %>
    <link rel="stylesheet" href="${APP_PATH}/static/css/bootstrap.css"> <%--报错不要管,统一使用APP_PATH--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.5.1.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1 class="text-center">EmployeeList</h1>
        </div>
    </div>
    <div class="row">
        <button class="btn btn-primary col-md-1 col-md-offset-9">
            <span>Append</span>
        </button>
        <button class="btn btn-danger col-md-1">
            <span>Remove</span>
        </button>
    </div>

    <table style="font-size: 20px" class="table table-hover table-responsive table-condensed text-center">
        <div class="row">
            <div class="col-md-2">
                <tr>
                    <td>EmployeeId</td>
                    <td>EmployeeName</td>
                    <td>WorkYear</td>
                    <td>DepartmentId</td>
                    <td>UpdateOption</td>
                </tr>
            </div>
        </div>
        <%--<c:forEach items="&lt;%&ndash;pi.list&ndash;%&gt;" var="i">
            <div class="row">
                <div class="col-md-2">
                    <tr>
                        <td>${i.employeeid}</td>
                        <td>${i.employeename}</td>
                        <td>${i.workyears}</td>
                        <td>${i.departmentid}</td>
                        <td><button class="btn btn-info">
                            <span class="glyphicon glyphicon-pencil">Modify</span>
                        </button>
                            <button class="btn btn-warning">
                                <span class="glyphicon glyphicon-remove">Delete</span>
                            </button>
                        <td>
                    </tr>
                </div>
            </div>
        </c:forEach>--%>
    </table>
    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <p class="text-center">
                <b>当前第 页,共有 页,总计 条记录</b>
            </p>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6 col-md-offset-8">
            <ul class="pagination">

                <%--在第一页不能点上一页--%>


               <%-- <c:if test="${pi.isFirstPage}">
                    <li class="disabled"><a>FP</a></li>
                    <li class="disabled"><a>&laquo;</a></li>
                </c:if>
                <c:if test="${!pi.isFirstPage}">
                    <li><a href="${APP_PATH}/emp?pn=1">FP</a></li>
                    <li><a href="${APP_PATH}/emp?pn=${pi.prePage}">&laquo;</a></li>
                </c:if>

                <c:forEach items="${pi.navigatepageNums}" var="Np">
                    <c:if test="${pi.pageNum==Np}">
                        <li class="active"><a href="#">${Np}</a></li>
                    </c:if>
                    <c:if test="${pi.pageNum!=Np}">
                        <li><a href="${APP_PATH}/emp?pn=${Np}">${Np}</a></li>
                    </c:if>
                </c:forEach>

                <c:if test="${pi.isLastPage}">
                    <li class="disabled"><a href="#">&raquo;</a></li>
                    <li class="disabled"><a>LP</a></li>
                </c:if>
                <c:if test="${!pi.isLastPage}">
                    <li><a href="${APP_PATH}/emp?pn=${pi.nextPage}">&raquo;</a></li>
                    <li><a href="${APP_PATH}/emp?pn=${pi.pages}">LP</a></li>
                </c:if>--%>

            </ul>
        </div>
    </div>
</div>

<%--加载页面完成之后,通过ajax向服务器发起请求,请求数据,得到数据后保存在XmlHttpRequest中,然后在jap页面中用dom获取到即可展示--%>
<script type="text/javascript">
    $(function (){
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"get",
            dataType:"JSON",
            success:function (data){
                console.log(data);
                alert(data.map.pi.total);
            }
        })
    });
</script>

</body>
</html>
