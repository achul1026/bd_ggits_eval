<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<form id="loginForm">
	<div class="login-content">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>경기도청 평가앱</h1>
		<div class="btn-wrap">
			<input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요." onkeyup="enterkey()"
				class="main-btn data-validate" data-valid-required data-valid-name="아이디" maxlength="30">
			<input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요." onkeyup="enterkey()"
				class="main-btn data-validate" data-valid-required data-valid-name="비밀번호" maxlength="50">
			<button type="button" id="loginBtn" class="on-btn main-btn">로그인</button>
		</div>
	</div>
</form>

<script type="text/javascript">
	$("#loginBtn").on("click",function(){
		var userId = $("#userId").val();
		var userPw = $("#userPw").val();
		
		if($("#loginForm").soValid()) {
			$.ajax({
	   			type : "post",
	   			data : $("#loginForm").serialize(),
	   			url : "${pageContext.request.contextPath}/login.ajax",
	   			success : function(result) {
	   				let resultCode = result.code;
					let resultMessage = result.message;
	   				if (resultCode == '200') {
		  				window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
	   				} else {
	   					alert(resultMessage);
	   				}
	   			}
	   		});
		} 
	});
	
	function enterkey() {
		if (window.event.keyCode == 13) {
			var userId = $("#userId").val();
			var userPw = $("#userPw").val();
			
			if($("#loginForm").soValid()) {
				$.ajax({
		   			type : "post",
		   			data : $("#loginForm").serialize(),
		   			url : "${pageContext.request.contextPath}/login.ajax",
		   			success : function(result) {
		   				let resultCode = result.code;
						let resultMessage = result.message;
		   				if (resultCode == '200') {
			  				window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
		   				} else {
		   					alert(resultMessage);
		   				}
		   			}
		   		});
			}
		}
	}
</script>