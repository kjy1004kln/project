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

var paramValue = request.getParameter('riid'); 
	
$(document).ready(function(){
  	$.ajax ({
		url : "/project/admin/lhj/roomDetail?riid=" + paramValue,
    	type : "GET",
    	success : function(data) {
    		let riid = data.vo.riid;
			let riroomtype = data.vo.riroomtype;
			let riroom = data.vo.riroom;
			let riservice = data.vo.riservice;
			let risize = data.vo.risize;
			let riminper =  data.vo.riminper;
			let rimaxper =  data.vo.rimaxper;
			let ripeak =  data.vo.ripeak;
			let risemipeak =  data.vo.risemipeak;
			let rioff =  data.vo.rioff;
			let rimainimg =  data.vo.rimainimg;
			let riextraimg1 =  data.vo.riextraimg1;
			let riextraimg2 =  data.vo.riextraimg2;
			let html = `
				<div class="contents">
					<div class="contents_container">
						<h2 class="title">객실 수정</h2>
						<form method="post" id="multiform" enctype="multipart/form-data" class="join_form">
							<input type='hidden' name='aid' value='${data.vo.aid}'>
						<input type='hidden' name='riid' value='${riid}'>
							<h3>
								객실정보입력
							</h3>
							<div class="join1">
								<div class="join_col1">
									<label for="">객실종류</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="wrap_inner">
											<div class="ui_input">
												<input type="text" name="riroomtype" value="${riroomtype}" class="input_space">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">총객실수</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="wrap_inner">
											<div class="ui_input">
												<input type="text" name="riroom" value="${riroom}" class="input_space">
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">부가서비스</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="riservice" value="${riservice}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">객실크기</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="risize" value="${risize}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">기준인원</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="riminper" value="${riminper}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">최대인원</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="rimaxper" value="${rimaxper}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">성수기요금</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="ripeak" value="${ripeak}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">준성수기요금</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="risemipeak" value="${risemipeak}" class="input_space">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">비수기요금</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="text" name="rioff" value="${rioff}" class="input_space" >
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
											<input type="file" name="file" value="${rimainimg}" class="input_space" style="height: 40px" >
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">추가사진1</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="file" name="file" value="${riextraimg1}" class="input_space" style="height: 40px">
										</div>
									</div>
								</div>
							</div>
							<div class="join1">
								<div class="join_col1">
									<label for="">추가사진2</label>
								</div>
								<div class="join_col_input">
									<div class="input_wrap">
										<div class="ui_input">
											<input type="file" name="file" value="${riextraimg2}" class="input_space"  style="height: 40px">
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
		$("#roomUpdate").append(html);
    	}
	});
});

function updatesubmit(){
	event.preventDefault();  
	var form =  $("#roomUpdate form");
 	var formData = new FormData(form[0]);  
 	console.log(form)
    $.ajax({
        type: "post",
        enctype: 'multipart/form-data', 
        url: "/project/admin/lhj/roomUpdate",
        data: formData,
	    dataType:'json',
	    processData: false,
        contentType: false,
		cache:false,
        success: function (data) {
            alert(data.msg);
            console.log(formData.get('aid'));
            window.location.href='roomlist.html?aid=' + formData.get('aid')
        	
        }
    });
}