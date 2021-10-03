<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findidresult.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

</head>
<body>
<div class="header">
	<jsp:include page="header.jsp" flush="true"/>
</div>

<div class="findid">
	<div class="findid_container">
		<h2 class="title">아이디 찾기 결과</h2>
		<h1>${findidResult }</h1>
		
		<div class="btn_area">
			<a href="${pageContext.request.contextPath }/jhr/login">로그인</a>
			<a href="${pageContext.request.contextPath }/" style="margin-left:20px;">홈</a>
		</div>
	</div>
</div>

<div class="footer">
	<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>