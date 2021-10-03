// Call the dataTables jQuery plugin
$(document).ready(function() {
	//호텔별 예약률
	$('#hotelTable').DataTable( {
	    ajax:{
        	url:path+"hjy/admin/hotelReservationRate?time="+$("#time").val(),
        	type:"GET",
        	dataSrc: 'list'
        },
        columns:[
        	{data:"aname"},
        	{data:"per"}
        ],
        //destroy: ajax현재 table이 수정? 될 수 있게함
        destroy: true,
        //order,ordering,serverSide: 초기정렬조건설정
        order: [[1, 'desc']],
	    ordering: true,
	    serverSide: false,
	    //Bfrtip: excel로 다운로드 기능
	    dom:'Bfrtip',
	    buttons:[
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
	} );
	//객실별 예약율
	$('#roomTable').DataTable( {
	    ajax:{
	    	url:path+"hjy/admin/roomReservationRate?time="+$("#time").val(),
        	type:"GET",
        	dataSrc: 'list'
        },
        columns:[
        	{data:"aname"},
			{data:"riroomtype"},
			{data:"per"}
        ],
        //ajax현재 table이 수정? 될 수 있게함
        destroy: true,
        order: [[2, 'desc']],
	    ordering: true,
	    serverSide: false,
	    dom:'Bfrtip',
	    buttons:[
	     	{
				extend: 'copy'
				,text: 'copy'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'	
			},
	     	{
				extend: 'excel'
				,text: 'excel'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'pdf'
				,text: 'pdf'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'print'
				,text: 'print'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
	    ]
	} );
	
	//select조건으로 몇개월치 검색할지 선택하면 수행될 구문
	$("#time").change(function(){
		console.log($("#time").val())
			//호텔별 예약율
			$('#hotelTable').dataTable().fnClearTable(); 
		$('#hotelTable').DataTable( {
		    ajax:{
	        	url:path+"hjy/admin/hotelReservationRate?time="+$("#time").val(),
	        	type:"GET",
	        	dataSrc: 'list'
	        },
	        columns:[
	        	{data:"aname"},
	        	{data:"per"}
	        ],
	        destroy: true,
	        order: [[1, 'desc']],
		    ordering: true,
		    serverSide: false,
		    dom:'Bfrtip',
		    buttons:[
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
		} );
		//객실별 예약율
		//$('#roomTable').parent().children().remove();
		$('#roomTable').dataTable().fnClearTable(); 
		$('#roomTable').DataTable( {
		    ajax:{
		    	url:path+"hjy/admin/roomReservationRate?time="+$("#time").val(),
	        	type:"GET",
	        	dataSrc: 'list'
	        },
	        columns:[
	        	{data:"aname"},
				{data:"riroomtype"},
				{data:"per"}
	        ],
	        destroy: true,
	        order: [[2, 'desc']],
		    ordering: true,
		    serverSide: false,
		    dom:'Bfrtip',
		    buttons:[
	     	{
				extend: 'copy'
				,text: 'copy'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
	     	{
				extend: 'excel'
				,text: 'excel'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'pdf'
				,text: 'pdf'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
			{
				extend: 'print'
				,text: 'print'
				,filename: '객실별 예약률'
				,title: '객실별 예약률'
				,className: 'btn btn-outline-primary'
			},
	    ]
		} );
	})
	
});
	