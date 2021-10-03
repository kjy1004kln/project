<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
    padding-top: 50px;
}

@media screen and (min-width: 768px) {
    #adv-search {
        width: 500px;
        margin: 0 auto;
    }
    .dropdown.dropdown-lg {
        position: static !important;
    }
    .dropdown.dropdown-lg .dropdown-menu {
        min-width: 500px;
    }
}
.star_section_field{
	width: 30px;
	height: 30px;
	border: 3px solid blue;
	float: left;
}
.grade_section_field{
	width: 30px;
	height: 30px;
	border: 3px solid blue;
	float: left;
}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css">
<!------ Include the above in your HEAD tag ---------->
<script type="text/javascript">
function collectInfo(){
	let countRoom=$("#countRoom").val();
	let countPeople=$("#countPeople").val();
	console.log(countRoom)
	$("#showInfo").val("객실"+countRoom+"인원"+countPeople);
}
//자동완성 - 지윤
$(function(){
	$("#searchHotel").autocomplete({
		source:function(request,response){
			let aname=$("#searchHotel").val();
			$.ajax({
				type:'get',
				url:"/project/lhjcjy/ajax/auto",
				data:{"aname":aname,"aaddress":aname},
				dataType:"json",
				success:function(data){
					console.log(data)
					response(
						$.map(data.list,function(item){
							return{
								label:item,
								value:item
							}
						})		
					)
				}
			})
		},
		select:function(event,ui){
			console.log(ui);
			console.log(ui.item.label);
			console.log(ui.item.value);
		},
		focus:function(event,ui){
			return false; //한글 에러잡기
		},
		minLength:1,//최소글자수
		autoFocus:true, //첫번째 항목 자동 포커스a 기본값 false
		 classes: {    //잘 모르겠음
             "ui-autocomplete": "highlight"
         },
		delay:500, //검색창에 글자 쓰고 autocomplete되기까지 딜레이 시간ms)
		//disabled:true, //자동완성기능 끄기
		//position:{my:"right top", at:"right bottom"},
		close:function(event){
			console.log(event);
		}
	}).autocomplete( "instance" )._renderItem = function( ul, item ) {    //요 부분이 UI를 마음대로 변경하는 부분
        return $( "<li>" )    //기본 tag가 li로 되어 있음 
        .append( "<div>" + item.value +"</div>" )    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
        .appendTo( ul );
 	};
 	//전체 정렬
	$("#sort").change(function(){
		if(this.value=="all"){
			let searchHotel=$("#searchHotel").val();
			let checkin=$("input[name=checkin]").val();
			let checkout=$("input[name=checkout]").val();
			let countPeople=$("input[name=countPeople]").val();
			let countRoom=$("input[name=countRoom]").val();
			$("#accommList").empty(); 
			$.ajax({
				url:"${pageContext.request.contextPath }/lhjcjy/sortbyall",
				dataType:"json",
				type:"get",
				data:{"searchHotel":searchHotel,"checkin":checkin, "checkout":checkout,"countPeople":countPeople,"countRoom":countRoom },
				success:function(data){
					$(data.list).each(function(i,d){
						let aid= d.aid;
						let amainimg=d.amainimg;
						let aname=d.aname;
						let aaddress=d.aaddress;
						//let star=d.star;
						let grade = d.agrade;
						let amountsum=d.amountsum;
						let restar = d.star;
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let li="<div class='accommList'>";
						li += "<div class='eachList'>";
						li += "<div class='card'>";
						li += "<div class='card-body'>";
						li += "<div class='row'>";
						li += "<div class='col-md-3'>";
						li += "<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+amainimg+"' width='300' height='250'>";
						li += "</div>";
						li += "<div class='col-md-7'>";
						li += "<h3>"+aname+"</h3>";
						li += "<small>"+aaddress+"</small>";
						li += "</div>";
						li += "<div class='col-md-2'>";
						if(grade == null){
    						li += "<h5> </h5>";
    					}else{
    						li += "<h5>" + grade + "성급</h5>";
    					}
						li += "<h5>" + star + "</h5>";
						li += "<h4>"+amountsum+"원</h4>";
						li += "<button class=\"btn\" onclick=\"location.href='{pageContext.request.contextPath }/user/kjy/room_info?aid="+aid+"&person="+countPeople+"&roomnum="+countRoom+"&startday="+checkin+"&endday="+checkout+"'\">예약하기</button>" 
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						$("#accommList").append(li);
					})
				}
			})
		}
 	//가격순 오름차순 정렬 - 지윤
		if(this.value=="price_low"){
			let searchHotel=$("#searchHotel").val();
			let checkin=$("input[name=checkin]").val();
			let checkout=$("input[name=checkout]").val();
			let countPeople=$("input[name=countPeople]").val();
			let countRoom=$("input[name=countRoom]").val();
			$("#accommList").empty(); 
			$.ajax({
				url:"${pageContext.request.contextPath }/lhjcjy/sortbyprice_low",
				dataType:"json",
				type:"get",
				data:{"searchHotel":searchHotel,"checkin":checkin, "checkout":checkout,"countPeople":countPeople,"countRoom":countRoom },
				success:function(data){
					$(data.list).each(function(i,d){
						let aid= d.aid;
						let amainimg=d.amainimg;
						let aname=d.aname;
						let aaddress=d.aaddress;
						//let star=d.star;
						let grade = d.agrade;
						let amountsum=d.amountsum;
						let restar = d.star;
						console.log("restar:"+restar);
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let li="<div class='accommList'>";
						li += "<div class='eachList'>";
						li += "<div class='card'>";
						li += "<div class='card-body'>";
						li += "<div class='row'>";
						li += "<div class='col-md-3'>";
						li += "<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+amainimg+"' width='300' height='250'>";
						li += "</div>";
						li += "<div class='col-md-7'>";
						li += "<h3>"+aname+"</h3>";
						li += "<small>"+aaddress+"</small>";
						li += "</div>";
						li += "<div class='col-md-2'>";
						if(grade == null){
    						li += "<h5> </h5>";
    					}else{
    						li += "<h5>" + grade + "성급</h5>";
    					}
						li += "<h5>" + star + "</h5>";
						li += "<h4>"+amountsum+"원</h4>";
						li += "<button class=\"btn\" onclick=\"location.href='{pageContext.request.contextPath }/user/kjy/room_info?aid="+aid+"&person="+countPeople+"&roomnum="+countRoom+"&startday="+checkin+"&endday="+checkout+"'\">예약하기</button>" 
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						$("#accommList").append(li);
					})
				}
			})
		}
 	//가격 내림차순 정렬 
		if(this.value=="price_high"){
			let searchHotel=$("#searchHotel").val();
			let checkin=$("input[name=checkin]").val();
			let checkout=$("input[name=checkout]").val();
			let countPeople=$("input[name=countPeople]").val();
			let countRoom=$("input[name=countRoom]").val();
			$("#accommList").empty(); 
			console.log(checkin);
			$.ajax({
				url:"${pageContext.request.contextPath }/lhjcjy/sortbyprice_high",
				dataType:"json",
				type:"get",
				data:{"searchHotel":searchHotel,"checkin":checkin, "checkout":checkout,"countPeople":countPeople,"countRoom":countRoom },
				success:function(data){
					$(data.list).each(function(i,d){
						let aid=d.aid;
						let amainimg=d.amainimg;
						let aname=d.aname;
						let aaddress=d.aaddress;
						let grade = d.agrade;
						//let star=d.star;
						let amountsum=d.amountsum;
						let restar = d.star;
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let li="<div class='accommList'>";
						li += "<div class='eachList'>";
						li += "<div class='card'>";
						li += "<div class='card-body'>";
						li += "<div class='row'>";
						li += "<div class='col-md-3'>";
						li += "<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+amainimg+"' width='300' height='250'>";
						li += "</div>";
						li += "<div class='col-md-7'>";
						li += "<h3>"+aname+"</h3>";
						li += "<small>"+aaddress+"</small>";
						li += "</div>";
						li += "<div class='col-md-2'>";
						if(grade == null){
    						li += "<h5> </h5>";
    					}else{
    						li += "<h5>" + grade + "성급</h5>";
    					}
						li += "<h5>" + star + "</h5>";
						li += "<h4>"+amountsum+"원</h4>";
						li += "<button class=\"btn\" onclick=\"location.href='{pageContext.request.contextPath }/user/kjy/room_info?aid="+aid+"&person="+countPeople+"&roomnum="+countRoom+"&startday="+checkin+"&endday="+checkout+"'\">예약하기</button>" 
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						li += "</div>";
						$("#accommList").append(li);
					})
				}
			})
		}
		//평점순 정렬
		if(this.value == "star"){
			let searchHotel = $("#searchHotel").val();
			let checkin = $("input[name=checkin]").val();
			let checkout = $("input[name=checkout]").val();
			let countPeople = $("input[name=countPeople]").val();
			let countRoom = $("input[name=countRoom]").val();
	 		$("#accommList").empty();
			$.ajax({
		 		url : "${pageContext.request.contextPath }/lhjcjy/firstsearchStar",
				data : {"searchHotel" : searchHotel, "checkin" : checkin, "checkout" : checkout, "countRoom" : countRoom, "countPeople" : countPeople},
				dataType : "json",
				success : function(data){
					$(data.list).each(function(i,d){
						let amainimg = d.amainimg;
						let aname = d.aname;
						let address = d.aaddress;
						let restar = d.restar;
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let price = d.amountsum;
						let grade = d.agrade;
						//console.log(aname + ", " + address + ", " + star + ", " + price);
						let aid = d.aid;
						let person = d.rimaxper;
						let roomnum = d.countRoom;
						let rcheckin = d.rcheckin;
						let rcheckout = d.rcheckout;
						//console.log(aid + ", " + person + ", " + roomnum + ", " + rcheckin + ", " + rcheckout);
						
						let html = "<div class='accommList'>";
						html    += "<div class='eachList'>";
						html	+= "<div class='card'>";
						html	+= "<div class='card-body'>";
						html	+= "<div class='row'>";
						html	+= "<div class='col-md-3'>";
						html	+= "<img src='${pageContext.request.contextPath }/resources/images/accommodations/" + amainimg + "' width='300' height='250'>";
						html	+= "</div>";
						html	+= "<div class='col-md-7'>";
						html	+= "<h3>" + aname + "</h3>";
						html	+= "<small>" + address + "</small>";
						html	+= "<p><small>지도보기?뭐든추가</small></p>";
						html	+= "</div>";
						html	+= "<div class='col-md-2'>";
						if(grade == null){
    						html += "<h5> </h5>";
    					}else{
    						html += "<h5>" + grade + "성급</h5>";
    					}
						html	+= "<h5>" + star + "</h5>";
						html	+= "<h4>" + price + "원</h4>";
						html	+= "<button class='btn' onclick=" + "location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid=" + aid + "&person=" + person + "&roomnum=" + roomnum + "&startday=" + rcheckin + "&endday=" + rcheckout + "'>예약하기</button>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						$("#accommList").append(html);
					});
				}	
		 	});
		}
	});
	   //가격 range slider -지윤
        $('#slider').slider({
            orientation:'horizontal',
             min:${minmax.minsum},
             max:${minmax.maxsum},
             step:10000,
             range:true,
             values:[${minmax.minsum},${minmax.maxsum}],
             
             create:function(e, ui){ //text 박스에 value값 나타냄
                 var values = $(this).slider('option','values');
                 $('#count_min').val(values[0]);
                 $('#count_max').val(values[1]);
             },
             change:function(e,ui){ //value 가 change 되었을 때
                 $('#count_min').val(ui.values[0]);
                 $('#count_max').val(ui.values[1]);
                 
                let searchHotel=$("#searchHotel").val();
         		let checkin=$("input[name=checkin]").val();
         		let checkout=$("input[name=checkout]").val();
         		let countPeople=$("input[name=countPeople]").val();
         		let countRoom=$("input[name=countRoom]").val();
         		let minprice=$("#count_min").val();
         		let maxprice=$("#count_max").val();
         		$("#accommList").empty();
         				
         		$.ajax({
        			url:"/project/lhjcjy/rangeslider",
        			dataType:"json",
        			type:"get",
        			data:{"searchHotel":searchHotel,"checkin":checkin, "checkout":checkout,"countPeople":countPeople,"countRoom":countRoom, "minprice":minprice, "maxprice":maxprice },
        			success:function(data){
        				$(data.list).each(function(i,d){
        					let aid=d.aid;
        					let amainimg=d.amainimg;
        					let aname=d.aname;
        					let aaddress=d.aaddress;
        					let grade = d.agrade;
        					//let star=d.star;
        					let amountsum=d.amountsum;
        					let restar = d.star;
    						if(restar == 5){
    							let star = "★★★★★";
    						}else if(restar == 4){
    							star="★★★★☆";
    						}else if(restar == 3){
    							star="★★★☆☆";
    						}else if(restar == 2){
    							star = "★★☆☆☆";
    						}else if(restar == 1){
    							star = "★☆☆☆☆";
    						}else if(restar == 0){
    							star="☆☆☆☆☆";
    						}
        					let li="<div class='accommList'>";
        					li += "<div class='eachList'>";
        					li += "<div class='card'>";
        					li += "<div class='card-body'>";
        					li += "<div class='row'>";
        					li += "<div class='col-md-3'>";
        					li += "<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+amainimg+"' width='300' height='250'>";
        					li += "</div>";
        					console.log("!!!!!!");
        					li += "<div class='col-md-7'>";
        					li += "<h3>"+aname+"</h3>";
        					li += "<small>"+aaddress+"</small>";
        					li += "</div>";
        					li += "<div class='col-md-2'>";
        					if(grade == null){
        						li += "<h5> </h5>";
        					}else{
        						li += "<h5>" + grade + "성급</h5>";
        					}
        					li += "<h5>" + star + "</h5>";
        					li += "<h4>"+amountsum+"원</h4>";
        					li += "<button class=\"btn\" onclick=\"location.href='{pageContext.request.contextPath }/user/kjy/room_info?aid="+aid+"&person="+countPeople+"&roomnum="+countRoom+"&startday="+checkin+"&endday="+checkout+"'\">예약하기</button>" 
        					li += "</div>";
        					li += "</div>";
        					li += "</div>";
        					li += "</div>";
        					li += "</div>";
        					li += "</div>";
        					$("#accommList").append(li);
        				})
        			}
        		})
                 
             }
         });
        $('#count_min').change(function(){
    		$('#slider').slider('values',0,$(this).val());
    	})
    	$('#count_max').change(function(){
    		$('#slider').slider('values',1,$(this).val());
    	})
	   
     // 평점 div박스
   		$(".star_section_field").click(function(){
   			let searchHotel = $("#searchHotel").val();
			let checkin = $("input[name=checkin]").val();
			let checkout = $("input[name=checkout]").val();
			let countPeople = $("input[name=countPeople]").val();
			let countRoom = $("input[name=countRoom]").val();
			let restar = $(this).attr("id");
		
			$("#accommList").empty();
			$.ajax({
		 		url : "${pageContext.request.contextPath }/lhjcjy/starsection",
				data : {"searchHotel" : searchHotel, "checkin" : checkin, "checkout" : checkout, "countRoom" : countRoom, "countPeople" : countPeople, "restar" : restar},
				dataType : "json",
				success : function(data){
					$(data.list).each(function(i,d){
						let restar = d.restar;
						let amainimg = d.amainimg;
						let aname = d.aname;
						let address = d.aaddress;
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let price = d.amountsum;
						let grade = d.agrade;
						console.log(aname + ", " + address + ", " + star + ", " + price);
						let aid = d.aid;
						let person = d.rimaxper;
						let roomnum = d.countRoom;
						let rcheckin = d.rcheckin;
						let rcheckout = d.rcheckout;
						console.log(aid + ", " + person + ", " + roomnum + ", " + rcheckin + ", " + rcheckout);
						
						let html = "<div class='accommList'>";
						html    += "<div class='eachList'>";
						html	+= "<div class='card'>";
						html	+= "<div class='card-body'>";
						html	+= "<div class='row'>";
						html	+= "<div class='col-md-3'>";
						html	+= "<img src='${pageContext.request.contextPath }/resources/images/accommodations/" + amainimg + "' width='300' height='250'>";
						html	+= "</div>";
						html	+= "<div class='col-md-7'>";
						html	+= "<h3>" + aname + "</h3>";
						html	+= "<small>" + address + "</small>";
						html	+= "<p><small>지도보기?뭐든추가</small></p>";
						html	+= "</div>";
						html	+= "<div class='col-md-2'>";
						if(grade == null){
    						html += "<h5> </h5>";
    					}else{
    						html += "<h5>" + grade + "성급</h5>";
    					}
						html	+= "<h5>" + star + "</h5>";
						html	+= "<h4>" + price + "원</h4>";
						html	+= "<button class='btn' onclick=" + "location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid=" + aid + "&person=" + person + "&roomnum=" + roomnum + "&startday=" + rcheckin + "&endday=" + rcheckout + "'>예약하기</button>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						$("#accommList").append(html);
					});
				}	
			});
		});
   		// 성급 div박스
   		$(".grade_section_field").click(function(){
   			let searchHotel = $("#searchHotel").val();
			let checkin = $("input[name=checkin]").val();
			let checkout = $("input[name=checkout]").val();
			let countPeople = $("input[name=countPeople]").val();
			let countRoom = $("input[name=countRoom]").val();
			let agrade = $(this).attr("id");
		
			$("#accommList").empty();
			$.ajax({
		 		url : "${pageContext.request.contextPath }/lhjcjy/gradesection",
				data : {"searchHotel" : searchHotel, "checkin" : checkin, "checkout" : checkout, "countRoom" : countRoom, "countPeople" : countPeople, "agrade" : agrade},
				dataType : "json",
				success : function(data){
					$(data.list).each(function(i,d){
						let restar = d.restar;
						let amainimg = d.amainimg;
						let aname = d.aname;
						let address = d.aaddress;
						console.log("평점: " + restar);
						if(restar == 5){
							let star = "★★★★★";
						}else if(restar == 4){
							star="★★★★☆";
						}else if(restar == 3){
							star="★★★☆☆";
						}else if(restar == 2){
							star = "★★☆☆☆";
						}else if(restar == 1){
							star = "★☆☆☆☆";
						}else if(restar == 0){
							star="☆☆☆☆☆";
						}
						let price = d.amountsum;
						let grade = d.agrade;
						console.log(aname + ", " + address + ", " + star + ", " + price + ", " + grade);
						let aid = d.aid;
						let person = d.rimaxper;
						let roomnum = d.countRoom;
						let rcheckin = d.rcheckin;
						let rcheckout = d.rcheckout;
						console.log(aid + ", " + person + ", " + roomnum + ", " + rcheckin + ", " + rcheckout);
						
						let html = "<div class='accommList'>";
						html    += "<div class='eachList'>";
						html	+= "<div class='card'>";
						html	+= "<div class='card-body'>";
						html	+= "<div class='row'>";
						html	+= "<div class='col-md-3'>";
						html	+= "<img src='${pageContext.request.contextPath }/resources/images/accommodations/" + amainimg + "' width='300' height='250'>";
						html	+= "</div>";
						html	+= "<div class='col-md-7'>";
						html	+= "<h3>" + aname + "</h3>";
						html	+= "<small>" + address + "</small>";
						html	+= "<p><small>지도보기?뭐든추가</small></p>";
						html	+= "</div>";
						html	+= "<div class='col-md-2'>";
						if(grade == null){
    						html += "<h5> </h5>";
    					}else{
    						html += "<h5>" + grade + "성급</h5>";
    					}
						html	+= "<h5>" + star + "</h5>";
						html	+= "<h4>" + price + "원</h4>";
						html	+= "<button class='btn' onclick=" + "location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid=" + aid + "&person=" + person + "&roomnum=" + roomnum + "&startday=" + rcheckin + "&endday=" + rcheckout + "'>예약하기</button>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						html	+= "</div>";
						$("#accommList").append(html);
					});
				}	
			});
		});				
});
</script>
</head>
<body>
	<form>
		<input id="count_min" type="text" size="10" class="price-range-field" />
		~ <input id="count_max" type="text" size="10" class="price-range-field" />
		<div id="slider"></div>
	</form>
	<div class ="star_section">
		<h4>평점</h4>
		<div class="star_section_field" id="1">1+</div>
		<div class="star_section_field" id="2">2+</div>
		<div class="star_section_field" id="3">3+</div>
		<div class="star_section_field" id="4">4+</div>
		<div class="star_section_field" id="5">5</div>
	</div><br>
	<div class ="grade_section">	
		<h4>성급</h4>
		<div class="grade_section_field" id="1">1+</div>
		<div class="grade_section_field" id="2">2+</div>
		<div class="grade_section_field" id="3">3+</div>
		<div class="grade_section_field" id="4">4+</div>
		<div class="grade_section_field" id="5">5</div>
	</div><br>
