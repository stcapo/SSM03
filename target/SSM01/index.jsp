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
        <button id="add" class="btn btn-primary col-md-1 col-md-offset-9" data-toggle="modal" data-target="#myModal">
            <span>Append</span>
        </button>
        <button class="btn btn-danger col-md-1">
            <span>Remove</span>
        </button>
    </div>

    <%--<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#myModal">
        开始演示模态框
    </button>--%>
    <%-------------------------------------------------------------------------------------------------------------%>

    <!-- 模态框（Modal） -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        ADD EMPLOYEE
                    </h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="form">
                        <div class="form-group">
                            <label for="employeename" class="control-label col-md-2" style="font-size: larger">Name</label>
                            <div class="col-md-8"><input name="employeename" type="text" class="form-control" id="employeename" placeholder="please input your name"></div>
                        </div>
                        <div class="form-group">
                            <label for="workyears" class="control-label col-md-2" style="font-size: larger">WorkYears</label>
                            <div class="col-md-8"><input name="workyears" type="text" class="form-control" id="workyears" placeholder="please input your workyears"></div>
                        </div>
                        <div class="form-group">
                            <label class="control-label col-md-1" style="font-size: larger">DepartmentID</label>
                                <label class="control-label col-md-offset-2">
                                    <select class="form-control" id="department" name="departmentid">

                                    </select>
                                </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                    </button>
                    <button type="button" class="btn btn-primary" id="submit">
                        提交更改
                    </button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>

    <%-------------------------------------------------------------------------------------------------------------%>
    <table style="font-size: 20px" class="table table-hover table-responsive table-condensed text-center" id="emp_list">
        <div class="row">
            <div class="col-md-2">
                <thead>
                <tr>
                    <td>EmployeeId</td>
                    <td>EmployeeName</td>
                    <td>WorkYear</td>
                    <td>DepartmentId</td>
                    <td>UpdateOption</td>
                </tr>
                </thead>
            </div>
        </div>
            <div class="row">
                <div class="col-md-2">
                        <tbody></tbody>
                </div>
            </div>
        <div id="list"></div>
    </table>
    <div class="row">
        <div class="col-md-4 col-md-offset-2">
            <p class="text-center">
                <b id="binfo"></b>
            </p>
        </div>
    </div>
    <div class="row">
        <div class="col-md-6 col-md-offset-8" id="page_nav">
        </div>
    </div>
</div>

