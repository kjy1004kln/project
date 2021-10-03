<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/jquery-ui.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500;600;700&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<style>
/*header*/
#header {
	position: relative;
	height: 50px;
	background:#C2DBEA;
	border-bottom:1px solid gray; 
}
.myprofile {
	position:absolute;
	top:5px;
	left:5px;
	width:40px;
	height:40px;
	border-radius: 10px;
}
.myname{
	position:absolute;
	left:60px;
	top:15px;
	font-size:15px;
	font-weight:bold;
}
.smallmenu{
	position: absolute;
	top:5px;
	right:20px;
	width:40px;
	height:40px;
	border-radius: 20px;
}
.smmenu{
	position:absolute;
	font-size:12px;
	font-weight: bold;
	margin-top:10px;
	text-decoration:none;
}
.moremenu{
	display:none;
	position:absolute;
	background-color:white;
	width:75px;
	height:80px;
	border:0.5px solid black;
	z-index:10;
	top:45px;
	right:5px;
}

#content{
	background: #D6F0FF;
	height:590px;
	overflow-y:scroll;
	overflow-x:hidden;
}
/* 시스템메세지 css */
.sysdiv{
	position:relative;
	width:380px;
	text-align:center;
	margin:10px 0;
}
.sysdiv:first-child {
	margin-top:20px;
	margin-bottom:0;
}
.sysdiv:last-child {
	margin-bottom:20px;
}
.sysbox{
	width:200px;
	margin:0 auto;
	word-break:break-all;
}
.msgsysmsg{
	background:white;
	font-size: 12px;
	font-weight:bold;
	border-radius:5px;
}

/* 채팅메세지 css */
/* 본인창 css */
.memsgdiv{
	position:relative;
	width: 380px;
	display:flex;
	justify-content:flex-end;
	margin-bottom:20px;
}
.memsgbox{
	max-width: 200px;
	word-break:break-all;
	position:relative;
	margin-right:10px;
}
.memsg{
	position:relative;
	background:white;
	font-size:15px;
	border-radius:5px;
	padding:5px 8px;
	margin-bottom:-10px;
}
 .metime{
 	position:relative;
 	font-size:10px;
 	text-align:right;
 }

/*상대방창 css */
.youmsgdiv{
	width: 380px;
	position:relative;
}
.youprofile{
	width:50px;
	height:50px;
	border-radius:15px;
	margin-left:10px;
}
.youname{
	position:absolute;
	top:5px;
	left:70px;
	font-size:12px;
	font-weight:bold;
}
.youmsgbox{
	position:relative;
	max-width:200px;
	top:-20px;
	left:70px;
	word-break:break-all;
}
.youmsg{
	display:inline-block;
	background:white;
	font-size:15px;
	border-radius:5px;
	padding:5px 8px;
}
.youtime{
	position:relative;
	font-size:10px;
}

/*footer*/
#footer{
	position:relative;
	height:50px;
	background:white; 
	border-top:1px solid gray; 
}
#sendBtn{
	position: absolute;
	top:5px;
	right:5px;
	width:100px;
	height:50px;
}
#chatting{
	position:absolute;
	top:5px;
	left:5px;
	width:285px;
	height:50px;
	overflow:auto;
    resize: none;
}
</style>
<div id="chat_room_main">
<div id="header">
	<c:choose>
		<c:when test="${cmprofile eq '' }">
			<img src="${pageContext.request.contextPath }/resources/images/members/noimage2.jpg" class="myprofile">
		</c:when>
		<c:otherwise>
			<img src="${pageContext.request.contextPath }/resources/images/members/${cmprofile }" class="myprofile">
 		</c:otherwise>
	 </c:choose>
	<p class="myname">${cmname }</p>
	<img src="${pageContext.request.contextPath }/resources/images/chat/menu2.png" class="smallmenu">
	<span class="moremenu">
		<span id="menu1" class="smmenu">창닫기</span><br>
		<span id="menu2" class="smmenu">대화상대초대</span><br>
		<span id="menu3" class="smmenu">채팅방나가기</span><br>
	</span>
	<!-- //////////파라미터 값들//////////// -->
	<input type="hidden" id="cmid" value=${cmid }>
	<input type="hidden" id="crid" value=${crid }>
	<input type="hidden" id="cmprofile" value=${cmprofile }>
	<input type="hidden" id="cmname" value=${cmname }>
	<!-- //////////////////////////////// -->
