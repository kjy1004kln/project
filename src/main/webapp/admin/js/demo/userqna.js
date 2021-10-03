// Call the dataTables jQuery plugin

$(document).ready(function(){
var url_ws_mock_get = './mock_svc_load.json';
    var url_ws_mock_ok = './mock_svc_ok.json';
    if (location.href.startsWith("file://")) {
        // local URL's are not allowed
        url_ws_mock_get = 'https://luca-vercelli.github.io/DataTable-AltEditor/example/03_ajax_objects/mock_svc_load.json';
        url_ws_mock_ok = 'https://luca-vercelli.github.io/DataTable-AltEditor/example/03_ajax_objects/mock_svc_ok.json';
    }
 
  var columnDefs = [
			{"data": "qid"},
         	{"data": "qcate"},
         	{"data": "qpw"},
         	{"data": "qtitle"},
         	{"data": "qcontent"},
         	{"data": "qfile", render: getImg},
         	{"data": "qrdate"},
         	{"data": "qlev"},
         	{"data": "qref"},
         	{"data": "qstep"},
         	{"data": "mid"}
    ];
 
  var table=$('#dataTable').DataTable({
  		"sPaginationType": "full_numbers",
  		ajax:{
  		"url":"/project/admin/cjy/userqnalist",
  		"dataType":"json",
  		"dataSrc":"list"
  		 },
         columns:[
         	{"data": "qid"},
         	{"data": "qcate"},
         	{"data": "qpw"},
         	{"data": "qtitle"},
         	{"data": "qcontent"},
         	{"data": "qfile", render: getImg},
         	{"data": "qrdate"},
         	{"data": "qlev"},
         	{"data": "qref"},
         	{"data": "qstep"},
         	{"data": "mid"}
         	],
         	order:[[7, 'asc'],[8,'desc'],[9,'asc']],
         	ordering: true,
         	serverSide:false,
         	dom: 'Bfrtip',
         	select: 'single',
        	responsive: true,
        	altEditor: true,     // Enable altEditor
         	buttons: [
            {
				extend: 'copy'
				,text: 'copy'
				,filename: '호텔별 예약률'
				,title: '호텔별 예약률'
				,className: 'btn btn-outline-primary'
			},
	     	{
				extend: 'excel'
				,text: 'excel'
				,filename: '호텔별 예약률'
				,title: '호텔별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'pdf'
				,text: 'pdf'
				,filename: '호텔별 예약률'
				,title: '호텔별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'print'
				,text: 'print'
				,filename: '호텔별 예약률'
				,title: '호텔별 예약률'
				,className: 'btn btn-outline-primary'
			},
			 {
                text: 'Add',
                name: 'add'        // do not change name
            },
            {
                extend: 'selected', // Bind to Selected row
                text: 'Edit',
                name: 'edit'        // do not change name
            },
            {
                extend: 'selected', // Bind to Selected row
                text: 'Delete',
                name: 'delete'      // do not change name
            },
            {
                text: 'Refresh',
                name: 'refresh'      // do not change name
            }
        ],

        onAddRow: function(datatable, rowdata, success, error) {
        console.log("테스트1:"+rowdata.qid);
            $.ajax({
                // a tipycal url would be / with type='PUT'
                url: '/project/admin/cjy/userqnareply',
                type: 'GET',
                //data는 문제없음 rowdata로 뽑아도 똑같이 에러
                data: {qid:rowdata.qid,
                		qcate:rowdata.qcate,
                		qpw:rowdata.qpw,
                		qtitle:rowdata.qtitle,
                		qcontent:$('#ansqna').val(),
                		qfile:rowdata.qfile,
                		qrdate:rowdata.qrdate,
                		qlev:rowdata.qlev,
                		qref:rowdata.qref,
                		qstep:rowdata.qstep,
                		mid:rowdata.mid
                		},
                success:success,
                error: error
            });
        },
        onDeleteRow: function(datatable, rowdata, success, error) {
            $.ajax({
                // a tipycal url would be /{id} with type='DELETE'
                url:  '/project/admin/cjy/userqnadelete',
                type: 'GET',
                data: rowdata,
                success:success,
                error: error
            });
        },
        onEditRow: function(datatable, rowdata, success, error) {
            $.ajax({
                // a tipycal url would be /{id} with type='POST'
                url: '/project/admin/cjy/userqnaupdate',
                type: 'GET',
                data: rowdata,
                success: success,
                error: error
            });
            //$('#dataTable').dataTable().fnDestroy();
            $('#dataTable').dataTable().fnReloadAjax(); //팝업이 안사라짐
            //$('#dataTable').dataTable().ajax.reload();
        },
         });
      

		   $('#dataTable tbody').on( 'click','tr', function () {
		   var td=$(this).children().children().children();
		    console.log($(this).children("tbody").children().children().eq(0));
		    console.log(table);
		      this_row = table.rows(this).data();
		       $("#testqid").val(this_row[0].qid);
		       $("#testqcate").val(this_row[0].qcate);
		       $("#testqpw").val(this_row[0].qpw);
		       $("#testqtitle").val(this_row[0].qtitle);
		       $("#testqcontent").val(this_row[0].qcontent);
		       $("#testqfile").val(this_row[0].qfile);
		       $("#testqrdate").val(this_row[0].qrdate);
		       $("#testqlev").val(this_row[0].qlev);
		       $("#testqref").val(this_row[0].qref);
		       $("#testqstep").val(this_row[0].qstep);
		       $("#testmid").val(this_row[0].mid);
		       //console.log("테스트"+$("#testmid").val());
		     //  console.log(this_row[0].qid);
		     // $('#rlt').html( "모든 데이터: "+table.row( this ).data()+"<br>문의글번호:"+this_row[0][0]+"<br>카테고리:"+this_row[0][1]+"<br>비밀번호:"+this_row[0][2]+"<br>제목:"+this_row[0][3]+"<br>내용:"+this_row[0][4]+"<br>첨부파일:"+this_row[0][5]+"<br>등록일:"+this_row[0][6]+"<br>처리여부:"+this_row[0][7]+"<br>그룹번호:"+this_row[0][8]+"<br>글번호:"+this_row[0][9]+"<br>아이디:"+this_row[0][10] );
		   } );
  
     function getImg(list, type, full, meta) {
	     if(list!=null){
	            return "<img src='/project/resources/images/userqna/"+list+"' width='150' height='150'>";
	     }else{
	     	return "";
	     }
	 }
	 
});