<%@ page import="cn.ldingyi.zbpp.Entity.Activity" %><%--
  Created by IntelliJ IDEA.
  User: ldy
  Date: 2019/8/27
  Time: 23:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html>
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
    <title>宣传管理</title>
    <link href="${pageContext.request.contextPath}/css/more.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <style>
        .gopage{
            width: 400px;
            margin: 0 auto;
            text-align: center;
            font-size: 14px;
            float: bottom;

        }
    </style>
</head>
<body>
<script>
    <c:if test="${param.deleteFlag!=null}">
        <c:if test="${param.deleteFlag=='ok'}">
            alert("删除成功");
            window.location.href='newsManager?currentPage=1'
        </c:if>
    </c:if>


</script>
<jsp:include page="common/Navbar.jsp"/>
<form id="newsCheckbox"></form>
<div class="content" id="content" >
    <h4>
        <c:if test="${more=='match'}">
            赛事
        </c:if>
        <c:if test="${more=='activity'}">
            活动
        </c:if>
        <c:if test="${more=='notice'}">
            公告
        </c:if>
        <c:if test="${more=='dynamic'}">
            动态
        </c:if>
    </h4>
    <ul>


        <c:if test="${(more=='match')||(more=='activity')}">
            <c:forEach var="activity" items="${activity}">
                <li>
                    <div class="spandiv"><a href="signActivityPage?id= <c:out value="${activity.id}"></c:out>" style="color: black;line-height: unset"><c:out value="${activity.name}"/></a></div>
                    <div class="spandiv">
                        <c:if test="${activity.kind==0}">
                            队内
                        </c:if>
                        <c:if test="${activity.kind==1}">
                            公开
                        </c:if>
                    </div>
                    <div class="spandiv"><c:out value="${fn:substring(activity.at,0 ,10 )}"/></div>
                </li>
            </c:forEach>

        </c:if>


        <c:if test="${(more=='notice')||(more=='dynamic')}">
            <c:forEach var="news" items="${news}">

                <li>

                    <div class="spandiv"><a href="newsdetail?id= <c:out value="${news.id}"></c:out>" style="color: black;line-height: unset"><c:out value="${news.title}"/></a></div>
                    <div class="spandiv">
                        <c:if test="${news.kind==0}">
                            动态
                        </c:if>
                        <c:if test="${news.kind==1}">
                            公告
                        </c:if>
                    </div>
                    <div class="spandiv"><c:out value="${fn:substring(news.date,0 ,10 )}"/></div>
                </li>
            </c:forEach>
        </c:if>

    </ul>
    <div class="gopage">共<c:out value="${total}"></c:out>条&nbsp;&nbsp;<a style="color: #1d819d" href="#" onclick="firstPage()">首页</a>&nbsp; <a style="color: #1d819d" href="#" onclick="upPage()">上一页</a>&nbsp;<a style="color: #1d819d" href="#" onclick="nextPage()">下一页</a>&nbsp;<a style="color: #1d819d" href="#" onclick="lastPage()">尾页</a> &nbsp;&nbsp;共<c:out value="${pages}"></c:out>页&nbsp; 当前第<span id="currentPage"></span>页</div>



</div>




<jsp:include page="common/footer.jsp"/>

<script>
    var currentPage = "${param.currentPage}";
    var more = "${more}";
    var max = "${pages}";
    function upPage() {
        if (currentPage>1) {
            currentPage=currentPage-1
        }else {
            currentPage=1
        }
        window.location.href='more?more='+ more +'&currentPage='+currentPage;
    }

    function nextPage() {

        if (currentPage<max) {
            currentPage=currentPage+1
        }else {
            currentPage=max
        }
        window.location.href='more?more='+ more +'&currentPage='+currentPage;
    }

    function firstPage() {
        currentPage=1;
        window.location.href='more?more='+ more +'&currentPage='+currentPage;
    }
    function lastPage() {
        currentPage=max;
        window.location.href='more?more='+ more +'&currentPage='+currentPage;
    }






    $("#currentPage").append(currentPage);
</script>

</body>
</html>
