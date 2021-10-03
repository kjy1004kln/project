<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>J6 숙소등록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=hznya2qvqk&submodules=geocoder"></script>

<!------ Include the above in your HEAD tag ---------->
<!-- 헤더 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css">
<!-- 푸터 -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
<style type="text/css">
body {
	background: #00AEF0;
}

form {
	width: 60%;
	display:block;
	margin:auto;
	background: #efefef;
	padding: 60px 120px 80px 120px;
	text-align: center;
	-webkit-box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.1);
	box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.1);
}

label {
	display: block;
	position: relative;
	margin: 40px 0px;
}

.label-txt {
	position: absolute;
	top: -1.6em;
	padding: 10px;
	font-family: sans-serif;
	font-size: .8em;
	letter-spacing: 1px;
	color: rgb(120, 120, 120);
	transition: ease .3s;
}

.input {
	width: 100%;
	padding: 10px;
	background: transparent;
	border: none;
	outline: none;
}

.line-box {
	position: relative;
	width: 100%;
	height: 2px;
	background: #BCBCBC;
}

.line {
	position: absolute;
	width: 0%;
	height: 2px;
	top: 0px;
	left: 50%;
	transform: translateX(-50%);
	background: #8BC34A;
	transition: ease .6s;
}

.input:focus+.line-box .line {
	width: 100%;
}

.label-active {
	top: -3em;
}

button {
	display: inline-block;
	padding: 12px 24px;
	background: rgb(220, 220, 220);
	font-weight: bold;
	color: rgb(120, 120, 120);
	border: none;
	outline: none;
	border-radius: 3px;
	cursor: pointer;
	transition: ease .3s;
}

button:hover {
	background: #00AEF0;
	color: #ffffff;
}

.button {
	display: inline-block;
	padding: 12px 24px;
	background: rgb(220, 220, 220);
	font-weight: bold;
	color: rgb(120, 120, 120);
	border: none;
	outline: none;
	border-radius: 3px;
	cursor: pointer;
	transition: ease .3s;
}

.button:hover {
	background: #00AEF0;
	color: #ffffff;
}

/*별점 칠하기 css*/
.star-rating {
	display: flex;
	flex-direction: row-reverse;
	font-size: 2.25rem;
	line-height: 0px;
	justify-content: space-around;
	padding: 0 0.2em;
	width: 100px;
}

/*기존 라디오 버튼 사라짐*/
.star-rating input {
	display: none;
}

