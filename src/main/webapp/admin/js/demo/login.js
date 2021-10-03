// Set new default font family and font color to mimic Bootstrap's default styling
$(document).ready(function() {
//로그아웃태그클릭시 실행
	$("#logoutAtag").click(function(){
		$.ajax({
				url:path+"hjy/admin/logout",
				type:"get",
				dataType:"json",
				success:function(data){
					location.href=path+"admin/login.html";
				}
		});
	})
   
});
$(document).ready(function() {
	//아이디 불러오기
	$.ajax({
			url:path+"hjy/admin/getid",
			data:{aid:$("#exampleInputEmail").val(),apw:$("#exampleInputPassword").val()},
			type:"get",
			dataType:"json",
			success:function(data){
				$("#adminid").html(data.adminid);
			}
	});
})

