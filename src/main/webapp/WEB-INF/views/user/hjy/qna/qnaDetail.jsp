<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
<!-- boardheader-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/board_header.css">
<!-- 글꼴 -->
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">
<style>
a {
	color: black;
}

body {
	background: #fafafa;
}

.container {
	margin-top: 50px;
}

table {
	font-size: 15px;
}

.card {
	font-size: 15px;
}
</style>
</head>
<body>
	<script type="text/javascript">
$(function(){
	$("#"+"${qcate}").parent().children().attr('class','')
	$("#"+"${qcate}").attr('class','liactive')
})
</script>
	<div class="header">
		<jsp:include page="/WEB-INF/views/user/jhr/header.jsp" flush="true" />
	</div>
	<div class="board_header">
		<ul class="ulcss">
			<li class="licss"><a
				href="${pageContext.request.contextPath }/hjy/qna" id="all">전체</a></li>
			<li class="licss"><a
				href="${pageContext.request.contextPath }/hjy/qna?qcate=상품"
				id="product">상품</a></li>
			<li class="licss"><a
				href="${pageContext.request.contextPath }/hjy/qna?qcate=교환/환불"
				id="refund">교환/환불</a></li>
			<li class="licss"><a
				href="${pageContext.request.contextPath }/hjy/qna?qcate=사이트이용"
				id="site">사이트 이용</a></li>
			<li class="licss"><a
				href="${pageContext.request.contextPath }/hjy/qna?qcate=기타" id="enc">기타</a></li>
		</ul>
	</div>
	<div class="container">
		<table class="table table-borderless" style="background-color: white;">
			<thead>
				<tr>
					<td scope="col">글번호: ${vo.qid }</td>
					<td scope="col"></td>
					<td scope="col" style="text-align: center;">${vo.qrdate }</td>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="2">제목: ${vo.qtitle }</td>
					<td style="text-align: center;">작성자: ${vo.mid }</td>
				</tr>
				<tr>
					<td colspan="3"><strong>내용: ${vo.qcontent }</strong></td>
				</tr>
				<tr>
					<td colspan="3"><img style="width: 50%;" src="${pageContext.request.contextPath }/resources/images/userqna/${vo.qfile }" onerror="this.style.display='none'"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<div class="card">
			<!-- 
			<div class="cmtHead"style="margin-top: 20px; margin-left: 50px;">
					<p style='font-size: 15px;'>ANS</p>
			</div>
			<hr>
		 -->
			<c:if test="${ans eq null}">
				<div style="margin: 50px 50px 50px 50px; text-align: center;">
					댓글이 없습니다.</div>
			</c:if>
			<c:if test="${ans != null}">
				<div style="margin: 48px 50px 50px 10px;">
					<strong>▶ ${ans }</strong>
				</div>
			</c:if>
		</div>
		<br>
		<br>
		<c:choose>
			<c:when test="${prevVo eq null }">
				이전글 없음
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${prevVo.qpw == null }">
	                  이전글 <a href="${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid=${prevVo.qid }"><strong>${prevVo.qtitle }</strong></a>
					</c:when>
					<c:otherwise>
	                  이전글 <a href="#" onclick="qpwCheck(${prevVo.qpw},${prevVo.qid });"><strong>${prevVo.qtitle }</strong></a>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		<br>
		<c:choose>
			<c:when test="${nextVo eq null }">
			다음글 없음
		</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${nextVo.qpw == null }">
	              		다음글 <a href="${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid=${nextVo.qid }"><strong>${nextVo.qtitle }</strong></a>
					</c:when>
					<c:otherwise>
	                	다음글 <a href="#" onclick="qpwCheck(${nextVo.qpw},${nextVo.qid });"><strong>${nextVo.qtitle }</strong></a>
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
	</div>
	<br>
	<br>
	<div class="footer">
		<jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true" />
	</div>
</body>
<script type="text/javascript">
function qpwCheck(qpw,qid){
	let pwc = prompt("비밀번호를 입력해주세요");
	if(pwc == null || pwc == ""){
		location.href= '${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid=${vo.qid}&qcate=${qcate}';
	}else{
		if(qpw == pwc) {
			location.href= '${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid='+qid+'&qcate=${qcate}';
		} else {
		    alert("비밀번호가 틀렸습니다");
		    location.href= '${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid=${vo.qid}&qcate=${qcate}';
		}
	}
}
</script>
</html>