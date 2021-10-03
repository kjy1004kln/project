<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_회원 정보 수정</title>
<!-- 커밋 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findid.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath }/jhr/mypageUpdate" class="update_form" id="update_form" onsubmit="return check()" enctype="multipart/form-data">
	<h3>회원정보 수정</h3><br>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">프로필 사진 <span class="point_color">*</span></label>
		</div>
		<img id="profileimg" onerror="this.style.display='none'" style="max-width:400px; max-height:300px; box-sizing:border-box; margin-bottom:10px;">
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="file" id="profile" name="profile" class="input_space" value="${vo.mprofile}">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">이름</label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="text" id="mname" name="mname" class="input_space" value="${vo.mname}" readonly="readonly">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">아이디</label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="text" id="mid" name="mid" class="input_space" value="${vo.mid}" readonly="readonly">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">생년월일</label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="text" id="mbirth" name="mbirth" class="input_space" value="${vo.mbirth}" readonly="readonly">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">휴대폰 <span class="point_color">*</span></label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="text" id="mphone" name="mphone" class="input_space" value="${vo.mphone}">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">이메일 <span class="point_color">*</span></label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input">
						<input type="text" id="memail" name="memail" class="input_space" value="${vo.memail}">
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="join1" style="margin-bottom:10px !important;">
		<div class="join_col1">
			<label for="">비밀번호 변경 <span class="point_color">*</span></label>
		</div>
		<div class="join_col_input">
			<div class="input_wrap">
				<div class="wrap_inner">
					<div class="ui_input2">
						<a href="${pageContext.request.contextPath }/jhr/mypageResetpw"><input type="button" value="비밀번호 변경" class="btn_pwd"></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<input type="submit" value="수정" class="submit_btn" id="submit_btn" style="margin-top:40px;">
</form>
</body>
<script type="text/javascript">
	let mid='${sessionScope.mid}';
	$.ajax({
		url:"/project/mypageupdate/"+mid,
		type:"get",
		dataType:"json",
		success:function(data){
			$("#profileimg").prop("src","${pageContext.request.contextPath }/resources/images/members/"+data.mprofile);
			$("#mname").val(data.mname);
			$("#mid").val(data.mid);
			$("#mbirth").val(data.mbirth);
			$("#mphone").val(data.mphone);
			$("#memail").val(data.memail);
		}
	});
	
	function check(){
		var email=document.getElementsByName("memail")[0];
		var ereg=/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		var birth=document.getElementsByName("mbirth")[0];
		var phone=document.getElementsByName("mphone")[0];
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
			alert("휴대폰번호는 11자리까지만 입력 가능합니다.");
			pwd1.focus();
			return false;
		}
		return true;
	}

	$(function(){
		$("#submit_btn").click(function(e) {
			e.preventDefault();
			var pop_up=confirm("수정하시겠습니까?");
			var form = $('#update_form')[0];
			var formData=new FormData(form);
			if(pop_up==true) {
				$.ajax({
					url:"/project/update",
					data:formData,
					processData: false,
	        	    contentType: false,
					type:"post",
					dataType:"json",
					success:function(data) {
						if(data.code=='success') {
							alert("회원정보 수정에 성공했습니다.");
							location.reload();
						} else {
							alert("회원정보 수정에 실패했습니다.");
						}
					}
				});
			} else if(pop_up==false) {
				location.href="${pageContext.request.contextPath }/jhr/mypageUpdate";
			}
		});
	});
</script>
</html>