.star-rating label {
	-webkit-text-fill-color: transparent;
	/* Will override color (regardless of order) */
	-webkit-text-stroke-width: 2.3px;
	-webkit-text-stroke-color: #00AEF0;
	cursor: pointer;
}
/*클릭시 변경*/
.star-rating :checked ~ label {
	-webkit-text-fill-color: #00AEF0;
}
/*호버시 변경*/
.star-rating label:hover, .star-rating label:hover ~ label {
	-webkit-text-fill-color: blue;
}
</style>
</head>
<body>
<div class="header">
	<div class="header_container">
		<div class="logo">
			<a href="${pageContext.request.contextPath}/" class="logo_container">
				<div class="logo_img">
					<img src="${pageContext.request.contextPath}/resources/images/main/logo1.png">
				</div>
			</a>
		</div>
		<div class="nav">
			<ul class="nav_menu">
				<li><a class="nav_hotel" href="${pageContext.request.contextPath}/"><span>호텔</span></a></li>
				<c:choose>
					<c:when test="${empty sessionScope.mid }">
						<li><a class="nav_board" href="${pageContext.request.contextPath }/jhr/login"><span>게시판</span></a></li>
					</c:when>
					<c:otherwise>
						<li><a class="nav_board" href="${pageContext.request.contextPath }/hjy/board/all"><span>게시판</span></a></li>
					</c:otherwise>
				</c:choose>
				<li><a class="nav_qna" href="${pageContext.request.contextPath }/hjy/qna"><span>QnA</span></a></li>
			</ul>
			<div class="nav_account">
				<div class="nav_account_container">
					<div class="nav_acco">
						<a href="#">숙소등록진행중...</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	<form method="post"
		action="${pageContext.request.contextPath }/hjy/hotelreq"
		enctype="multipart/form-data">
		<h1 style="font-family: sans-serif; font-size: 18px;">숙소정보</h1>
		<label>
			<p class="label-txt">카테고리</p> <input type="text" name="acate"
			class="input">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">숙박업소명</p> <input type="text" name="aname"
			class="input">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">전화번호</p> <input type="text" name="aphone"
			class="input">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">주소</p>
			<br>
			<div
				style="margin-bottom: -30px; z-index: 1; position: relative; text-align: left;">
				<input type="text" id="find" name="aaddress"> <input
					type="button" value="주소 검색" onclick="go()">
			</div>
			<div id="map" style="width: 100%; height: 400px;">
				<input type="hidden" name="aycoordi" id="xcoordi"> 
				<input type="hidden" name="axcoordi" id="ycoordi">
			</div> 
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">총객실수</p> <input type="text" name="atotalroom"
			class="input">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">숙소성급</p>
			<div class="star-rating space-x-4 mx-auto">
				<input type="radio" id="5-stars" name="agrade" value="5"
					v-model="ratings" /> <label for="5-stars" class="star pr-4">★</label>
				<input type="radio" id="4-stars" name="agrade" value="4"
					v-model="ratings" /> <label for="4-stars" class="star">★</label> <input
					type="radio" id="3-stars" name="agrade" value="3" v-model="ratings" />
				<label for="3-stars" class="star">★</label> <input type="radio"
					id="2-stars" name="agrade" value="2" v-model="ratings" /> <label
					for="2-stars" class="star">★</label> <input type="radio"
					id="1-star" name="agrade" value="1" v-model="ratings" /> <label
					for="1-star" class="star">★</label>
			</div>
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">대표소개</p> <input type="text" name="adetail"
			class="input">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label> <label>
			<p class="label-txt">대표이미지</p> <input type="file" name="file"
			class="input" multiple="multiple">
			<div class="line-box">
				<div class="line"></div>
			</div>
		</label>
		<hr>
		<h1 style="font-family: sans-serif; font-size: 18px;">객실 세부정보</h1>

		<div id="roomInfoadd"></div>
		<hr>
		<input type="button" onclick="roomInfoAdd()" value="객실세부정보 추가"
			class="button">

		<script>
	  var cnt = 0;
	  function roomInfoAdd(){
		  for (var i = 0; i < cnt; i++) {
			$("#collapse"+i).attr('class','collapse')
			}
		  var roomInfo=`<div id="c\${cnt}"><div class="container" ><hr>
			  <div id="accordion">
			    <div class="card" style="background: #efefef;">
			    <div class="card-header">
			    <a href="javascript:deleteForm(\${cnt})" style="text-align: right; position: relative;">삭제</a><br>
		      <a class="card-link" data-toggle="collapse" href="#collapse\${cnt}">
			    접기/펼치기
		  </a>
		    <label>
			    <p class="label-txt">객실이름</p>
			    <input type="text" name="room_InfoVo[\${cnt}].riroomtype" class="input">
			    <div class="line-box">
			      <div class="line"></div>
			    </div>
			  </label>
		</div>
		    <div id="collapse\${cnt}" class="collapse show" data-parent="#accordion">
		      <div class="card-body">
					<label>
					    <p class="label-txt">객실수</p>
					    <input type="text" name="room_InfoVo[\${cnt}].riroom" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">부가서비스</p>
					    <input type="text" name="room_InfoVo[\${cnt}].riservice" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">객실크기</p>
					    <input type="text" name="room_InfoVo[\${cnt}].risize" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">숙박가능인원</p>
					    <input type="text" name="room_InfoVo[\${cnt}].riminper" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">숙박최대인원</p>
					    <input type="text" name="room_InfoVo[\${cnt}].rimaxper" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">성수기 1박 기본요금</p>
					    <input type="text" name="room_InfoVo[\${cnt}].ripeak" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">준성수기 1박 기본요금</p>
					    <input type="text" name="room_InfoVo[\${cnt}].risemipeak" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">비수기 1박 기본요금</p>
					    <input type="text" name="room_InfoVo[\${cnt}].rioff" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">대표이미지</p>
					    <input type="file" name = "file" class="input"multiple="multiple">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">추가이미지1</p>
					    <input type="file" name = "file" class="input"multiple="multiple">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">추가이미지2</p>
					    <input type="file" name = "file" class="input"multiple="multiple">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <h1 style="font-family: sans-serif; font-size:18px;">추가요금 설정</h1>
					  <label>
					    <p class="label-txt">인원추가비용</p>
					    <input type="text" name="additional_feeVo[\${cnt}].afpersonnel" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">조식추가비용</p>
					    <input type="text" name="additional_feeVo[\${cnt}].afbreakfast" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					  <label>
					    <p class="label-txt">침대추가비용</p>
					    <input type="text" name="additional_feeVo[\${cnt}].afbed" class="input">
					    <div class="line-box">
					      <div class="line"></div>
					    </div>
					  </label>
					</div>
					</div>
					</div>
					</div>
					</div>
		    </div>
		  </div>`;
		  $("#roomInfoadd").append(roomInfo);
		  cnt++;
	  }
	  function deleteForm(delCount){
		  if($("#roomInfoadd").children().length!=1){
			  $("#c"+delCount).remove();
		  }else{
			  alert('최소 1개 이상의 세부정보가 포함되어야 합니다.')
		  }
	  }
  </script>
		<hr>
		<h1 style="font-family: sans-serif; font-size: 18px;">시즌 정보</h1>
		<div id="periodInfoAdd"></div>
		<hr>
		<input type="button" onclick="periodInfoAdd()" value="시즌정보 추가"
			class="button"><br><hr>

		<script>
	  var periodCnt = 0;
	  function periodInfoAdd(){
		  for (var i = 0; i < periodCnt; i++) {
			$("#period"+i).attr('class','collapse')
		}
		  var roomInfo=`<div id="p\${periodCnt}"><div class="container" ><hr>
			  <div id="accordion">
			    <div class="card" style="background: #efefef;">
			    <div class="card-header">
			    <a href="javascript:deleteperiodForm(\${periodCnt})" style="text-align: right; position: relative;">삭제</a><br>
		      <a class="card-link" data-toggle="collapse" href="#period\${periodCnt}">
			    접기/펼치기
		  </a>
			    <label>
			    <p class="label-txt">시즌</p>
			    <select name = "periodVo[\${periodCnt}].peseason" class="input">
			    	<option value="비수기">비수기</option>
			    	<option value="준성수기">준성수기</option>
			    	<option value="성수기">성수기</option>
			    </select>
			    <div class="line-box">
			      <div class="line"></div>
			    </div>
			  </label>
		</div>
		    <div id="period\${periodCnt}" class="collapse show" data-parent="#accordion">
		      <div class="card-body">
		      <label>
		      <p class="label-txt">시즌 시작날짜</p>
		      <input type="date" name="periodVo[\${periodCnt}].pestart" class="input">
		      <div class="line-box">
		        <div class="line"></div>
		      </div>
		    </label>
		    <label>
		      <p class="label-txt">시즌 끝날짜</p>
		      <input type="date" name="periodVo[\${periodCnt}].peend" class="input">
		      <div class="line-box">
		        <div class="line"></div>
		      </div>
		    </label>
					</div>
					</div>
					</div>
					</div>
					</div>
		    </div>
		  </div>`;
		  $("#periodInfoAdd").append(roomInfo);
		  periodCnt++;
	  }
	  function deleteperiodForm(periodCnt){
		  if($("#periodInfoAdd").children().length!=1){
			  $("#p"+periodCnt).remove();
		  }else{
			  alert('최소 1개 이상의 시즌 정보가 포함되어야 합니다.')
		  }
		  
	  }
  </script>

		<button type="submit">신청하기</button>
	</form>
	<div class="footer">
	<div class="footer_container">
		<div class="site_map">
			<div class="site_map_container">
				<div class="nav_column">
					<h6>회사 정보</h6>
					<ul>
						<li><a href="#">호텔스컴바인 소개</a></li>
						<li><a href="#">사이트 작동 방식</a></li>
						<li><a href="#">모바일</a></li>
					</ul>
				</div>
				<div class="nav_column">
					<h6>연락처</h6>
					<ul>
						<li><a href="#">도움말/FAQ</a></li>
						<li><a href="#">숙박시설 관리</a></li>
						<li><a href="#">제휴 프로그램</a></li>
					</ul>
				</div>
				<div class="nav_column">
					<h6>더 보기</h6>
					<ul>
						<li><a href="#">위치별 호텔 검색</a></li>
						<li><a href="#">최저가 보장</a></li>
					</ul>
				</div>
			</div>
		</div>
		
		<div class="privacy">
			<div class="privacy_container">
				<a href="#">개인 정보 보호 정책</a>
				<a href="#">쿠키 정책</a>
				<a href="#">이용 약관</a>
				<span>©2021 HotelsCombined</span>
			</div>
		</div>
		
		<div class="description">
			<p>호텔스컴바인에서 전 세계 주요 여행지의 호텔 상품을 최저가로 만나보세요. 수 백개의 호텔 사이트를 검색하여, 고객님께서 딱 맞는 호텔 상품을 바로 찾아 예약하실 수 있도록 도와드립니다. 호텔스컴바인에서는 국내외 유명한 호텔 사이트를 한 번에 검색하여 한눈에 비교할 수 있도록 도와 드리고 있어 특가 상품을 쉽게 찾으실 수 있습니다. 지금 바로 시작해 보세요.</p>
		</div>
		
		<div class="group_logo">
			<div class="group_logo_container">
				<p>호텔스컴바인은 세계적인 온라인 여행 기업 '부킹홀딩스(Booking Holdings Inc.)'의 그룹사입니다.</p>
				<ul>
					<li class="group_logo_booking"></li>
					<li class="group_logo_kayak"></li>
					<li class="group_logo_opentable"></li>
					<li class="group_logo_princeline"></li>
					<li class="group_logo_agoda"></li>
					<li class="group_logo_rentalcars"></li>
				</ul>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	roomInfoAdd();
	periodInfoAdd();
	  $('.input').focus(function(){
	    $(this).parent().find(".label-txt").addClass('label-active');
	  });

	  $(".input").focusout(function(){
	    if ($(this).val() == '') {
	      $(this).parent().find(".label-txt").removeClass('label-active');
	    };
	  });
	});
	
