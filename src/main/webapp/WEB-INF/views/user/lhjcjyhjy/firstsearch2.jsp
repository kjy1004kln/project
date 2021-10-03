<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 헤더 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<!-- 푸터 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
<!-- 글꼴 -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<!-- 부트스트랩 -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
	integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
	integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF"
	crossorigin="anonymous"></script>
<!-- jquery ui -->
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<!-- css -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
	integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l"
	crossorigin="anonymous">
<!-- x,y좌표 위도,경도로 바꾸기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/proj4js/2.7.5/proj4.js"></script>
<!-- 지도추가 -->
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=hznya2qvqk&submodules=geocoder"></script>
<!-- css -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/firstsearchmain.css">

<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">

<style type="text/css">
.bg-orange {
	background: #00AEF0;
	color: #fff !important;
}

body {
	font-family: Brezel Grotesk, Helvetica Neue, Helvetica, Arial,
		sans-serif;
}

img {
	width: 100%;
	max-height: 560px;
}

a {
	color: #696969;
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

.noresult {
	font-family: Brezel Grotesk, Helvetica Neue, Helvetica, Arial,
		sans-serif;
	font-weight: 400;
}

#sort {
	padding: 5px 5px 5px 5px;
	color: #00AEF0;
	border: 1px solid #00AEF0;
	border-radius: 3px;
}

.text-left {
	color: black;
}
</style>
<!------ Include the above in your HEAD tag ---------->
<script type="text/javascript">
let aname;
function collectInfo(){
	let countRoom=$("#countRoom").val();
	let countPeople=$("#countPeople").val();
	$("#showInfo").val("객실"+countRoom+"인원"+countPeople);
}
$(function(){
	//자동완성 - 지윤
	$("#searchHotel").autocomplete({
		source:function(request,response){
			let aname=$("#searchHotel").val();
			$.ajax({
				type:'get',
				url:"/project/lhjcjy/ajax/auto",
				data:{"aname":aname,"aaddress":aname},
				dataType:"json",
				success:function(data){
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
 	
 	//숙소이름 자동완성 검색에 아무것도 안써져있을때 수행 -지영
 	$("#searchHotelname").focusout(function() {
 		if($(this).val()==""){
 			aname="";
 			callList();
 		}
 	});
 	//숙소이름 자동완성 검색 -지영
	$("#searchHotelname").autocomplete({
		source:function(request,response){
			let aname=$("#searchHotelname").val();
			$.ajax({
				type:'get',
				url:"/project/hjy/ajax/auto",
				data:{"aname":aname,"aaddress":aname,"firstaaddress":"${aaddress }"},
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
			aname =ui.item.value;
			console.log("aname",aname)
			callList();
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
			//if(event.)
			//console.log("event",event)
		}
	}).autocomplete( "instance" )._renderItem = function( ul, item ) {    //요 부분이 UI를 마음대로 변경하는 부분
        return $( "<li>" )    //기본 tag가 li로 되어 있음 
        .append( "<div>" + item.value +"</div>" )    //여기에다가 원하는 모양의 HTML을 만들면 UI가 원하는 모양으로 변함.
        .appendTo( ul );
 	};
 	
 	//즐겨찾기 체크박스 클릭 시 실행되는 ajax -지영
	$("#favorite ul li input").click(function() {
		if("${mid}"=="undifined" || "${mid}"==""){
        	var confirmcheck=confirm("로그인 하셔야 이용할 수 있는 서비스입니다. 로그인 하시겠습니까?")
        	if(confirmcheck	){
        		location.href = "${pageContext.request.contextPath }/jhr/login";
				$(this).prop('checked',false)
        	}else{
				$(this).prop('checked',false)
        	}
        }else{
			callList();
		}
	})
	
	//편의시설 체크박스 클릭 시 실행되는 ajax -지영
	$("#facilities input").click(function() {
 		callList()
	})
		
	//무료시설 체크박스 클릭 시 실행되는 ajax -지영
	$("#forFree input").click(function() {
 		callList()
	})
	
	//거리를 통한 검색의 select옵션이 변경되었을때 실행될 함수 -지영
 	$("#locationamount").change(function() {
 		let grade;
		let star;
		//성급 몇인지 뽑아오는부분
 		for (var i =1; i <= 5; i++) {
 			if($("#grade"+i).attr('style')=="background-color: #00AEF0 opacity:0.8;"){
 				grade = $("#grade"+i).attr('id')
 				grade = grade.substring(5)
 				break;
 			};
		}
 		//리뷰별점 몇인지 뽑아오는부분
 		for (var i =1; i <= 5; i++) {
 			if($("#star"+i).attr('style')=="background-color: #00AEF0 opacity:0.8;"){
 				star = $("#star"+i).attr('id')
 				star = star.substring(4)
 				break;
 			};
		}
 		
    	for (var i = 0; i < circle.length; i++) {
	    	circle[i].setMap(null);
	    	circle.shift();
		}
    	let templist= new Array(); 
		checklist(templist)
    	if($(this).val()=="none"){
    		list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star,aname)
    	}else{
    	makeCircle(locationmap,locationmarker.getPosition(),$(this).val());
		list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[0]],locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[2]],$(this).val(),grade,star,aname);
    	}
		
    })
    
	//지도로 보기 클릭시 효과 -지영
	$("#gomap").click(function() {
		let grade;
		let star;
		//성급 몇인지 뽑아오는부분
 		for (var i =1; i <= 5; i++) {
 			if($("#grade"+i).attr('style')=="background-color: #00AEF0; opacity:0.8;"){
 				grade = $("#grade"+i).attr('id')
 				grade = grade.substring(5)
 				break;
 			};
		}
 		//리뷰별점 몇인지 뽑아오는부분
 		for (var i =1; i <= 5; i++) {
 			if($("#star"+i).attr('style')=="background-color: #00AEF0; opacity:0.8;"){
 				star = $("#star"+i).attr('id')
 				star = star.substring(4)
 				break;
 			};
		}
	  if($("#gomap").html()=="지도로 보기"){
		  $("#gomap").html("돌아가기")
		  $("#location").attr('class','collapse')
		  $("#list").empty();
		  
		  let html = "<div id='gomapchange' style='width:100%; height:1050px;'></div>";
		  $("#list").append(html);
		  let templist= new Array(); 
		  checklist(templist)
		  gomapchange(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star)
		}else{
	    	  $("#gomap").html("지도로 보기")
	    	  $("#location").attr('class','collapse show')
			  $("#list").empty();
	    	  let templist= new Array(); 
			  checklist(templist)
			  if($("#locationamount").val()!="none"){
				  list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[0]],locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[2]],$("#locationamount").val(),grade,star,aname)
			  }else{
				  list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star,aname);
			  }
	  	}
	})
 	
 	//전체 정렬
	$("#sort").change(function(){
		let sort = $(this).val();
		let templist = new Array();
		checklist(templist)
 		callList()
	})
	
   	// 평점 div박스
  	$(".star_section_field").click(function(){
		let restar = $(this).attr("id");
		$(this).siblings().attr('style','background-color: none');
		for (var i =0; i <= 5-restar.substring(4); i++) {
			$("#star"+(Number(restar.substring(4))+i)).attr('style','background-color: #00AEF0; opacity:0.8;');
		}
	 	callList()
	});
   	
	// 성급 div박스
 	$(".grade_section_field").click(function(){
		let agrade = $(this).attr("id");
		$(this).siblings().attr('style','background-color: none');
		for (var i =0; i <= 6-agrade.substring(5); i++) {
			$("#grade"+(Number(agrade.substring(5))+i)).attr('style','background-color: #00AEF0; opacity:0.8;');
		}
		callList();
	});		
  		
  	//슬라이더 관련 실행
	slider(${minmax.minsum},${minmax.maxsum})
    $('#count_min').change(function(){
    	$('#slider').slider('values',0,$(this).val());
   	})
   	$('#count_max').change(function(){
    	$('#slider').slider('values',1,$(this).val());
   	})
});

