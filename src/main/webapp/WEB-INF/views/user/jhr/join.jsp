<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/join.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#idoverlap").click(function(){
			let mid = $("#mid").val();
			$.ajax({
				url:"/project/checkId/"+mid,
				dataType:"json",
				success:function(data){
					if(data.using==true){
						$("#idcheck").html("사용중인 아이디입니다.");
					}else{
						$("#idcheck").html("사용가능한 아이디입니다.");
					}
				}
			});
		});
	});
</script>
</head>
<body>
<div class="header">
	<jsp:include page="header.jsp" flush="true"/>
</div>
<div class="contents">
	<div class="contents_container">
		<h2 class="title">회원가입</h2>
		<form method="post" action="${pageContext.request.contextPath }/jhr/join" enctype="multipart/form-data" class="join_form" onsubmit="return check()">
			<h3>
				회원정보입력
				<span class="point_color"><small>*은 필수입력 항목입니다.</small></span>
			</h3>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>이름</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mname" class="input_space" maxlength="12" placeholder="한글 또는 영문으로 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>아이디</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mid" class="input_space" maxlength="15" id="mid" placeholder="아이디를 입력해주세요.">
								<span id="result"></span><br>
							</div>
							<button type="button" class="ui_button" id="idoverlap">중복확인</button>
							<span id="idcheck" class="idoverlap" style="color: #ee1c25; font-size:13.125px; line-height:34px;"></span>
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>비밀번호</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="password" name="mpw" class="input_space" maxlength="20" id="mpw" placeholder="비밀번호를 입력해주세요."><br>
							</div><br>
							<span class="point_color"><small>8-15자리의 영문/숫자를 함께 입력해주세요.</small></span><br>
							<div class="ui_input">
								<input type="password" name="pwd2" class="input_space" maxlength="20" id="pwd2" placeholder="입력하신 비밀번호를 다시 한번 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>이메일</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="ui_input">
							<input type="email" name="memail" class="input_space" placeholder="이메일주소를 입력해주세요.">
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>생년월일</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="ui_input">
							<input type="date" name="mbirth" class="input_space" maxlength="20" placeholder="생년월일 8자리를 입력해주세요. (ex.19990625)">
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for=""><span class="point_color">*</span>휴대폰 번호</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="ui_input">
							<input type="text" name="mphone" class="input_space" maxlength="15" placeholder="휴대폰 번호를 입력해주세요. (숫자만 입력가능합니다.)">
						</div>
					</div>
				</div>
			</div>
			<div class="join1">
				<div class="join_col1">
					<label for="">프로필사진</label>
				</div>
				<div class="join_col_input">
					<div class="input_wrap">
						<div class="ui_input">
							<input type="file" name="profile" class="input_space" maxlength="15" placeholder="휴대폰 번호를 입력해주세요. (숫자만 입력가능합니다.)">
						</div>
					</div>
				</div>
			</div>
			<div class="submit_container">
				<input type="submit" value="가입" class="submit_btn">
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
		var pwd1=document.getElementsByName("mpw")[0];
		var pwd2=document.getElementsByName("pwd2")[0];
		var email=document.getElementsByName("memail")[0];
		var ereg=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var birth=document.getElementsByName("mbirth")[0];
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
		if(pwd1.value.trim()==""){
			alert("비밀번호를 입력하세요.");
			pwd.focus();
			return false;
		}
		if(pwd1.value.length<8 || pwd1.value.length>15){
			alert("비밀번호는 8-15자리의 영문/숫자를 함께 입력해주세요.");
			pwd1.focus();
			return false;
		}
		if(pwd2.value.trim()==""){
			alert("비밀번호 확인을 입력하세요.");
			pwd.focus();
			return false;
		}
		if (pwd1.value!=pwd2.value) {
			alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			pwd1.value="";
			pwd2.value="";
			pwd1.focus();
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
		if(birth.value.trim()==""){
			alert("생년월일을 입력하세요.");
			birth.focus();
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
			alert("휴대폰번호는 11자리를 입력해주세요.");
			pwd1.focus();
			return false;
		}
		alert("회원가입에 성공했습니다!");
		return true;
	}
</script>
</body>
</html>