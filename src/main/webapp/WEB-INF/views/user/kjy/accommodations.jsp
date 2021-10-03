<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
호텔 페이지
<form action="${pageContext.request.contextPath }/user/kjy/room_info">
	<input type="text" name="aid" value="호텔번호">
	<input type="text" name="person" value="인원">
	<input type="text" name="roomnum" value="예약할개수">
	<input type="date" name="startday">
	<input type="date" name="endday">
	<input type="submit">
</form>
<a href="${pageContext.request.contextPath }/user/kjy/mypage">테스트</a><br>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
</script>
</html>