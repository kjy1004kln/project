<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/js/jquery-ui.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Hahmlet:wght@500;600;700&family=Nanum+Pen+Script&display=swap" rel="stylesheet">
</head>
<style>
* {
	font-family: 'Stylish', sans-serif;
}

#largeimgbox {
	position: relative;
	width: 1000px;
	left: 400px;
	height: 600px;
	top: 0px;
	margin-bottom: 200px;
	border-bottom: 1px solid gray;
}

.largeimg {
	position: absolute;
	top: 100px;
	left: 0px;
	width: 500px;
	height: 400px;
	border-radius: 10px;
}

.amainimg {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 500px;
	height: 400px;
	z-index: 1;
	border-radius: 10px;
}

.anme {
	position: absolute;
	top: 100px;
	left: 550px;
	font-size: 30px;
	font-weight: bold;
}

.agrade {
	position: absolute;
	top: 150px;
	left: 550px;
	font-size: 15px;
	font-weight: bold;
}

.aadress {
	position: absolute;
	top: 150px;
	left: 600px;
	font-size: 15px;
	font-weight: bold;
}

.detailbox {
	position: absolute;
	top: 180px;
	left: 550px;
	width: 450px;
	height: 200px;
}

.adetail {
	position: absolute;
	font-size: 12px;
}

#googlemap {
	position: absolute;
	top: 400px;
	left: 550px;
	width: 450px;
	height: 100px;
	border-radius: 10px;
}

.search_title {
	position: absolute;
	top: 700px;
	left: 400px;
	font-size: 25px;
	font-weight: bold;
}

.room_title {
	position: absolute;
	top: 1030px;
	left: 400px;
	font-size: 25px;
	font-weight: bold;
}

#search_info{
	position: absolute;
	width: 1000px;
	top:750px;
	left: 400px;
	height: 235px;
	border: 1px solid blue;
	border-radius: 10px;
	box-shadow: 5px 5px 5px gray;
}

/* 전체테두리 */
#room_info {
	position: relative;
	width: 1000px;
	top:220px;
	left: 400px;
	height: 235px;
	border: 1px solid blue;
	margin-bottom: 40px;
	border-radius: 10px;
	box-shadow: 5px 5px 5px gray;
}

/* 이미지박스 */
#imgbox {
	position: absolute;
	top: 20px;
	left: 20px;
	width: 175px;
	height: 195px;
}

#smallimg1 {
	position: absolute;
	top: 0px;
	left: 0px;
	width: 175px;
	height: 120px;
}

#smallimg2 {
	position: absolute;
	top: 125px;
	left: 0px;
	width: 85px;
	height: 70px;
}

#smallimg3 {
	position: absolute;
	top: 125px;
	left: 90px;
	width: 85px;
	height: 70px;
}

#romm_name {
	position: absolute;
	top: 20px;
	left: 215px;
	width: 765px;
	height: 195px;
}

.name {
	position: absolute;
	top: 0px;
	line-height: 0px;
}

.serv {
	position: absolute;
	top: 80px;
	font-size: 15px;
	cursor: help;
}

.subname {
	position: absolute;
	top: 105px;
	font-size: 10px;
	color: blue;
}

.sumprice {
	position: absolute;
	top: 165px;
	right: 180px;
	font-size: 20px;
	color: red;
}

.price {
	position: absolute;
	top: 135px;
	right: 180px;
	font-size: 15px;
}

.btn {
	position: absolute;
	top: 140px;
	right: 0px;
	width: 150px;
	height: 50px;
}

/* 맨우측 인원표시 */
.maxpersonimg {
	position: absolute;
	top: 0px;
	right: 0px;
	height: 20px;
}

.maxperson {
	position: absolute;
	top: 25px;
	right: 0px;
	font-size: 10px;
}

.minpersonimg {
	position: absolute;
	top: 0px;
	right: 120px;
	height: 20px;
}

.minperson {
	position: absolute;
	top: 25px;
	right: 120px;
	font-size: 10px;
}

.personimg {
	position: absolute;
	top: 50px;
	right: 0px;
	height: 20px;
}

.person {
	position: absolute;
	top: 75px;
	right: 0px;
	font-size: 10px;
}
#reserimg{
	position:absolute;
	top:30px;
	right: 300px;
	width: 300px;
	height: 150px;
	z-index: 0;
	opacity: 0.6;
}


