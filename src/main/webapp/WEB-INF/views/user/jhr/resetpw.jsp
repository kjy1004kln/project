<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>
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
			<h2 class="title">비밀번호 재설정</h2>
		</div>
		<form method="post" action="${pageContext.request.contextPath }/jhr/resetpw" class="find_id" onsubmit="return check()">
			<input type="hidden" name="mid" value="${mid }"><br>
			<h3></h3>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">새 비밀번호</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="password" name="mpw" class="input_space" maxlength="20" id="mpw" placeholder="8-15자리의 영문/숫자를 함께 입력해주세요.">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="findid1">
				<div class="findid_col1">
					<label for="">새 비밀번호 확인</label>
				</div>
				<div class="findid_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="password" name="newpw" class="input_space" maxlength="20"  placeholder="새 비밀번호를 재입력해주세요.">
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
		var mpw=document.getElementsByName("mpw")[0];
		var newpw=document.getElementsByName("newpw")[0];

		if(mpw.value.trim()==""){
			alert("새 비밀번호를 입력하세요.");
			mpw.focus();
			return false;
		}
		if(mpw.value.length<8 || newpw.value.length>15){
			alert("비밀번호는 8-15자리의 영문/숫자를 함께 입력해주세요.");
			mpw.focus();
			return false;
		}
		if(newpw.value.trim()==""){
			alert("새 비밀번호 확인을 입력하세요.");
			newpw.focus();
			return false;
		}
		if (mpw.value!=newpw.value) {
			alert("새로운 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			mpw.value="";
			newpw.value="";
			mpw.focus();
			return false;
		}
		alert("비밀번호가 재설정 되었습니다!");
		return true;
	}
</script>
</body>
</html>