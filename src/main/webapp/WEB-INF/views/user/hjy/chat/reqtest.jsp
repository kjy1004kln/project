<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
</head>
<script type="text/javascript">
$(function(){
	$("#id").click(function() {
		if($(this).html()=="${chatid }"){
			alert('본인임')
		}else{
			$("#id div").remove();
			let id = $(this).html()
			let html=
				`
				<div style='width:100px; height:200px; background:red;'>
					<ul>
						<li><a href='javascript:friendreq("\${id}");'>친구요청</a></li>
					</ul>
				</div>
				`;
			$("#id").append(html)
		}
	})
	$("#id2").click(function() {
		if($(this).html()=="${chatid }"){
			alert('본인임')
		}else{
			$("#id2 div").remove();
			let id = $(this).html()
			let html=
				`
				<div style='width:100px; height:200px; background:pink;'>
					<ul>
						<li><a href='javascript:friendreq("\${id}");'>친구요청</a></li>
					</ul>
				</div>
				`;
			$("#id2").append(html)
		}
	})
})
function friendreq(id){
	let checkdel = confirm(id+"님에게 친구요청을 보내시겠습니까?");
	if(checkdel == true){
		$.ajax({
    		type : "GET",
    		url :"${pageContext.request.contextPath }/hjy/friendreq",
    		data : {"reqId":id,"myId":"${chatid }"},
    		dataType:"json",
	    	success:function(data){
	    		alert(data.result)
			}
		})
	}
}
</script>
<body>
<h1>본인: ${chatid }</h1>
<h1>친구요청하기</h1>
<div id="id">user1</div>
<div id="id2">user2</div>
</body>
</html>