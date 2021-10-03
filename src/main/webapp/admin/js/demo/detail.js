// Set new default font family and font color to mimic Bootstrap's default styling

<!-- html에서 파라미터 받아오는방법 -->
var Request = function() {  
    this.getParameter = function(name) {  
        var rtnval = '';  
        var nowAddress = unescape(location.href);  
        var parameters = (nowAddress.slice(nowAddress.indexOf('?') + 1,  
                nowAddress.length)).split('&');  
        for (var i = 0; i < parameters.length; i++) {  
            var varName = parameters[i].split('=')[0];  
            if (varName.toUpperCase() == name.toUpperCase()) {  
                rtnval = parameters[i].split('=')[1];  
                break;  
            }  
        }  
        return rtnval;  
    }  
}  
var request = new Request();  

var paramValue = request.getParameter('aid'); 
	
$(document).ready(function(){
  	$.ajax ({
		url : "/project/admin/lhj/detail?aid="+paramValue,
    	type : "GET",
    	success : function(data) {
    		let aid = data.vo.aid;
			let aname = data.vo.aname;
			let aaddress = data.vo.aaddress;
			let aphone = data.vo.aphone;
			let atotalroom = data.vo.atotalroom;
			let agrade =  data.vo.agrade;
			let amainimg =  data.vo.amainimg;
			let adetail =  data.vo.adetail;
			let aregdate =  data.vo.aregdate;
			let aisdel =  data.vo.aisdel;
			let html = `
				<div class="contents">
					<div class="contents_container">
						<h2 class="title">숙소 수정</h2>
						<form method="post" id="multiform" enctype="multipart/form-data" class="join_form">
							<input type='hidden' name='aid' value='${aid}'>
							<input type='hidden' name='acate' value='${ data.vo.acate}'>
			        		<input type='hidden' name='axcoordi' value='${ data.vo.axcoordi}'>
			       	 		<input type='hidden' name='aycoordi' value='${ data.vo.aycoordi}'>
			       	 		<input type='hidden' name='aisdel' value='${ data.vo.aisdel}'>
							<h3>
								슥소정보입력
								<span class="point_color"><small>*은 필수입력 항목입니다.</small></span>
							</h3>
							<div class="join1">
								<div class="join_col1">
									<label for=""><span class="point_color">*</span>숙소명</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="wrap_inner">
											<div class="ui_input">
												<input type="text" name="aname" value="${aname}" class="input_space">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">위치</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="wrap_inner">
											<div class="ui_input">
												<input type="text" name="aaddress" value="${aaddress}" class="input_space">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">전화번호</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="aphone" value="${aphone}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">방갯수</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="atotalroom" value="${atotalroom}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">성급</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="agrade" value="${agrade}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">추가설명</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="adetail" value="${adetail}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">메인사진</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="file" name="file" value="${amainimg}" class="input_space" style="height: 40px">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">등록일</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="aregdate" value="${aregdate}" class="input_space">
										</div>
									</div>
								</div>
							</div>	
						</form>
					</div>
				</div>
				<div class="submit_container">
					<input type="button" value="수정" onclick="updatesubmit(); return false;">
				</div>
				`	
			$("#accommUpdate").append(html);
    	}
	});
});
function updatesubmit(){
	event.preventDefault();  
	var form =  $("#accommUpdate form");
 	var formData = new FormData(form[0]);  
 	console.log(form)
    $.ajax({
        type: "post",
        enctype: 'multipart/form-data', 
        url: "/project/admin/lhj/accommUpdate",
        data: formData,
	    dataType:'json',
	    processData: false,
        contentType: false,
		cache:false,
        success: function (data) {
            alert(data.msg);
        	window.location.href='accommlist.html'
        }
    });
}
