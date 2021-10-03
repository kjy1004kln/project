<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 헤더 -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/header.css">
<!-- 푸터 -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/footer.css">
<!-- boardheader-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<!-- 글꼴 -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<!-- 부트스트랩 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>qnaWriteForm.jsp</title>
<script>
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		$("#form").submit();
	});

	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/hjy/qna";
	});
	
	
</script>

<style>
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
</head>
<body>
<script type="text/javascript">
$(function(){
		let qcate = "${qcate}"
		$("#"+qcate).parent().children().attr('class','')
		$("#"+qcate).attr('class','liactive')
		let qcatename=$("#"+qcate).html();
		$("#cate").val(qcatename).attr("selected", "selected");
		if(qcatename=='전체'){
			$("#cate").val("상품").attr("selected", "selected");
		}
})
</script>
<div class="header">
   <jsp:include page="/WEB-INF/views/user/jhr/header.jsp" flush="true"/>
</div>
<div class="board_header">
   <ul class="ulcss">
      <li class="licss"><a href="${pageContext.request.contextPath }/hjy/qna" id="all">전체</a></li>
      <li class="licss"><a href="${pageContext.request.contextPath }/hjy/qna?qcate=상품" id="product">상품</a></li>
      <li class="licss"><a href="${pageContext.request.contextPath }/hjy/qna?qcate=교환/환불"id="refund">교환/환불</a></li>
      <li class="licss"><a href="${pageContext.request.contextPath }/hjy/qna?qcate=사이트이용"id="site">사이트이용</a></li>
      <li class="licss"><a href="${pageContext.request.contextPath }/hjy/qna?qcate=기타"id="enc">기타</a></li>
    </ul>
</div>
	<article>
		<div class="container" role="main">
			<h2>QnA 글쓰기</h2>
			<form name="form" id="form" role="form" enctype="multipart/form-data" method="post" action="${pageContext.request.contextPath}/hjy/qna/newQna">
				<div class="mb-3">
				<label for="reg_id">카테고리</label><br>
					<select name="qcate" class="form-control" id='cate'>
					    <option value="상품">상품</option>
					    <option value="교환/환불">교환/환불</option>
					    <option value="사이트이용">사이트이용</option>
					    <option value="기타">기타</option>
					</select>
				</div>
				<div class="mb-3">
					<label for="title">제목</label>
					<input type="text" class="form-control" name="qtitle" id="qtitle" placeholder="제목을 입력해 주세요">
				</div>
				<!-- 
				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<input type="text" class="form-control" name="reg_id" id="reg_id" placeholder="이름을 입력해 주세요">
				</div>
				 -->
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" name="qcontent" id="qcontent" placeholder="내용을 입력해 주세요" ></textarea>
				</div>
				<div class="mb-3">
					<label for="file">첨부파일</label>
					<input type="file" class="form-control" name="qfile" id="fileupload" placeholder="태그를 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="reg_id">비밀번호</label>
					<input type="password" class="form-control" name="qpw" id="reg_id" placeholder="비밀번호를 입력해 주세요">
				</div>
			</form>
			<div  style='text-align: center;'>
				<button type="button" class="btn" id="btnSave">저장</button>
				<button type="button" class="btn" id="btnList">취소</button>
			</div>
		</div>
	</article>
<div class="footer">
   <jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true"/>
</div>

</body>
</html>