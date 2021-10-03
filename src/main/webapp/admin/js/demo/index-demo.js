// Set new default font family and font color to mimic Bootstrap's default styling
$(document).ready(function() {
//이번달 매출액
$.ajax({
		url:path+"hjy/admin/monthlySales",
		type:"get",
		dataType:"json",
		success:function(data){
			$("#monthlySales").html(data.monthlySales)
		}
	});
	
//이번년 매출액
$.ajax({
		url:path+"hjy/admin/annualSales",
		type:"get",
		dataType:"json",
		success:function(data){
			$("#annualSales").html(data.annualsales)
		}
	});
	
//현재 달 구하기
$.ajax({
		url:path+"hjy/admin/month",
		type:"get",
		dataType:"json",
		success:function(data){
			let month =data.month
			for (let i = 0; i < $("div[name=month]").length; i++) {
				$("div[name=month]").eq(i).html(month+$("div[name=month]").eq(i).html())
			}
		}
	});
	
//현재 년도 구하기
$.ajax({
		url:path+"hjy/admin/year",
		type:"get",
		dataType:"json",
		success:function(data){
			let year = data.year
			year += $("#year").html()
			$("#year").html(year)
		}
	});
	
//전체 회원수
$.ajax({
		url:path+"hjy/admin/allMembers",
		type:"get",
		dataType:"json",
		success:function(data){
			$("#allMembers").html(data.allMembers)
		}
	});
	
//이번달 회원 유입수
$.ajax({
		url:path+"hjy/admin/monthMembers",
		type:"get",
		dataType:"json",
		success:function(data){
			$("#monthMembers").html(data.monthMembers)
			$("#monthMembersBar").attr('style','width:'+data.monthMembers*10+'%')
		}
	});

//이번달 최고 예약율 호텔 top5
$.ajax({
		url:path+"hjy/admin/reservationRate",
		type:"get",
		dataType:"json",
		success:function(data){
		let color = ['progress-bar bg-danger','progress-bar bg-warning','progress-bar','progress-bar bg-info','progress-bar bg-success'];
            for (let i = 0; i < data.list.length; i++) {
				let html = 
					`
						<h4 class="small font-weight-bold">${data.list[i].ANAME}<span
		                        class="float-right">${data.list[i].PER}%</span></h4>
		                <div class="progress mb-4">
		                    <div class="${color[i]}" role="progressbar" style="width: ${data.list[i].PER*100}%"
		                        aria-valuenow="${data.list[i].PER}" aria-valuemin="0" aria-valuemax="100"></div>
		                </div>
					`
				$("#reservationRate").append(html);
			}
		}
	});
	
//취소환불 신청내역
	$('#cancelTable').dataTable({
  		ajax:{
  		"url":"/project/admin/cjy/rvcancel",
  		"dataType":"json",
  		"dataSrc":"data"
  		 },
         columns:[
         	{"data": "rid"},
         	{"data": "ramount"},
         	{"data": "rcheckin"},
         	{"data": "rcheckout"},
         	{"data": "rresname"},
         	{"data": "rcancel"},
         	{"data": "mid"},
         	{"data": "riid"},
         ],
         searching: false,
         info: true,
   });

})

