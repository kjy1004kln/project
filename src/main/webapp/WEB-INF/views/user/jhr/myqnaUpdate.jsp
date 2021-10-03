<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지_나의 문의 내역 수정</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myqnaUpdate.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="header">
	<jsp:include page="/WEB-INF/views/user/jhr/header.jsp"/>
</div>
<div class="myqnaupdate">
	<div class="qnaupdate">
		<form method="post" action="${pageContext.request.contextPath }/jhr/myqnaUpdate" class="qna_update">
			<input type="hidden" name="qid" value="${vo.qid }"><br>
			<h3>나의 문의 수정하기</h3>
			
			<div class="qnaup">
				<div class="qnaup_col1">
					<label for="">카테고리</label>
				</div>
				<div class="qnaup_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="qcate" class="input_space" value="${vo.qcate }" readonly="readonly">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="qnaup">
				<div class="qnaup_col1">
					<label for="">제목</label>
				</div>
				<div class="qnaup_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="qtitle" class="input_space" value="${vo.qtitle }">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="qnaup">
				<div class="qnaup_col1">
					<label for="">작성자</label>
				</div>
				<div class="qnaup_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<input type="text" name="mid" class="input_space" value="${vo.mid }" readonly="readonly">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="qnaup">
				<div class="qnaup_col1">
					<label for="">내용</label>
				</div>
				<div class="qnaup_col_input">
					<div class="input_wrap">
						<div class="wrap_inner">
							<div class="ui_input">
								<textarea rows="5" cols="50" class="input_space2" name="qcontent">${vo.qcontent }</textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="submit_container">
				<input type="submit" value="수정" class="submit_btn">
			</div>
		</form>
	</div>
</div>
<div class="footer">
	<jsp:include page="/WEB-INF/views/user/jhr/footer.jsp"/>
</div>

<script type="text/javascript">
	let msg='${errMsg}';
	if(msg!='') {
		alert(msg);
	}
</script>
</body>
</html>
