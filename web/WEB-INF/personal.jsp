<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>个人详情</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/personal.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
</head>
<body>
<div class="shade"></div>
<div id="passwordForm" style="display: none;position: absolute;top: 40%;left: 40%;z-index: 11">
    <input style="width: 200px" type="password" id="password1" placeholder="新密码" required autocomplete="off"><br>
    <input style="width: 200px" type="password" id="password2" placeholder="再次输出" required autocomplete="off"><br>
    <button id="sure" onclick="sure()">确认</button>&nbsp;&nbsp;&nbsp;<button id="closeUpPassword" onclick="closePassword()">取消</button>
    <script>
        function sure() {
            var password1 = $("#password1").val();
            var password2 = $("#password2").val();
            if (password1==password2){
                $.ajax({
                    type:'post',
                    url:'updatePassword',
                    data:'password='+ password1,
                    success:function (result) {
                        if (result=="true"){
                            alert("修改成功");
                            closePassword();
                        } else {
                            alert("修改失败，请稍后再试");
                        }
                    }
                })
            } else {
                alert("两次密码不一致")
            }
        }

        function closePassword() {
            $("#password1").val("");
            $("#password2").val("");
            $("#passwordForm").css("display","none");
            $(".shade").css("display","none");


        }
    </script>
</div>
<jsp:include page="common/Navbar.jsp"></jsp:include>
<div class="content">

    <form id="personal" enctype="multipart/form-data" method="post">
        <input type="hidden" name="id" value="<c:out value="${member.id}"/>">
    </form>
    <table  border="1" class="table">
        <tbody>
        <tr>
            <td width="78">姓名</td>
            <td width="149"><input type="text" id="name" name="name" form="personal" readonly value="<c:out value="${member.name}"/>" ></td>
            <td width="99">性别</td>
            <td width="93">
                <c:if test="${member.sex==1}">
                    男
                </c:if>
                <c:if test="${member.sex==0}">
                    女
                </c:if>

            </td>
            <td width="109"  rowspan="2" id="up_img" onclick=file.click()>
                <input type="file" name="file" id="file" style="display: none;" onchange="readFile()" form="personal"
                       accept=".jpg,.png"  />
                <p class="kpic">点击上传照片</p>
                <img src="up/personalPhoto/<c:out value="${member.photo}"/>" onerror="this.src='up/personalPhoto/tx.png'"  id="img">

            </td>
        </tr>
        <tr>
            <td width="78">年级</td>
            <td width="149"><input type="text" id="grade" name="grade" form="personal" readonly value="<c:out value="${member.grade}"/>" ></td>
            <td width="99">专业</td>
            <td width="93"><input type="text" id="major" name="major" form="personal"value="<c:out value="${member.major}"/>"  readonly></td>
        </tr>
        <tr>
            <td>院系</td>
            <td><input type="text" name="academy" id="acdemy" form="personal" value="<c:out value="${member.academy}"/>" readonly></td>
            <td>学号</td>
            <td colspan="2"><input type="text" name="sno"  form="personal" value="<c:out value="${member.sno}"/>" readonly></td>
        </tr>
        <tr>
            <td>班级</td>
            <td><input type="text" name="clazz" id="clazz" form="personal" value="<c:out value="${member.clazz}"/>" readonly></td>
            <td>手机</td>
            <td colspan="2"><input type="text" id="phone" name="phone" form="personal" value="<c:out value="${member.phone}"/>" readonly></td>
        </tr>
        <tr>
            <td>球队职位</td>

            <td>

                <c:if test="${sessionScope.member.role.id==1}">
                    <c:if test="${member.role.id==1}">
                        <select name="rids" id="role" form="personal"><option value="1" selected >队长</option><option value="2">副队长</option><option value="3">队员</option> </select>
                    </c:if>
                    <c:if test="${member.role.id==2}">
                        <select  name="rids" id="role" form="personal"><option value="1" >队长</option><option value="2" selected>副队长</option><option value="3">队员</option> </select>
                    </c:if>
                    <c:if test="${member.role.id==3}">
                        <select  name="rids" id="role" form="personal"><option value="1"  >队长</option><option value="2">副队长</option><option value="3" selected>队员</option> </select>
                    </c:if>

                </c:if>
                <c:if test="${sessionScope.member.role.id!=1}">
                    <c:if test="${member.role.id==1}">
                        队长
                    </c:if>
                    <c:if test="${member.role.id==2}">
                        副队长
                    </c:if>
                    <c:if test="${member.role.id==3}">
                        队员
                    </c:if>
                </c:if>
            </td>



            <td>qq</td>
            <td colspan="2"><input type="text" name="qq" id="qq" form="personal" value="<c:out value="${member.qq}"/>" readonly></td>
        </tr>
        <tr>
            <td colspan="5">个人介绍</td>
        </tr>
        <tr>
            <td height="602" colspan="5"><textarea name="ps" form="personal" id="ps" readonly><c:out value="${member.ps}"/></textarea></td>
        </tr>
        </tbody>
    </table>


</div>
<script type="text/javascript">







    var up_img = document.getElementById("up_img");
    var input = document.getElementById("file"); //获取选择图片的input元素           
    //这边是判断本浏览器是否支持这个API。
    if (typeof FileReader === 'undefined') {
        // wrapper.innerHTML = "抱歉，你的浏览器不支持 FileReader";
        alert("抱歉，你的浏览器不支持 FileReader");
        input.setAttribute('disabled', 'disabled');
    } else {
        input.addEventListener('change', readFile, false); //如果支持就监听改变事件，一旦改变了就运行readFile函数。
    }

    function readFile() {
        /*console.log("this:" + this)
        console.log(input)*/
        var file = this.files[0]; //获取file对象
        var reader = new FileReader(); //声明一个FileReader实例
        reader.readAsDataURL(file); //调用readAsDataURL方法来读取选中的图像文件
        reader.onload = function (e) {
            var data = e.target.result;
            if (document.getElementsByClassName('kpic').length != 0) {
                up_img.removeChild(document.getElementsByClassName('kpic')[0]);
            }

            var wrapper = document.getElementById("img");
            wrapper.src = data;




        }
    }
</script>
<div class="edit">
    <c:if test="${sessionScope.member!=null}">
        <button onclick="edit()">编辑</button>
        <button id="updatePassword" style="display: none">修改密码</button>
        <input type="submit"  formaction="updatePersonalInformation" form="personal" value="保存">
    </c:if>

</div>
<script>
    function edit() {
        $("#role").removeAttr("disabled");
        $("input").removeAttr("readonly");
        $("#ps").removeAttr("readonly");
        $("#updatePassword").css("display","block")


    }


    $("#updatePassword").click(function () {
        $("#passwordForm").css("display","block");
        $(".shade").css("display","block");

    })

    function closeLogin() {
        $(".shade").css("display","none");
        $(".login").css("display","none");

    }
</script>
<jsp:include page="common/footer.jsp"></jsp:include>
</body>
</html>
