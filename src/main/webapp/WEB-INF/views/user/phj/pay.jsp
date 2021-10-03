<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제페이지</title>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<style>
	.paybox{
		float:left;
		width:75%;
		border:solid 1px;
		border-color:#BDBDBD;
		border-image:liner-gradient(to right,gray,white);
		margin:2% 2% 2% 2%;
		padding:7px;
	}
	.boxsize{
		width:85%;
		height:10%
	}
	.hiddenbox{
	
	}
</style>
</head>
<body>
<div class="header">
	<jsp:include page="../jhr/header.jsp" flush="true"/>
</div>
<form method="post" action="${pageContext.request.contextPath }/phj/payOk">
<div class="paybox" style="width:700px;text-align: center;margin-left: 30%;">
	<br><input style="width:60px;" type="hidden" id="rroomnum" name="rroomnum" value="${rroomnum }"><br>
	<input type="hidden" name="rid" id="rid" value="${rid }">
	<input type="hidden" id="ramount" value="${ramount }">
	<input type="hidden" id="rcheckin" value="${rcheckin }">
	<input type="hidden" id="rcheckout" value="${rcheckout }">
	<input type="hidden" id="rresname" value="${rresname }">
	<input type="hidden" id="rresemail" value="${rresemail }">
	<input type="hidden" id="rresphone" value="${rresphone }">
	<input type="hidden" id="rexbreaknum" value="${rexbreaknum }">
	<input type="hidden" id="rexbed" value="${rexbed }">
	<input type="hidden" id="rexperson" value="${rexperson }">
	<input type="hidden" id="rcancel" value="${rcancel }">
	<input type="hidden" id="mid" value="${mid }">
	<input type="hidden" id="riid" value="${riid }">
	<input type="hidden" id="rordernum" value="${rordernum }">
	<input type="hidden" id="rexperson" value="${rexperson }">
	<input type="hidden" id="rexbreaknum" value="${rexbreaknum }">
	<input type="hidden" id="rexbed" value="${rexbed }">
	<input type="hidden" id="totalbreakfee" value="${totalbreakfee }">
	<input type="hidden" id="totalbedfee" value="${totalbedfee }">
	
	<input type="hidden" id="totalpersonfee" value="${totalpersonfee }">
	<input type="hidden" id="breakfastfee" value="${breakfastfee }">
	<input type="hidden" name="prefund" id="prefund" value="${prefund }">
	<input type="hidden" id=sum value="${sum }" style="border: none;text-align: right;">
	<input name="totalFee" id="totalFee"type="hidden" value="" style="border: none"><br>
	<h2>예약을 완성하세요!</h2>
	<table class="table" style="margin:auto;">
		<tr>
			
			<img src="${pageContext.request.contextPath }/resources/images/accommodations/booking_phj.png"  style="text-align: center; width:100%;height: 100%;">
			
		</tr>
		<tr>
			<th>총 방 가격 </th>
			<td>${sum } * ${rroomnum }개</td>
		</tr>
		<tr>
			<th></th>
			<td id="totalsum"></td>
		</tr>
		<tr>
			<th>인원 추가 비용 </th>
			<td id="totalpersonfee1"></td>
		</tr>
		<tr>
			<th>조식 추가 비용 </th>
			<td id="totalbreakfee1"></td>
		</tr>
		<tr>
			<th>침대 추가 비용 </th>
			<td id="totalbedfee1"></td>
		</tr>
		<tr>
			<th>총 결제 가격 </th>
			<td id="totalFee1"></td>
		</tr>
	</table>
	<br>
	<span style="border:none; border-color:gray; font-size: 17px;">안전 결제  | 모든 카드 정보는 왼벽하게 암호화되어 안전하게 보호됩니다.</span>
	<br>
	<br>
	<div>
	<span style="font-size:17px;">결제방법 선택</span><br>
	<input type="button" id="card" value="신용/직불카드" class="btn btn-link" style="border-color: #6799FF; border-radius: 5px;">
	

	</div>