//가격 range slider -지윤
function slider(minsum,maxsum){
 $('#slider').slider({
     orientation:'horizontal',
      min:Number(minsum),
      max:Number(maxsum),
      step:10000,
      range:true,
      values:[minsum,maxsum],
      create:function(e, ui){ //text 박스에 value값 나타냄
          $('#count_min').val(minsum);
          $('#count_max').val(maxsum);
      },
      change:function(e,ui){ //value 가 change 되었을 때
          $('#count_min').val(ui.values[0]);
          $('#count_max').val(ui.values[1]);
          
  		let minprice=$("#count_min").val();
  		let maxprice=$("#count_max").val();
  		
  		$("#accommList").empty();
  		
  		callList();
      }
      
      
  });
}

//조건에 따른 list내역(지도로보기,리스트보기) 호출을 위한 반복function
function callList(){
	let grade;
	let star;
	let templist= new Array(); 
	checklist(templist);
	//성급 몇인지 뽑아오는부분
		for (var i =1; i <= 5; i++) {
			if($("#grade"+i).attr('style')=="background-color: #00AEF0; opacity:0.8;"){
				grade = $("#grade"+i).attr('id')
				grade = grade.substring(5)
				break;
			};
	}
		//리뷰별점 몇인지 뽑아오는부분
		for (var i =1; i <= 5; i++) {
			if($("#star"+i).attr('style')=="background-color: #00AEF0; opacity:0.8;"){
				star = $("#star"+i).attr('id')
				star = star.substring(4)
				break;
			};
	}
	//인근반경 거리가 상관없음이 아닐때
	if($("#locationamount").val()!="none"){
		//지도로보기로 지도가 펼쳐져 있을때				
	 	if($("#gomap").html()=="돌아가기"){
			gomapchange(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star,aname)
		//리스트가 나올때				
	 	}else{
			list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[0]],locationmarker.getPosition()[Object.keys(locationmarker.getPosition())[2]],$("#locationamount").val(),grade,star,aname)
	 	}
	}else{
		if($("#gomap").html()=="돌아가기"){
			gomapchange(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star,aname)
	 	}else{
			list(templist,$("#count_min").val(),$("#count_max").val(),$("#sort").val(),null,null,null,grade,star,aname)
	 	}
	}
}


