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

<!------ Include the above in your HEAD tag ---------->
<script type="text/javascript">
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
});
</script>
</head>
<body>
<form method="post" action="${pageContext.request.contextPath }/lhjcjyhjy/firstsearch">
	<div>
	호텔명 or 지역
	<input type="text" id="searchHotel" name="searchHotel">
	체크인
	<input type="date" name="checkin">
	체크아웃
	<input type="date" name="checkout">
	<div class="form-group">
	  <label for="filter">객실수</label>
	  <input type="number" min="1" id="countRoom" name="countRoom">
	</div>
	<div class="form-group">
	  <label for="contain">인원수</label>
	  <input type="number" min="1" id="countPeople" name="countPeople">
	</div>                  
	<input type="submit" value="검색" id="search">
	</div>
</form>
<div class="accommList">
	<c:forEach var="vo" items="${list }">
		<div class="eachList">
		    <div class="card">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-3">
		                   <img src="${pageContext.request.contextPath }/resources/img/${vo.amainimg }" width="300" height="250">
		                </div>
		                <div class="col-md-7">
		                    <h3>${vo.aname }</h3>
		                    <small>${vo.aaddress }</small>
		                    <p><small>지도보기?뭐든추가</small></p>
		                </div>
		                <div class="col-md-2">
		                	<h5>${vo.SUM}원</h5>
		                    <button type="button" class="btn">예약하기</button>  
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</c:forEach>
</div>         
</body>
</html>