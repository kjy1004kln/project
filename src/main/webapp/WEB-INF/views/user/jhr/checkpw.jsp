<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정 인증</title>
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
		<form method="post" action="${pageContext.request.contextPath }/jhr/checkpw" class="find_id" onsubmit="return check()">
			<div class="toparea">
				<h2 class="title">비밀번호 재설정 인증</h2>
				<div class="headline">개인정보보호를 위해<br>본인 인증해주세요.</div>
			</div>
			<h3>인증정보 입력</h3>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">아이디</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mid" class="input_space" maxlength="15" id="mid" placeholder="아이디를 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">이름</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mname" class="input_space" maxlength="15" id="mname" placeholder="한글 또는 영문으로 입력해주세요.">
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
								<input type="email" name="memail" class="input_space" placeholder="이메일을 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">생년월일</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="date" name="mbirth" class="input_space" placeholder="생년월일 8자리를 입력해주세요. (ex.19990625)">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">휴대폰 번호</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mphone" class="input_space" placeholder="휴대폰 번호를 입력해주세요. (숫자만 입력가능합니다.)">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="errmsg">${errMsg }</div>
			<div class="submit_container">
				<input type="submit" value="확인" class="submit_btn">
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
		var id=document.getElementsByName("mid")[0];
		var email=document.getElementsByName("memail")[0];
		var ereg=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var year=document.getElementsByName("mbirth")[0];
		var phone=document.getElementsByName("mphone")[0];
		if(name.value.trim()==""){
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		if(id.value.trim()==""){
			alert("아이디를 입력하세요.");
			id.focus();
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
		if(year.value.trim()==""){
			alert("생년월일을 입력하세요.");
			year.focus();
			return false;
		}
		if(phone.value.trim()==""){
			alert("휴대폰번호를 입력하세요.");
			phone.focus();
			return false;
		}
		if(phone.value.indexOf("-")!=-1){
			alert("휴대폰번호에 숫자만 입력해주세요.");
			phone.focus();
			return false;
		}
		if(phone.value.length<10 || phone.value.length>12){
			alert("휴대폰번호는 11자리까지만 입력 가능합니다.");
			pwd1.focus();
			return false;
		}
		return true;
	}
</script>
</body>
</html>