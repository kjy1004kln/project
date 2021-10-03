// Call the dataTables jQuery plugin
$(document).ready(function(){
   var table =$('#dataTable').dataTable({
  		ajax:{
  		"url":"/project/admin/cjy/rvcancel",
  		"dataType":"json",
  		"dataSrc":"data",
  		 },
         columns:[
         	{targets: 0,
             data: null,
             className: 'text-center',
             searchable: false,
             orderable: false,
             render: function (data, type, full, meta) {
         	    return '<input type="checkbox" id="check_' + data.id + '" class="check" name="check" value="' + data.id + '">';
             },
             width: "5%"},
         	{"data": "rid"},
         	{"data": "rordernum"},
         	{"data": "ramount"},
         	{"data": "rcheckin"},
         	{"data": "rcheckout"},
         	{"data": "rresname"},
         	{"data": "rresphone"},
         	{"data": "rresemail"},
         	{"data": "rexbreaknum"},
         	{"data": "rexbed"},
         	{"data": "rexperson"},
         	{"data": "rcancel"},
         	{"data": "mid"},
         	{"data": "riid"},
         	{"data": "pmethod"},
         	{"data": "pdate"},
         	{"data": "ptotal"},
         	{"data": "prefund"}
         ],

         	dom: 'Bfrtip',
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
        ]
   });
   $('input[name=selectall]').on('change', function(){
	  	if($('input[name=selectall]').prop("checked")){
	  		$('input[type=checkbox]').prop('checked', true);
	  		console.log($('input[type=checkbox]').prop('checked', true));
	  	}else{
	  		$('input[type=checkbox]').prop('checked', false);
	  	}
	});
	
     $('#okbtn').click(function(){
         var checkbox = $("input[name='check']:checked");
         console.log(checkbox);
         var msgcnt=0;
         checkbox.each(function(i) {
             var tr = checkbox.parent().parent().eq(i); //체크박스의 부모는 td
             var td = tr.children();
             var rid = td.eq(1).text();

             $.ajax({
                   url:"/project/admin/cjy/rvcancelapproval",
                   dataType:"json",
                   data:{rid:rid},
                   dataSrc:"data",
                   success:function(d){
                   		if(d.msg=='취소승인 되었습니다'){
	                   		msgcnt++;
	                   		if(msgcnt==checkbox.length){
	                   			alert(d.msg) //여러개 처리시 메세지 1번뜨게 해야함
	                   		}
	                   	}else{
	                   	console.log(d.msg)
	                   	}
	                   	window.location.href='rsvcancel.html'
                   },       
            });
            $('input[type=checkbox]').prop('checked', false);
        });
        if(checkbox.length==0){
            alert("선택된 체크박스가 존재하지 않습니다")
        }
        /*
        //취소 승인후 테이블 삭제
        table.fnDestroy(); //구버전은 destroy()가 아니라 fnDestroy()사용해야함
		//테이블 다시 생성
        table =$('#dataTable').dataTable({
               ajax:{
                   "url":"/project/admin/cjy/rvcancel",
                   "dataType":"json",
                   "dataSrc":"data"
                },
                columns:[
                    {targets: 0,
                    data: null,
                    className: 'text-center',
                    searchable: false,
                    orderable: false,
                    render: function (data, type, full, meta) {
                        return '<input type="checkbox" id="check_' + data.id + '" class="check" name="check" value="' + data.id + '">';
                    },
                    width: "5%"},
                    {"data": "rid"},
                    {"data": "rordernum"},
                    {"data": "ramount"},
                    {"data": "rcheckin"},
                    {"data": "rcheckout"},
                    {"data": "rresname"},
                    {"data": "rresphone"},
                    {"data": "rresemail"},
                    {"data": "rexbreaknum"},
                    {"data": "rexbed"},
                    {"data": "rexperson"},
                    {"data": "rcancel"},
                    {"data": "mid"},
                    {"data": "riid"},
                ],
                    dom: 'Bfrtip',
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
                ]
        });
            */
    });

});