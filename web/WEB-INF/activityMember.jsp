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

<html>
<head>
    <title>查看活动</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
    <link href="${pageContext.request.contextPath}/css/more.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<form id="activityMemberCheck"></form>
<jsp:include page="common/Navbar.jsp"/>
<div class="content" id="content" style="overflow-y: scroll;height: 800px;">
    <h4><c:out value="${activity.name}"></c:out></h4>

    <c:if test="${activity.ispub==0}">
        <span>共<c:out value="${activity.activityMembers.size()}"/>人</span>
    </c:if>
    <c:if test="${activity.ispub==1}">
        <span>共<c:out value="${activity.activityTourist.size()}"/>人</span>
    </c:if>



    <ul>
    <c:if test="${activity.ispub==0}">
        <c:forEach var="member" items="${activity.activityMembers}">

                <li>
                    <div style="float: left"><input type="checkbox" name="ids" form="activityMemberCheck" value="<c:out value="${member.id}"/>"></div>
                    <div class="spandiv"><c:out value="${member.name}"></c:out></div>
                    <div class="spandiv">
                        <c:if test="${member.sex==0}">
                            女
                        </c:if>
                        <c:if test="${member.sex==1}">
                            男
                        </c:if>
                    </div>
                    <div class="spandiv"><c:out value="${member.grade}"></c:out></div>
                    <div class="spandiv"><c:out value="${member.phone}"></c:out></div>

                </li>

        </c:forEach>
    </c:if>



    <c:if test="${activity.ispub==1}">
        <c:forEach var="member" items="${activity.activityTourist}">

                <li>
                    <div style="float: left"><input type="checkbox" form="activityMemberCheck" value="<c:out value="${member.id}"/>"></div>
                    <div class="spandiv"><c:out value="${member.name}"></c:out></div>
                    <div class="spandiv">
                        <c:if test="${member.sex==0}">
                            女
                        </c:if>
                        <c:if test="${member.sex==1}">
                            男
                        </c:if>
                    </div>
                    <div class="spandiv"><c:out value="${member.age}"></c:out></div>
                    <div class="spandiv"><c:out value="${member.phone}"></c:out></div>

                </li>

        </c:forEach>
    </c:if>



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
            <li><h3>报名截止时间:</h3><c:out value="${signEnd}"/></li>
            <li><h3>活动开始时间:</h3><c:out value="${activityStart}"/></li>
        </ul>
    </div>
    <div class="edit">
        <button onclick="window.location.href='updateActivity'">编辑</button>
        <button onclick="window.location.href='socialManager?catalog=activityMember'">通知</button>

    </div>
</div>


<script>
</script>
<jsp:include page="common/footer.jsp"/>

</body>
</html>
