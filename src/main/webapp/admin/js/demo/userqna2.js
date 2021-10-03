// Call the dataTables jQuery plugin
function format ( d ) {
	console.log(d.qref)
	if(d.qlev=='Y'){
	var list
		//return `<div id=repliedcomment> `
			$.ajax({
		  		url:"/project/admin/cjy/userqnacommentList",
		  		data:{qref:d.qref},
		  		dataType:"json",
		  		async: false,
		  		success: function (data) {
		  		list=`<div id=repliedcomment>`
			  		+ data.vo.qcontent +
				  	`<div>
						<input type="button" class="dt-button buttons-copy buttons-html5 btn btn-outline-primary" id="updatebtn" value="수정" onclick="updateform($('#qid').val());"> 
						<input type="button" class="dt-button buttons-copy buttons-html5 btn btn-outline-primary" id="deletebtn" value="삭제" onclick="deleteform($('#qid').val());"> 
					</div>
				</div>							
					`
				 }
	  		});
	  		return list;
	}else{
		return	`
			<div id=repliedcomment>
				<div class="input-div">
					<textarea id="reply" name="reply" rows="5" cols="100"></textarea>
				</div>
				<div>
					<input type="button" class="dt-button buttons-copy buttons-html5 btn btn-outline-primary" value="답변하기" onclick="replyqna($('#qid').val(),$('#reply').val());">
				</div>
			</div>
			`;
	}
}

function replyqna(qid,qcontent){
console.log("qid"+qid);
console.log("qcontent"+qcontent);
    $.ajax({
        type: "GET",
        //enctype: 'multipart/form-data', 
        url: "/project/admin/cjy/userqnareply",
        data: {qid:qid,qcontent:qcontent},
	    dataType:'json',
        success: function (data) {
            alert(data.code);
        	window.location.href='userqna2.html'
        }
    });
}  	
function updateform(qid){
console.log("qid0"+qid)
	$('#repliedcomment').empty(); //empty는 선택한 요소의 자식요소를 삭제, 반면 remove는 선택한 요소를 삭제
	let html="";
	html+= `
	 		<div class="input-div">
				<textarea id="reply" name="reply" rows="5" cols="100"></textarea>
			</div>
			<div>
				<input type="button" class="dt-button buttons-copy buttons-html5 btn btn-outline-primary" value="수정하기" onclick="updateqna(`+qid+`,$('#reply').val());"> 
			</div>
		`;
	$('#repliedcomment').append(html)
}

function updateqna(qid,qcontent){
console.log("qid1"+qid)
console.log("qcontent1"+qcontent)
    $.ajax({
        type: "GET",
        //enctype: 'multipart/form-data', 
        url: "/project/admin/cjy/userqnaupdate",
        data: {qid:qid,qcontent:qcontent},
	    dataType:'json',
        success: function (data) {
            alert(data.code);
        	window.location.href='userqna2.html'
        }
    });
}  	
function deleteform(qid){
console.log("qid2"+qid)
    $.ajax({
        type: "GET",
        //enctype: 'multipart/form-data', 
        url: "/project/admin/cjy/userqnadelete2",
        data: {qid:qid},
	    dataType:'json',
        success: function (data) {
            alert(data.code);
        	window.location.href='userqna2.html'
        }
    });
}  	
$(document).ready(function(){

  var table=$('#dataTable').DataTable({
   		"processing": true,
        "serverSide": true,
  		ajax:{
  		"url":"/project/admin/cjy/userqnalist",
  		"dataType":"json",
  		"dataSrc":"list",
  		"draw": 1,
		"recordsTotal": 57,
		"recordsFiltered": 57,
  		 	},
         columns:[
         	{
                "class":          "details-control",
                "orderable":      false,
                "data":           null,
                "defaultContent": ""
            },
         	{data: "qid"},
         	{data: "qcate"},
         	{data: "qpw"},
         	{data: "qtitle"},
         	{data: "qcontent"},
         	{data: "qfile", render: getImg},
         	{data: "qrdate"},
         	{data: "qlev"},
         	{data: "qref"},
         	{data: "qstep"},
         	{data: "mid"},
         	{data:"qid",
				"render":function(data,type,row){
					if(type==='display'){
						data="<a href='javascript:deleteconfirm("+data+");'>삭제</a>"
					}
					return data;
				}
			}
         	],
         	order:[[8, 'asc'],[9,'desc'],[10,'asc'],[7,'desc']],
         	ordering: true,
         	serverSide:false,
  		 	destroy: true,
         	dom: 'Bfrtip',
         	buttons: [
            {
				extend: 'copy'
				,text: 'copy'
				,filename: 'UserQnA'
				,title: 'UserQnA'
				,className: 'btn btn-outline-primary'
			},
	     	{
				extend: 'excel'
				,text: 'excel'
				,filename: 'UserQnA'
				,title: 'UserQnA'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'pdf'
				,text: 'pdf'
				,filename: 'UserQnA'
				,title: 'UserQnA'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'print'
				,text: 'print'
				,filename: 'UserQnA'
				,title: 'UserQnA'
				,className: 'btn btn-outline-primary'
			}
			],
         });
  	 var detailRows = [];
  	  $('#dataTable tbody').on( 'click', 'tr td.details-control', function () {
  	   this_row = table.rows(this).data();
  	  	$("#qid").val(this_row[0].qid);
        var tr = $(this).closest('tr');
        var row = table.row( tr );
        var idx = $.inArray( tr.attr('id'), detailRows );
 		
        if ( row.child.isShown() ) {
            tr.removeClass( 'details' );
            row.child.hide();
 
            // Remove from the 'open' array
            detailRows.splice( idx, 1 );
        }
        else {
            tr.addClass( 'details' );
            row.child( format( row.data() ) ).show();
 
            // Add to the 'open' array
            if ( idx === -1 ) {
                detailRows.push( tr.attr('id') );
            }
        }
    } );
 
    // On each draw, loop over the `detailRows` array and show any child rows
    table.on( 'draw', function () {
        $.each( detailRows, function ( i, id ) {
            $('#'+id+' td.details-control').trigger( 'click' );
        } );
    } );

     function getImg(list, type, full, meta) {
	     if(list!=null){
	            return "<img src='/project/resources/images/userqna/"+list+"' width='150' height='150'>";
	     }else{
	     	return "";
	     }
	 }
 });  
 
 function deleteconfirm(qid){
 	var delConfirm=confirm('정말로 삭제하시겠습니까?')
 	console.log(qid);
	if(delConfirm){
		$.ajax({
    		type : "GET",
    		url : "/project/admin/cjy/userqnadelete?qid="+qid,
	    	success:function(data){
	    		if(data.code=='success'){
	    			alert('삭제되었습니다')
		    		location.reload(true);
	    		}else{
	    			alert('삭제 실패')
	    		}
			}
			})	
	}else{
		alert('삭제를 취소합니다')
	}
 }