</div>
<div id="content">
	<div id="contentarea" class="contentarea">
		<div id="messagearea" class="messagearea"></div>
	</div>
</div>
<div id="footer">
	<div id="Msg">
		<textarea rows="" cols="" id="chatting"></textarea>
		<button class="btn btn-primary" onclick="send()" id="sendBtn">보내기</button>
	</div>
</div>
</div>
<script type="text/javascript">
var crid=$("#crid").val();
var cmid=$("#cmid").val();
var cmprofile=$("#cmprofile").val();
var cmname=$("#cmname").val();

//소켓 연결
var ws;
function wsOpen(){
	ws = new WebSocket("ws://" + location.host + "${pageContext.request.contextPath }/chating");
	//소켓 연결후 ajax로 채팅 리스트 불러오기
	$.ajax({
		type:'get',
		data:{'crid':crid},
		url:'${pageContext.request.contextPath }/user/kjy/messagelist',
		dataType:'json',
		success:function(data){
			$(data.list).each(function(i,d){
				let msgmessage=d.msgmessage;
				let msgshottime=d.msgshottime;
				let cmname=d.cmname;
				let cmprofile=d.cmprofile;
				let msgsysmsg=d.msgsysmsg;
				if(cmprofile==null){
					//대체 이미지
					cmprofile="noimage2.jpg";
				}
				if(d.cmid==$("#cmid").val() && msgmessage!=null && msgsysmsg==null){
					let html="<div class='memsgdiv'>"+
					"<div class='memsgbox'>"+
					"<p class='memsg'>"+msgmessage+"</p><br>"+
					"<p class='metime'>"+msgshottime+"</p>"+
					"</div>"+
					"</div>";
					$("#messagearea").append(html);
				}else if(msgmessage!=null && msgsysmsg==null){
					let html="<div class='youmsgdiv'>"+
					"<img src='${pageContext.request.contextPath }/resources/images/members/"+cmprofile+"' class='youprofile'>"+
					"<p class='youname'>"+cmname+"</p>"+
					"<div class='youmsgbox'>"+
					"<p class='youmsg'>"+msgmessage+"</p>"+
					"<p class='youtime'>"+msgshottime+"</p>"+
					"</div>"+
					"</div>";
					$("#messagearea").append(html);
				}else if(msgsysmsg!=null){
					let html="<div class='sysdiv'>"+
					"<div class='sysbox'>"+
					"<p class='msgsysmsg'>"+msgsysmsg+"</p>"+
					"</div>"+
					"</div>";
					$("#messagearea").append(html);
				}
			});
			//스크롤 하단 고정
			$('#content').scrollTop($('#content')[0].scrollHeight);
		}
	});
}

wsOpen();

ws.onopen = function(data){
	//채팅방 사람 초대후 시스템 메세지 보내기
	add_msgsys();
}
//웹소켓 종료시 종료시간 db에 저장
function onClose(){
	$.ajax({
		type:'get',
		data:{'crid':crid,'cmid':cmid},
		url:'${pageContext.request.contextPath }/user/kjy/chat_close',
		dataType:'json',
		success:function(data){
			console.log(data.code);
		}
	});
	ws.close()
}

