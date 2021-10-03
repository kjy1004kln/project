<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/jquery-ui.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500;600;700&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style>
*{
	font-family: 'Stylish', sans-serif;
}
#addheader{
	position: relative;
	height:50px;
	border-bottom:1px solid gray;
}
.addheader_title{
	position:absolute;
	top:25px;
	left:50px;
	font-size:15px;
	font-weight: bold;
}

#addcontent{
	position:relative;
	height:555px;
	overflow:scroll;
	overflow-x:hidden;
	margin-top:20px;
	margin-bottom:20px;
}

#addfooter{
	position:relative;
	height:50px;
	border-top:1px solid gray;
}

.addbuddy{
	position:relative;
	left:40px;
	width:280px;
	height:60px;
	display:flex;
	flex-direction:row;
	padding:10px;
	border-bottom:1px solid gray;
}
.addimg{
	width:40px;
	height:40px;
	margin-right:10px;
	border-radius: 10px;
}
.addcmname{
	position:absolute;
	top:20px;
	left:80px;
	font-size:12px; 
	font-weight:bold;
}

.btn btn-primary{
	background:#408BCC;
	border: 1px solid #408BCC;
}
/* 체크박스 체크안할시 확인버튼 이벤트 막기 */
#addokbtn{
	pointer-events: none;
	background:#D2D2D2;
	border: 1px solid #D2D2D2;
	
	position:absolute;
	left:90px;
	top:10px;
	width:100px;
	
}
#addcanclebtn{
	position:absolute;
	right:90px;
	top:10px;
	width:100px;
}


/* 스위치 버튼 */
.switch-button { 
position: absolute; 
right:10px;
top:20px;
display: inline-block; 
width: 44px; 
height: 
23px; 
} 
.switch-button input { 
opacity: 0; 
width: 0; 
height: 0; 
} 
.onoff-switch { 
position: absolute; 
cursor: pointer; 
top: 0; 
left: 
0; 
right: 0; 
bottom: 0; 
border-radius:20px; 
background-color: #ccc; 
box-shadow: inset 1px 5px 1px #999; 
-webkit-transition: .4s; 
transition: .4s; 
} 
.onoff-switch:before { 
position: absolute; 
content: ""; 
height: 15px; 
width: 15px; 
left: 4px; 
bottom: 4px; 
background-color: #fff; 
-webkit-transition: .5s; 
transition: .4s; 
border-radius:20px; } 
.switch-button input:checked + .onoff-switch { 
background-color: #12EAFF; 
box-shadow: inset 1px 5px 1px #00B4DB; 
} 
.switch-button input:checked + .onoff-switch:before { 
-webkit-transform: translateX(17px); 
-ms-transform: translateX(17px); 
transform: translateX(17px); 
}
</style>
<input type="hidden" id="cmid" value="${cmid }">
<input type="hidden" id="cmprofile" value="${cmprofile }">
<input type="hidden" id="cmname" value="${cmname }">
<input type="hidden" id="crid" value="${crid }">
<div id="addheader">
	<p class="addheader_title">대화상대 초대</p>
</div>
<div id="addcontent">
<c:forEach var="vo" items="${list }">
		<div class="addbuddy">
			<c:choose>
				<c:when test="${vo.cmprofile eq null }">
					<img src="${pageContext.request.contextPath }/resources/images/members/noimage2.jpg" class="addimg">
				</c:when>
				<c:otherwise>
					<img src="${pageContext.request.contextPath }/resources/images/members/${vo.cmprofile}" class="addimg">
 				</c:otherwise>
			 </c:choose>
	   		<p class="addcmname">${vo.cmname }</p>
	   		<label class="switch-button"> 
				<input type="checkbox" value="${vo.cmid }"/> 
				<span class="onoff-switch"></span> 
			</label>
   		</div>	   	
</c:forEach>
</div>
<div id="addfooter">
	<input type="button" class="btn btn-primary" id="addokbtn" value="확인">
	<input type="button" class="btn btn-primary" id="addcanclebtn" value="취소">
</div>
<script type="text/javascript">
	var cmid=$("#cmid").val();
	var cmname=$("#cmname").val();
	var cmprofile=$("#cmprofile").val();
	var crid=$("#crid").val();
 	
 	//체크된 상태일경우 확인버튼 활성화
 	$("input[type=checkbox]").change(function(){
 		var checked='input[type=checkbox]:checked';
 		var checkedtrue=document.querySelectorAll(checked);
 		var checkcnt=checkedtrue.length;
 		if(checkcnt > 0){
 			$("#addokbtn").css({
 				pointerEvents: "auto",
 				background: "#408BCC",
 				border: "1px solid #408BCC"	
 			});
 			$(document).on("mouseenter","#addokbtn",function(){
 				$(this).css({
 					background: "#3071A9"
 				});
 			});
 			$(document).on("mouseleave","#addokbtn",function(){
 				$(this).css({
 					background: "#408BCC"
 				});
 			});
 		}else{
 			$("#addokbtn").css({
 				pointerEvents: "none",
 				background: "#D2D2D2",
 				border: "1px solid #D2D2D2"
 			});
 		}
 	});
 	
 	//확인 버튼 이벤트
 	$("#addokbtn").on('click',function(){
 		
 		//체크된 친구 아이디 배열로 저장
 		var addcbbuid=[];
 		$("input[type=checkbox]:checked").each(function(i){
 			addcbbuid.push($(this).val());
 		});
 		//시스템메세지 리스트 넘겨줄거 선언
 		$.ajax({
			type:'post',
			url:'${pageContext.request.contextPath }/user/kjy/chat_addlist',
			data:{'addcbbuid':addcbbuid,"crid":crid},
			dataType:'json',
			success:function(data){
				console.log(data.code);
				if(data.code=='success'){
					//alert("초대가 완료되었습니다.");
					var url='${pageContext.request.contextPath }/user/kjy/chating_room?crid='+crid+'&cmid='+cmid+'&cmprofile='+cmprofile+'&cmname='+cmname;
					location.href=url;
				}else{
					alert("오류발생!");
				}
			}
 		});
 	});
 	
 	//취소시 뒤로가기
 	$("#addcanclebtn").on('click',function(){
 		var url='${pageContext.request.contextPath }/user/kjy/chating_room?crid='+crid+'&cmid='+cmid+'&cmprofile='+cmprofile+'&cmname='+cmname;
 		location.href=url;
 	});
 	
 	
 </script>