<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>添加宣传</title>
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
          alert("添加宣传成功");
          window.location.href="newsManager?currentPage=1";
        </c:if>
      </c:if>
    </script>

	<div id="summernote"></div>
    <div id="activityForm">
      <form action="addNews" onsubmit="completeForm()" method="post">

          <c:if test="${news!=null}">
              <input type="hidden" name="id" value="<c:out value="${news.id}"/>">
              标题：<input type="text" name="title" value="<c:out value="${news.title}"/>" required><br>
              <c:if test="${news.kind==0}">
                  类型：<input type="radio" name="kind" value="0" checked> 动态 <input type="radio" value="1" name="kind"> 公告
              </c:if>
              <c:if test="${news.kind==1}">
                  类型：<input type="radio" name="kind" value="0" > 动态 <input type="radio" value="1" name="kind" checked>  公告
              </c:if>

              日期：<input type="date" name="date"  value="<c:out value="${fn:substring(news.date,0 ,10 )}"/>" required>
          </c:if>

          <c:if test="${news==null}">
              标题：<input type="text" name="title"  required><br>
              类型：<input type="radio" name="kind" value="0" > 动态 <input type="radio" value="1" name="kind">  公告
              日期：<input type="date" name="date"   required>
          </c:if>




        <textarea name="content" id="ad" hidden></textarea>
        <input type="submit" value="保存">
      </form>
    </div>

  <script>
        <c:if test="${news==null}">
            $('#summernote').summernote();
        </c:if>
        <c:if test="${news!=null}">
            $('#summernote').summernote('code','<c:out value="${news.content}" escapeXml="false"/>' );
        </c:if>





    function completeForm() {


      $("#ad").val($('#summernote').summernote('code'));

    }

  </script>
</body>
</html>
