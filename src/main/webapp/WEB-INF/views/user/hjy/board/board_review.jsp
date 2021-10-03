<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
#sidebar-wrapper {
    position: fixed;
    height: 625px;
    width: 250px;
    margin-left: -250px;
    background: #EBEDEF;
    overflow-x: hidden;
    overflow-y: auto;
  }
  </style>
</head>
<body>
	<div class="header">
		<jsp:include page="../../jhr/header.jsp" flush="true"/>
	</div>
	<div class="board_header">
		<ul class="ulcss">
 			<li class="licss"><a href="/project/phj/home">MyPage</a></li>
	      <li class="licss"><a href="/project/hjy/board/all">자유게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/review"class="liactive">리뷰게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/matching">매칭게시판</a></li>
	    </ul>
	</div>
	<input type="hidden" name="bcate" id="bcate" value="${bcate }">	
	
	<div class="board_content">
		<table class="table">
			<tr class="table_title">
				<th class="table_date">작성일</th>
				<th>글제목</th>
				<th class="table_writer">작성자</th>
			</tr>
			<c:forEach var="vo" items="${list }">
				<tr class="table_content">
					<fmt:formatDate value="${vo.brdate }" pattern="YY-MM-dd" var="brdate"/>
					<td class="tdalign">${brdate }</td>
					<td><a href="/project/hjy/board/detail?bid=${vo.bid }">${vo.btitle }</a></td>
					<td class="tdalign">${vo.mid }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="other_content">
			<input type="button" onclick="clickForm()" value="글쓰기" class="btn btn-default writebtn">
		</div>
		<div>
			<form method="post" action="${pageContext.request.contextPath }/list" class="searchbox">
				<select name = "field" class="box_margin">
					<option value="btitle" <c:if test="${field=='btitle' }">selected</c:if>>제목</option>
					<option value="mid" <c:if test="${field=='mid' }">selected</c:if>>글쓴이</option>
					<option value="bcontent" <c:if test="${field=='bcontent' }">selected</c:if>>내용</option>
				</select>
				<input type="text" name ="keyword" value="${keyword }" class="form-control box_margin">
				<input type="submit" value="검색" class="btn btn-default submitbtn">
			</form>
		</div>
	</div>
	<div class="footer">
		<jsp:include page="../../jhr/footer.jsp" flush="true"/>
	</div>
</body>
<script type="text/javascript">
function clickForm(){
	console.log("글쓰기");
	var bcate=$("#bcate").val();
	location.href='${pageContext.request.contextPath }/hjy/board/newPost?bcate='+bcate;
}
</script>
</html>