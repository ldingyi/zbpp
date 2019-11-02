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



</script>
<jsp:include page="common/Navbar.jsp"/>
<div class="content" id="content" style="font-size: 16px;padding: 0 30px 80px 30px">
    <c:out value="${news.content}" escapeXml="false"></c:out>
</div>
<div class="baseInfo" style="height: 40px">

    <c:if test="${(sessionScope.member.role.id==1)||(sessionScope.member.role.id==2)}">
        <div class="edit">
            <button onclick="window.location.href='intoAddNews?id='+<c:out value="${news.id}"/>">编辑</button>


        </div>
    </c:if>

</div>



<jsp:include page="common/footer.jsp"/>

</body>
</html>
