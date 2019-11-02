<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>


<head>
	<title>管理系统</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manager.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/tableMe.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/add.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/honeySwitch.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/tableMe.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/pageMe.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/honeySwitch.js"></script>


</head>
<body>
<%--会员管理--%>
<%--搜索--%>
<%--会员搜索--%>
<div style="display: none">
	<div class="searchbody" id="memberSearchBody">
		<div class="searchinfo">
			<h5>姓名:</h5>
			<input type="text" id="name">
		</div>
		<div class="searchinfo">
			<h5>学号:</h5>
			<input type="text" id="sno">
		</div>
		<div class="searchinfo">
			<h5>年级:</h5>
			<input type="text" id="grade">
		</div>
		<div class="searchinfo">
			<h5>专业:</h5>
			<input type="text" id="major">
		</div>

		<div class="searchinfo">
			<h5>性别</h5>
			<select id="sex">
				<option></option>
				<option value="1">男</option>
				<option value="0">女</option>
			</select>
		</div>
		<div class="searchinfo">
			<h5>身份</h5>
			<select id="role">
				<option></option>
				<option value="1">队长</option>
				<option value="2">副队长</option>
				<option value="3">队员</option>
			</select>
		</div>

	</div>
</div>

<%--招新搜索--%>
<div style="display: none">
	<div class="searchbody" id="newMemberSearchBody">
		<div class="searchinfo">
			<h5>姓名:</h5>
			<input type="text" id="newMemberName">
		</div>
		<div class="searchinfo">
			<h5>学号:</h5>
			<input type="text" id="newMemberSno">
		</div>
		<div class="searchinfo">
			<h5>学院:</h5>
			<input type="text" id="newMemberAcademy">
		</div>
		<div class="searchinfo">
			<h5>专业:</h5>
			<input type="text" id="newMemberMajor">
		</div>

		<div class="searchinfo">
			<h5>性别</h5>
			<select id="newMemberSex">
				<option></option>
				<option value="1">男</option>
				<option value="0">女</option>
			</select>
		</div>

	</div>
</div>

<%--活动搜索--%>
<div style="display: none">
	<div class="searchbody" id="activitySearchBody">
		<div class="searchinfo">
			<h5>类型</h5>
			<input type="text" id="activityName">
		</div>
		<div class="searchinfo">
			<h5>类型</h5>
			<select id="kind">
				<option></option>
				<option value="0">活动</option>
				<option value="1">赛事</option>
			</select>
		</div>
		<div class="searchinfo">
			<h5>性质</h5>
			<select id="ispub">
				<option></option>
				<option value="0">队内</option>
				<option value="1">公开</option>
			</select>
		</div>
		<div class="searchinfo">
			<h5>进度</h5>
			<select id="progress">
				<option></option>
				<option value="0">完成</option>
				<option value="1">未完成</option>
			</select>
		</div>
	</div>
</div>

<%--添加--%>
<div class="addForm" id="addForm" style="display: none;position: absolute;top: 40%;left: 40%;">
	<form id="form_addMember" onsubmit="return false">
		<div id="addClose"></div>
		<div class="addInfo">
			<span>学号：</span>
			<input type="text" autocomplete="off" id="addMemberSno" form="form_addMember" required>
		</div>
		<div class="addInfo">
			<span>姓名：</span>
			<input type="text" autocomplete="off" id="addMemberName" form="form_addMember" required>
		</div>
		<div class="addInfo">
			<span>性别：</span>
			<input type="radio" value="1" name="addMemberSex"> 男
			<input type="radio" value="0" name="addMemberSex"> 女
		</div>
		<div class="addInfo">
			<span>专业：</span>
			<input type="text" autocomplete="off" id="addMemberMajor" form="form_addMember" required>
		</div>
		<button id="doAddMember">确定</button>
		<input type="reset" id="addMemberRest" style="display: none">
	</form>
</div>






	<div class="wapper">
		<div class="LeftNav">
			<ul class="ul">
				<li class="li"><a href="home">首页</a></li>
				<li class="li"><a onclick="directoryManager('memberSys')">会员管理</a></li>
				<li class="li"><a onclick="directoryManager('activitySys')">活动管理</a></li>
				<li class="li"><a onclick="window.location.href='newsManager?currentPage=1'">宣传管理</a></li>
				<li class="li"><a onclick="directoryManager('newSys')">招新管理</a></li>
			</ul>
		</div>
		<div class="RightContent">
			<div class="logo">
				<img width="657px" height="90px" src="images/logo.jpg">
				<span id="signButton" class="switch-off" style="position: relative;float: right;display: none"></span>
				<script>
                    var thisCatalog= "${param.catalog}";
                    if (thisCatalog=='newSys'){
                        $("#signButton").css("display","block");
                    }

                    var openFlag = "${applicationScope.openSign}";
                    if (openFlag=='ok'){
                        honeySwitch.showOn("#signButton");
                    }else {
                        honeySwitch.showOff("#signButton")
                    }

					$(function () {
						switchEvent("#signButton",function(){
						    $.ajax({
                                type:'post',
                                url:'openSign',
                                data:'flag=1',
                                success:function (result) {
                                    if (result=='hadOpen'){
                                        alert("报名开启")
                                    }
                                }
                            });




                            },
                            function(){
                                $.ajax({
                                    type:'post',
                                    url:'openSign',
                                    data:'flag=0',
                                    success:function (result) {
                                        if (result=='hadClosed'){
                                            alert("报名关闭")
                                        }
                                    }
                                });

						});
					})

				</script>

			</div>
			<div class="table" id="data">
				<div class="list" id="table" style="display: none">


				</div>
				<div class="page_div" id="page">

				</div>
			</div>
		</div>
		
	</div>








