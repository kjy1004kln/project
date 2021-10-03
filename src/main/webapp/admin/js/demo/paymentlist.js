// Call the dataTables jQuery plugin

$(document).ready(function(){
	$('#dataTable').dataTable({
  		ajax:{
  			url : "/project/admin/lhj/paymentlist",
  			dataType : "json",
  		 	dataSrc : "list"
  		 },
         columns:[
         	{"data": "pid"},
         	{"data": "pmethod"},
         	{"data": "pdate"},
         	{"data": "ptotal"},
         	{"data": "prefund"},
         	{"data": "rid"},
         	{"data": "mid"}
         	],
         	dom: 'Bfrtip',
         	buttons: [
            'copy', 'excel', 'pdf', 'print'
        ],
        dom: 'Bfrtip',
     	buttons: [
      	  {
			extend: 'copy'
			,text: 'copy'
			,filename: '결제 목록'
			,title: '결제 목록'
			,className: 'btn btn-outline-primary'
			},
     		{
			extend: 'excel'
			,text: 'excel'
			,filename: '결제 목록'
			,title: '결제 목록'
			,className: 'btn btn-outline-primary'
			},
			{
			extend: 'pdf'
			,text: 'pdf'
			,filename: '결제 목록'
			,title: '결제 목록'
			,className: 'btn btn-outline-primary'
			},
			{
			extend: 'print'
			,text: 'print'
			,filename: '결제 목록'
			,title: '결제 목록'
			,className: 'btn btn-outline-primary'
			},
    	],
	});
});