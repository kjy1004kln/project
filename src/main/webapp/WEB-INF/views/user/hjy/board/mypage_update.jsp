<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
<!-- 헤더 -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/header.css">
<!-- 헤더 css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<!-- 푸터 -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/footer.css">
<!-- boardheader-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<!-- 글꼴 -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
body {
  padding-top: 70px;
  padding-bottom: 30px;
}
.btn{
   color: #00AEF0;
   background-color: white;
   border-color: #00AEF0;
}
.btn:hover {
  background-color: #00AEF0;
  border-color: #00AEF0 !important;
  color: white !important;
}
input[name="qfile"] {
  height: 40px;
}

.container{
	display:block;
	margin:0 auto;
	margin-bottom:50px;
}
</style>
<script>
	$(document).on('click', '#btnUpdate', function(e){
		e.preventDefault();
		$("#form").submit();
	});

	$(document).on('click', '#btnDelete', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/phj/board/delete?bid="+${vo.bid};
	});
	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/phj/home";
	});

</script>
</head>
<body>
<div class="header">
   <jsp:include page="/WEB-INF/views/user/jhr/header.jsp" flush="true"/>
</div>
<div class="board_header">
   <div class="board_header">
		<ul class="ulcss">
	      <li class="licss"><a href="/project/phj/home" class="liactive">MyPage</a></li>
	      <li class="licss"><a href="/project/hjy/board/all">자유게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/review">리뷰게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/matching">매칭게시판</a></li>
	    </ul>
	</div>
</div>
	<article>
		<div class="container" role="main">
			<h2>게시판 수정/삭제</h2>
			<form name="form" id="form" role="form" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/phj/board/update?bid=${vo.bid}">
			<input type="hidden" id="bcate" name="bcate" value="${vo.bcate }">
			<input type="hidden" id="mid" name="mid" value="${mid }"><br>
			<input type="hidden" id="brdate" name="brdate" value="${vo.brdate }"><br>
			<c:if test="${not empty vo.bfile1}">
				<input type="hidden" class="form-control" name="bfile1" id="bfile1" value="${vo.bfile1 }">
			</c:if>
			<c:if test="${not empty vo.bfile2}">
				<input type="hidden" class="form-control" name="bfile2" id="bfile2" style="margin-top: 5px;" value="${vo.bfile2 }">
			</c:if>
			<c:if test="${not empty vo.bfile3}">
				<input type="hidden" class="form-control" name="bfile3" id="bfile3" style="margin-top: 5px;" value="${vo.bfile3 }">	
			</c:if>
				
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="btitle" id="btitle" value="${vo.btitle }">
				</div>
				<!-- 
				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
				</div>
				 -->
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="bcontent" id="bcontent" >${vo.bcontent }
					</textarea>
				</div>
				<div class="mb-3">
					<label for="file">첨부파일</label>
					<input type="text" class="form-control" value="${vo.bfile1 }"><input type="file" name="file" value="파일첨부">
					<input type="text" class="form-control" value="${vo.bfile2 }"><input type="file" name="file" style="margin-top: 5px;" value="파일첨부">
					<input type="text" class="form-control" value="${vo.bfile3 }"><input type="file" name="file" style="margin-top: 5px;" value="파일첨부">
				</div>
			</form>
			<div style='text-align: center;'>
				<button type="button" class="btn" id="btnUpdate">수정</button>
				<button type="button" class="btn" id="btnDelete">삭제</button>
				<button type="button" class="btn" id="btnList">취소</button>
			</div>
		</div>
	</article>
<div class="footer">
   <jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true"/>
</div>

</body>
</html>