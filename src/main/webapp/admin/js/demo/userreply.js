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

var paramValue = request.getParameter('qid'); 
	
$(document).ready(function(){
  	$.ajax ({
		url : "/project/admin/cjy/userqnaselect?qid="+paramValue,
    	type : "GET",
    	success : function(data) {
    		let qid = data.list.qid;
			let qcate = data.list.qcate;
			let qpw = data.list.qpw;
			let qtitle = data.list.qtitle;
			let qcontent = data.list.qcontent;
			let qfile =  data.list.qfile;
			let rdate =  data.list.rdate;
			let qlev =  data.list.qlev;
			let qref =  data.list.qref;
			let qstep =  data.list.qstep;
			let mid =  data.list.mid;
			let html = `
				<form method="post" id="multiform" enctype="multipart/form-data">
				//<input type='hidden' name='aid' value='${aid}'>


				 <table>
				 	<thead>
				        <tr>
                         <th>문의글번호</th>
                         <th>카테고리</th>
                         <th>비밀번호</th>
                         <th>제목</th>
                         <th>내용</th>
                         <th>첨부파일</th>
                         <th>등록일</th>
                         <th>처리여부</th>
                         <th>그룹번호</th>
                         <th>글번호</th>
                         <th>아이디</th>
				        </tr>
				      </thead>
				      <tbody>
				        <tr>
				          <td>"${qid}"</td>
				          <td>"${qcate}"</td>
				          <td>"${qpw}"</td>
				          <td>"${qtitle}"</td>
				          <td>"${qcontent}"</td>
				          <td>"${qfile}"</td>
				          <td>"${qrdate}"</td>
				          <td>"${qlev}"</td>
				          <td>"${qref}"</td>
				          <td>"${qstep}"</td>
				          <td>"${mid}"</td>
				        </tr>
					</tbody>
				    </table>
				<label>답변</label>
					<textarea id="reply" name="reply"
					          rows="5" cols="33">
					
					</textarea>
            	</form>
            	<div>
				     <input type="button" value="답변하기" onclick="updatesubmit(); return false;">
				</div>
            	`
		$("#replyUpdate").append(html);
    	}
	});
});
function updatesubmit(){
	event.preventDefault();  
	var form =  $("#replyUpdate form");
 	var formData = new FormData(form[0]);  
 	console.log(form)
    $.ajax({
        type: "post",
        enctype: 'multipart/form-data', 
        url: "/project/admin/cjy/userqnareply",
        data: formData,
	    dataType:'json',
	    processData: false,
        contentType: false,
		cache:false,
        success: function (data) {
            alert(data.msg);
        	window.location.href='userqna2.html'
        }
    });
}
