<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage_preferences.css">
<!-- 커밋 -->
<p class="title">개인 설정</p>
<br>
<div id="airport">
	<p class="text1">공항 선택</p>
	<p class="text2">나의 출발 공항 및 자주 방문하는 공항을 저장해두고 편하게 검색하세요.</p>
	<input type="text" placeholder="공항검색" class="select" id="airportselect">
	<div class="largebox" id="portbox"></div>
</div>
<div id="airline">
	<p class="text1">항공사 선택</p>
	<p class="text2">선호하는 항공사를 추가하여 더 나은 검색 결과를 얻으세요.</p>
	<input type="text" placeholder="항공사검색" class="select" id="airlineselect">
	<div class="largebox" id="linebox"></div>
</div>
<div id="hotelchain">
	<p class="text1">호텔 선택</p>
	<p class="text2">선호하는 호텔 체인을 추가하여 더 나은 검색 결과를 얻으세요.</p>
	<input type="text" placeholder="호텔검색" class="select" id="hotelselect">
	<div class="largebox" id="hotelbox"></div>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
//즐겨찾기 불러오기
function portlist(){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/portlist",
		dataType:"json",
		success:function(d){
			let favairport=d.arrayport;
			if(favairport!=null){
				$(favairport).each(function(i,d){
					let html1="<div>"+
					"<p class='dbtext'>&nbsp;&nbsp;"+d+
					"<a href='javascript:portdel("+i+")' style='cursor:pointer; color:white;'>&nbsp;&times;&nbsp;</a>"+
					"</p></div>";
					$(html1).appendTo("#portbox").css({
						position:'relative',
						float: "left",
						marginRight: "10px",
						Width: 'auto',
						height:'30px',
						fontSize: "15px",
						fontWeight:"bold",
						background:"black",
						color: "white",
						lineHeight: "28px",
						borderRadius: "10px"
					});
				});
			}
		}
	});
}
//데이터 삭제하기
function portdel(data){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/portdel",
		data:{"portnum":data},
		dataType:"json",
		success:function(d){
			if(d==1){
				alert("삭제가 완료되었습니다.");
				$("#portbox").empty();//비우기
				portlist();//업데이트 완료시 새로고침
			}
		}
	});
}

function linelist(){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/linelist",
		dataType:"json",
		success:function(d){
			let favarline=d.arrayline;
			if(favarline!=null){
				$(favarline).each(function(i,d){
					let html2="<div>"+
					"<p class='dbtext'>&nbsp;&nbsp;"+d+
					"<a href='javascript:linedel("+i+")' style='cursor:pointer; color:white;'>&nbsp;&times;&nbsp;</a>"+
					"</p></div>";
					$(html2).appendTo("#linebox").css({
						position:'relative',
						float: "left",
						marginRight: "10px",
						Width: 'auto',
						height:'30px',
						fontSize: "15px",
						fontWeight:"bold",
						background:"black",
						color: "white",
						lineHeight: "28px",
						borderRadius: "10px"
					});
				});
			}
		}
	});
}
//데이터 삭제하기
function linedel(data){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/linedel",
		data:{"linenum":data},
		dataType:"json",
		success:function(d){
			if(d==1){
				alert("삭제가 완료되었습니다.");
				$("#linebox").empty();//비우기
				linelist();//업데이트 완료시 새로고침
			}
		}
	});
}