ws.onmessage = function(data) {
	//메시지를 받으면 동작
	var msg = data.data;
	if(msg != null && msg.trim() != ''){
			var d = JSON.parse(msg);
			let today = new Date();   
			let msgshottime=today.toLocaleTimeString();
			let msgmessage=d.msgmessage;
			let cmname=d.cmname;
			let cmprofile=d.cmprofile;
			let msgsysmsg=d.msgsysmsg;
			if(cmprofile==""){
				//대체 이미지
				cmprofile="noimage2.jpg";
			}
			if(d.cmid==$("#cmid").val() && msgmessage!=null && msgsysmsg==null){
				let html="<div class='memsgdiv'>"+
				"<div class='memsgbox'>"+
				"<p class='memsg'>"+msgmessage+"</p><br>"+
				"<p class='metime'>"+msgshottime+"</p>"+
				"</div>"+
				"</div>";
				$("#contentarea").append(html);	
			}else if(msgmessage!=null && msgsysmsg==null){
				let html="<div class='youmsgdiv'>"+
				"<img src='${pageContext.request.contextPath }/resources/images/members/"+cmprofile+"' class='youprofile'>"+
				"<p class='youname'>"+cmname+"</p>"+
				"<div class='youmsgbox'>"+
				"<p class='youmsg'>"+msgmessage+"</p>"+
				"<p class='youtime'>"+msgshottime+"</p>"+
				"</div>"+
				"</div>";
				$("#contentarea").append(html);
			}else if(msgsysmsg!=null){
				let html="<div class='sysdiv'>"+
				"<div class='sysbox'>"+
				"<p class='msgsysmsg'>"+msgsysmsg+"</p>"+
				"</div>"+
				"</div>";
				$("#contentarea").append(html);
			}
		}
		//스크롤 하단 고정
		$('#content').scrollTop($('#content')[0].scrollHeight);
	}

function send(data) {
	var option ={
		type: "message",
		cmid : $("#cmid").val(),
		crid : $("#crid").val(),
		cmname : $("#cmname").val(),
		cmprofile : $("#cmprofile").val(),
		msgmessage : $("#chatting").val(),
		msgsysmsg : data
	}
	ws.send(JSON.stringify(option))
	$('#chatting').val("");
}

$(document).on("mouseenter",".smmenu",function(){
	$(this).css({
		cursor: "pointer",
		textDecoration: "underline"
	});
});
$(document).on("mouseleave",".smmenu",function(){
	$(this).css({
		cursor: "default",
		textDecoration: "none"		
	});
});

$(document).on("mouseenter",".smallmenu",function(){
	$(this).attr("src","${pageContext.request.contextPath }/resources/images/chat/menu1.png");
	$(this).css("cursor","pointer");
});
$(document).on("mouseleave",".smallmenu",function(){
	$(this).attr("src","${pageContext.request.contextPath }/resources/images/chat/menu2.png");
	$(this).css("cursor","default");
});

$(".smallmenu").on('click',function(){
	if( $(".moremenu").is(":visible")){
    	$(".moremenu").hide();
	}else{
		$(".moremenu").show();
	}
});
//전페이지로 이동
$("#menu1").on('click',function(){
	onClose();
	location.href="${pageContext.request.contextPath }/user/kjy/chat_main";
});
//방에 친구초대
$("#menu2").on('click',function(){
	var url='${pageContext.request.contextPath }/user/kjy/chat_add?cmid='+cmid+'&crid='+crid+'&cmname='+cmname+'&cmprofile='+cmprofile;
	$("#chat_room_main").load(url);
});
//방 나가기
$("#menu3").on('click',function(){
	$.ajax({
		type:'post',
		data:{'crid':crid,"cmid":cmid,"cmname":cmname},
		url:'${pageContext.request.contextPath }/user/kjy/chat_exit',
		dataType:'json',
		success:function(data){
			let code=data.code;
			let msgsysmsg=data.msgsysmsg;
			if(code=='success'){
				location.href="${pageContext.request.contextPath }/user/kjy/chat_main";
				//나갔다는 메세지 상대방에게 보내기
				send(msgsysmsg);
			}else{
				console.log("오류발생!");
			}
		}
	});
});

</script>