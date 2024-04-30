<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="wrap">
	<div class="login-content">
		<div class="login_wrap">
			<button type="button" id="moveLoginBtn">
				<img src="${pageContext.request.contextPath}/statics/images/login.png" class="login-img">
				관리자
			</button>
		</div>
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>경기도 제안평가위원회 평가시스템</h1>
		<p>평가 참여 코드를 입력하여 평가를 시작합니다.</p>
		<div class="btn-wrap pd0">
			<button type="button" id="moveEntercodeBtn" class="on-btn main-btn">평가 시작하기</button>
			<!-- <button type="button" id="moveLoginBtn" class="main-btn ">로그인</button> -->
		</div>
		<div class="inquiry">문의 : 경기도 교통정보과(031-8008-6824)</div>
	</div>
</div>
</body>
<script>
	$("#moveEntercodeBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/rater/code/check.do"
	});
	
	$("#moveLoginBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/login.do"
	});
</script>
</html>