#reviewbox {
	position: relative;
	width: 1000px;
	margin-top:400px;
	margin-bottom:20px;
	left: 400px;
	border-top: 1px solid gray;
}

.reviewtitle {
	position: absolute;
	top:30px;
	font-size: 25px;
	font-weight: bold;
}

#starbox{
	position:relative;
	height:150px;
}

.sumstart {
	position: absolute;
	top: 80px;
	font-size: 15px;
	font-weight: bold;
}

#totalreview {
	position: relative;
	
	
}
#review {
	position: relative;
	width: 1000px;
	height: 150px;
	padding: 0px;
	background: #FFFFFF;
	-webkit-border-radius: 31px;
	-moz-border-radius: 31px;
	border-radius: 31px;
	border: #5347C0 solid 2px;
	margin-bottom: 50px;
	box-shadow: 5px 5px 5px gray;
}

#review:after {
	content: '';
	position: absolute;
	border-style: solid;
	border-width: 20px 6px 0;
	border-color: #FFFFFF transparent;
	display: block;
	width: 0;
	z-index: 1;
	bottom: -20px;
	left: 100px;
}

#review:before {
	content: '';
	position: absolute;
	border-style: solid;
	border-width: 21px 7px 0;
	border-color: #5347C0 transparent;
	display: block;
	width: 0;
	z-index: 0;
	bottom: -23px;
	left: 99px;
}

.retitle {
	position: absolute;
	top: 10px;
	left: 10px;
	font-size: 20px;
	font-weight: bold;
}

.reviewid {
	position: absolute;
	top: 42px;
	left: 10px;
	font-size: 12px;
	font-weight: bold;
}

.recontent {
	position: absolute;
	top: 70px;
	left: 10px;
	width: 800px;
	height: 70px;
	font-size: 15px;
	font-weight: bold;
}

.restar {
	position: absolute;
	top: 15px;
	right: 10px;
	font-size: 15px;
	font-weight: bold;
}

#page {
	position: relative;
	left: 450px;
	width: 100px;
	height: 50px;
	font-size: 25px;
}

</style>
<div class="header">
	<jsp:include page="/WEB-INF/views/user/jhr/header.jsp"/>
