<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>J6 게시판</title>

<!-- 닉네임 눌러서 선객하틑 관련 -->
<link href="${pageContext.request.contextPath }/admin/css/sb-admin-2.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/admin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.bundle.min.js"></script>
	
	
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/boardDetail.css">
<style type="text/css">
element.style {
	transform: translate3d(0px, 0px, 0px);
}
.dropdown-list {
	transform: translate3d(0px, 0px, 0px);
}
</style>
</head>
<body>
	<div class="header">
		<jsp:include page="/WEB-INF/views/user/jhr/header.jsp" flush="true"/>
	</div>
	<div class="board_header">
		<jsp:include page="board_header.jsp" flush="true"/>
	</div>
	<div class="container">
		<div class="card">
			<table class="table">
				<tr>
					<th>글번호</th>
					<td>${vo.bid }</td>
				</tr>
				<tr>
					<th>제목</th>
					<td><strong>${vo.btitle }</strong></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td>
						<c:choose>
							<c:when test="${my != null}">
								${vo.mid }
							</c:when>
							<c:otherwise>
								<ul class="navbar-nav ml-auto re_container">
						        	<li class="nav-item dropdown no-arrow mx-1 re_box">
										<a class="nav-link dropdown-toggle user" href="#" role="button"
							                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${vo.mid }
							            </a>
						                <div class="dropdown-list dropdown-menu shadow animated--grow-in"
					                    	aria-labelledby="alertsDropdown"style="position: absolute; top: 10px;left:10px;">
											<!-- Dropdown - Alerts -->
							                <a class="dropdown-item d-flex align-items-center" href="#">
							                    <%--
							                    <div class="mr-3">
							                        <div class="icon-circle bg-primary">
							                        	<img src="">
							                        </div>
							                    </div>
							                     --%>
							                    <div>
							                        <span class="font-weight-bold">
							                        	<div class="small text-gray-500" onclick='friendreq("${vo.mid }");'>친구요청</div>
							                        </span>
							                    </div>
							               	</a>
											<%--
							                    <div>
							                        <span class="font-weight-bold">
														<a href='javascript:friendreq("\${mid}");'>프로필보기</a></li>
							                        </span>
							                    </div>
							                    --%>
						                </div>
									</li>
								</ul>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr>
					<th>작성일</th>
					<td>${vo.brdate }</td>
				</tr>
				<tr>
					<th colspan="2">내용</th>
				</tr>
				<tr>
					<td colspan="2">
						<div id="imgbox">
							${vo.bcontent }<br>
							<img src="${pageContext.request.contextPath }/resources/images/board/${vo.bfile1 }" onerror="this.style.display='none'" style='width:50%; margin-top:5px;'>
							<img src="${pageContext.request.contextPath }/resources/images/board/${vo.bfile2 }" onerror="this.style.display='none'" style='width:50%; margin-top:5px;'>
							<img src="${pageContext.request.contextPath }/resources/images/board/${vo.bfile3 }" onerror="this.style.display='none'" style='width:50%; margin-top:5px;'>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<br>
		<div class="card">
			<div class="cmtHead">
				<h4>
					댓글<strong id="comment">(${cnt})</strong>
				</h4>
			</div>
			<hr>
			<c:if test="${cnt ==0}">
				<div class="no_re">
					댓글이 없습니다.
				</div>
			</c:if>
			<c:if test="${cnt !=0}">
				<div id="cmt"></div>
			</c:if>
		</div>
		<br>
			<div class="card mb-2">
				<div class="card-header bg-light">
				        <i class="fa fa-comment fa"></i> 
				</div>
				<div class="card-body">
					<ul class="list-group list-group-flush">
					    <li class="list-group-item">
						<div class="form-inline mb-2">
							${mid }
						</div>
						<textarea class="form-control" id="ccontentText"  placeholder="댓글을 남겨보세요." rows="3"></textarea>
						<br><button type="button" class="btn btn-outline-primary" id="btnAdd">등록</button> 
					    </li>
					</ul>
				</div>
			</div>
			
		<div class="more_content">
			<div class="more_prev">
				<c:choose>
					<c:when test="${prevVo eq null }">
						<p>이전글 없음</p>
					</c:when>
					<c:otherwise>
						이전글 <a href="${pageContext.request.contextPath }/hjy/board/detail?bid=${prevVo.bid }">${prevVo.btitle }</a>
					</c:otherwise>
				</c:choose>
			</div>
			<div class="more_next">
				<c:choose>
					<c:when test="${nextVo eq null }">
						<p>다음글 없음</p>
					</c:when>
					<c:otherwise>
						다음글 <a href="${pageContext.request.contextPath }/hjy/board/detail?bid=${nextVo.bid }">${nextVo.btitle }</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<br>
	</div>
	<div class="footer">
		<jsp:include page="/WEB-INF/views/user/jhr/footer.jsp" flush="true"/>
	</div>
