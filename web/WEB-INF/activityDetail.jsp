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
    <title>查看活动</title>
    <link href="${pageContext.request.contextPath}/css/more.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<script>



</script>
<jsp:include page="common/Navbar.jsp"/>
<div class="content" id="content" style="font-size: 16px;padding: 0 30px 80px 30px" >
    <c:out value="${activity.ad}" escapeXml="false"></c:out>
</div>
<div class="baseInfo">
    <div class="infoBox">
        <ul class="infoBoxList1">
            <li><h3>活动名称:</h3><c:out value="${activity.name}"/></li>
            <li><h3>活动性质:</h3><c:out value="${activity.kind}"/></li>
            <li><h3>是否公开:</h3><c:out value="${activity.ispub}"/></li>
        </ul>
        <ul class="infoBoxList2">
            <li><h3>活动结束时间:</h3><c:out value="${activityEnd}"/></li>
            <li><h3>报名截止时间:</h3><c:out value="${fn:substring(activity.se,0 , 10)}"/></li>
            <li><h3>活动开始时间:</h3><c:out value="${activityStart}"/></li>
        </ul>
    </div>
    <div class="edit">
        <button onclick="window.location.href='intoAddActivity?id='+<c:out value="${activity.id}"/>">编辑</button>
        <button onclick="window.location.href='activityMember?id='+<c:out value="${activity.id}"/>">报名人员</button>

    </div>
</div>



<jsp:include page="common/footer.jsp"/>

</body>
</html>
