<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<form id="loginForm" name="loginForm" method="post"
	action="${pageContext.request.contextPath}/login.ajax">


	<div class="login-content">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png"
			class="logo">
		<h1>경기도청 평가앱</h1>
		<p>최초 관리자 계정 생성</p>
		<div class="btn-wrap">

			<input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요."
				class="main-btn data-validate" data-valid-required data-valid-name="아이디" maxlength="30">
			<input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요."
				class="main-btn data-validate" data-valid-required data-valid-name="비밀번호" maxlength="50">
			<button type="button" id="saveBtn" class="on-btn main-btn">저장</button>

		</div>
	</div>
</form>

<script type="text/javascript">

	$("#saveBtn").on("click", function() {
		var userId = $("#userId").val();
		var userPw = $("#userPw").val();
		if($("#loginForm").soValid()) {
			$.ajax({
				type : "post",
				data : $("#loginForm").serialize(),
				url : "${pageContext.request.contextPath}/admin/save.ajax",
				success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					if (resultCode == '200') {
						alert(resultMessage);
						window.location.href = "${pageContext.request.contextPath}/login.do";
					} else {
						alert(resultMessage);
					}
				}
			});
		}
	});
</script>