<script type="text/javascript">
	
	
	/*目录管理*/
	function directoryManager(catalog) {
		window.location.href='socialManager?catalog='+catalog;
	}
	
	var table ;
	function instantTable() {
		var catalog = "${param.catalog}";
		if (catalog=="memberSys"){
			table=memberTable();
			table.init();
			getData("memberList",getMemberCondition());


		}
		if (catalog=='activitySys') {
			table=activityTable();
			table.init();
			getData('listActivity',getActivityCondition());


		}
		if (catalog=="newSys") {
			table = newTable();
			table.init();
			getData("newMemberList",getNewMemberCondition());
		}
		if(catalog=="activityMember"){

			getData("",getMemberCondition());
		}

	}
	$(function () {
		instantTable();
	})


	
	
	
	/*目录管理end*/
	
	
	
	
	


	/*公用方法*/
	//获得数据
	function getData(url,condition){
		$.ajax({
			type:'post',
			url:url,
			data:"currentPageJSON=1&conditionJSON="+ condition,
			success:function (result) {
				$("#table").css("display","block");
				var data = $.parseJSON(result);
				table.refresh(data[0]);
				$("#page").paging({
					pageNum: 1, // 当前页面
					totalNum: data[1], // 总页码
					totalList: data[2], // 记录总数量
					callback: function (num) { //回调函数
						$.ajax({
							type:'post',
							url:url,
							data:'currentPageJSON='+ num +"&conditionJSON="+condition,
							success:function (result) {

								table.refresh($.parseJSON(result)[0]);
							}
						})
					}
				});


			}
		});
	};


	//删除
	function deleteCommon(url,ids,isAll,condition,catalog){
		if(ids==[]){
			alert("你没有选择任何信息");

		}else {
			/*这个地方放一个正在加载的图片更加合适 防止网速慢用户重复点击 emmmm 好吧 异步做增删改查确实不太好*/
			$(".shade").css("display","none");
			var idsJSON = JSON.stringify(ids);
			$.ajax({
				url:url,
				type:'post',
				data:"idsJSON="+ idsJSON + "&isAll="+ isAll+"&conditionJSON="+condition,
				success:function (result) {
					if (result=="true"){
						alert("删除成功");
						directoryManager(catalog);

					}

				}
			})
		}
	};










/*会员管理*/

/*获取搜索条件*/
	function getMemberCondition() {
		var sno = $("#sno").val();
		var name = $("#name").val();
		var sex = $("#sex").val();
		var major = $("#major").val();
		var grade = $("#grade").val();
		var role = $("#role").val();
		var condition = {
			sno: sno == "" ? null : sno,
			name: name == "" ? null : name,
			sex: sex == "" ? null : sex,
			major: major == "" ? null : major,
			grade: grade == "" ? null : grade,
			role: role == "" ? null : role

		};
		var conditionJSON = JSON.stringify(condition);
		return conditionJSON;
	}
