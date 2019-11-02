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
    <title>声明</title>
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

<jsp:include page="common/Navbar.jsp"/>


<div class="content" id="content"  style="font-size: 16px;padding: 0 30px 80px 30px" >
    <h4>
        声明
    </h4>
    1.此系统为郑州大学北校区球队的网站以及管理系统，个人制作，仅代表球队，不代表郑州大学。<br><br>
    2.此系统中的收款码为球队队长，一切损失与网站制作者和球队无关。<br><br>
    3.系统制作匆忙，制作者能力有限，其中的一些漏洞，请一些大神们不要恶意攻击。<br><br>
    4.网站为个人制作，不代表任何组织。<br><br>
    7.因为个人制作，考虑到经济原因，服务器硬件设施条件比较差，给您带来的不便以及不好的体验深感歉意。<br><br>
    6.网站制作人刘定一，qq：944743434。打球好的，可以认识下，你教我打球，我教你编程。编程好的也可以认识下，你教我编程，我教你打球
    ,编程和打球都好的，更可以认识下，我能请你吃饭啊（xjjyx）.
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
