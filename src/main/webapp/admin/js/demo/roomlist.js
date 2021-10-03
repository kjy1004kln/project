// Set new default font family and font color to mimic Bootstrap's default styling
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
	$('#dataTable').DataTable( {
	    ajax:{
	    	url :"/project/admin/lhj/roomlist?aid=" + paramValue,
    		type : "GET",
        	dataSrc: 'list'
        },
        columns:[
        	{data:"riid"},
			{data:"riroomtype"},
			{data:"riroom"},
			{data:"riservice"},
			{data:"risize"},
			{data:"riminper"},
			{data:"rimaxper"},
			{data:"ripeak"},
			{data:"risemipeak"},
			{data:"rioff"},
			{data:"rimainimg", render : getImg},
			{data:"riextraimg1", render : getImg},
			{data:"riextraimg2", render : getImg},
			{data:"riid",
				"render":function(data,type,row){
					if(type==='display'){
						data="<a href='" + path + "admin/roomDetail.html?riid=" + data + "'>수정</a>"
					}
					return data;
				}
			}
		],
        dom: 'Bfrtip',
     	buttons: [
      	  {
			extend: 'copy'
			,text: 'copy'
			,filename: '객실 목록'
			,title: '객실 목록'
			,className: 'btn btn-outline-primary'
			},
     		{
			extend: 'excel'
			,text: 'excel'
			,filename: '객실 목록'
			,title: '객실 목록'
			,className: 'btn btn-outline-primary'
			},
			{
			extend: 'pdf'
			,text: 'pdf'
			,filename: '객실 목록'
			,title: '객실 목록'
			,className: 'btn btn-outline-primary'
			},
			{
			extend: 'print'
			,text: 'print'
			,filename: '객실 목록'
			,title: '객실 목록'
			,className: 'btn btn-outline-primary'
			},
    	],
	});
});

function getImg(list, type, full, meta) {
	if(list != null){
		return "<img src='" + path + "/resources/images/room_info/" + list + "' width='150' height='150'>";
	}else{
		return "";
	}
}
	
