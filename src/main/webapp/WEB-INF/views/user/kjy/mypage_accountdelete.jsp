<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage_accountdelete.css">

<p class="title">회원탈퇴</p><br>
<div class="deletecontent">
	<p class="pwinput">비밀번호를 입력해주세요</p>
	<input type="password" class="pwtext">
	<input type="button" value="확인" class="btn btn-primary" id="okbtn">
</div>
<!-- 모달창 -->
<div id="myModal3" class="modal3">
   <!-- 모달 내용 -->
   <div class="modal-content3">
      <div style='text-align: center; font-size: 10px; color: gray;'>이메일로 보안문자가 전송되었습니다.<br></div>                                                          
      <span class="close3">&times;</span><br>  
      <p class="pwcheck3">보안문자 입력</p>
      <input class="textcheck3" type="text">
      <input type="button" class="btn btn-primary" id="pwcheck3" value="확인">
   </div>
</div>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
	var emailcheck="";
	$("#okbtn").click(function(){
		var mpw=$(".pwtext").val();
		$.ajax({
			dataType: 'json',
			url:'${pageContext.request.contextPath }/user/kjy/pwdcheck',
			data:{'mpw':mpw},
			success:function(data){
				if(data.code=='success'){
					$("#myModal3").css('display','block');
					$('html').css('overflow','hidden');
					$.ajax({
						dataType: 'json',
						url:'${pageContext.request.contextPath }/user/kjy/emailcheck',
						success:function(data){
							emailcheck=data.key;
							console.log(emailcheck);
							$("#pwcheck3").click(function(){
								var text=$(".textcheck3").val();
								if(emailcheck!=text){
									alert("보안코드를 다시 확인해주세요");
								}else{
									if(confirm("정말 탈퇴하시겠습니까?") == true){
										$.ajax({
											dataType: 'json',
											url:'${pageContext.request.contextPath }/user/kjy/memberdel',
											success:function(data){
												console.log(data);
												if(data=='1'){
													alert("탈퇴가 완료되었습니다");
													location.href="${pageContext.request.contextPath }/";
												}
											}
										});
									}else{
										return;
									}
								}
							});
						}
					});
				}else{
					alert("비밀번호를 확인해주세요");
				}
			}
		});
		
	});
	$(".close3").click(function(){
		$("#myModal3").css('display','none');
		//페이지 스크롤이동 다시 허용
		$('html').css('overflow','visible');
	});
	
</script>