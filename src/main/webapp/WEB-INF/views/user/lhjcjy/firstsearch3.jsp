<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> firstsearch.jsp </title>
<style type="text/css">
body {
    padding-top: 50px;
}
.dropdown.dropdown-lg .dropdown-menu {
    margin-top: -1px;
    padding: 6px 20px;
}
.input-group-btn .btn-group {
    display: flex !important;
}
.btn-group .btn {
    border-radius: 0;
    margin-left: -1px;
}
.btn-group .btn:last-child {
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
}
.btn-group .form-horizontal .btn[type="submit"] {
  border-top-left-radius: 4px;
  border-bottom-left-radius: 4px;
}
.form-horizontal .form-group {
    margin-left: 0;
    margin-right: 0;
}
.form-group .form-control:last-child {
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
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
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/firstsearchmain.css">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery-ui.min.css">

<script type="text/javascript">
function showID(id){
	obj=document.getElementById(id);
		if(obj.style.display == "none") 
		  obj.style.display="inline";
		else
		  obj.style.display="none";
}
$(function(){	
	$("#ttt").click(function(){
		let countRoom=$("#countRoom").val();
		let countPeople=$("#countPeople").val();
		console.log(countRoom)
		$("#ttt").val("인원수:"+countRoom+"  객실수:"+countPeople)
	})
})
function collectInfo(){
	let countRoom=$("#countRoom").val();
	let countPeople=$("#countPeople").val();
	console.log(countRoom)
	$("#showInfo").val("객실"+countRoom+"인원"+countPeople);
}
$(function(){
	/*
	function collectInfo(){
		let countRoom=$("#countRoom").val();
		let countPeople=$("#countPeople").val();
		console.log(countRoom)
		$("#showInfo").val("객실"+countRoom+"인원"+countPeople);
	}
	*/
	
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
});
</script>
</head>
<body>
<div class="search">
	<div class="search_container">
		<form class="search_content" method="post" action="${pageContext.request.contextPath }/lhjcjy/firstsearch3">
			<div class="search_number">
				<div class="search_number_container">
					<button class="search_number_button">
						<div class="search_number_text">
							<div class="search_text_inner">
								<div class="search_text">
									객실 1개, 투숙객 2명 
								</div>
							</div>
						</div>
						<div class="search_number_arr">
							<svg viewBox="0 0 8 5">
								<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
							</svg>
						</div>
					</button>
				</div>
			</div>
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
										<input type="text" id="searchHotel" name="searchHotel">
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
											<input type="date" name="checkin">
										</div>
									</div>
									<button class="date_btn_before">
										<svg viewBox="0 0 8 5">
											<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
										</svg>
									</button>
									<button class="date_btn_after">
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
											<input type="date" name="checkout">
										</div>
									</div>
									<button class="date_btn_before">
										<svg viewBox="0 0 8 5">
											<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
										</svg>
									</button>
									<button class="date_btn_after">
										<svg viewBox="0 0 8 5">
											<path d="M7 1.053L4.027 4 1 1" stroke="currentColor" fill="none" style="user-select: auto;"></path>
										</svg>
									</button>
								</div>
							</div>
						</div>
						<div class="search_insert_countRoom">
							<div class="search_room_display">
								<svg viewBox="0 0 20 21">
									<path fill-rule="evenodd" clip-rule="evenodd" d="M8.31529 16.2594C4.18311 16.2594 0.833313 12.9096 0.833313 8.77745C0.833313 4.64527 4.18311 1.29547 8.31529 1.29547C12.4475 1.29547 15.7973 4.64527 15.7973 8.77745C15.7973 10.5759 15.1628 12.2261 14.1054 13.5165L18.949 18.36C19.2392 18.6503 19.2392 19.1209 18.949 19.4111C18.6587 19.7014 18.1881 19.7014 17.8979 19.4111L13.0543 14.5676C11.7639 15.6249 10.1137 16.2594 8.31529 16.2594ZM12.5286 13.0429C11.4458 14.1126 9.95766 14.7729 8.31529 14.7729C5.00407 14.7729 2.3198 12.0887 2.3198 8.77745C2.3198 5.46623 5.00407 2.78195 8.31529 2.78195C11.6265 2.78195 14.3108 5.46623 14.3108 8.77745C14.3108 10.4198 13.6504 11.908 12.5807 12.9908C12.5716 12.999 12.5628 13.0075 12.554 13.0162C12.5453 13.0249 12.5368 13.0338 12.5286 13.0429Z" fill="#4E4E4E"></path>
								</svg>
								<div class="room_text_wrap">
									<div class="room_text">
										<div id="content_bt">
										<!-- 
									    	<input type="button" onclick="showID('content');" id="ttt" value="인원수,객실수">
									        <div id="content" style="display:none;">
											   인원수 <input type="number" min="1" id="countPeople"><br>
										       객실수 <input type="number" min="1" id="countRoom">
									    	</div>
									    	 -->
									    </div>								    	 
										<input type="number" min="1" id="countRoom" name="countRoom">
									</div>
								</div>
							</div>
						</div>
						<div class="search_insert_countPeople">
							<div class="search_people_display">
								<svg viewBox="0 0 20 21">
									<path fill-rule="evenodd" clip-rule="evenodd" d="M8.31529 16.2594C4.18311 16.2594 0.833313 12.9096 0.833313 8.77745C0.833313 4.64527 4.18311 1.29547 8.31529 1.29547C12.4475 1.29547 15.7973 4.64527 15.7973 8.77745C15.7973 10.5759 15.1628 12.2261 14.1054 13.5165L18.949 18.36C19.2392 18.6503 19.2392 19.1209 18.949 19.4111C18.6587 19.7014 18.1881 19.7014 17.8979 19.4111L13.0543 14.5676C11.7639 15.6249 10.1137 16.2594 8.31529 16.2594ZM12.5286 13.0429C11.4458 14.1126 9.95766 14.7729 8.31529 14.7729C5.00407 14.7729 2.3198 12.0887 2.3198 8.77745C2.3198 5.46623 5.00407 2.78195 8.31529 2.78195C11.6265 2.78195 14.3108 5.46623 14.3108 8.77745C14.3108 10.4198 13.6504 11.908 12.5807 12.9908C12.5716 12.999 12.5628 13.0075 12.554 13.0162C12.5453 13.0249 12.5368 13.0338 12.5286 13.0429Z" fill="#4E4E4E"></path>
								</svg>
								<div class="people_text_wrap">
									<div class="people_text">
										 <input type="number" min="1" id="countPeople" name="countPeople">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="search_insert_button_container">
						<button class="search_insert_button" type="submit" id="search">
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
</body>
</html>