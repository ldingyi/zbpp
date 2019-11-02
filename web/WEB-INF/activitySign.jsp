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
    <title>查看活动</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
    <link href="${pageContext.request.contextPath}/css/more.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<script>
    <c:if test="${requestScope.flag!=null}">
        <c:if test="${requestScope.flag=='ok'}">
            alert("报名成功");
            window.location.href="home";
        </c:if>
        <c:if test="${requestScope.flag=='false'}">
            alert("你已经报过名了");
            window.location.href="home";
        </c:if>
    </c:if>

</script>
<jsp:include page="common/Navbar.jsp"/>
<div class="content" id="content" style="font-size: 16px;padding: 0 30px 80px 30px">

    <c:out value="${activity.ad}" escapeXml="false"></c:out>


</div>
<div class="baseInfo">
    <div class="infoBox">
        <ul class="infoBoxList1">
            <li><h3>活动名称:</h3><c:out value="${activity.name}"/></li>
            <li><h3>活动性质:</h3>
                <c:if test="${activity.kind==0}">
                    活动
                </c:if>
                <c:if test="${activity.kind==1}">
                    赛事
                </c:if>


            </li>
            <li><h3>是否公开:</h3>
                <c:if test="${activity.ispub==0}">
                    队内
                </c:if>
                <c:if test="${activity.ispub==1}">
                    公开
                </c:if>


            </li>
        </ul>
        <ul class="infoBoxList2">
            <li><h3>活动结束时间:</h3><c:out value="${fn:substring(activity.ae,0 ,10 )}"/></li>
            <li><h3>报名截止时间:</h3><c:out value="${fn:substring(activity.se,0 , 10)}"/></li>
            <li><h3>活动开始时间:</h3><c:out value="${fn:substring(activity.at,0,10)}"/></li>
        </ul>
    </div>
    <div class="edit">
        <c:if test="${activity.ispub==0}">
            <button id="signButton" onclick="window.location.href='signActivity?aid=<c:out value="${activity.id}"/>'  ">我要参加</button>

        </c:if>
        <c:if test="${activity.ispub==1}">
            <button id="signButton" onclick="window.location.href='joinActivityPage?id=<c:out value="${activity.id}"/>'  ">我要参加</button>
        </c:if>

    </div>
</div>



<jsp:include page="common/footer.jsp"/>

<script>
    var ispub = "<c:out value="${activity.ispub}"/>";
    if (ispub==0){
        var session = "<c:out value="${sessionScope.member}"/>";
        if (session==""||session==null||session==undefined){
            $("#signButton").attr("disabled",true);
        }
    }

</script>

</body>
</html>
