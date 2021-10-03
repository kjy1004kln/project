<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findid.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypageQnalist.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>

<h3>나의 문의 내역</h3>
<div id="category">
	<select id="field">
		<option value="all" <c:if test="${field=='all' }">selected</c:if>>전체</option>
		<option value="상품" <c:if test="${field=='cate1' }">selected</c:if>>상품</option>
		<option value="교환/환불" <c:if test="${field=='cate2' }">selected</c:if>>교환/환불</option>
		<option value="사이트이용" <c:if test="${field=='cate3' }">selected</c:if>>사이트이용</option>
		<option value="기타" <c:if test="${field=='cate4' }">selected</c:if>>기타</option>
	</select>
</div>
<div id="qnalist">
</div>
<div id="qnapage">
</div>
<script type="text/javascript">
	var category;
	$("#field").on('change',function(){
		category=$(this).val();
		list();
	});
	
	function list(pageNum) {
		$("#qnalist").empty();
		$.ajax({
			type:'get',
			url:"${pageContext.request.contextPath }/user/jhr/list",
			data:{'pageNum':pageNum,'category':category},
			dataType:"json",
			success:function(data){
				var list=data.list;
				var html1="<table width='1000' border='1' id='test'>"+
				"<tr><th class='widlen'>글 번호</th><th class='widcate'>카테고리</th><th class='widlen3'>제목</th><th class='widlen3'>내용</th>"+
				"<th class='widdate'>작성일</th><th class='widlen2'>처리여부</th><th class='widlen'>삭제</th><th class='widlen2'>수정</th></tr></table>";
				$("#qnalist").append(html1);
				$(list).each(function(i,d){
					if(d.qlev==null){
						console.log('dd')
						var html2="<tr>"+
						"<td id='qid' class='cate widlen'>"+d.qid+"</td>"+
						"<td id='qcate' class='widcate cate'>"+d.qcate+"</td>"+
						"<td id='qtitle'><a class='widcon' href='${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid="+d.qid+"&qcate="+d.qcate+"'>"+d.qtitle+"</a></td>"+
						"<td id='qcontent'><p class='widcon'>"+d.qcontent+"</p></td>"+
						"<td id='qrdate' class='cate widdate'>"+d.qrdate+"</td>"+
						"<td id='qlev' class='cate widlen2'>N</td>"+
						"<td class='cate widlen'><a href='/project/jhr/myqnaDelete?mid="+d.mid+"&qid="+d.qid+"'>삭제</a></td>"+
						"<td class='cate widlen2'><a href='/project/jhr/myqnaUpdate?mid="+d.mid+"&qid="+d.qid+"'>수정</a></td>"+
						"</tr>";
					}else{
						console.log('dddd')
						var html2="<tr>"+
						"<td id='qid' class='cate widlen'>"+d.qid+"</td>"+
						"<td id='qcate' class='widcate cate'>"+d.qcate+"</td>"+
						"<td id='qtitle'><a class='widcon' href='${pageContext.request.contextPath }/hjy/qna/qnaDetail?qid="+d.qid+"&qcate="+d.qcate+"'>"+d.qtitle+"</a></td>"+
						"<td id='qcontent'><p class='widcon'>"+d.qcontent+"</p></td>"+
						"<td id='qrdate' class='cate widdate'>"+d.qrdate+"</td>"+
						"<td id='qlev' class='cate widlen2'>"+d.qlev+"</td>"+
						"<td class='cate widlen'><a href='/project/jhr/myqnaDelete?mid="+d.mid+"&qid="+d.qid+"'>삭제</a></td>"+
						"<td class='cate widlen2'>수정불가</td>"+
						"</tr>";
					}
					$("#test").append(html2);
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
					pageHtml += "<a href='javascript:list("+ 1 + ")'><span style='color:blue'>"+ 1 + "</span></a> ";
					startPage++;
				}
				for(let i=startPage;i<=endPage;i++){
					if(i==pageNum){
						pageHtml += "<a href='javascript:list("+ i + ")'><span style='color:blue'>"+ i + "</span></a> ";
					}else if(pageNum==null){
						pageHtml += "<a href='javascript:list("+ i + ")'><span style='color:gray'>"+ i + "</span></a> ";
					}else{
						pageHtml += "<a href='javascript:list("+ i + ")'><span style='color:gray'>"+ i + "</span></a> ";
					}	
				}
				if(endPage<pageCount){
					pageHtml += "<a href='javascript:list("+ (endPage+1) + ")'>다음</a>";
				}
				$("#qnapage").html(pageHtml);
			}
		});
	}
	list();
</script>