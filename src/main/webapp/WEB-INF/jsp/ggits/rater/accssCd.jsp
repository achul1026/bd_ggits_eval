<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="wrap">
	<div class="login-content">
		<div class="login_wrap">
				<button type="button" id="cancelBtn" class="back-btn">
					<img src="/statics/images/back.png" onclick="location.replace('${pageContext.request.contextPath}/main.do')">
				</button>
			</div>
		<div class="content-head button-bottom">
				<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
				<h1>안내받은 제안평가의 <br> 참여 코드를 입력해 주세요.</h1>
		</div>
		<div class="">
			<form id="accssCdForm" method="post" onsubmit="return false;">
				<input type="text" id="accssCd" name="accssCd" placeholder="제안평가위원회 참여 코드를 입력해 주세요" maxlength="10"
				 	class="data-validate main-btn" data-valid-maximum="6" data-valid-required data-valid-name="참여 코드" onkeyup="enterkey()">
				<button type="button" id="codeCheckBtn" class="on-btn main-btn ">확인</button>
			</form>
		</div>
	</div>
</div>


	
<script type="text/javascript">
	$("#codeCheckBtn").on("click",function(){
		if($("#accssCdForm").soValid()){
			
			$.ajax({
	   			type : "post",
	   			data : $("#accssCdForm").serialize(),
	   			url : "${pageContext.request.contextPath}/rater/code/check.ajax",
	   			success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					if(resultCode == 200) {
						alert(resultMessage);					
		  				window.location.href="${pageContext.request.contextPath}/rater/info/save.do";
					} else {
						alert(resultMessage);
					}
	   			}
	   		});
			
		} 
	});
	
	function enterkey() {
		if (window.event.keyCode == 13) {
			if($("#accssCdForm").soValid()){
				$.ajax({
		   			type : "post",
		   			data : $("#accssCdForm").serialize(),
		   			url : "${pageContext.request.contextPath}/rater/code/check.ajax",
		   			success : function(result) {
						let resultCode = result.code;
						let resultMessage = result.message;
						if(resultCode == 200) {
							alert(resultMessage);					
			  				window.location.href="${pageContext.request.contextPath}/rater/info/save.do";
						} else {
							alert(resultMessage);
						}
		   			}
		   		});
			} 
	    }
	}
	
	$("#accssCd").keyup(function() {
		let accssCd = document.getElementById('accssCd');
		let accssCdValue = accssCd.value.trim().replace(/[^A-Za-z0-9]/g, "");

		accssCd.value = accssCdValue;
	})
	
</script>
