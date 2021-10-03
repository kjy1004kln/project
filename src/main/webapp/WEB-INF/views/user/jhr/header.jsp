<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>header.jsp</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
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
						<a href="${pageContext.request.contextPath }/hjy/hotelForm">숙소등록</a>
					</div>
					<div class="nav_acco">
						<c:choose>
							<c:when test="${empty sessionScope.mid }">
								<!-- 로그인이 안되어있을때 -->
							</c:when>
							<c:otherwise>
								<a href="#none" target="_blank" onclick="openchat()">채팅</a><br>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="nav_mypage">
						<c:choose>
							<c:when test="${empty sessionScope.mid }">
								<!-- 로그인이 안되어있을때 -->
							</c:when>
							<c:otherwise>
								<a href="${pageContext.request.contextPath }/user/kjy/mypage">마이트립</a>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="nav_login">
				 	<c:choose>
				 		<c:when test="${empty mid }">
							<a href="${pageContext.request.contextPath }/jhr/login">로그인</a>
 						</c:when>			
				 		<c:otherwise>
							<a href="${pageContext.request.contextPath }/jhr/logout">로그아웃</a>
				 		</c:otherwise>
 					</c:choose>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	function openchat(){
	    var popup = window.open('${pageContext.request.contextPath }/user/kjy/chat_main', '채팅팝업', 'width=400px,height=700px,scrollbars=no,location=no');
	}
	document.addEventListener("DOMContentLoaded", function(event) {
		let path = document.location.pathname;
		var array = new Array();
		array= path.split("/");
		let addpath;
		for (var i = 0; i < array.length; i++) {
			if(array[i]=='board'){
				addpath="/hjy/board/all";
				break;
			}else if(array[i]=='qna'){
				addpath="/hjy/qna";
				break;
			}else{
				addpath="/";
			}
		}
		$('.nav').find('a[href="/project'+addpath+'"]').parents('li').addClass('header_active');
	});
</script>