<%--加载页面完成之后,通过ajax向服务器发起请求,请求数据,得到数据后保存在XmlHttpRequest中,然后在jap页面中用dom获取到即可展示--%>
<script type="text/javascript">
    $(function (){
        to_page(2)
        show_modal()
    });
    var Total
    /*点击哪一页查哪一页*/
    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emp",
            data:"pn="+pn,
            type:"get",
            dataType:"JSON",
            success:function (data){
                var pageInfo = data.map.pi;
                build_emps_table(pageInfo);
                show_pagefoot(pageInfo);
                show_nav(pageInfo);
            }
        });
    }
    /*展示员工表数据的模块，建立员工表。。。*/
    function build_emps_table(pageInfo){
        $("#emp_list tbody").empty();
        var list = pageInfo.list;
        $.each(list,function (index,item){
            var employeeId = $("<td></td>").append(item.employeeid);
            var employeeName= $("<td></td>").append(item.employeename);
            var workYears = $("<td></td>").append(item.workyears);
            var departmentId = $("<td></td>").append(item.departmentid);
            var modifybtn = $("<button></button>").addClass("btn btn-info").append($("<span></span>").addClass("glyphicon glyphicon-pencil").append("Modify"));
            var deletebtn = $("<button></button>").addClass("btn btn-warning").append($("<span></span>").addClass("glyphicon glyphicon-remove").append("Delete"));
            var td = $("<td></td>").append(modifybtn).append(" ").append(deletebtn);
            $("<tr></tr>").append(employeeId).append(employeeName).append(workYears).append(departmentId).append(td)
                .appendTo("#emp_list tbody");
        });
    }
    /*展示页脚信息*/
    function show_pagefoot(pageInfo){
        var b = $("#binfo")
        b.empty()
        b.append("当前第 "+pageInfo.pageNum+"页,共有"+pageInfo.pages+"页,总计"+pageInfo.total+"条记录");
        Total = pageInfo.total
    }
    /*展示导航栏分页信息*/
    function show_nav(pi){
        $("#page_nav").empty()
        var ul = $("<ul></ul>").addClass("pagination")
        var isFP = pi.isFirstPage;
        var isLP = pi.isLastPage;
        var navpage = pi.navigatepageNums;

        var FP;
        var previousP;
        if(isFP==true){
            FP = $("<li></li>").append($("<a></a>").append("FP").attr("href","#")).addClass("disabled");
            previousP = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#")).addClass("disabled");
        }else{
            FP = $("<li></li>").append($("<a></a>").append("FP").attr("href","#"));
            previousP = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
        }
        ul.append(FP).append(previousP)
        $.each(navpage,function (index,item){
            var nav;
            if (item==pi.pageNum){
                nav = $("<li></li>").addClass("active").append($("<a></a>").append(item).attr("href","#"));
            }else{
                nav = $("<li></li>").append($("<a></a>").append(item).attr("href","#"));
                FP.click(function (){to_page(1)})
                previousP.click(function (){to_page(pi.prePage)})
            }
            ul.append(nav)
            nav.click(function (){to_page(item)});
        })

        var nextP
        var LP

        if(isLP==true){
            LP = $("<li></li>").append($("<a></a>").append("LP").attr("href","#")).addClass("disabled");
            nextP = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#")).addClass("disabled");
        }else{
            LP = $("<li></li>").append($("<a></a>").append("LP").attr("href","#"));
            nextP = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
            LP.click(function (){to_page(pi.pages)})
            nextP.click(function (){to_page(pi.pageNum+1)})
        }
        ul.append(nextP).append(LP);
        ul.appendTo($("#page_nav"));
    }

    /*显示模态框*/
    function show_modal(){
        $("#add").click(function (){
            $.ajax({
                url:"${APP_PATH}/dept",
                type:"get",
                dataType:"JSON",
                success:function (data){
                    var list = data.map.depts;
                    $("#department").empty()
                    $.each(list,function (){
                        var optionEle = $("<option></option>").append(this.departmentid+"   "+this.departmentname).attr("value",this.departmentid)
                        optionEle.appendTo($("#department"))
                    })
                }
            });
        })

    }


    function validate_data(){
        var en = $("#employeename").val();
        var regname = /^[a-z0-9_-]{5,16}$/
        if (!regname.test(en))
        {
            alert("EMPLOYEENAME ILLEGAL")
            return false;
        }
        return true;
    }

    /*添加员工数据*/
    $("#submit").click(function (){
        /*先校验数据*/
        if (!validate_data()){
            return;
        }

        $.ajax({
            url:"${APP_PATH}/save",
            type:"POST",
            data: $("#form").serialize(),
            success:function (data){
                /*关闭模态框*/
                $("#myModal").modal('hide');
                /*展现最后一页数据*/
                to_page(Total)
            }
        })
    })


</script>
</body>
</html>

<%--<form class="form-horizontal">
    <div class="form-group">
        <label for="name" class="control-label col-md-2" style="font-size: larger">Name</label>
        <div class="col-md-8"><input type="text" class="form-control" id="name" placeholder="please input your name"></div>
    </div>
    <div class="form-group">
        <label for="email" class="control-label col-md-2" style="font-size: larger">WorkYears</label>
        <div class="col-md-8"><input type="text" class="form-control" id="email" placeholder="please input your email"></div>
    </div>
    <div class="form-group">
        <label class="control-label col-md-1" style="font-size: larger">DepartmentID</label>
        <label class="control-label col-md-offset-2">
            <select class="form-control">
                <option selected="selected">1</option>
                <option>2</option>
                <option>3</option>
            </select>
        </label>
    </div>
</form>--%>




















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
































<%--<td><button class="btn btn-info">
                            <span class="glyphicon glyphicon-pencil">Modify</span>
                        </button>
                            <button class="btn btn-warning">
                                <span class="glyphicon glyphicon-remove">Delete</span>
                            </button>
                        <td>--%>