</div>
<!-- 이미지 크게 일단 하나 -->
<div id="content">
	<div id="largeimgbox">
	<p class="anme">${accvo.aname}</p>
	<p class="agrade">${accvo.agrade}&nbsp;|&nbsp;</p>
	<p class="aadress">${accvo.aaddress}</p>
	<div class="detailbox">
		<p class="adetail">${accvo.adetail}</p>
	</div>
	<div id="googlemap">
		<input type="hidden" value="${accvo.aname}" id="googlename">
		<input type="hidden" value="${accvo.axcoordi}" id="googlex">
		<input type="hidden" value="${accvo.aycoordi}" id="googley">
	</div>
		<div class="largeimg">
			<img src="${pageContext.request.contextPath }/resources/images/accommodations/${accvo.amainimg}" class="amainimg">
		</div>
	</div>
	
	<p class='search_title'>검색결과</p>
	<c:forEach var="vo" items="${list }" varStatus="status">
		<input type="hidden" value="${vo.aid }" id="aid">
		<c:if test="${riid eq vo.riid}">
		<div id="search_info">
			<div id="imgbox">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.rimainimg }" id="smallimg1">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.riextraimg1}" id="smallimg2">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.riextraimg2}" id="smallimg3">			
			</div>
			<div id="romm_name">
				<h2 class="name">${vo.riroomtype}</h2>
				<p class="serv">부가서비스</p>
				<p class="subname">${vo.riservice}</p>
				<p class="sumprice">₩&nbsp;${vo.sum}</p>
				<p class="price"><a href="javascript:void(0);" title="${vo.price}">요금세부정보</a></p>
			 	<img class="maxpersonimg" src="${pageContext.request.contextPath }/${vo.maxperimg}">
			 	<p class="maxperson">최대&nbsp;${vo.rimaxper}인</p>
			 	<img class="minpersonimg" src="${pageContext.request.contextPath }/${vo.minperimg}">
			 	<p class="minperson">최소&nbsp;${vo.riminper}인</p>
			 	<img class="personimg" src="${pageContext.request.contextPath }/${vo.perimg}">
			 	<p class="person">현재&nbsp;${person}인</p>
			 	<img src="${pageContext.request.contextPath }/${vo.reserimg}" onerror="this.style.display='none'" id="reserimg">
			 	<!-- session에 id가 있는지 확인후 없을경우 로그인페이지로 -->
			 	<c:choose>
			 		<c:when test="${empty sessionScope.mid }">
			 			<input type="button" class="btn btn-primary" class="btn" value="바로예약" onclick="loginpage()">
			 		</c:when>
			 		<c:otherwise>
			 			<input type="button" class="btn btn-primary" class="btn" value="바로예약" onclick="location.href='${pageContext.request.contextPath }/phj/reservation?aid=${vo.aid}&riid=${vo.riid}&startday=${startday}&endday=${endday}&ramount=${person }&sum=${vo.sum }&roomnum=${roomnum}'">
			 		</c:otherwise>
			 	</c:choose>
			</div>
		</div>
		</c:if>
		<c:if test="${riid ne vo.riid}">
		<p class='room_title'>객실정보</p>
		<div id="room_info">
			<div id="imgbox">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.rimainimg }" id="smallimg1">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.riextraimg1}" id="smallimg2">
				<img src="${pageContext.request.contextPath }/resources/images/room_info/${vo.riextraimg2}" id="smallimg3">			
			</div>
			<div id="romm_name">
				<h2 class="name">${vo.riroomtype}</h2>
				<p class="serv">부가서비스</p>
				<p class="subname">${vo.riservice}</p>
				<p class="sumprice">₩&nbsp;${vo.sum}</p>
				<p class="price"><a href="javascript:void(0);" title="${vo.price}">요금세부정보</a></p>
			 	<img class="maxpersonimg" src="${pageContext.request.contextPath }/${vo.maxperimg}">
			 	<p class="maxperson">최대&nbsp;${vo.rimaxper}인</p>
			 	<img class="minpersonimg" src="${pageContext.request.contextPath }/${vo.minperimg}">
			 	<p class="minperson">최소&nbsp;${vo.riminper}인</p>
			 	<img class="personimg" src="${pageContext.request.contextPath }/${vo.perimg}">
			 	<p class="person">현재&nbsp;${person}인</p>
			 	<img src="${pageContext.request.contextPath }/${vo.reserimg}" onerror="this.style.display='none'" id="reserimg">
			 	<!-- session에 id가 있는지 확인후 없을경우 로그인페이지로  -->
			 	<c:choose>
			 		<c:when test="${empty sessionScope.mid }">
			 			<input type="button" class="btn btn-primary" class="btn" value="바로예약" onclick="loginpage()">
			 		</c:when>
			 		<c:otherwise>
			 			<input type="button" class="btn btn-primary" class="btn" value="바로예약" onclick="location.href='${pageContext.request.contextPath }/phj/reservation?aid=${vo.aid}&riid=${vo.riid}&startday=${startday}&endday=${endday}&ramount=${person }&sum=${vo.sum }&roomnum=${roomnum}'">
			 		</c:otherwise>
			 	</c:choose>
			</div>
		</div>
		</c:if>
	</c:forEach>
	<div id="reviewbox">
		<div id="starbox">
			<p class="reviewtitle">솔직이용후기</p>
		</div>
		<div id="totalreview"></div>
		<div id="page"></div>
	</div>