//지도로 보기 ajax받아와서 뿌려주기 -지영
function gomapchange(facilities,minprice,maxprice,sort,axcoordi,aycoordi,distance,agrade,restar){
	  let gomapchange = new naver.maps.Map('gomapchange', {
          center: new naver.maps.LatLng(ycoordi, xcoordi),
          zoom: 14
      })
	var latlngs = [];
    var contentString=[];
    var fac = "";
    for (var i = 0; i < facilities.length; i++) {
		fac+=facilities[i];
		if(i !=facilities.length-1){
			fac+=",";
		}
	}
	  $.ajax({
			url:"${pageContext.request.contextPath }/hjy/firstsearchajax",
			 async: false,
			 data:{"searchHotel":"${aaddress }","checkin":"${rcheckin }","checkout":"${rcheckout }","countRoom":"${countRoom }","countPeople":"${rimaxper}",
					"fac":fac,"minprice":minprice,"maxprice":maxprice,"sort":sort,"xcoordi":xcoordi,"ycoordi":ycoordi,"distance":distance,"restar":restar,"agrade":agrade,"autoaname":aname},
			type:"get",
			dataType:"json",
			success:function(data){
				if(data.code=='success'){
		        	for (var i = 0; i < data.list.length; i++) {
		        		let star="";
						if(data.list[i].restar == 5){
							star = "★★★★★";
						}else if(data.list[i].restar == 4){
							star="★★★★☆";
						}else if(data.list[i].restar == 3){
							star="★★★☆☆";
						}else if(data.list[i].restar == 2){
							star = "★★☆☆☆";
						}else if(data.list[i].restar == 1){
							star = "★☆☆☆☆";
						}else if(data.list[i].restar == 0){
							star="☆☆☆☆☆";
						}
		        		if(data.list[i].axcoordi>100){
							let listxy = changeXY(data.list[i].axcoordi,data.list[i].aycoordi);
							latlngs.push(new naver.maps.LatLng(listxy[0], listxy[1]));
		        		}else{
							latlngs.push(new naver.maps.LatLng(data.list[i].axcoordi, data.list[i].aycoordi));
		        		}
						if(data.list[i].amainimg==null){
							  let html = '<div class="iw_inner" style="padding:3px;">'+'<h5>'+star+'</h5>'+'<h3>'+data.list[i].aname+'</h3>'+'<h5>';
		    		          if(data.list[i].agrade!=null){
			    		          html+=data.list[i].agrade+'성급</h5>'
		    		          }
		    		          html+='<p>'+data.list[i].aaddress
		    		          +'<br> <img src="${pageContext.request.contextPath }/resources/images/accommodations/220i0z000000mulfw433F_Z_1080_808_R5_D.jpg" width="300" height="250" /><br>'
		    		          +'전화번호: '+data.list[i].aphone+' | 가격: '+data.list[i].amountsum+'원<br/>'
		    		          +"<br><button class='btn btn-outline-primary' onclick=\""
							  +"location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid="+data.list[i].aid+"&riid="+data.list[i].riid
							  +"&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}+endday=${rcheckout}'\">예약하기</button>"
							  +'</p></div>'
							contentString.push(html)
					   }else{
						   let html = '<div class="iw_inner"style="padding:3px;">'+'<h5>'+star+'</h5>'+'<h3>'+data.list[i].aname+'</h3>'+'<h5>';
						   if(data.list[i].agrade!=null){
			    		          html+=data.list[i].agrade+'성급</h5>'
		    		          }
						   html+='<p>'+data.list[i].aaddress
		    		          +'<br /> <img src="${pageContext.request.contextPath }/resources/images/accommodations/'+data.list[i].amainimg+'"width="300" height="250"/><br />'
		    		          +'<br>전화번호: '+data.list[i].aphone+' <br><br> 가격: '+data.list[i].amountsum+'원<br/>'
		    		          +"<br><button class='btn btn-outline-primary' onclick=\""
							  +"location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid="+data.list[i].aid+"&riid="+data.list[i].riid
							  +"&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}&endday=${rcheckout}'\">예약하기</button>"
							  +'</p></div>'
						   contentString.push(html)
						   }
    		        	}
					}
				}
		  })	

		  var markerList = [];
		  for (var i=0, ii=latlngs.length; i<ii; i++) {
	          let marker = new naver.maps.Marker({
	              position: latlngs[i],
	              map: gomapchange
	          });
	          marker.set('seq', i);
	          
		      markerList.push(marker);
		      
		      marker.addListener('click', marckerClick);
		      
		      marker = null;
	  }

	  function marckerClick(e){
		  var marker = e.overlay;
	      seq = marker.get('seq');
	      var infowindow = new naver.maps.InfoWindow({
		      content: contentString[seq],
		      maxWidth: 200,
		      backgroundColor: "#eee",
		      borderColor: "#00AEF0",
		      borderWidth: 5,
		      anchorSize: new naver.maps.Size(30, 30),
		      anchorSkew: true,
		      anchorColor: "#eee",
		      pixelOffset: new naver.maps.Point(20, -20)
		  	});
	      
		  if (infowindow.getMap()) {
	          infowindow.close();
	      } else {
	          infowindow.open(gomapchange, marker);
	      }
	  }  
 }

//선호호텔체인,부대시설,무료시설 체크박스 선택되어있는지 체크해주는 function -지영
function checklist(templist){
	$("#facilities input").each(function(){
		if( $(this).is(":checked") == true ){
	      	var temId = $(this).attr('id');
	      	templist.push(temId);
		}
		});
	$("#forFree input").each(function(){
		if( $(this).is(":checked") == true ){
	      	var temId = $(this).attr('id');
	      	templist.push(temId);
		}
		});
	$("#favorite input").each(function(){
		if( $(this).is(":checked") == true ){
	      	var temId = $(this).attr('id');
	      	templist.push(temId);
		}
		});
}

//좌표(X,Y) 위도경도로 변환함수 -지영
function changeXY(xcoordi,ycoordi){
	let xy=[];
	if(xcoordi*1>100){
		// point array 1
	    var point1 = [xcoordi*1, ycoordi*1]
	    var firstProjection = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs"; // from
	    var secondProjection = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"; // to
	   
	    // #1. 변환한 위도 경도 값 저장
	    var lonAndLat1 = proj4(firstProjection, secondProjection, point1);// from 경위도
		xy.push(lonAndLat1[1])
		xy.push(lonAndLat1[0])
		console.log('변환계 사용')
	}else{
		xy.push(xcoordi)
		xy.push(ycoordi)
		console.log('변환계 사용안함')
	}
	return xy;
}

//위도 경도를 통해 거리 구하는 함수 -지영
function isdistancein(coords1, coords2) {
	var isdistanceinlat1 = coords1[0];
	var isdistanceinlon1 = coords1[1];
	var isdistanceinlat2 = coords2[0];
	var isdistanceinlon2 = coords2[1];
	function deg2rad(deg) {
	    return deg * (Math.PI/180)
	}
	var r = 6371; //지구의 반지름(km)
	var dLat = deg2rad(isdistanceinlat2-isdistanceinlat1);
	var dLon = deg2rad(isdistanceinlon2-isdistanceinlon1);
	var a = Math.sin(dLat/2) * Math.sin(dLat/2) + 
	Math.cos(deg2rad(isdistanceinlat1)) * Math.cos(deg2rad(isdistanceinlat2)) * 
	Math.sin(dLon/2) * Math.sin(dLon/2);
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
	var d = r * c; // Distance in km
	return Math.round(d*1000);
}