function hotellist(){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/hotellist",
		dataType:"json",
		success:function(d){
			let favarhotel=d.arrayhotel;
			if(favarhotel!=null){
				$(favarhotel).each(function(i,d){
					let html3="<div class='ptbox'>"+
					"<p class='dbtext'>&nbsp;&nbsp;"+d+
					"<a href='javascript:hoteldel("+i+")' style='cursor:pointer; color:white;'>&nbsp;&times;&nbsp;</a>"+
					"</p></div>";
					$(html3).appendTo("#hotelbox").css({
						position:'relative',
						float: "left",
						marginRight: "10px",
						Width: 'auto',
						height:'30px',
						fontSize: "15px",
						fontWeight:"bold",
						background:"black",
						color: "white",
						lineHeight: "28px",
						borderRadius: "10px"
					});
				});
			}
		}
	});
}
//데이터 삭제하기
function hoteldel(data){
	$.ajax({
		type:'get',
		url:"${pageContext.request.contextPath }/user/kjy/hoteldel",
		data:{"hotelnum":data},
		dataType:"json",
		success:function(d){
			if(d==1){
				alert("삭제가 완료되었습니다.");
				$("#hotelbox").empty();//비우기
				hotellist();//업데이트 완료시 새로고침
			}
		}
	});
}

//공항자동검색
$("#airportselect").autocomplete({
	source:function(request,response){
		let portname=$("#airportselect").val();
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/user/kjy/airportsearch",
			data:{"portname":portname},
			dataType:"json",
			success:function(data){
				response(
					$.map(data.port,function(item){
						if(item.portname!=null){
							return{
								label:item.portname,
								value:item.portname
							}
						}
					})		
				);
			}
		});
	},
	select: function (e, ui) {
		var airport=ui.item.label;
		if(confirm("등록하시겠습니까?") == true){
			$.ajax({
				type:'get',
				url:"${pageContext.request.contextPath }/user/kjy/airportup",
				data:{"airport":airport},
				dataType:"json",
				success:function(data){
					if(data=='1'){
						$("#portbox").empty();//비우기
						portlist();//업데이트 완료시 새로고침
					}
				}
			});
		}else{
			return;
		}
	}
}),
//항공사자동검색
$("#airlineselect").autocomplete({
	source:function(request,response){
		let airname=$("#airlineselect").val();  
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/user/kjy/airlinesearch",
			data:{"airname":airname},
			dataType:"json",
			success:function(data){
				response(
					$.map(data.air,function(item){
						if(item.airname!=null){
							return{
								label:item.airname,
								value:item.airname
							}
						}
					})		
				);
			}
		});
	},
	select: function (e, ui) {
		var airline=ui.item.label;
		if(confirm("등록하시겠습니까?") == true){
			$.ajax({
				type:'get',
				url:"${pageContext.request.contextPath }/user/kjy/airlineup",
				data:{"airline":airline},
				dataType:"json",
				success:function(data){
					if(data=='1'){
						$("#linebox").empty();//비우기
						linelist();//업데이트 완료시 새로고침
					}
				}
			});
	    }
	    else{
	        return;
	    }
	}
}),
//호텔자동검색
$("#hotelselect").autocomplete({
	source:function(request,response){
		let hotel=$("#hotelselect").val();  
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/user/kjy/hotelseach",
			data:{"hotel":hotel},
			dataType:"json",
			success:function(data){
				response(
					$.map(data.hotel,function(item){
						if(item.krchainname!=null){
							return{
								label:item.krchainname+","+item.engchainname,
								value:item.krchainname+","+item.engchainname
							}
						}
					})		
				);
			}
		});
	},
	select: function (e, ui) {
		var hotel=ui.item.label;
		if(confirm("등록하시겠습니까?") == true){
			$.ajax({
				type:'get',
				url:"${pageContext.request.contextPath }/user/kjy/hotelup",
				data:{"hotel":hotel},
				dataType:"json",
				success:function(data){
					if(data=='1'){
						$("#hotelbox").empty();//비우기
						hotellist();//업데이트 완료시 새로고침
					}
				}
			});
		}else{
			return;
		}
	}
});


//포커스안 내용지우기
$("#airportselect").focusout(function(){
	$(this).val("");
});
$("#airlineselect").focusout(function(){
	$(this).val("");
});
$("#hotelselect").focusout(function(){
	$(this).val("");
});

//즐겨찾기 리스트불러오기
portlist();
linelist();
hotellist();

</script>
