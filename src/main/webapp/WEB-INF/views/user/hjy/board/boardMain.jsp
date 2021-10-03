<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_all.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_header.css">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
 #page-wrapper {
    padding-left: 250px;
  }
  
  #sidebar-wrapper {
    position: fixed;
    height: ;
    width:;
    margin-left: -250px;
    background: ;
    overflow-x: hidden;
    overflow-y: auto;
  }
  
  #page-content-wrapper {
    width: 100%;
    padding: 20px;
  }
  /* 사이드바 스타일 */
  
  .sidebar-nav {
    width: 250px;
    margin: 0;
    padding: 0;
    list-style: none;
  }
  
  .sidebar-nav li {
    text-indent: 1.5em;
    line-height: 2.8em;
  }
  
  .sidebar-nav li a {
    display: block;
    text-decoration: none;
    color: #000;
  }
  
  .sidebar-nav li a:hover {
    color: #00AEF0;
    background: #EBEDEF;
  }
  
  .sidebar-nav > .sidebar-brand {
    font-size: 1.3em;
    line-height: 3em;
  }

</style>
</head>
<body>
	<div class="header">
		<jsp:include page="../../jhr/header.jsp" flush="true"/>
	</div>
	<div class="board_header">
		<ul class="ulcss">
	      <li class="licss"><a href="/project/phj/home" class="liactive">MyPage</a></li>
	      <li class="licss"><a href="/project/hjy/board/all">자유게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/review">리뷰게시판</a></li>
	      <li class="licss"><a href="/project/hjy/board/matching">매칭게시판</a></li>
	    </ul>
	</div>
	<div id="page-wrapper">
	  <!-- 사이드바 -->
	  <div id="sidebar-wrapper">
	    <ul class="sidebar-nav">
	      <li class="sidebar-brand">
	        <a href="/project/phj/home">${mid }님 마이페이지</a>
	      </li>
	      <li><a href="/project/phj/mypage/all">자유게시판</a></li>
	      <li><a href="/project/phj/mypage/review">리뷰게시판</a></li>
	      <li><a href="/project/phj/mypage/matching">매칭게시판</a></li>
	    </ul>
	  </div>
  	</div>
	<div class="board_content" style="padding-left: 100px;">
		<table class="table">
			<tr class="table_title">
				<th class="table_writer">카테고리</th>
				<th>글제목</th>
				<th>수정/삭제</th>
				<th class="table_date">작성일</th>
			</tr>
			<c:forEach var="vo" items="${list }">
				<tr class="table_content">
					<td class="tdalign">
						<c:choose>
							<c:when test="${vo.bcate eq 'all' }">
								자유게시판
							</c:when>
							<c:when test="${vo.bcate eq 'review' }">
								리뷰게시판
							</c:when >	
							<c:when test="${vo.bcate eq 'matching' }">
								매칭게시판
							</c:when>
						</c:choose>
				 	</td>
					<td><a href="/project/hjy/board/detail?bid=${vo.bid }">${vo.btitle }</a></td>
					<td style="text-align: center;"><a href="/project/phj/board/update?bid=${vo.bid }">수정/삭제</a></td>
					<fmt:formatDate value="${vo.brdate }" pattern="YY-MM-dd" var="brdate"/>
					<td class="tdalign">${brdate }</td>
				</tr>
			</c:forEach>
		</table>
		<div class="other_content">
			<div class="pagebox">
				<c:forEach var="i" begin="${pu.startPageNum }" end="${pu.endPageNum }">
					<c:choose>
						<c:when test="${pu.pageNum==i }"><!-- 현재페이지 -->
							<a href="/project/phj/home?pageNum=${i }&field=${field}&keyword=${keyword}">
							<span style='color:blue;font-weight: bold'>[${i }]</span>
							</a>
						</c:when>
						<c:otherwise>
							<a href="/project/phj/home?pageNum=${i }&field=${field}&keyword=${keyword}">
							<span style='color:gray;'>[${i }]</span>
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
		</div>
		<div>
			<form action="${pageContext.request.contextPath }/phj/home" class="searchbox">
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
</html>