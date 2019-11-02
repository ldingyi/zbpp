<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Summernote</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/zzu.ico" />
  <link href="http://www.jq22.com/jquery/bootstrap-3.3.4.css" rel="stylesheet">
  <script src="http://www.jq22.com/jquery/2.1.1/jquery.min.js"></script>
  <script src="http://www.jq22.com/jquery/bootstrap-3.3.4.js"></script> 
  <link href="${pageContext.request.contextPath}/plugin/summernote/summernote.css" rel="stylesheet">
  <script src="${pageContext.request.contextPath}/plugin/summernote/summernote.js"></script>
</head>
<body>


    <script type="text/javascript">
      <c:if test="${flag!=null}">
        <c:if test="${flag=='ok'}">
          alert("添加活动成功");
          window.location.href="socialManager?catalog=activitySys";
      </c:if>
      </c:if>
    </script>

	<div id="summernote"></div>
    <div id="activityForm">
      <form action="addActivity" onsubmit="completeForm()" method="post">



         <c:if test="${activity!=null}">
             <input type="hidden" name="id" value="<c:out value="${activity.id}"/>">
             活动名称：<input type="text" name="name" value="<c:out value="${activity.name}"/>" required><br>
             报名截止时间：<input type="date" name="se" value="<c:out value="${fn:substring(activity.se,0 ,10 )}"/>"  required><br>
             活动开始时间：<input type="date" name="at" value="<c:out value="${fn:substring(activity.at,0 ,10 )}"/>"  required><br>
             活动结束时间：<input type="date" name="ae"  value="<c:out value="${fn:substring(activity.ae,0 ,10 )}"/>"  required><br>
             <c:if test="${activity.kind==0}">
                 活动性质：<input type="radio" name="kind" value="0" checked>活动  <input type="radio" name="kind" value="1">赛事
             </c:if>
             <c:if test="${activity.kind==1}">
                 活动性质：<input type="radio" name="kind" value="0" >活动  <input type="radio" name="kind" value="1" checked>赛事
             </c:if>
             <c:if test="${activity.ispub==0}">
                 是否公开:<input type="radio" name="ispub" value="0" checked>队内  <input type="radio" name="ispub" value="1">公开
             </c:if>
             <c:if test="${activity.ispub==1}">
                 是否公开:<input type="radio" name="ispub" value="0" >队内  <input type="radio" name="ispub" value="1" checked>公开
             </c:if>
         </c:if>
          <c:if test="${activity==null}">
              活动名称：<input type="text" name="name" required><br>
              报名截止时间：<input type="date" name="se"  required><br>
              活动开始时间：<input type="date" name="at" required><br>
              活动结束时间：<input type="date" name="ae" required><br>
              活动性质：<input type="radio" name="kind" value="0">活动  <input type="radio" name="kind" value="1">赛事
              是否公开:<input type="radio" name="ispub" value="0" >队内  <input type="radio" name="ispub" value="1" >公开

          </c:if>



        <textarea name="ad" id="ad" hidden></textarea>
        <input type="submit" value="保存">
      </form>
    </div>

  <script>

        <c:if test="${activity==null}">
            $('#summernote').summernote();
        </c:if>

        <c:if test="${activity!=null}">

            $('#summernote').summernote('code','<c:out value="${activity.ad}" escapeXml="false"/>');
        </c:if>




    function completeForm() {


      $("#ad").val($('#summernote').summernote('code'));

    }




  </script>
</body>
</html>