//위의 검색조건,왼쪽 검색조건에 맞는 list뽑아주기 ajax
function list(facilities,minprice,maxprice,sort,xcoordi,ycoordi,distance,agrade,restar){
	let changecnt=0;
   $.ajax({
		url:"${pageContext.request.contextPath }/hjy/firstsearchajax",
		traditional :true,
		data:{"searchHotel":"${aaddress }","checkin":"${rcheckin }","checkout":"${rcheckout }","countRoom":"${countRoom }","countPeople":"${rimaxper}",
			"facilities":facilities,"minprice":minprice,"maxprice":maxprice,"sort":sort,"xcoordi":xcoordi,"ycoordi":ycoordi,"distance":distance,"restar":restar,"agrade":agrade,"autoaname":aname},
		type:"post",
		dataType:"json",
		success:function(data){
			if(data.code=='success'){
			   $("#list").empty();
			   if(data.list.length==0){
				   $("#list").html("<div style='text-align: center;'><img style='width:200px;height:200px;'src = 'https://content.r9cdn.net/res/images/horizon/hotels/results/brands/hotelscombined/max-magnifying-glass.png?v=2ce4b5af1d8bd19e6264dabe7ceb3c51793b5f87&cluster=5'><br><Br><h3>조건에 맞는 호텔이 없습니다</h3></div>");
			   }else{
				   for (var i = 0; i < data.list.length; i++) {
					   let html = "";
					   //xcoordi값이 있을때
					   if(xcoordi){
						   	let testxy = changeXY(data.list[i].axcoordi,data.list[i].aycoordi)
						   //기준좌표
						   	let refcoordi = [xcoordi, ycoordi];
						   //db에서 불러온 좌표
							dbcoordi = [testxy[0],testxy[1]];
							console.log("숙소이름: "+data.list[i].aname);
							console.log("두개사이의 거리: "+isdistancein(refcoordi, dbcoordi),"m");
							console.log("distance: "+distance)
							if(isdistancein(refcoordi, dbcoordi)<=distance){
								   	html+="<div class='row mb-3'>";
									html+="<div class='col-md-12'>";
									html+="<div class='card'>";
									html+="<div class='card-body'>";
									html+="<div class='row'>";
									html+="<div class='col-md-3'>";
									if(data.list[i].amainimg==null){
										html+="<img src='${pageContext.request.contextPath }/resources/images/accommodations/220i0z000000mulfw433F_Z_1080_808_R5_D.jpg' width='300' height='250'>";
									}else{
										html+="<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+data.list[i].amainimg+"'width='300' height='250'>";
									}
									html+="</div>";
									html+="<div class='col-md-6'>";
									html+="<h3>"+data.list[i].aname+"</h3>";
									html+="<small>"+data.list[i].aaddress+"</small>";
									html+="<div id='map"+changecnt+"' style='width: 200px; height: 200px;'>지도넣기"
									html+="<input type='hidden' id='axcoordi"+changecnt+"' value="+data.list[i].axcoordi+">";
									html+="<input type='hidden' id='aycoordi"+changecnt+"' value="+data.list[i].aycoordi+">";
									html+="</div>";
									html+="</div>";
									html+="<div class='col-md-3' style='padding-left: 70px;'>";
									if(data.list[i].agrade !=null){
										html+="<h5>"+data.list[i].agrade+"성급</h5>";
									}
									html+="<h5>";
									if(data.list[i].restar==5){
										html+="★★★★★";
									}else if(data.list[i].restar==4){
										html+="★★★★☆";
									}else if(data.list[i].restar==3){
										html+="★★★☆☆";
									}else if(data.list[i].restar==2){
										html+="★★☆☆☆";
									}else if(data.list[i].restar==1){
										html+="★☆☆☆☆";
									}else{
										html+="☆☆☆☆☆";
									}
									html+="</h5>";
									html+="<h4>"+data.list[i].amountsum+"원</h4>";
									html+="<button class='btn btn-outline-primary' onclick=\"";
									html+="location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid="+data.list[i].aid+"&riid="+data.list[i].riid+
											+"&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}&endday=${rcheckout}"
									html+="'\">예약하기</button>";
									html+="</div>";
									html+="</div>";
									html+="</div>";
									html+="</div>";
									html+="</div>";
									html+="</div>";
									changecnt++;
							   }
				   			}else{
								html+="<div class='row mb-3'>";
								html+="<div class='col-md-12'>";
								html+="<div class='card'>";
								html+="<div class='card-body'>";
								html+="<div class='row'>";
								html+="<div class='col-md-3'>";
								if(data.list[i].amainimg==null){
									html+="<img src='${pageContext.request.contextPath }/resources/images/accommodations/220i0z000000mulfw433F_Z_1080_808_R5_D.jpg' width='300' height='250'>";
								}else{
									html+="<img src='${pageContext.request.contextPath }/resources/images/accommodations/"+data.list[i].amainimg+"'width='300' height='250'>";
								}
								html+="</div>";
								html+="<div class='col-md-6'>";
								html+="<h3>"+data.list[i].aname+"</h3>";
								html+="<small>"+data.list[i].aaddress+"</small>";
								html+="<div id='map"+i+"' style='width: 200px; height: 200px;'>지도넣기"
								html+="<input type='hidden' id='axcoordi"+i+"' value="+data.list[i].axcoordi+">";
								html+="<input type='hidden' id='aycoordi"+i+"' value="+data.list[i].aycoordi+">";
								html+="</div>";
								html+="</div>";
								html+="<div class='col-md-3'style='padding-left: 70px;'>";
								if(data.list[i].agrade !=null){
									html+="<h5>"+data.list[i].agrade+"성급</h5>";
								}
								html+="<h5>"
								if(data.list[i].restar==5){
									html+="★★★★★"
								}else if(data.list[i].restar==4){
									html+="★★★★☆"
								}else if(data.list[i].restar==3){
									html+="★★★☆☆"
								}else if(data.list[i].restar==2){
									html+="★★☆☆☆"
								}else if(data.list[i].restar==1){
									html+="★☆☆☆☆"
								}else{
									html+="☆☆☆☆☆"
								}
								html+="</h5>"
								html+="<h4>"+data.list[i].amountsum+"원</h4>";
								html+="<button class='btn btn-outline-primary' onclick=\"";
								html+="location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid="+data.list[i].aid+"&riid="+data.list[i].riid;
								html+="&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}&endday=${rcheckout}"
								html+="'\">예약하기</button>";
								html+="</div>";
								html+="</div>";
								html+="</div>";
								html+="</div>";
								html+="</div>";
								html+="</div>";
						   	}
					   $("#list").append(html);
				   }
			   }
				    if(changecnt!=0){
					    for (var i = 0; i < changecnt; i++) {
					  		mainMapList(i);
					   	}
					}else{
						for (var i = 0; i < data.list.length; i++) {
						    mainMapList(i);
						}
				   	}
				}else{
					alert("fail")
				}
			}
		})
	}

//db에 받아온 주소를 좌표로 변환해서 xcoordi, ycoordi에 저장하기+왼쪽 거리검색의 센터를 해당 좌표로 지정 -지영
function searchAddressToCoordinate(address) {
	naver.maps.Service.geocode({
	  query: address
	}, function(status, response) {
	  if (status === naver.maps.Service.Status.ERROR) {
	    if (!address) {
	      return alert('Geocode Error, Please check address');
	    }
	    return alert('Geocode Error, address:' + address);
	  }
/*
	  if (response.v2.meta.totalCount === 0) {
	    return alert('검색결과가 없습니다.');
	  }
*/
	  var htmlAddresses = [],
	    item = response.v2.addresses[0],
	    point = new naver.maps.Point(item.x, item.y);
	    xcoordi = item.x;
	    ycoordi = item.y;
	  if (item.roadAddress) {
	    htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	  }
	  if (item.jibunAddress) {
	    htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	  }
	  if (item.englishAddress) {
	    htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	  }
	locationmap.setCenter(point);
	});
}

