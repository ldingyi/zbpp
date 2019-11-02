<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta name="viewport" content="width=1100">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Navbar.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.cookie.js"></script>
    <title>Title</title>
</head>
<body>
<div class="shade"></div>
<div class="top">
    <div class="loginb">
        <c:if test="${sessionScope.member!=null}">
            <span id="greet">你好，<c:out value="${sessionScope.member.name}"></c:out></span>
        </c:if>
        <c:if test="${sessionScope.member==null}">
            <a onclick="showLogin()" href="javascript:void(0) ">登录</a>
        </c:if>
        <script>
            function showLogin() {
                $(".shade").css("display","block");
                $(".login").css("display","block");

            }
        </script>
    </div>
    <div class="logo">
        <img width="657px" height="107px" src="images/logo.jpg">
    </div>
</div>
<div class="header">
    <ul>
        <li><a href="home">首页</a></li>
        <li><a href="more?more=activity&currentPage=1">协会活动</a></li>
        <li><a href="more?more=match&currentPage=1">赛事信息</a></li>
        <li><a href="#">关于协会</a></li>
        <li><a href="more?more=dynamic&currentPage=1">协会动态</a></li>
        <li><a href="more?more=notice&currentPage=1">协会公告</a></li>
        <li><a href="#">帮助</a></li>
    </ul>
</div>
<div class="login">

    <div class="close">
        <button onclick="closeLogin()"></button>
    </div>

    <div class="count">
        <h1>会员登录</h1>
        <div class="input">
            <input type="text" name="sno" placeholder="学号" id="sno" required autocomplete="off">
        </div>
        <div class="input">
            <input type="password" name="sno" placeholder="密码" id ="password" required autocomplete="off" >
        </div>
        <div class="status">
            <button form="login" onclick="login()">登录</button>
            <input type="checkbox" id="remember">记住密码
            <a href="">忘记密码</a>
        </div>
        <div class="error" id="error">
            !学号或密码错误
        </div>



    </div>
</div>
<script type="text/javascript">
    function closeLogin() {
        $(".shade").css("display","none");
        $(".login").css("display","none");

    }

    var cookieSno = $.cookie('zbppSno');
    var cookiePassword = $.cookie('zbppPassword');
    if (cookieSno!=null&&cookiePassword!=null){
        /*var sno = cookie.split("@")[0];
        var password = cookie.split("@")[1];*/
        var sno = cookieSno;
        var password = cookiePassword;
        $("#sno").val(sno);
        $("#password").val(password);

    }



    function login() {
        var remember;
        if ($("#remember").prop("checked")){
            remember=1;
        }else {
            remember=0;
        }
        var sno = $("#sno").val();
        var password = $("#password").val();
        $.ajax({
            type:"post",
            url:"lg",
            data:"sno=" + sno + "&password="+ password+"&remember="+remember,
            success:function (result) {
                if(result=="false"){
                    $("#error").css("display","block");
                }else {
                   window.location.href="index.jsp";
                }
            }
        })
    }


</script>
</body>
</html>
