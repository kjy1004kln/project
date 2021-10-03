<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
	$(function(){
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/hjy/chatAddList",
			dataType:"json",
			success:function(data){
				let html;
				$(data.list).each(function(i,data){
					html+="<li>"+data.caaddid+"<input type='button' value='수락' onclick = '"
					+"reqfriend(\""+data.caaddid+"\",\"acc\")' id='"+data.caaddid+"'>"
					+"<input type='button' value='거부' onclick = '"
					+"reqfriend(\""+data.caaddid+"\",\"del\")' id='"+data.caaddid+"'></li>";				
				})
				$("#reqlist").append(html);
			}
		})
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/hjy/chatBuddyList",
			dataType:"json",
			data:{"myId":"${chatid}"},
			success:function(data){
				let html="";
				$(data.list).each(function(i,d){
					html+="<li>"+d.cbbuid+"</li>";				
				})
				$("#buddylist").append(html);
			}
		})
	})
	function reqfriend(id,select){
			$.ajax({
				url:"${pageContext.request.contextPath }/hjy/accdelreq",
				type:'get',
				data:{"reqId":id,"myId":"${mid}","select":select},
				dataType:"json",
				success:function(data){
					if(data.sel=='acc'){
						if(data.result=='success'){
							alert('이동이 완료되었습니다.')
							location.reload(true)
						}else{
							alert(data.result)
						};
					}else{
						if(data.result=='success'){
							alert('거절이 완료되었습니다.')
							location.reload(true)
						}else{
							alert(data.result)
						};
					}						
				}
			})
	}
</script>
<body>
<h1>${chatid }님의 친구요청목록</h1>
<div>
	<ul id="reqlist">
		
	</ul>
</div>
<h1>친구목록</h1>
<div>
	<ul id="buddylist">
		
	</ul>
</div>
</body>
</html>