//찍힌 좌표와 선택한 반경에 따라 원 그려주기 -지영
function makeCircle(locationmap,locationposition,size){
circle.push(
	new naver.maps.Circle({
        map: locationmap,
        center: locationposition,
        radius: size,//m단위의 반지름 입력
        fillColor: '#00AEF0',
        fillOpacity: 0.8
    })
);
}

//리스트에 호텔 위치에 맞는 지도 표시하기 -지영
function mainMapList(index){
	var mainmaplist = new Array();
	mainmaplist.push(index);
	if($("#axcoordi"+index).val()*1>100){
	    // point array 1
	    var point1 = [$("#axcoordi"+index).val()*1, $("#aycoordi"+index).val()*1]
	    var firstProjection = "+proj=tmerc +lat_0=38 +lon_0=127 +k=1 +x_0=200000 +y_0=500000 +ellps=bessel +units=m +no_defs"; // from
	    var secondProjection = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"; // to
	   
	    // #1. 변환한 위도 경도 값 저장
	    var lonAndLat1 = proj4(firstProjection, secondProjection, point1);// from 경위도
		
		var mainmap = new naver.maps.Map('map'+index, {
		   center: new naver.maps.LatLng(lonAndLat1[1], lonAndLat1[0]),
		    zoom: 15
		});
		
		var testmarker = new naver.maps.Marker({
		    position: new naver.maps.LatLng(lonAndLat1[1],lonAndLat1[0]),
		    map: mainmap
		});
	}
	else{
		var hotelDetailMap = new naver.maps.Map('map'+index, {
		    center: new naver.maps.LatLng($("#axcoordi"+index).val(), $("#aycoordi"+index).val()),
		    zoom: 15
		});
	
		var hotelDetailmarker = new naver.maps.Marker({
		    position: new naver.maps.LatLng($("#axcoordi"+index).val(), $("#aycoordi"+index).val()),
		    map: hotelDetailMap
		});
	}
}
//체크인 날짜이동
function inMoveBefore(){ //버튼 클릭시 하루 전날로 이동
	let date = new Date($("#checkin").val());
	//console.log(date);
	let year = date.getFullYear();
	let month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
	let day = (date.getDate()-1) > 9 ? (date.getDate()-1) : '0' + (date.getDate()-1);
	//console.log(year + month + day);
	$("#checkin").val(year + "-" + month + "-" + day);	
}
function inMoveAfter(){ //버튼 클릭시 다음날로 이동
	let date = new Date($("#checkin").val());
	//console.log(date);
	let iyear = date.getFullYear();
	let imonth = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
	let idate = (date.getDate()+1) > 9 ? (date.getDate()+1) : '0' + (date.getDate()+1);
	//console.log(ye + mo + da);
	$("#checkin").val(iyear + "-" + imonth + "-" + idate);	
}
//체크아웃 날짜이동
function outMoveBefore(){ //버튼 클릭시 하루 전날로 이동
	let date = new Date($("#checkout").val());
	let year = date.getFullYear();
	let month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
	let day = (date.getDate()-1) > 9 ? (date.getDate()-1) : '0' + (date.getDate()-1);
	$("#checkout").val(year + "-" + month + "-" + day);	
}