var xcoordi; 
var ycoordi; 

var map = new naver.maps.Map("map", {
	  center: new naver.maps.LatLng(37.3595316, 127.1052133),
	  zoom: 15,
	  mapTypeControl: true
	});

	var infoWindow = new naver.maps.InfoWindow({
	  anchorSkew: true
	});

	map.setCursor('pointer');

	function searchCoordinateToAddress(latlng) {

	  infoWindow.close();

	  naver.maps.Service.reverseGeocode({
	    coords: latlng,
	    orders: [
	      naver.maps.Service.OrderType.ADDR,
	      naver.maps.Service.OrderType.ROAD_ADDR
	    ].join(',')
	  }, function(status, response) {
	    if (status === naver.maps.Service.Status.ERROR) {
	      if (!latlng) {
	        return alert('ReverseGeocode Error, Please check latlng');
	      }
	      if (latlng.toString) {
	        return alert('ReverseGeocode Error, latlng:' + latlng.toString());
	      }
	      if (latlng.x && latlng.y) {
	        return alert('ReverseGeocode Error, x:' + latlng.x + ', y:' + latlng.y);
	      }
	      return alert('ReverseGeocode Error, Please check latlng');
	    }

	    var address = response.v2.address,
	        htmlAddresses = [];

	    if (address.jibunAddress !== '') {
	        htmlAddresses.push('[지번 주소] ' + address.jibunAddress);
	    }

	    if (address.roadAddress !== '') {
	        htmlAddresses.push('[도로명 주소] ' + address.roadAddress);
	    }

	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:200px;line-height:150%;">',
	      '<h4 style="margin-top:5px;">검색 좌표</h4><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));

	    infoWindow.open(map, latlng);
	  });
	}

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

	    if (response.v2.meta.totalCount === 0) {
	      return alert('검색결과가 없습니다.');
	    }

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

	    infoWindow.setContent([
	      '<div style="padding:10px;min-width:100px;line-height:150%;">',
	      '<h5 style="margin-top:5px;">검색 주소 : '+ address +'</h5><br />',
	      htmlAddresses.join('<br />'),
	      '</div>'
	    ].join('\n'));

	    map.setCenter(point);
	    infoWindow.open(map, point);
	  });
	}

	function initGeocoder() {
	  if (!map.isStyleMapReady) {
	    return;
	  }

	  map.addListener('click', function(e) {
	    searchCoordinateToAddress(e.coord);
	  });

	  $('#address').on('keydown', function(e) {
	    var keyCode = e.which;

	    if (keyCode === 13) { // Enter Key
	      searchAddressToCoordinate($('#address').val());
	    }
	  });

	  $('#submit').on('click', function(e) {
	    e.preventDefault();

	    searchAddressToCoordinate($('#address').val());
	  });

	  searchAddressToCoordinate('서울시');
	}

	naver.maps.onJSContentLoaded = initGeocoder;
	naver.maps.Event.once(map, 'init_stylemap', initGeocoder);
	
	function go(){
		searchAddressToCoordinate($("#find").val())
		$("#xcoordi").val(xcoordi)
		$("#ycoordi").val(ycoordi)
	}
</script>
</html>