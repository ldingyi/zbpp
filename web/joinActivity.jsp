<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="no-js">

    <head>

        <meta charset="utf-8">
        <title>Fullscreen Login</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- CSS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign/reset.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign/supersized.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sign/style.css">
		<style>
			.sex{
				height: 20px;
				width: 20px;
				
			}
		</style>

        <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
        <!--[if lt IE 9]>
            <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
        <![endif]-->

    </head>
	<script>
		<c:if test="${param.flag!=null}">
			<c:if test="${param.flag=='ok'}">
				alert("报名成功");
				window.location.href="home";
			</c:if>
			<c:if test="${param.flag=='false'}">
				alert("你已经报过名");
				window.location.href="home";
			</c:if>
		</c:if>
	</script>
    <body oncontextmenu="return false">


        <div class="page-container">
            <h1>报名</h1>
            <form action="joinActivity" method="post">
				<input type="hidden" name="aid" value="<c:out value="${activity.id}"/>">
				<div>
					<input type="text" name="name" class="username" placeholder="姓名" autocomplete="off" required/>
				</div>
				<div style="float: left;">
					<input type="radio" name="sex" class="sex" value="1" />男 <input type="radio" name="sex" class="sex" value="0">女
				</div>
				<div>
					<input type="number" name="age" class="username" placeholder="年龄" autocomplete="off" required/>
				</div>

				<div>
					<input type="text" name="phone" class="username" placeholder="手机" autocomplete="off" required/>
				</div>
                
                <input  style="background-color: orangered" type="submit" value="我要参加！！"></input>
            </form>
            <div class="connect">
                <p>If we can only encounter each other rather than stay with each other,then I wish we had never encountered.</p>
				<p style="margin-top:20px;">如果只是遇见，不能停留，不如不遇见。</p>
            </div>
        </div>
		<div class="alert" style="display:none">
			<h2>消息</h2>
			<div class="alert_con">
				<p id="ts"></p>
				<p style="line-height:70px"><a class="btn">确定</a></p>
			</div>
		</div>

        <!-- Javascript -->
		<script src="http://apps.bdimg.com/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/sign/supersized.3.2.7.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sign/supersized-init.js"></script>
		<script>

		window.onload = function()
		{
			$(".connect p").eq(0).animate({"left":"0%"}, 600);
			$(".connect p").eq(1).animate({"left":"0%"}, 400);
		}
		function is_hide(){ $(".alert").animate({"top":"-40%"}, 300) }
		function is_show(){ $(".alert").show().animate({"top":"45%"}, 300) }
		</script>
    </body>

</html>

