<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>content.jsp</title>
<style>
.slide_des ul li:first-child {left:0;}
.slide_des ul li:nth-child(12) {left:-100%;}
.slide_hotel ul li:first-child {left:0;}
.slide_hotel ul li:nth-child(10) {left:-100%;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/content.css">

<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
<script type="text/javascript">
//fag 토글
var acc_state=0;
function accodionAction(target) {
	//제이쿼리
	 $(target).next().slideToggle(300);
/*
    //자바스크립트
    var panel=document.getElementsByClassName("faq_answer");
    var accordion_button=document.getElementsByClassName("faq_question_title");
    if(target.nextElementSibling.style.display=='block') {
        target.nextElementSibling.style="display:none;";
        target.classList.toggle("active");
        
    }
    else{
        for(i=0; i<panel.length; i++){
            panel[i].style.display="none";
            accordion_button[i].classList.remove("active");
        }
        target.nextElementSibling.style="display:block;";
        target.classList.toggle("active"); 
    } 
    
    */
}
	$(function(){	
		//인기 여행지 슬라이드
		$(".slider_des li:last").prependTo(".slider_des");
		$("#prevDes").click(function() {
			$(".slider_des").animate({left:208}, function() {
				$(".slider_des li:last").prependTo(".slider_des")
				$(".slider_des").css({left:0})
			});
		});
		$("#nextDes").click(function() {
			$(".slider_des").animate({left:-208}, function() {
				$(".slider_des li:first").appendTo(".slider_des")
				$(".slider_des").css({left:0})
			});
		});
		//지금 인기 있는 호텔 슬라이드
		$(".slider_hotel li:last").prependTo(".slider_hotel");
		$("#prevHotel").click(function() {
			$(".slider_hotel").animate({left:259}, function() {
				$(".slider_hotel li:last").prependTo(".slider_hotel")
				$(".slider_hotel").css({left:0})
			});
		});
		$("#nextHotel").click(function() {
			$(".slider_hotel").animate({left:-259}, function() {
				$(".slider_hotel li:first").appendTo(".slider_hotel")
				$(".slider_hotel").css({left:0})
			});
		});
		
		var acc_state=0;
	    function accodionAction(target) {
	        var panel=document.getElementsByClassName("faq_answer");
	        var accordion_button=document.getElementsByClassName("faq_question_title");
	
	        if(target.nextElementSibling.style.display=='block') {
	            target.nextElementSibling.style="display:none;";
	            target.classList.toggle("active");
	        }
	        else{
	            for(i=0; i<panel.length; i++){
	                panel[i].style.display="none";
	                accordion_button[i].classList.remove("active");
	            }
	            target.nextElementSibling.style="display:block;";
	            target.classList.toggle("active"); 
	        } 
	    }
	    
	    function showID(id){
	    	obj=document.getElementById(id);
	    		if(obj.style.display == "none") 
	    		  obj.style.display="inline";
	    		else
	    		  obj.style.display="none";
	    }
	  
    	$("#searchHotel").autocomplete({
    		source:function(request,response){
    			let aname=$("#searchHotel").val();
    			//console.log(aname);
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
    		 classes: {   
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
     	//체크인
     	//버튼 클릭시 전날로 이동
     	$(".date_btn_before").on('click', function(){
     		let date = new Date($("#checkin").val());
     		console.log(date);
     		let year = date.getFullYear();
     		let month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
     		let day = (date.getDate()-1) > 9 ? (date.getDate()-1) : '0' + (date.getDate()-1);
     		//console.log(year + month + day);
     		$("#checkin").val(year + "-" + month + "-" + day);	
     	});
     	//버튼 클릭시 다음날로 이동
     	$(".date_btn_after").on('click', function(){ 
     		let date = new Date($("#checkin").val());
     		//console.log(date);
     		let iyear = date.getFullYear();
     		let imonth = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
     		let idate = (date.getDate()+1) > 9 ? (date.getDate()+1) : '0' + (date.getDate()+1);
     		//console.log(ye + mo + da);
     		$("#checkin").val(iyear + "-" + imonth + "-" + idate);	
     	});
     	//체크아웃
     	//버튼 클릭시 전날로 이동
     	$(".date_btn_before_a").on('click', function(){
     		let date = new Date($("#checkout").val());
     		console.log(date);
     		let year = date.getFullYear();
     		let month = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
     		let day = (date.getDate()-1) > 9 ? (date.getDate()-1) : '0' + (date.getDate()-1);
     		//console.log(year + month + day);
     		$("#checkout").val(year + "-" + month + "-" + day);	
     	});
     	//버튼 클릭시 다음날로 이동
     	$(".date_btn_after_a").on('click', function(){ 
     		let date = new Date($("#checkout").val());
     		//console.log(date);
     		let iyear = date.getFullYear();
     		let imonth = (date.getMonth()+1) > 9 ? (date.getMonth()+1) : '0' + (date.getMonth()+1);
     		let idate = (date.getDate()+1) > 9 ? (date.getDate()+1) : '0' + (date.getDate()+1);
     		//console.log(ye + mo + da);
     		$("#checkout").val(iyear + "-" + imonth + "-" + idate);	
     	});
    });
</script>

<div class="content">
	<div class="top">
		<div class="top_container">
			<div class="covid">
				<div class="covid_container">
					<div class="covid_imp">고객님의 여정이 코로나19(COVID-19) 발생 상황에 영향을 받을 수 있습니다.</div>
					<div class="covid_sub">
						<span>여행지별 여행 경보를 확인할 수 있는 알리미를 사이트에서 찾아보시기 바랍니다.</span>
						<span>자세한 내용은 <a>여기</a>에서 확인하실 수 있습니다.</span>
					</div>
				</div>
			</div>
			<div class="ad">
				<div class="ad_container">
					<div class="ad_text">
						<h2>316만개 호텔, 한번에 비교해서 최고의 예약을</h2>
						<p>
							<img src="${pageContext.request.contextPath}/resources/images/main/bookingcom.svg">
							<img src="${pageContext.request.contextPath}/resources/images/main/hotelscom.svg">
							<img src="${pageContext.request.contextPath}/resources/images/main/agoda.svg">
							<img src="${pageContext.request.contextPath}/resources/images/main/expedia.svg">
							<img src="${pageContext.request.contextPath}/resources/images/main/interparktour.png">
						</p>
					</div>
					<div class="ad_img">
						<img src="${pageContext.request.contextPath}/resources/images/main/max_with_celebrity_kr.png">
					</div>
				</div>
			</div>
			<div class="search">
				<div class="search_container">
					<form class="search_content" method="post" action="${pageContext.request.contextPath }/lhjcjyhjy/firstsearch">
						<div class="search_insert">
							<div class="search_insert_container">
								<div class="search_insert_content">
									<div class="search_insert_city">
										<div class="search_city_display">
											<svg viewBox="0 0 20 21">
												<path fill-rule="evenodd" clip-rule="evenodd" d="M8.31529 16.2594C4.18311 16.2594 0.833313 12.9096 0.833313 8.77745C0.833313 4.64527 4.18311 1.29547 8.31529 1.29547C12.4475 1.29547 15.7973 4.64527 15.7973 8.77745C15.7973 10.5759 15.1628 12.2261 14.1054 13.5165L18.949 18.36C19.2392 18.6503 19.2392 19.1209 18.949 19.4111C18.6587 19.7014 18.1881 19.7014 17.8979 19.4111L13.0543 14.5676C11.7639 15.6249 10.1137 16.2594 8.31529 16.2594ZM12.5286 13.0429C11.4458 14.1126 9.95766 14.7729 8.31529 14.7729C5.00407 14.7729 2.3198 12.0887 2.3198 8.77745C2.3198 5.46623 5.00407 2.78195 8.31529 2.78195C11.6265 2.78195 14.3108 5.46623 14.3108 8.77745C14.3108 10.4198 13.6504 11.908 12.5807 12.9908C12.5716 12.999 12.5628 13.0075 12.554 13.0162C12.5453 13.0249 12.5368 13.0338 12.5286 13.0429Z" fill="#4E4E4E"></path>
											</svg>
											<div class="city_text_wrap">
												<div class="city_text">
													<input type="text" id="searchHotel" name="searchHotel" placeholder="도시 또는 호텔명을 검색해 보세요" />
												</div>
											</div>
										</div>
									</div>
									<div class="search_insert_date">
										<div class="search_date_display">
											<div class="date_check">
												<div class="date_text">
													<svg viewBox="0 0 20 21">
														<path fill-rule="evenodd" clip-rule="evenodd" d="M14.5952 3.67643H18.381C18.8149 3.67643 19.1667 4.04952 19.1667 4.50976V7.68436V18.7955C19.1667 19.2557 18.8149 19.6288 18.381 19.6288H1.61905C1.18511 19.6288 0.833333 19.2557 0.833333 18.7955V7.68436V4.50976C0.833333 4.04952 1.18511 3.67643 1.61905 3.67643H5.40476V2.1288C5.40476 1.66857 5.75654 1.29547 6.19048 1.29547C6.62441 1.29547 6.97619 1.66857 6.97619 2.1288V3.67643H13.0238V2.1288C13.0238 1.66857 13.3756 1.29547 13.8095 1.29547C14.2435 1.29547 14.5952 1.66857 14.5952 2.1288V3.67643ZM2.40476 8.51769V17.9621H17.5952V8.51769H2.40476ZM17.5952 6.85102H2.40476V5.34309H17.5952V6.85102ZM4.66667 10.0256H6.19048C6.62441 10.0256 6.97619 10.3987 6.97619 10.859V11.6526C6.97619 12.1129 6.62441 12.4859 6.19048 12.4859H4.66667C4.23273 12.4859 3.88095 12.1129 3.88095 11.6526V10.859C3.88095 10.3987 4.23273 10.0256 4.66667 10.0256ZM9.2381 10.0256H10.7619C11.1958 10.0256 11.5476 10.3987 11.5476 10.859V11.6526C11.5476 12.1129 11.1958 12.4859 10.7619 12.4859H9.2381C8.80416 12.4859 8.45238 12.1129 8.45238 11.6526V10.859C8.45238 10.3987 8.80416 10.0256 9.2381 10.0256ZM6.97619 14.8272C6.97619 14.367 6.62441 13.9939 6.19048 13.9939H4.66667C4.23273 13.9939 3.88095 14.367 3.88095 14.8272V15.6209C3.88095 16.0811 4.23273 16.4542 4.66667 16.4542H6.19048C6.62441 16.4542 6.97619 16.0811 6.97619 15.6209V14.8272ZM10.7619 13.9939C11.1958 13.9939 11.5476 14.367 11.5476 14.8272V15.6209C11.5476 16.0811 11.1958 16.4542 10.7619 16.4542H9.2381C8.80416 16.4542 8.45238 16.0811 8.45238 15.6209V14.8272C8.45238 14.367 8.80416 13.9939 9.2381 13.9939H10.7619ZM15.3333 10.0256H13.8095C13.3756 10.0256 13.0238 10.3987 13.0238 10.859V11.6526C13.0238 12.1129 13.3756 12.4859 13.8095 12.4859H15.3333C15.7673 12.4859 16.119 12.1129 16.119 11.6526V10.859C16.119 10.3987 15.7673 10.0256 15.3333 10.0256Z" fill="#4E4E4E"></path>
													</svg>
													<div class="date_innertext">
														<input type="date" id="checkin" name="checkin" value="${rcheckin }">
													</div>
												</div>
												<button class="date_btn_before" type="button">
													<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
													</svg>
												</button>
												<button class="date_btn_after" type="button">
													<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
													</svg>
												</button>
											</div>
											<div class="date_sep"></div>
											<div class="date_check">
												<div class="date_text">
													<svg viewBox="0 0 20 21">
														<path fill-rule="evenodd" clip-rule="evenodd" d="M14.5952 3.67643H18.381C18.8149 3.67643 19.1667 4.04952 19.1667 4.50976V7.68436V18.7955C19.1667 19.2557 18.8149 19.6288 18.381 19.6288H1.61905C1.18511 19.6288 0.833333 19.2557 0.833333 18.7955V7.68436V4.50976C0.833333 4.04952 1.18511 3.67643 1.61905 3.67643H5.40476V2.1288C5.40476 1.66857 5.75654 1.29547 6.19048 1.29547C6.62441 1.29547 6.97619 1.66857 6.97619 2.1288V3.67643H13.0238V2.1288C13.0238 1.66857 13.3756 1.29547 13.8095 1.29547C14.2435 1.29547 14.5952 1.66857 14.5952 2.1288V3.67643ZM2.40476 8.51769V17.9621H17.5952V8.51769H2.40476ZM17.5952 6.85102H2.40476V5.34309H17.5952V6.85102ZM4.66667 10.0256H6.19048C6.62441 10.0256 6.97619 10.3987 6.97619 10.859V11.6526C6.97619 12.1129 6.62441 12.4859 6.19048 12.4859H4.66667C4.23273 12.4859 3.88095 12.1129 3.88095 11.6526V10.859C3.88095 10.3987 4.23273 10.0256 4.66667 10.0256ZM9.2381 10.0256H10.7619C11.1958 10.0256 11.5476 10.3987 11.5476 10.859V11.6526C11.5476 12.1129 11.1958 12.4859 10.7619 12.4859H9.2381C8.80416 12.4859 8.45238 12.1129 8.45238 11.6526V10.859C8.45238 10.3987 8.80416 10.0256 9.2381 10.0256ZM6.97619 14.8272C6.97619 14.367 6.62441 13.9939 6.19048 13.9939H4.66667C4.23273 13.9939 3.88095 14.367 3.88095 14.8272V15.6209C3.88095 16.0811 4.23273 16.4542 4.66667 16.4542H6.19048C6.62441 16.4542 6.97619 16.0811 6.97619 15.6209V14.8272ZM10.7619 13.9939C11.1958 13.9939 11.5476 14.367 11.5476 14.8272V15.6209C11.5476 16.0811 11.1958 16.4542 10.7619 16.4542H9.2381C8.80416 16.4542 8.45238 16.0811 8.45238 15.6209V14.8272C8.45238 14.367 8.80416 13.9939 9.2381 13.9939H10.7619ZM15.3333 10.0256H13.8095C13.3756 10.0256 13.0238 10.3987 13.0238 10.859V11.6526C13.0238 12.1129 13.3756 12.4859 13.8095 12.4859H15.3333C15.7673 12.4859 16.119 12.1129 16.119 11.6526V10.859C16.119 10.3987 15.7673 10.0256 15.3333 10.0256Z" fill="#4E4E4E"></path>
													</svg>
													<div class="date_innertext">
														<input type="date" id="checkout" name="checkout" value="${rcheckout }">
													</div>
												</div>
												<button class="date_btn_before_a" type="button">
													<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
													</svg>
												</button>
												<button class="date_btn_after_a" type="button">
													<svg viewBox="0 0 8 5">
														<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
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
				                        		<input type="number" min="1" id="countRoom" name="countRoom" placeholder="객실수" />
				                        	</div>
				                        </div>
									</div>
								</div>
								<div class="search_insert_countPeople">
									<div class="search_people_display">
										<svg viewBox="0 0 200 200">
				                           <path d="M160.6 180H39.4c-1.6 0-3.2-.8-4.1-2.1c-8-11.5-6.8-32.8 2.2-41.5c3.9-3.8 23.8-10.5 35.6-14C58.8 108.1 50 95.4 50 70.9C50 38.6 68.2 20 100 20s50 18.6 50 50.9c0 23.8-8.2 36.7-23.1 51.5c11.8 3.5 31.6 10.2 35.6 14c9.1 8.7 10.3 30 2.3 41.5c-1 1.3-2.6 2.1-4.2 2.1zM42.3 170h115.5c4-8.3 2.4-21.8-2.1-26.3c-3.6-2.8-31.2-12.1-38.9-13.8c-3.5-.8-5.1-4.9-3-7.8c7.9-10.8 26.3-19.2 26.3-51.2c0-18.7-6.9-40.9-40-40.9S60 52.2 60 70.9c0 31.9 18.4 40.3 26.3 51.2c2.1 2.9.5 7.1-3 7.8c-7.7 1.6-35.3 10.9-38.9 13.7c-4.6 4.5-6.1 18.1-2.1 26.4zm2.2-26.4z"/>
				                        </svg>
				                        <div class="people_text_wrap">
				                        	<div class="people_text">
				                        		<input type="number" min="1" id="countPeople" name="countPeople" placeholder="인원수" />
				                        	</div>
				                        </div>
									</div>
								</div>
								<div class="search_insert_button_container">
									<button class="search_insert_button" type="submit"id="search">
										<span class="search_icon_container">
											<span class="search_icon">
												<svg viewBox="0 0 92 92">
													<path d="M20.8 39.27c0-11.016 8.808-19.976 19.637-19.976 10.827 0 19.635 8.96 19.635 19.972 0 11.014-8.808 19.976-19.635 19.976-10.83 0-19.64-8.96-19.64-19.976zm55.472 32.037l-15.976-16.25c3.357-4.363 5.376-9.835 5.376-15.788 0-14.16-11.32-25.67-25.232-25.67-13.923 0-25.24 11.51-25.24 25.67s11.32 25.67 25.237 25.67c4.776 0 9.227-1.388 13.04-3.74L69.84 77.85c1.77 1.8 4.664 1.8 6.432 0 1.77-1.8 1.77-4.744 0-6.544z" fill="currentColor" style="user-select: auto;"></path>
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
	</div>
	
	<div class="space1"></div>
	
	<div class="space2">
		<div class="space2_inner"></div>
	</div>
	
	<div class="other">
		<div class="popular">
			<div class="popular_destination">
				<div class="popular_destination_container">
					<div class="popular_destination_inner">
						<div class="popular_title">
							<h2>인기 여행지</h2>
						</div>
						<div class="popular_des_content">
							<div class="prev_arr_des" id="prevDes">
								<svg viewBox="0 0 9 16">
									<path d="M7.89 15.87l1.07-1.05L2.23 8l6.73-6.82L7.89.13.12 8l7.77 7.87"></path>
								</svg>
							</div>
							<div class="popular_des_container" id="slidebox_des">
								<div id="slide_des">
									<ul class="slider_des">
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/794e703d-city-35982-1620c5d9650.jpg">
												<div class="popular_des_text">
													<h3>서울</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/8bdba93d-city-41830-172044905bc.jpg">
												<div class="popular_des_text">
													<h3>부산</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/8ff30a1b-city-32610-17686cfdd47.jpg">
												<div class="popular_des_text">
													<h3>제주시</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/e4272fa0-city-44381-1685ca3a41f.jpg">
												<div class="popular_des_text">
													<h3>인천</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/97ff1445-city-48541-1685d9584dc.jpg">
												<div class="popular_des_text">
													<h3>서귀포시</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/07e926ab-city-52588-176cf00643c.jpg">
												<div class="popular_des_text">
													<h3>강릉</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/1ff45244-city-48734-176ddda3728.jpg">
												<div class="popular_des_text">
													<h3>속초</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/4cb1c668-city-55089-171f0446990.jpg">
												<div class="popular_des_text">
													<h3>여수</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/c8113f30-city-43930-17686d4c79f.jpg">
												<div class="popular_des_text">
													<h3>경주</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/79245e46-city-52889-17686cd7b82.jpg">
												<div class="popular_des_text">
													<h3>전주</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/dff004ea-city-55073-17061f273f3.jpg">
												<div class="popular_des_text">
													<h3>양양</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
										<li>
											<a href="#">
												<img src="${pageContext.request.contextPath}/resources/images/main/8f6ef4b5-city-33653-171f050398e.jpg">
												<div class="popular_des_text">
													<h3>수원</h3>
													<h4>대한민국</h4>
												</div>
											</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="next_arr_des" id="nextDes">
								<svg viewBox="0 0 9 16">
									<path d="M1.11 15.87L.04 14.82 6.77 8 .04 1.18 1.11.13 8.88 8l-7.77 7.87"></path>
								</svg>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="popular_hotel">
				<div class="popular_hotel_container">
					<div class="popular_title">
						<h2>지금 인기 있는 호텔</h2>
					</div>
					<div class="popular_hotel_content">
						<div class="popular_hotel_content_container">
							<div class="prev_arr_hotel" id="prevHotel">
								<svg viewBox="0 0 9 16">
									<path d="M7.89 15.87l1.07-1.05L2.23 8l6.73-6.82L7.89.13.12 8l7.77 7.87"></path>
								</svg>
							</div>
							<div class="popular_hotel_ul_container" id="slidebox_hotel">
								<div id="slide_hotel">
									<ul class="slider_hotel">
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/arbisoftimages-2077628-cornersuite2-385203.jpg">
													<div class="popular_hotel_text">
														<h3>정동진 썬크루즈</h3>
														<h4>강릉, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-1832279-12076490-406677.jpg">
													<div class="popular_hotel_text">
														<h3>랜딩관 제주신화월드 호텔앤리조트</h3>
														<h4>서귀포시, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/8c35d8f78260b5c9.jpg">
													<div class="popular_hotel_text">
														<h3>세인트존스 호텔</h3>
														<h4>강릉, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/ice-93102-68043206_3XL-448106.jpg">
													<div class="popular_hotel_text">
														<h3>아난티 힐튼</h3>
														<h4>부산, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-1374678-10966835-896878.jpg">
													<div class="popular_hotel_text">
														<h3>라마다 제주 시티 호텔</h3>
														<h4>제주시, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-10104-12548353-322377.jpg">
													<div class="popular_hotel_text">
														<h3>제주 신라 호텔</h3>
														<h4>서귀포시, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-1338436-11139252-293730.jpg">
													<div class="popular_hotel_text">
														<h3>신라스테이 해운대</h3>
														<h4>부산, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/hotelsdotcom-600178-0e927fd0_w-821565.jpg">
													<div class="popular_hotel_text">
														<h3>라마다 속초 호텔</h3>
														<h4>속초, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-6730-9988634-820594.jpg">
													<div class="popular_hotel_text">
														<h3>파라다이스 호텔 부산</h3>
														<h4>부산, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
										<li>
											<div class="popular_hotel_li_container">
												<a href="#">
													<img src="${pageContext.request.contextPath}/resources/images/main/revato-1865922-12031689-093701.jpg">
													<div class="popular_hotel_text">
														<h3>스카이베이 호텔 경포</h3>
														<h4>강릉, 대한민국</h4>
													</div>
												</a>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="next_arr_hotel" id="nextHotel">
								<svg viewBox="0 0 9 16">
									<path d="M1.11 15.87L.04 14.82 6.77 8 .04 1.18 1.11.13 8.88 8l-7.77 7.87"></path>
								</svg>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="faq">
			<div class="faq_container">
				<h6>최저가 예약을 위한 자주 묻는 질문 (FAQ)</h6>
				<div class="faq_question">
					<div class="faq_column">
						<div class="faq_column_container">
							<div class="faq_column_content">
								<div class="faq_question_title" onclick="accodionAction(this);">
									<div class="faq_question_text">J6컴바인에서 최저가를 예약하는 방법은 무엇입니까?</div>
									<button class="faq_question_arr">
										<svg viewBox="0 0 10 10">
											<path fill="currentColor" d="M4.4,7.32a0.84,0.84,0,0,0,1.2,0L9.07,3.85A0.84,0.84,0,0,0,7.88,2.67L5,5.55,2.12,2.67A0.84,0.84,0,0,0,.93,3.85Z" style="user-select: auto;"></path>
										</svg>
									</button>
								</div>
								<div class="faq_answer">J6컴바인은 국내외 주요 여행 사이트의 가격을 한곳에 모아 비교해드리는 메타 검색 브랜드입니다. 원하는 호텔을 다양한 옵션으로 필터링하여 한눈에 비교하고 예약할 수 있습니다. 게다가 J6컴바인은 추가 예약 수수료도 없다는 것, 잊지 마세요!</div>
							</div>
						</div>
						
						<div class="faq_column_container">
							<div class="faq_column_content">
								<div class="faq_question_title" onclick="accodionAction(this);">
									<div class="faq_question_text">J6컴바인 후기의 특별한 점은 무엇입니까?</div>
									<button class="faq_question_arr">
										<svg viewBox="0 0 10 10">
											<path fill="currentColor" d="M4.4,7.32a0.84,0.84,0,0,0,1.2,0L9.07,3.85A0.84,0.84,0,0,0,7.88,2.67L5,5.55,2.12,2.67A0.84,0.84,0,0,0,.93,3.85Z" style="user-select: auto;"></path>
										</svg>
									</button>
								</div>
								<div class="faq_answer">J6컴바인은 실제로 투숙했던 고객들의 생생한 후기만 보여드립니다. 주요 여행 사이트들의 후기를 한 번에 읽어보고 후회 없는 선택을 해보세요!</div>
							</div>
						</div>
					</div>
					<div class="faq_column">
						<div class="faq_column_container">
							<div class="faq_column_content">
								<div class="faq_question_title" onclick="accodionAction(this);">
									<div class="faq_question_text">J6컴바인의 회원 전용 혜택은 무엇입니까?</div>
									<button class="faq_question_arr">
										<svg viewBox="0 0 10 10">
											<path fill="currentColor" d="M4.4,7.32a0.84,0.84,0,0,0,1.2,0L9.07,3.85A0.84,0.84,0,0,0,7.88,2.67L5,5.55,2.12,2.67A0.84,0.84,0,0,0,.93,3.85Z" style="user-select: auto;"></path>
										</svg>
									</button>
								</div>
								<div class="faq_answer">J6컴바인 무료 가입 후 로그인하시면, 회원들에게만 제공하는 '시크릿 특가'를 확인하실 수 있습니다. 한 번의 회원 가입으로 최저가 그 이상의 혜택을 누려보세요!</div>
							</div>
						</div>
						
						<div class="faq_column_container">
							<div class="faq_column_content">
								<div class="faq_question_title" onclick="accodionAction(this);">
									<div class="faq_question_text">J6컴바인 앱(app)이 있습니까?</div>
									<button class="faq_question_arr">
										<svg viewBox="0 0 10 10">
											<path fill="currentColor" d="M4.4,7.32a0.84,0.84,0,0,0,1.2,0L9.07,3.85A0.84,0.84,0,0,0,7.88,2.67L5,5.55,2.12,2.67A0.84,0.84,0,0,0,.93,3.85Z" style="user-select: auto;"></path>
										</svg>
									</button>
								</div>
								<div class="faq_answer">물론입니다. 모바일과 태블릿에서도 J6컴바인을 사용하실 수 있습니다. 지금 바로 iOS 또는 안드로이드에서 "J6컴바인"을 검색하고 앱(APP)을 다운로드하세요!</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>