<form method="post" action="${pageContext.request.contextPath }/lhjcjy/firstsearch">
	<div>
	호텔명 or 지역
	<input type="text" id="searchHotel" name="searchHotel" value="${aaddress }">
	체크인
	<input type="date" name="checkin" value="${rcheckin }">
	체크아웃
	<input type="date" name="checkout" value="${rcheckout }">
	<div class="form-group">
	  <label for="filter">객실수</label>
	  <input type="number" min="1" id="countRoom" name="countRoom" value="${countRoom }">
	</div>
	<div class="form-group">
	  <label for="contain">인원수</label>
	  <input type="number" min="1" id="countPeople" name="countPeople" value="${rimaxper }">
	</div>                  
	<input type="submit" value="검색" id="search">
	</div>
</form>
	<select name="sort" id="sort">
		<option value="all">전체</option>
		<option value="price_low">가격(낮은순)</option>
		<option value="price_high">가격(높은순)</option>
		<option value="star">평점</option>
	</select>
<div class="accommList" id="accommList">
	<c:forEach var="vo" items="${list }">
		<div class="eachList">
		    <div class="card">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-3">
		                   <img src="${pageContext.request.contextPath }/resources/images/accommodations/${vo.amainimg }" width="300" height="250">
		                </div>
		                <div class="col-md-7">
		                    <h3>${vo.aname }</h3>
		                    <small>${vo.aaddress }</small>
		                    <p><small>지도보기?뭐든추가</small></p>
		                </div>
		                <div class="col-md-2">
		                	<h5>${vo.agrade }성급</h5>
						<c:choose>
		                <c:when test="${vo.restar==5 }">
		                	<h5>★★★★★</h5>
		                </c:when>
		                 <c:when test="${vo.restar==4 }">
		                	<h5>★★★★☆</h5>
		                </c:when>
		                 <c:when test="${vo.restar==3 }">
		                	<h5>★★★☆☆</h5>
		                </c:when>
		                 <c:when test="${vo.restar==2 }">
		                	<h5>★★☆☆☆</h5>
		                </c:when>
		                 <c:when test="${vo.restar==1 }">
		                	<h5>★☆☆☆☆</h5>
		                </c:when>
		                <c:otherwise>
		               		<h5>☆☆☆☆☆점</h5>
		                </c:otherwise>	
		                </c:choose>
							<h4>${vo.amountsum}원</h4>
		                    <button class="btn" onclick="location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid=${vo.aid}&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}&endday=${rcheckout}'">예약하기</button> 
		                </div>
		            </div>
		        </div>
		    </div>
		</div>   
	</c:forEach>
</div>         
</body>
</html>