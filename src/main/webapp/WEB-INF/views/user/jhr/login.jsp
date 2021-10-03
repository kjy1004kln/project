<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

</head>
<body>
<div class="header">
	<jsp:include page="header.jsp" flush="true"/>
</div>

<div id="login" class="login_container">
	<div class="login_contents">
		<ul class="tab_wrap">
			<li>
				<div class="tab_content">
					<div class="member_login_wrap">
						<div class="login_inner">
							<div class="login_box">
								<div class="login_title">로그인</div>
								<form class="login_area" method="post" action="${pageContext.request.contextPath }/jhr/login">
									<input type="text" name="mid" id="userId" class="login_id" maxlength="50" placeholder="아이디 또는 이메일을 입력해 주세요.">
									<input type="password" name="mpw" id="userPwd" class="login_pwd" maxlength="15" placeholder="비밀번호를 입력해 주세요.">
									<div class="errmsg">${errMsg }</div>
									<input type="submit" class="btn_login" value="로그인">
								</form>
								<div class="login_bot_wrap">
									<div class="login_menu">
										<a href="${pageContext.request.contextPath }/jhr/join">회원가입</a>
										<a href="${pageContext.request.contextPath }/jhr/findid">아이디 찾기</a>
										<a href="${pageContext.request.contextPath }/jhr/checkpw">비밀번호 재설정</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>

<div class="footer">
	<jsp:include page="footer.jsp" flush="true"/>
</div>
</body>
</html>