function outMoveAfter(){ //버튼 클릭시 다음날로 이동
	let date = new Date($("#checkout").val());
	//console.log(date);
	let oyear = date.getFullYear();
	let omonth = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
	let odate = (date.getDate()+1) > 9 ? (date.getDate()+1) : '0' + (date.getDate()+1);
	//console.log(oyear + omonth + odate);
	$("#checkout").val(oyear + "-" + omonth + "-" + odate);
}
</script>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/user/jhr/header.jsp" flush="true"/>
	</div>
	<!--filter section-->
	<div style='position: absolute; left: 50%; margin-left: -765px;'>
		<div class="search">
			<div class="search_container">
				<form class="search_content" style='width: 1150px;' method="post"
					action="${pageContext.request.contextPath }/lhjcjyhjy/firstsearch">
					<div class="search_insert">
						<div class="search_insert_container">
							<div class="search_insert_content">
								<div class="search_insert_city">
									<div class="search_city_display">
										<svg viewBox="0 0 20 21">
												<path fill-rule="evenodd" clip-rule="evenodd"
												d="M8.31529 16.2594C4.18311 16.2594 0.833313 12.9096 0.833313 8.77745C0.833313 4.64527 4.18311 1.29547 8.31529 1.29547C12.4475 1.29547 15.7973 4.64527 15.7973 8.77745C15.7973 10.5759 15.1628 12.2261 14.1054 13.5165L18.949 18.36C19.2392 18.6503 19.2392 19.1209 18.949 19.4111C18.6587 19.7014 18.1881 19.7014 17.8979 19.4111L13.0543 14.5676C11.7639 15.6249 10.1137 16.2594 8.31529 16.2594ZM12.5286 13.0429C11.4458 14.1126 9.95766 14.7729 8.31529 14.7729C5.00407 14.7729 2.3198 12.0887 2.3198 8.77745C2.3198 5.46623 5.00407 2.78195 8.31529 2.78195C11.6265 2.78195 14.3108 5.46623 14.3108 8.77745C14.3108 10.4198 13.6504 11.908 12.5807 12.9908C12.5716 12.999 12.5628 13.0075 12.554 13.0162C12.5453 13.0249 12.5368 13.0338 12.5286 13.0429Z"
												fill="#4E4E4E"></path>
											</svg>
										<div class="city_text_wrap">
											<div class="city_text">
												<input type="text" id="searchHotel" name="searchHotel"
													value="${aaddress }" />
											</div>
										</div>
									</div>
								</div>
								<div class="search_insert_date">
									<div class="search_date_display">
										<div class="date_check">
											<div class="date_text">
												<svg viewBox="0 0 20 21">
														<path fill-rule="evenodd" clip-rule="evenodd"
														d="M14.5952 3.67643H18.381C18.8149 3.67643 19.1667 4.04952 19.1667 4.50976V7.68436V18.7955C19.1667 19.2557 18.8149 19.6288 18.381 19.6288H1.61905C1.18511 19.6288 0.833333 19.2557 0.833333 18.7955V7.68436V4.50976C0.833333 4.04952 1.18511 3.67643 1.61905 3.67643H5.40476V2.1288C5.40476 1.66857 5.75654 1.29547 6.19048 1.29547C6.62441 1.29547 6.97619 1.66857 6.97619 2.1288V3.67643H13.0238V2.1288C13.0238 1.66857 13.3756 1.29547 13.8095 1.29547C14.2435 1.29547 14.5952 1.66857 14.5952 2.1288V3.67643ZM2.40476 8.51769V17.9621H17.5952V8.51769H2.40476ZM17.5952 6.85102H2.40476V5.34309H17.5952V6.85102ZM4.66667 10.0256H6.19048C6.62441 10.0256 6.97619 10.3987 6.97619 10.859V11.6526C6.97619 12.1129 6.62441 12.4859 6.19048 12.4859H4.66667C4.23273 12.4859 3.88095 12.1129 3.88095 11.6526V10.859C3.88095 10.3987 4.23273 10.0256 4.66667 10.0256ZM9.2381 10.0256H10.7619C11.1958 10.0256 11.5476 10.3987 11.5476 10.859V11.6526C11.5476 12.1129 11.1958 12.4859 10.7619 12.4859H9.2381C8.80416 12.4859 8.45238 12.1129 8.45238 11.6526V10.859C8.45238 10.3987 8.80416 10.0256 9.2381 10.0256ZM6.97619 14.8272C6.97619 14.367 6.62441 13.9939 6.19048 13.9939H4.66667C4.23273 13.9939 3.88095 14.367 3.88095 14.8272V15.6209C3.88095 16.0811 4.23273 16.4542 4.66667 16.4542H6.19048C6.62441 16.4542 6.97619 16.0811 6.97619 15.6209V14.8272ZM10.7619 13.9939C11.1958 13.9939 11.5476 14.367 11.5476 14.8272V15.6209C11.5476 16.0811 11.1958 16.4542 10.7619 16.4542H9.2381C8.80416 16.4542 8.45238 16.0811 8.45238 15.6209V14.8272C8.45238 14.367 8.80416 13.9939 9.2381 13.9939H10.7619ZM15.3333 10.0256H13.8095C13.3756 10.0256 13.0238 10.3987 13.0238 10.859V11.6526C13.0238 12.1129 13.3756 12.4859 13.8095 12.4859H15.3333C15.7673 12.4859 16.119 12.1129 16.119 11.6526V10.859C16.119 10.3987 15.7673 10.0256 15.3333 10.0256Z"
														fill="#4E4E4E"></path>
													</svg>
												<div class="date_innertext">
													<input type="date" id="checkin" name="checkin"
														value="${rcheckin }">
												</div>
											</div>
											<button class="date_btn_before" type="button"
												onclick="inMoveBefore()">
												<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor"
														fill="none" style="user-select: auto;"></path>
													</svg>
											</button>
											<button class="date_btn_after" type="button"
												onclick="inMoveAfter()">
												<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor"
														fill="none" style="user-select: auto;"></path>
													</svg>
											</button>
										</div>
										<div class="date_sep"></div>
										<div class="date_check">
											<div class="date_text">
												<svg viewBox="0 0 20 21">
														<path fill-rule="evenodd" clip-rule="evenodd"
														d="M14.5952 3.67643H18.381C18.8149 3.67643 19.1667 4.04952 19.1667 4.50976V7.68436V18.7955C19.1667 19.2557 18.8149 19.6288 18.381 19.6288H1.61905C1.18511 19.6288 0.833333 19.2557 0.833333 18.7955V7.68436V4.50976C0.833333 4.04952 1.18511 3.67643 1.61905 3.67643H5.40476V2.1288C5.40476 1.66857 5.75654 1.29547 6.19048 1.29547C6.62441 1.29547 6.97619 1.66857 6.97619 2.1288V3.67643H13.0238V2.1288C13.0238 1.66857 13.3756 1.29547 13.8095 1.29547C14.2435 1.29547 14.5952 1.66857 14.5952 2.1288V3.67643ZM2.40476 8.51769V17.9621H17.5952V8.51769H2.40476ZM17.5952 6.85102H2.40476V5.34309H17.5952V6.85102ZM4.66667 10.0256H6.19048C6.62441 10.0256 6.97619 10.3987 6.97619 10.859V11.6526C6.97619 12.1129 6.62441 12.4859 6.19048 12.4859H4.66667C4.23273 12.4859 3.88095 12.1129 3.88095 11.6526V10.859C3.88095 10.3987 4.23273 10.0256 4.66667 10.0256ZM9.2381 10.0256H10.7619C11.1958 10.0256 11.5476 10.3987 11.5476 10.859V11.6526C11.5476 12.1129 11.1958 12.4859 10.7619 12.4859H9.2381C8.80416 12.4859 8.45238 12.1129 8.45238 11.6526V10.859C8.45238 10.3987 8.80416 10.0256 9.2381 10.0256ZM6.97619 14.8272C6.97619 14.367 6.62441 13.9939 6.19048 13.9939H4.66667C4.23273 13.9939 3.88095 14.367 3.88095 14.8272V15.6209C3.88095 16.0811 4.23273 16.4542 4.66667 16.4542H6.19048C6.62441 16.4542 6.97619 16.0811 6.97619 15.6209V14.8272ZM10.7619 13.9939C11.1958 13.9939 11.5476 14.367 11.5476 14.8272V15.6209C11.5476 16.0811 11.1958 16.4542 10.7619 16.4542H9.2381C8.80416 16.4542 8.45238 16.0811 8.45238 15.6209V14.8272C8.45238 14.367 8.80416 13.9939 9.2381 13.9939H10.7619ZM15.3333 10.0256H13.8095C13.3756 10.0256 13.0238 10.3987 13.0238 10.859V11.6526C13.0238 12.1129 13.3756 12.4859 13.8095 12.4859H15.3333C15.7673 12.4859 16.119 12.1129 16.119 11.6526V10.859C16.119 10.3987 15.7673 10.0256 15.3333 10.0256Z"
														fill="#4E4E4E"></path>
													</svg>
												<div class="date_innertext">
													<input type="date" id="checkout" name="checkout"
														value="${rcheckout }">
												</div>
											</div>
											<button class="date_btn_before" type="button"
												onclick="outMoveBefore()">
												<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor"
														fill="none" style="user-select: auto;"></path>
													</svg>
											</button>
											<button class="date_btn_after" type="button"
												onclick="outMoveAfter()">
												<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor"
														fill="none" style="user-select: auto;"></path>
													</svg>
											</button>
										</div>
									</div>
								</div>
							</div>
							<div class="search_insert_countRoom">
								<div class="search_room_display">
									<svg viewBox="394.5 418.584 212 206.25">
				                           <path d="M600.116,503.301l-88.955-77.062c-0.298-0.254-0.656-0.472-1.059-0.639c-5.693-4.32-13.557-4.119-19.049,0.639
											l-88.956,77.053c-6.376,5.519-7.181,15.313-1.784,21.839c3.411,4.128,9.069,4.075,13.408,3.2v82.834
											c0,6.253,5.02,11.344,11.195,11.344h53.586c2.414,0,4.374-1.96,4.374-4.373v-72.242h36.471v72.242c0,2.413,1.959,4.373,4.372,4.373
											h53.587c6.175,0,11.195-5.091,11.195-11.344v-82.834c4.355,0.857,9.996,0.919,13.407-3.2
											C607.297,518.606,606.492,508.802,600.116,503.301z M595.166,519.551c-0.9,1.058-5.563,0.48-9.288-1.146
											c-1.355-0.595-2.93-0.454-4.146,0.351c-1.233,0.805-1.985,2.187-1.985,3.655v88.746c0,1.435-1.103,2.598-2.449,2.598h-49.214
											v-72.242c0-2.414-1.959-4.373-4.373-4.373h-45.217c-2.414,0-4.373,1.959-4.373,4.373v72.242h-49.214
											c-1.347,0-2.449-1.163-2.449-2.598V522.41c0-1.478-0.744-2.859-1.985-3.664c-1.233-0.796-2.799-0.919-4.155-0.342
											c-3.306,1.461-8.334,2.283-9.279,1.138c-2.388-2.887-2.046-7.207,0.77-9.647l88.956-77.061c2.432-2.099,5.956-2.099,8.388,0
											c0.314,0.28,0.674,0.507,1.05,0.674l88.186,76.405C597.213,512.344,597.553,516.664,595.166,519.551L595.166,519.551z"/>
				                        </svg>
									<div class="room_text_wrap">
										<div class="room_text">
											<!--  
												<div id="content_bt">
											    	<input type="button" onclick="showID('content');" id="ttt" value="인원수,객실수">
											        <div id="content" style="display:none;">
													   인원수 <input type="number" min="1" id="countPeople"><br>
												       객실수 <input type="number" min="1" id="countRoom">
											    	</div>
											    </div>								    	 
										   		-->
											<input type="number" min="1" id="countRoom" name="countRoom"
												value="${countRoom }" />
										</div>
									</div>
								</div>
							</div>
							<div class="search_insert_countPeople">
								<div class="search_people_display">
									<svg viewBox="0 0 200 200">
				                           <path
											d="M160.6 180H39.4c-1.6 0-3.2-.8-4.1-2.1c-8-11.5-6.8-32.8 2.2-41.5c3.9-3.8 23.8-10.5 35.6-14C58.8 108.1 50 95.4 50 70.9C50 38.6 68.2 20 100 20s50 18.6 50 50.9c0 23.8-8.2 36.7-23.1 51.5c11.8 3.5 31.6 10.2 35.6 14c9.1 8.7 10.3 30 2.3 41.5c-1 1.3-2.6 2.1-4.2 2.1zM42.3 170h115.5c4-8.3 2.4-21.8-2.1-26.3c-3.6-2.8-31.2-12.1-38.9-13.8c-3.5-.8-5.1-4.9-3-7.8c7.9-10.8 26.3-19.2 26.3-51.2c0-18.7-6.9-40.9-40-40.9S60 52.2 60 70.9c0 31.9 18.4 40.3 26.3 51.2c2.1 2.9.5 7.1-3 7.8c-7.7 1.6-35.3 10.9-38.9 13.7c-4.6 4.5-6.1 18.1-2.1 26.4zm2.2-26.4z" />
				                        </svg>
									<div class="people_text_wrap">
										<div class="people_text">
											<input type="number" min="1" id="countPeople"
												name="countPeople" value="${rimaxper }" />
										</div>
									</div>
								</div>
							</div>
							<div class="search_insert_button_container">
								<button class="search_insert_button" type="submit" id="search">
									<span class="search_icon_container"> <span
										class="search_icon"> <svg viewBox="0 0 92 92">
													<path
													d="M20.8 39.27c0-11.016 8.808-19.976 19.637-19.976 10.827 0 19.635 8.96 19.635 19.972 0 11.014-8.808 19.976-19.635 19.976-10.83 0-19.64-8.96-19.64-19.976zm55.472 32.037l-15.976-16.25c3.357-4.363 5.376-9.835 5.376-15.788 0-14.16-11.32-25.67-25.232-25.67-13.923 0-25.24 11.51-25.24 25.67s11.32 25.67 25.237 25.67c4.776 0 9.227-1.388 13.04-3.74L69.84 77.85c1.77 1.8 4.664 1.8 6.432 0 1.77-1.8 1.77-4.744 0-6.544z"
													fill="currentColor" style="user-select: auto;"></path>
												</svg>
									</span>
									</span>
								</button>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<!--main content section-->
	<section class="mb-5">
		<div class="container">
			<div class="row title py-3">
				<div class="col-md-12">
					<h5>
						<strong>검색결과</strong>
					</h5>
					<select name="sort" id="sort">
						<option value="all">전체</option>
						<option value="price_low">가격(낮은순)</option>
						<option value="price_high">가격(높은순)</option>
						<option value="star">평점</option>
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3">
					<div class="row mb-3">
						<div class="col-md-12">
							<div class="card">
								<div id="accordion">
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse" data-target="#mapshow"
												aria-expanded="true">지도</button>
										</h2>
									</div>
									<div id="mapshow" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li>
													<button id="gomap" class="btn btn-outline-primary">지도로 보기</button>
												</li>
											</ul>
										</div>

									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse" data-target="#favorite"
												aria-expanded="true">즐겨찾기</button>
										</h2>
									</div>
									<div id="favorite" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li><input type="checkbox" id="즐겨찾기">
													선호호텔체인</li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse"
												data-target="#hotelGrades" aria-expanded="true">
												호텔등급</button>
										</h2>
									</div>
									<div id="hotelGrades" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li>
													<div class="grade_section" style='padding-left: 20px;'>
														<div class="grade_section_field" id="grade1">1+</div>
														<div class="grade_section_field" id="grade2">2+</div>
														<div class="grade_section_field" id="grade3">3+</div>
														<div class="grade_section_field" id="grade4">4+</div>
														<div class="grade_section_field" id="grade5">5</div>
													</div>
													<br>
												</li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse"
												data-target="#costomgrade" aria-expanded="true">
												고객평점</button>
										</h2>
									</div>
									<div id="costomgrade" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li>
													<div class="star_section"  style='padding-left: 20px;'>
														<div class="star_section_field" id="star1">1+</div>
														<div class="star_section_field" id="star2">2+</div>
														<div class="star_section_field" id="star3">3+</div>
														<div class="star_section_field" id="star4">4+</div>
														<div class="star_section_field" id="star5">5</div>
													</div>
													<br>
												</li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse" data-target="#price"
												aria-expanded="true">가격</button>
										</h2>
									</div>
									<div id="price" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li>
													<form>
														<div style='text-align: center;'>
															<input id="count_min" type="text" size="10"
															class="price-range-field" /> ~ <input id="count_max"
															type="text" size="10" class="price-range-field" />
														</div>
															<br>
														<div id="slider"></div>
													</form>
												</li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse" data-target="#forFree"
												aria-expanded="true">무료제공</button>
										</h2>
									</div>
									<div id="forFree" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li><input type="checkbox" id="조식포함">조식포함</li>
												<li><input type="checkbox" id="무료주차">무료주차</li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse"
												data-target="#AccommodationName" aria-expanded="true">
												숙소명</button>
										</h2>
									</div>
									<div id="AccommodationName" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li><input type="text" placeholder="숙소명"
													id="searchHotelname"></li>
											</ul>
										</div>
									</div>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse" data-target="#location"
												aria-expanded="true">위치</button>
										</h2>
									</div>
									<div id="location" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li>
													<div id="locationmap" style="width: 100%; height: 300px;"></div>
												</li><br>
												<li style='text-align: center;'>인근반경</li><br>
												<li style='text-align: center;'><select id="locationamount">
														<option value="none">거리 상관없음</option>
														<option value="500">0.5km</option>
														<option value="1000">1km</option>
														<option value="2000">2km</option>
														<option value="5000">5km</option>
														<option value="10000">10km</option>
												</select></li>
											</ul>
										</div>
									</div>
									<script type="text/javascript">
									    var xcoordi; 
									    var ycoordi; 
									    var circle =[];
									  	searchAddressToCoordinate($("#searchHotel").val());
									    var locationposition = new naver.maps.LatLng(ycoordi, xcoordi);
									    var locationmap = new naver.maps.Map('locationmap', {
									        center: locationposition,
									        zoom: 15
									    });
									    var locationmarker = new naver.maps.Marker({
									        position: locationposition,
									        map: locationmap
									    });
									    
									    //왼쪽 인근반경 지도를 클릭했을때 핀 위치 저장하기 -지영
									    naver.maps.Event.addListener(locationmap, 'click', function(e) {
									    	locationmarker.setPosition(e.coord);
									    });
									    
									    </script>
									<div class="card-header">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse"
												data-target="#facilities" aria-expanded="true">
												편의시설</button>
										</h2>
									</div>
									<div id="facilities" class="collapse show"
										aria-labelledby="headingOne">
										<div class="card-body">
											<ul class="list-unstyled">
												<li><input type="checkbox" id="금연">금연</li>
												<li><input type="checkbox" id="수영장">수영장</li>
												<li><input type="checkbox" id="스파">스파</li>
												<li><input type="checkbox" id="욕조">욕조</li>
												<li><input type="checkbox" id="wifi">wifi</li>
												<li><input type="checkbox" id="피트니스">피트니스</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


				<div class="col-md-9" id="list">

					<c:choose>
						<c:when test="${list.size()==0}">
							<h3>${nullmsg}</h3>
						</c:when>
						<c:otherwise>
							<c:forEach var="vo" items="${list }" varStatus="status">
								<div class="row mb-3">
									<div class="col-md-12">
										<div class="card">
											<div class="card-body">
												<div class="row">
													<div class="col-md-3">
														<c:choose>
															<c:when test="${vo.amainimg eq null or vo.amainimg==''}">
																<img
																	src="${pageContext.request.contextPath }/resources/images/accommodations/220i0z000000mulfw433F_Z_1080_808_R5_D.jpg"
																	width="300" height="250">
															</c:when>
															<c:otherwise>
																<img
																	src="${pageContext.request.contextPath }/resources/images/accommodations/${vo.amainimg }"
																	width="300" height="250">
															</c:otherwise>
														</c:choose>
													</div>
													<div class="col-md-6">
														<h3>${vo.aname }</h3>
														<small>${vo.aaddress }</small>
														<div id="map${status.index }"
															style="width: 200px; height: 200px;">
															<input type="hidden" id="axcoordi${status.index }"
																value="${vo.axcoordi }"> <input type="hidden"
																id="aycoordi${status.index }" value="${vo.aycoordi }">
														</div>
														<script type="text/javascript">
													mainMapList(${status.index });
													</script>
													</div>
													<div class="col-md-3" style="padding-left: 70px;">
														<c:if test="${vo.agrade!=null}">
															<h5>${vo.agrade }성급</h5>
														</c:if>
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
															<c:when test="${vo.restar==0 }">
																<h5>☆☆☆☆☆</h5>
															</c:when>
															<c:otherwise>
																<h5>☆☆☆☆☆</h5>
															</c:otherwise>
														</c:choose>
														<h4>${vo.amountsum}원</h4>
														<button class="btn btn-outline-primary"
															onclick="location.href='${pageContext.request.contextPath }/user/kjy/room_info?aid=${vo.aid}&riid=${vo.riid }&person=${rimaxper}&roomnum=${countRoom}&startday=${rcheckin}&endday=${rcheckout}'">예약하기</button>
													</div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</section>

	<div class="footer">
		<jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true"/>
	</div>
</body>
</html>