/* 获取搜索条件 end*/


	/*member add */
	function getAddMember(){
		var sno = $("#addMemberSno").val();
		var name = $("#addMemberName").val();
		var sex = $("input[name='addMemberSex']").val();
		var major = $("#addMemberMajor").val();
		var member ={
			sno:sno,
			name:name,
			sex:sex,
			major:major
		};
		var memberJSON = JSON.stringify(member);
		return memberJSON;
	}

	$("#addClose").click(function () {
		closeAddForm();
	});
	function closeAddForm(){
		$("#shade").css("display","none");
		$("#addForm").css("display","none");
		$("#addMemberRest").click();
	}
	$("#doAddMember").click(function () {
		$.ajax({
			type:'post',
			url:'addMember',
			data:'memberJSON='+ getAddMember(),
			success:function (result) {
				if (result=="false"){

					alert("会员已存在");
				} else {

					closeAddForm();
					alert("添加会员成功");
				}
			}
		})
	});

	/*member add end*/




	/*table*/
	function memberTable() {
		var memberTable = $("#table").table({
			title:[{name:'学号',property:'sno',},{name:'姓名',property:'name'},{name:'电话',property:'phone'},{name:'性别',show:{0:'女',1:'男'},property:'sex'},{name:'院系',property:'academy'},{name:'专业',property:'major'},{name:'年级',property:'grade'}],
			id:'id',
			size:15,
			search:'memberSearchBody',
			addBtn:function(){
				$("#shade").css("display","block");
				$("#addForm").css("display","block");
			},
			divbutton:function (id) {
				window.location.href="memberPersonalInformation?id="+id;
			},
			deleteCallback:function (ids,isAll) {

				deleteCommon('deleteMember',ids,isAll,getMemberCondition(),'memberSys');

			},
			sendCallback:function (ids,isAll) {
				alert("因为腾讯的审查原因，没有适合此类型的模板");
			},
			searchCallback:function () {
				var condition = getMemberCondition();

				$("#page").empty();
				getData('memberList',condition);
			}


		});
		return memberTable;
	}




	/*获取搜索信息*/
	function getNewMemberCondition() {

		var sno = $("#newMemberSno").val();
		var name = $("#newMemberName").val();
		var sex = $("#newMemberSex").val();
		var academy = $("#newMemberAcademy").val();
		var major = $("#newMemberMajor").val();
		var grade = $("#newMemberGrade").val();
		var condition = {
			sno: sno == "" ? null : sno,
			name: name == "" ? null : name,
			sex: sex == "" ? null : sex,
			major: major == "" ? null : major,
			grade: grade == "" ? null : grade,
			academy:academy==""?null:academy
		};
		var conditionJSON = JSON.stringify(condition);
		return conditionJSON;
	}

	/*获取搜索信息end*/

	function newTable() {
		var newStudentTable = $("#table").table({
			title:[{name:'学号',property:'sno'},{name:'姓名',property:'name'},{name:'性别',show:{1:'男',0:'女'},property:'sex'},{name:'学院',property:'academy'},{name:'专业',property:'major'},{name:'手机',property:'phone'}],
			id:'id',
			size:15,
			search:'newMemberSearchBody',
			addBtn:function (ids,isAll) {
				if (ids==[]){
					alert("你没有选择任何信息");

				} else{
					var idsJSON = JSON.stringify(ids);
					var c = confirm("添加成员");
					if (c==true){
						$.ajax({
							url:'accept',
							type:'post',
							data:"idsJSON="+ idsJSON + "&isAll="+ isAll+"&conditionJSON="+getNewMemberCondition(),
							success:function (result) {
								if (result=="ok"){
									alert("添加成功");
									directoryManager('newSys');

								}
							}
						})
					}
				}

			},
			divbutton:function (id) {

			},
			deleteCallback:function (ids,isAll) {
				deleteCommon('deleteNewMember',ids,isAll,getNewMemberCondition(),'newSys');
			},
			sendCallback:function (ids,isAll) {
				var idsJSON = JSON.stringify(ids);
				$.ajax({
					type:'post',
					url:'sendMessage',
					data:"idsJSON="+ idsJSON + "&isAll="+ isAll+"&conditionJSON="+getNewMemberCondition(),
					success:function (result) {
						if (result=='true'){
							alert("发送成功");
						} else {
							alert("一些原因发送失败，请再次尝试或者联系开发人员");
						}
					}
				})
			},
			searchCallback:function () {
				var condition = getNewMemberCondition();
				$("#page").empty();
				getData('newMemberList',condition);
			}

		});
		return newStudentTable;
	}











	function getActivityCondition() {
		var name = $("#activityName").val();
		var kind = $("#kind").val();
		var ispub= $("#ispub").val();
		var progress=$("#progress").val();
		var condition = {

			name: name == "" ? null : name,
			kind: kind == "" ? null : kind,
			ispub: ispub == "" ? null : ispub,
			progress: progress == "" ? null : progress,

		}

		var conditionJSON = JSON.stringify(condition);
		return conditionJSON;

	}


	function activityTable() {
		var activityTable = $("#table").table({
			title:[{name:'活动名称',property:'name'},{name:'报名截止',property:'signEnd'},{name:'开始时间',property:'activityStart'},{name:'结束时间',property:'activityEnd'},{name:'类型',show:{0:'活动',1:'赛事'},property:'kind'},{name:'性质',show:{0:'队内',1:'公开'},property:'ispub'}],
			id:'id',
			size:15,
			search:'activitySearchBody',
			divbutton:function(id){
				window.location.href='checkActivityDetail?id='+id;
			},
			addBtn:function () {
				window.location.href='intoAddActivity';
			},
			deleteCallback:function (ids,isAll) {
				deleteCommon('deleteActivity',ids,isAll,getActivityCondition(),'activitySys');


			},
			searchCallback:function () {
				var condition = getActivityCondition();
				$("#page").empty();
				getData('listActivity',condition);
			}



		});
		return activityTable;
	}

	/*活动管理end*/











</script>

</body>
</html>