<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
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
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
a{
   color:black;
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
.active {
    background-color: #00AEF0;
    margin:0px;
}
.liactive {
background-color:gray;
}
</style>
</head>
<body>
<script type="text/javascript">
$(function(){
		let qcate = "${qcate}"
		console.log(qcate)
		$("#"+qcate).parent().children().attr('class','')
		$("#"+qcate).attr('class','liactive')
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
<input type="hidden" id="qnaCate" value="${qcate}">
<input type="hidden" id="mid" value="${mid}">
<div class="board_content">
   <table class="table">
      <tr class="table_title">
         <th style="width:140px">답변상태</th>
         <th style="width:140px">번호</th>
         <th>글제목 </th>
         <th class="table_date">작성일</th>
         <th class="table_writer">작성자</th>
      </tr>
      <c:forEach var="vo" items="${list }">
         <tr class="table_content">
            <c:choose>
               <c:when test="${vo.qlev=='Y' }">
                  <td class="tdalign" style="color:#00aef0">완료</td>
               </c:when>
               <c:otherwise>
                  <td class="tdalign" style="color:#f02000">대기</td>
               </c:otherwise>
            </c:choose>
            <td class="tdalign">${vo.qid }</td>
            <c:choose>
               <c:when test="${vo.qpw == null }">
                  <td><a href="${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid=${vo.qid }&qcate=${qcate}">${vo.qtitle }</a></td>
               </c:when>
               <c:otherwise>
                 <td><img src="//img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_lock.gif"><a href="#" onclick="qpwCheck(${vo.qpw},${vo.qid });"> ${vo.qtitle }</a></td>
               </c:otherwise>
            </c:choose>
            <fmt:formatDate value="${vo.qrdate }" pattern="YY-MM-dd" var="qrdate"/>
            <td class="tdalign">${qrdate }</td>
            <td class="tdalign">${vo.mid }</td>
         </tr>
      </c:forEach> 
   	</table>
   	<div class="other_content">
		<c:choose>
	 		<c:when test="${empty sessionScope.mid }">
	 			<input type="button" onclick="chklogin()" value="글쓰기" class="btn btn-default writebtn">
	 		</c:when>
	 		<c:otherwise>
	 			<input type="button" onclick="writeQna()" value="글쓰기" class="btn btn-default writebtn">
	 		</c:otherwise>
	 	</c:choose>
      <div class="pagebox">
         <c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
            <c:choose>
               <c:when test="${pu.pageNum==i }"><!-- 현재페이지 -->
                  <a href="${pageContext.request.contextPath }/hjy/qna?pageNum=${i }&field=${field}&keyword=${keyword}">
                  <span style='color:#00AEF0;font-weight: bold'>[${i }]</span>
                  </a>
               </c:when>
               <c:otherwise>
                  <a href="${pageContext.request.contextPath }/hjy/qna?pageNum=${i }&field=${field}&keyword=${keyword}">
                  <span style='color:gray;'>[${i }]</span>
                  </a>
               </c:otherwise>
            </c:choose>
         </c:forEach>
      </div>
   </div>
   <div>
      <form method="post" action="${pageContext.request.contextPath }/hjy/qna" class="searchbox">
         <select name = "field" class="box_margin">
            <option value="qtitle" <c:if test="${field=='qtitle' }">selected</c:if>>제목</option>
            <option value="mid" <c:if test="${field=='mid' }">selected</c:if>>글쓴이</option>
            <option value="qcontent" <c:if test="${field=='qcontent' }">selected</c:if>>내용</option>
         </select>
         <input type="text" name ="keyword" value="${keyword }" class="form-control box_margin">
         <input type="submit" value="검색" class="btn btn-default submitbtn">
      </form>
   </div>
</div>
<div class="footer">
   <jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true"/>
</div>
</body>
<script type="text/javascript">
function writeQna(){	
	location.href='${pageContext.request.contextPath }/hjy/qna/newQna?qcate=${qcate}';
}
function chklogin(){
	let chk = confirm("로그인 해야만 이용 가능한 서비스입니다. 로그인 하시겠습니까?");
	if(chk == true){
		location.href='${pageContext.request.contextPath }/jhr/login';
	}else{
		return;
	}
}
function qpwCheck(qpw,qid){
	let qcate = "${qcate}";
	let qcateplus = $("#"+qcate).html()
	if(qcateplus =='전체'){
		qcateplus='all';
	}
	let pwc = prompt("비밀번호를 입력해주세요");
	if(pwc == null || pwc == ""){
		location.href= '${pageContext.request.contextPath }/hjy/qna?qcate='+qcateplus;
	}else{
		if(qpw == pwc) {
			location.href= '${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid='+qid+'&qcate=${qcate}';
		} else {
		    alert("비밀번호가 틀렸습니다.");
		    location.href= '${pageContext.request.contextPath }/hjy/qna?qcate='+qcateplus;
		}
	}
}
</script>
</html>