</body>
		<script type="text/javascript">
			$(document).ready(function() {
				list();
				$("#btnAdd").click(function(){
					$.ajax({
						url:"${pageContext.request.contextPath }/hjy/commentInsert",
						data:{"ccontent":$("#ccontentText").val(),"bid":${vo.bid}},
						type:"post",
						dataType:"json",
						success:function(data){
							if(data.code=='success'){
								list();
							}else{
								alert(data.code)
							}
						}
					});
					$("#ccontentText").val("")
				});
			});
			function list(){
				$.ajax({
					url:"${pageContext.request.contextPath }/hjy/commentList",
					data:{"bid":${vo.bid}},
					type:"get",
					dataType:"json",
					success:function(data){
						$("#comment").html("("+data.cnt+")");
						$("#cmt").empty();
						let myid="${mid }";
						let html ="<ul>";
						for (var i = 0; i < data.list.length; i++) {
							html +="<li class='row' id='cmt"+i+"'>";
						if(data.list[i].clev>0){
							for (var j = 0; j < data.list[i].clev; j++) {
								html += "&nbsp;&nbsp&nbsp;&nbsp";
							}
							html +="<img src='https://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_re.gif' style='object-fit: none; margin:0 10px 55px 0;'>";
						}
						let mid = data.list[i].mid;
						let crdate = dateFormat(data.list[i].crdate);
						//삭제된 댓글이 아닐때 실행될곳
						if(data.list[i].cisdel==null){
							html +="<div>";
							html+=
								`
								<ul class="navbar-nav ml-auto re_container">
					        	<!-- Nav Item - Alerts -->
					        	<li class="nav-item dropdown no-arrow mx-1 re_box">`
					        	//아이디가 본인꺼일때 실행
							if(mid=="${mid}"){
								html+=
									`
										<div>
					            		\${mid}
							            <p style='color: gray;'>(\${crdate})</p>
							            </div>
							        	</li>
							        </ul>
									`	
							}else{
								//아이디가 본인이 아닐때 실행
					        	html+=`
				            		<a class="nav-link dropdown-toggle user" href="#" role="button"
					                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">\${mid}
						            </a>
						            <p style='color: gray;'>(\${crdate})</p>
					                <div class="dropdown-list dropdown-menu shadow animated--grow-in"
					                    aria-labelledby="alertsDropdown">
						                <div id="reqlist\${i}">
											<!-- Dropdown - Alerts -->
							                <a class="dropdown-item d-flex align-items-center" href="#">
							                    <%--
							                    <div class="mr-3">
							                        <div class="icon-circle bg-primary">
							                        	<img src="">
							                        </div>
							                    </div>
							                     --%>
							                    <div>
							                        <span class="font-weight-bold">
							                        	<div class="small text-gray-500" onclick='friendreq("\${mid}");'>친구요청</div>
							                        </span>
							                    </div>
							               	</a>
											<%--
							                    <div>
							                        <span class="font-weight-bold">
														<a href='javascript:friendreq("\${mid}");'>프로필보기</a></li>
							                        </span>
							                    </div>
							                    --%>
						                </div>
					                </div>
					        	</li>
					        </ul>
							`	
								}
							html +="<div>";
							html +="<span>"+data.list[i].ccontent+"</span>";
							html +="</div>";
							html +="<div id='cmtcmt"+i+"'>";
							html +="</div>";
							html +="</div>";
							html +="<div class='re'>"
							html +="<a href='javascript:commentPlus("+data.list[i].cid+","+i+")'>답글</a>";
							if(data.list[i].mid=='${mid}'){
								html +="<span>&nbsp;|&nbsp;</span><a href='javascript:updateForm("+data.list[i].cid+","+i+")'>수정</a>";
								html +="<span>&nbsp;|&nbsp;</span><a href='javascript:deleteForm("+data.list[i].cid+")'>삭제</a>";
							}
							html +="</div>";
						}else{//삭제된 댓글일때 실행
							html+=
								`
				        		<div>
						        	\${mid}
						            <p style='color: gray;'>(\${crdate})</p>
					        		삭제된 댓글입니다.
				        		</div>
						        <br>
							`
						}
							html +="</li>";
						}
						html +="</ul>";
						$("#cmt").append(html)
					}
				})
			}
			
			function friendreq(id){
				let checkdel = confirm(id+"님에게 친구요청을 보내시겠습니까?");
				if(checkdel == true){
					$.ajax({
			    		type : "GET",
			    		url :"${pageContext.request.contextPath }/hjy/friendreq",
			    		data : {"reqId":id,"myId":"${mid }"},
			    		dataType:"json",
				    	success:function(data){
				    		alert(data.result)
						}
					})
				}
			}
			
			function deleteForm(cid){
				$.ajax({
					url:"${pageContext.request.contextPath }/hjy/deleteForm",
					data:{"cid":cid},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code=='success'){
							list();
						}else{
							alert(data.code)
						}
					}
				});
			}
			function updateForm(cid, num){
					$.ajax({
						url:"${pageContext.request.contextPath }/hjy/findComment",
						data:{"cid":cid},
						type:"post",
						dataType:"json",
						success:function(data){
							let updateHtml = "";
							if(data.vo.clev>0){
								for (var j = 0; j < data.vo.clev; j++) {
									updateHtml += "&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp";
								}
								updateHtml +="<img src='https://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_re.gif' style='object-fit: none; margin-bottom:65px;'>";
							}
							updateHtml +="<div>";
							updateHtml +="<img src=''><span>"+data.vo.mid+"</span>";
							let crdate = dateFormat(data.vo.crdate);
							updateHtml +="<br><span style='color: gray;'>("+crdate+")</span><br>";
							updateHtml +="<br><input type='text' value='"+data.vo.ccontent+"' id='ccontent"+num+"'><br>";
							updateHtml +="<div class='re'>";
							updateHtml +="<a href='javascript:list()'>취소</a>";
							updateHtml +="<span>|</span><a href='javascript:updatedb("+cid+","+num+")'>확인</a>";
							updateHtml +="</div>";
							updateHtml +="</div>";
							$("#cmt"+num).html(updateHtml);
						}
					});
			}
			function updatedb(cid,num){
				$.ajax({
					url:"${pageContext.request.contextPath }/hjy/updateComment",
					data:{"cid":cid,"ccontent":$("#ccontent"+num).val()},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code=='success'){
							list();
						}else{
							alert(data.code)
						}
					}
				});
			}
			
			function commentPlusDb(cid,num){
				$.ajax({
					url:"${pageContext.request.contextPath }/hjy/updateCommentPlus",
					data:{"cid":cid,"ccontent":$("#cmtcmttext"+num).val()},
					type:"post",
					dataType:"json",
					success:function(data){
						if(data.code=='success'){
							list();
						}else{
							alert(data.code)
						}
					}
				});
			}

			function commentPlus(cid,num){	
				var cmtHtml = "";
				cmtHtml +="<div>";
				cmtHtml +="&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp&nbsp;&nbsp";
				cmtHtml +="<img src='https://img.echosting.cafe24.com/design/skin/admin/ko_KR/ico_re.gif' style='object-fit: none; margin-right: 5px;'>";
				cmtHtml +="${mid}: <input type='text' placeholder='댓글을 입력하세요.' id='cmtcmttext"+num+"' style='margin-right: 5px;'>";
				cmtHtml +="<a href='javascript:list()'>취소</a>";
				cmtHtml +="<span>|</span><a href='javascript:commentPlusDb("+cid+","+num+")'>확인</a>";
				cmtHtml +="</div>";
				$("#cmtcmt"+num).append(cmtHtml);
			
			}
			function dateFormat(date) {
				var dt = new Date(date);
		        let month = dt.getMonth() + 1;
		        let day = dt.getDate();
		        let hour = dt.getHours();
		        let minute = dt.getMinutes();
		        let second = dt.getSeconds();

		        month = month >= 10 ? month : '0' + month;
		        day = day >= 10 ? day : '0' + day;
		        hour = hour >= 10 ? hour : '0' + hour;
		        minute = minute >= 10 ? minute : '0' + minute;
		        second = second >= 10 ? second : '0' + second;

		        return dt.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
			}
			
		</script>
</html>