</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/user/jhr/footer.jsp"/>
</div>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCIFdez0Bx1XuNNQ0eIa12BjxqJ0gFO6eA&callback=initMap&region=kr"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/jquery-ui.js"></script>
<script type="text/javascript">
	$(function(){
		list(1);
		//사진 호버설정
		var scrollValue=0;
		$(window).scroll(function () { 
			scrollValue = $(document).scrollTop(); 
		});
		$("#imgbox img").hover(function(){
			var top=$(this).offset().top;
			var left=$(this).offset().left;
			var height=$(this).height();
			var img=$(this).attr("src");
			let str="<img src="+img+" id='addimg'>";
			if(top-300>scrollValue){
				$(str).appendTo("#content").css({
					border: '3px solid black',
					position:'absolute',
					top:top-303+'px',
					left:left+'px',
					width:'400px',
					height:'300px'
				});
			}else{
				$(str).appendTo("#content").css({
					border: '3px solid black',
					position:'absolute',
					top:top+height+'px',
					left:left+'px',
					width:'400px',
					height:'300px'
				});
			}
		},function(){
			$("#addimg").remove();
		});
	
		//툴팁효과
		$(".price").tooltip();
	
	});

	//구글 지도	
	function initMap() {
		var googlename=$("#googlename").val();//호텔 이름
		var googlex=$("#googlex").val(); //경도
		var googley=$("#googley").val(); //위도
		var xy = { 
			lat:+googlex, 
			lng:+googley
		};//위치
		var map = new google.maps.Map(
		document.getElementById('googlemap'), {
  		zoom: 16,//줌화면크기
  		center: xy
		});
		new google.maps.Marker({
   		 position: xy,//좌표에 마커찍기
   		 map: map,
   		 label:googlename
		});
	}
	
	//리뷰 총점
	var aid=$("#aid").val();
	var sstar=0;
	var sumstar=0;
	var cnt=0;
	$.ajax({
		url:"${pageContext.request.contextPath }/user/kjy/review2",
		data:{"aid":aid},
		dataType:"json",
		success:function(d){
			sumstar=d.SUMSTAR;
			cnt=d.CNT;
			if(sumstar==1){
				sstar="★☆☆☆☆"
			}else if(sumstar==2){
				sstar="★★☆☆☆";
			}else if(sumstar==3){
				sstar="★★★☆☆";
			}else if(sumstar==4){
				sstar="★★★★☆";
			}else if(sumstar==5){
				sstar="★★★★★";
			}
			let html="<p class='sumstart'>"+cnt+"개의 리뷰 전체평점: "+sstar+"</p>";
			$("#starbox").append(html);
		}
	});
	//리뷰페이지
	function list(pageNum){
		$("#totalreview").empty();
		$.ajax({
			url:"${pageContext.request.contextPath }/user/kjy/review1",
			data:{"aid":aid,"pageNum":pageNum},
			dataType:"json",
			success:function(data){
				$(data.result).each(function(i,d){
					let retitle=d.retitle;
					let recontent=d.recontent;
					let rerdate=d.rerdate;
					let restar=d.restar;
					let mid=d.mid;
					if(restar==1){
						restar="★☆☆☆☆"
					}else if(restar==2){
						restar="★★☆☆☆";
					}else if(restar==3){
						restar="★★★☆☆";
					}else if(restar==4){
						restar="★★★★☆";
					}else if(restar==5){
						restar="★★★★★";
					}
					let html="<div id='review'>"+
					"<p class='retitle'>"+retitle+"</p>"+
					"<p class='reviewid'>(작성자: "+mid+")</p>"+
					"<p class='recontent'>"+recontent+"</p>"+
					"<p class='restar'>평점: "+restar+"</p>"+
					"</div>";
					$("#totalreview").append(html);
				});
				//페이징 처리
				let startPage=data.startPageNum;
				let endPage=data.endPageNum;
				let pageCount=data.totalPageCount;
				let pageHtml="";
				if(startPage>5){
					pageHtml += "<a href='javascript:list("+ (startPage-1) + ")'>이전</a>";
				}
				if(pageNum==null){
					pageHtml += "<a href='javascript:reservationlist("+ 1 + ")'><span style='color:blue'>"+ 1 + "</span></a> ";
					startPage++;
				}
				for(let i=startPage;i<=endPage;i++){
					if(i==pageNum){
						pageHtml += "<a href='javascript:list("+ i + ")'><span style='color:blue'>"+ i + "</span></a> ";
					}else if(pageNum==null){
						pageHtml += "<a href='javascript:reservationlist("+ i + ")'><span style='color:gray'>"+ i + "</span></a> ";
					}else{
						pageHtml += "<a href='javascript:list("+ i + ")'><span style='color:gray'>"+ i + "</span></a> ";
					}	
				}
				if(endPage<pageCount){
					pageHtml += "<a href='javascript:list("+ (endPage+1) + ")'>다음</a>";
				}
				$("#page").html(pageHtml);
			}
		});
	}
	
	//로그인 페이지로 이동
	function loginpage(){
		alert("로그인 페이지로 이동합니다.");
		location.href='${pageContext.request.contextPath }/jhr/login';
	}
	
</script>
</html>