</div>
</form>
<div class="footer" style="clear:both;">
	<jsp:include page="../jhr/footer.jsp" flush="true"/>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		var totalpersonfee=parseInt($("#totalpersonfee").val());
		var totalbreakfee=parseInt($("#totalbreakfee").val());
		var totalbedfee=parseInt($("#totalbedfee").val());
		var sum=parseInt($("#sum").val());
		var rroomnum=parseInt($("#rroomnum").val());
		$('#totalpersonfee1').text(numberWithCommas(totalpersonfee));
		$('#totalbreakfee1').text(numberWithCommas(totalbreakfee));
		$('#totalbedfee1').text(numberWithCommas(totalbedfee));
		$('#totalsum').text(numberWithCommas(sum*rroomnum*1000));
		console.log(sum*rroomnum*1000);
		var total=(sum*rroomnum*1000)+totalpersonfee+totalbreakfee+totalbedfee;
		$('input[name=totalFee]').attr('value',numberWithCommas(total));
		$('#totalFee1').text(numberWithCommas(total));
		
	})
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
/*	$(function(){
		$('#kakao').click(function(){
			$.ajax({
				url:'/project/kakaopay',
				dataType:'json',
				success:function(data){
					window.open(data.next_redirect_pc_url);
				},
				error:function(error){
					alert(error);
				}
			})
		})
	})*/
	
	$("#card").click(function () {
		var totalFee=parseInt($("#totalFee").val());
		var rid=0;
		var ramount=parseInt($("#ramount").val());
		var rroomnum=parseInt($("#rroomnum").val());
		var rcheckin=$("#rcheckin").val();
		var rcheckout=$("#rcheckout").val();
		var rresname=$("#rresname").val();
		var rresemail=$("#rresemail").val();
		var rresphone=$("#rresphone").val();
		var rexbreaknum=$("#rexbreaknum").val();
		var rexbed=$("#rexbed").val();
		var rexperson=$("#rexperson").val();
		var rcancel=$("#rcancel").val();
		var mid=$("#mid").val();
		var riid=parseInt($("#riid").val());
		var rordernum=22;
		var IMP = window.IMP; // 생략가능
		IMP.init('imp42648943');
		// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
		// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드imp42648943
		IMP.request_pay({
		pg: 'inicis', // version 1.1.0부터 지원.
		/*
		'kakao':카카오페이,
		html5_inicis':이니시스(웹표준결제)
		'nice':나이스페이
		'jtnet':제이티넷
		'uplus':LG유플러스
		'danal':다날
		'payco':페이코
		'syrup':시럽페이
		'paypal':페이팔
		*/
		pay_method: 'card',
		/*
		'samsung':삼성페이,
		'card':신용카드,
		'trans':실시간계좌이체,
		'vbank':가상계좌,
		'phone':휴대폰소액결제
		*/
		merchant_uid: 'merchant_' + new Date().getTime(),
		/*
		merchant_uid에 경우
		https://docs.iamport.kr/implementation/payment
		위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
		참고하세요.
		나중에 포스팅 해볼게요.
		*/
		name: '주문명:숙소 예약',
		//결제창에서 보여질 이름
		amount: 500,
		//가격 totalFee
		buyer_email: '${rresemail }',
		buyer_name: '${rresname }',
		buyer_tel: '${rresphone}',
		buyer_addr: '서울특별시 강남구 삼성동',
		buyer_postcode: '123-456',
		m_redirect_url: '/project/approval'
		/*
		모바일 결제시,
		결제가 끝나고 랜딩되는 URL을 지정
		(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
		*/
		}, function (rsp) {
			console.log(rsp);
		if (rsp.success) {
			var msg = '결제가 완료되었습니다.\n';
			msg += '고유ID : ' + rsp.imp_uid;
			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
			msg += '\n결제 금액 : ' + rsp.paid_amount;
			msg += '\n카드 승인번호 : ' + rsp.apply_num;
			var ptoken=rsp.merchant_uid;
			$.ajax({
				url:'/project/phj/insert',
				data:JSON.stringify({"rid":rid,"rordernum":rordernum,"ramount":ramount,"rroomnum":rroomnum,"rcheckin":rcheckin,"rcheckout":rcheckout,
					"rresname":rresname,"rresphone":rresphone,"rresemail":rresemail,"rexbreaknum":rexbreaknum,
					"rexbed":rexbed,"rexperson":rexperson,"rcancel":rcancel,"mid":mid,"riid":riid,"ptoken":ptoken}),
				type:"post",
				dataType:"json",
				contentType:'application/json',
				success:function(data){
					console.log(data);
					if(data.code=='success'){
						console.log(data.ptoken);
						insertPaymentOk("card", data.rid,data.ptoken);
						console.log(data.code);
						location.href="/project/approval";
					}else{
						alert("실패");
					}
				}
			})
		} else {
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
		}
		alert(msg);
		});
	});
	
	function insertPaymentOk(pmethod, rid,ptoken){
		var ptotal=parseInt($("#totalFee").val().replace(/,/gi, ""));
		var mid=$("#mid").val();
		$.ajax({
			url:"/project/phj/paymentInsertOk",
			data:JSON.stringify({"pmethod":pmethod,"ptotal":ptotal,"rid":rid,"mid":mid,"ptoken":ptoken}),
			type:"post",
			dataType:"json",
			contentType:'application/json'
		})
	}
</script>
</html>