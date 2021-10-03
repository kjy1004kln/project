<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findid.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

</head>
<body>
<div class="header">
	<jsp:include page="header.jsp" flush="true"/>
</div>

<div class="findid">
	<div class="findid_container">
		<div class="toparea">
			<h2 class="title">아이디 찾기</h2>
			<div class="headline">개인정보보호를 위해<br>본인 인증해주세요.</div>
		</div>
		<form method="post" action="${pageContext.request.contextPath }/jhr/findid" class="find_id" onsubmit="return check()">
			<h3>인증정보 입력</h3>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">이름</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mname" class="input_space" maxlength="15" id="name" placeholder="한글 또는 영문으로 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">이메일</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="memail" class="input_space" placeholder="이메일을 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="errmsg">${errMsg }</div>
			<div class="submit_container">
				<input type="submit" value="찾기" class="submit_btn">
			</div>
		</form>
	</div>
</div>

<div class="footer">
	<jsp:include page="footer.jsp" flush="true"/>
</div>

<script type="text/javascript">
	function check(){
		var name=document.getElementsByName("mname")[0];
		var email=document.getElementsByName("memail")[0];
		var ereg=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		if(name.value.trim()==""){
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		if(email.value.trim()==""){
			alert("이메일을 입력하세요.");
			email.focus();
			return false;
		}
		if (!ereg.test(email.value)){
			alert("이메일형식에 맞게 입력하세요.");
			email.focus();
			return false;
		}
	}
</script>
</body>
</html>