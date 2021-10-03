<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>메인페이지</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/content.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>
	<div class="header">
		<jsp:include page="header.jsp" flush="true"/>
	</div>
	<div class="content">
		<jsp:include page="content.jsp" flush="true"/>
	</div>
	<div class="footer">
		<jsp:include page="footer.jsp" flush="true"/>
	</div>
</body>
</html>