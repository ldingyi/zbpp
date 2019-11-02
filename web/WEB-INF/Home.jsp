<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
    <meta charset="UTF-8">
    <meta name="viewport" content="width=1100">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/index.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>

    <title>郑北乒乓</title>
</head>
<body>
    <div class="wapper">
        <jsp:include page="/WEB-INF/common/Navbar.jsp"></jsp:include>
        <div class="mian_01">
            <div class="focus">
                <link rel="stylesheet" href="css/meSlider.css">
                <script type="text/javascript" src="js/sliderMe.js"></script>
                <div id="slider" class="slider"></div>
                <script type="text/javascript">
                    $(function () {
                        $('#slider').sliders({
                            imgArr: ['http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/yFqgRcY7yIXW9DRedUrH9rO6MxOLxmpJEBHuIFNMGw0!/r/dDMBAAAAAAAA', 'http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/LRrerBKzt2JvlYV7ekFGvmbSEroHr*O2ISB5x0q3QkI!/r/dAcBAAAAAAAA', 'http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/In2ucu.60J*ry3HJSS.xrzF8gKysq2lcS7kLX8foEKg!/r/dLgAAAAAAAAA','http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/dmtkQuERuGR3gycAVoeH9iuAN1OaCRCgnkP63Ml3bcU!/r/dFIBAAAAAAAA'],
                            autoLoop: true,
                            current: 1,
                            time: 5000,

                        })
                    });
                </script>

            </div>
            <div class="news">
                <dl>
                    <dt>
                       河南省大学生乒乓球锦标赛
                    </dt>
                    <dd>
                        河南省大学生锦标赛，郑州大学甲组共6人参赛，其中北校区参加2人，
                        郑州大学在这次比赛中取得优异成绩，共摘得5金7银3铜
                    </dd>
                </dl>
                <dl>
                    <dt>
                        中国大学生阳光体育运动会
                    </dt>
                    <dd>
                        中国大学生阳光体育运动会，郑州大学共6人参赛，其中北校区参加2人
                        这次比赛中，郑州大学的运动员们，奋力拼搏，取得三等奖

                    </dd>
                </dl>
                <dl>
                    <dt>
                        郑州大学乒乓球比赛
                    </dt>
                    <dd>
                        这是郑州大学举办的校内团体比赛
                        北校区软件与应用科技学院的运动健儿，英勇善战，取得历史最优成绩，团体第四名。
                        其中前三名为校高水平学院。
                    </dd>
                </dl>

            </div>

        </div>
        <div class="main_02">
            <div class="main_02_01">
                <ul class="main_02_01_1">
                    <li><a href="javascript:void(0)" onclick="gotoManager()">协会管理系统</a></li>
                    <script>
                        function gotoManager() {
                            $.ajax({
                                type:'post',
                                url:'gotoManager',
                                success:function (result) {
                                    if (result=='noLogin'){
                                        alert("请先登陆");
                                    }
                                    if (result=='noPower'){
                                        alert("你没有权限");
                                    }
                                    if (result=='ok'){
                                        window.location.href='socialManager?catalog=memberSys'
                                    }

                                }
                            })
                        }
                    </script>
                    <li><a href="#">后台管理系统</a> </li>
                    <li>
                        <a href="javascript:void(0)" onclick="signSys()">招新报名系统</a>
                        <script>
                            function signSys() {
                                $.ajax({
                                    type:'post',
                                    url:'signSys',
                                    success:function (result) {
                                        if (result=='ok'){
                                            window.location.href='gotoSignSys';
                                        } else {

                                            alert("报名还没有开始");
                                        }
                                    }
                                })
                            }
                        </script>



                    </li>
                    <li><a href="more?more=match&currentPage=1">赛事报名系统</a> </li>
                </ul>
                <dl class="main_02_01_2">
                    <dt>
                        <span>近期活动</span>
                        <span class="more">
                            <a href="more?more=activity&currentPage=1">更多</a>
                        </span>
                    </dt>
                    <dd>
                        <ul class="list01">

                            <c:forEach var="activity" items="${activity}">
                                <li>
                                    <a href="signActivityPage?id=<c:out value="${activity.id}"/>"><c:out value="${activity.name}"/></a>
                                    <span><c:out value="${fn:substring(activity.at,5 ,10 )}"/>-<c:out value="${fn:substring(activity.ae,5 ,10 )}"/></span>
                                </li>
                            </c:forEach>

                        </ul>
                    </dd>
                </dl>
            </div>
            <div class="main_02_02">
                <div class="main_02_02_1">
                    <dt>
                        <span>协会公告</span>
                        <span class="more"><a href="more?more=notice&currentPage=1">更多</a> </span>
                    </dt>
                    <dd>
                        <ul class="list02">

                            <c:forEach var="notice" items="${notice}">
                                <li>
                                    <a href="newsdetail?id=<c:out value="${notice.id}"/>"><c:out value="${notice.title}"/></a>
                                    <span><c:out value="${fn:substring(notice.date,5 ,10 )}"/> </span>
                                </li>

                            </c:forEach>

                        </ul>
                    </dd>
                </div>
                <div class="main_02_02_2">
                    <dt>
                        <span>协会动态</span>
                        <span class="more"><a href="more?more=dynamic&currentPage=1">更多</a> </span>
                    </dt>
                    <dd>
                        <ul class="list02">
                            <c:forEach var="dynamic" items="${dynamic}">
                                <li>
                                    <a href="newsdetail?id=<c:out value="${dynamic.id}"/>" ><c:out value="${dynamic.title}"/></a>
                                    <span><c:out value="${fn:substring(dynamic.date,5 ,10 )}"/> </span>
                                </li>

                            </c:forEach>





                        </ul>
                    </dd>
                </div>
            </div>
            <div class="main_02_03">
                <ul>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj1.png') center center no-repeat"><a href="pay">付款</a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj2.png') center center no-repeat"><a href="javascript:void(0)" onclick="personalInformation()">个人信息</a></li>
                    <script>
                        function personalInformation() {
                            $.ajax({
                                type:'post',
                                url:'gotoManager',
                                success:function (result) {
                                    if (result=='noLogin'){
                                        alert("请先登陆");
                                    }
                                    if (result=='ok'||result=='noPower'){
                                        window.location.href='myPersonalInformation';
                                    }

                                }
                            })
                        }
                    </script>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj3.png') center center no-repeat"><a href=""></a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj4.png') center center no-repeat"><a href=""></a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj5.png') center center no-repeat"><a href=""></a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj6.png') center center no-repeat"><a href=""></a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj7.png') center center no-repeat"><a href=""></a></li>
                    <li style="background: url('${pageContext.request.contextPath}/images/linkbj8.png') center center no-repeat"><a href=""></a></li>
                </ul>
            </div>

        </div>
        <div class="main_03">
            <h4>精彩图集</h4>
            <div class="rollBox">
                <div class="LeftBotton" id="up"></div>
                <div class="Cont">
                    <ul id="jc">
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/4PwO2M4o4FaYBFdfFWLju0y3nlSh4DQosLI0XetiYQQ!/r/dLYAAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/RAg55we0k43*Ph3*6wCnVKVO2Dq3A4FymgnHsM8r4F0!/r/dFMBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/XrK0x2XXjHAvdCHzzjHrDYGdkKFsO4tUknq6jn0giEw!/r/dEEBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/QN20XvQSXs.V0QTF2G0zSBHXwpefBkj1gT1R.7ZoVSg!/r/dL4AAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/yq344WVrnTGlb0wG7zqIEHvHckRNCQr*VBaDeU46Y*Y!/r/dDYBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/9RgTxhGUQuy.PHrJG0BgdlbC8.RXQ47bYscE.zoZO7A!/r/dAYBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/b9Rlpf0muU7Z1WznuXqZguMaEnlLQeTFqTRHcOD3T*w!/r/dDABAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/ElvRLHvUhcWUHzXArzSQDBdMH*Ad8euTlzkRXh3QByc!/r/dL8AAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/4PwO2M4o4FaYBFdfFWLju0y3nlSh4DQosLI0XetiYQQ!/r/dLYAAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/RAg55we0k43*Ph3*6wCnVKVO2Dq3A4FymgnHsM8r4F0!/r/dFMBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/XrK0x2XXjHAvdCHzzjHrDYGdkKFsO4tUknq6jn0giEw!/r/dEEBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/QN20XvQSXs.V0QTF2G0zSBHXwpefBkj1gT1R.7ZoVSg!/r/dL4AAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/yq344WVrnTGlb0wG7zqIEHvHckRNCQr*VBaDeU46Y*Y!/r/dDYBAAAAAAAA"></li>
                        <li><img src="http://r.photo.store.qq.com/psb?/V10AMFwa2ivwUd/9RgTxhGUQuy.PHrJG0BgdlbC8.RXQ47bYscE.zoZO7A!/r/dAYBAAAAAAAA"></li>
                    </ul>
                </div>
                <div class="RightBotton" id="next"></div>

                <script type="text/javascript">
                    var index =1;
                    var d = document.getElementById("jc");
                    d.style.transform="translateX(-500px)";
                    var nextbtn = document.getElementById("next");
                    var upbtn = document.getElementById("up");
                    function next() {

                        index++;
                        d.style.transform="translateX(-"+index*250 * 2 +"px)";
                        d.style.transitionDuration="0.4s";
                        d.style.transitionDelay="0s";
                        if(index==5){
                            setTimeout(function () {
                                d.style.transform="translateX(-500px)";
                                d.style.transitionDuration="0s";
                            },400)
                            index=1;
                        }

                    }
                    function up() {

                        index--;
                        d.style.transform="translateX(-"+index*250 * 2 +"px)";
                        d.style.transitionDuration="0.4s";
                        d.style.transitionDelay="0s";
                        if(index==0){
                            setTimeout(function () {
                                d.style.transform="translateX(-2000px)";
                                d.style.transitionDuration="0s";
                            },400)
                            index=4;
                        }

                    }
                    nextbtn.onclick=next;
                    upbtn.onclick=up;

                </script>


            </div>
        </div>
        <jsp:include page="common/footer.jsp"></jsp:include>

    </div>
</body>
</html>