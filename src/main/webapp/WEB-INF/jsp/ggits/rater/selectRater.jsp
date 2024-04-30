<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="wrap">
<div class="content">
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>경기도 제안평가위원회 인증</h1>		
	</div>
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="active">
	          	<p>제안평가<br>위원회 인증</p>
	          </li>
	          <li>
	            <p>제안평가<br>정보 확인</p>
	          </li>
	          <li>
	          	 <p>제안평가<br> 화면</p>
	          </li>
	          <li>
	          	<p>제안평가위원회<br>점수 확인</p>
	          </li>
	      </ul>
	</div>
	
	<div>
		<form id="raterRegisterForm" onsubmit="return false;">	
			<div class="search-list-title form wd100">
				<label>제안평가위원 정보를 입력하세요.</label>
			</div>
			<div class="test-table">
				<input type="text" id="rtrNm" name="rtrNm" placeholder="이름을 입력하세요." onkeyup="enterkey()"
					class="main-btn data-validate" data-valid-required data-valid-name="이름" maxlength="10">
				<input type="number" id="rtrBrthDt" name="rtrBrthDt" placeholder="생년월일 8자리를 입력해 주세요." onkeyup="enterkey()"
					class="main-btn data-validate" data-valid-required data-valid-name="생년월일" maxlength="50">
			</div>
				
			<div class="tablet-footer-btn-wrap">
				<a href="${pageContext.request.contextPath}/rater/code/check.do" class="mini-btn mini-sub-btn prev">이전</a>
				<button type="button" id="raterRegisterBtn" class="on-btn mini-btn">다음</button>
			</div>
		</form>
	</div>
</div>
</div>

<script type="text/javascript">
	$("#raterRegisterBtn").on("click", function(){
		if($("#raterRegisterForm").soValid()) {
			$.ajax({
				type : "post",
				data : $("#raterRegisterForm").serialize(),
				url : "${pageContext.request.contextPath}/rater/info/check.ajax",
				success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					if (resultCode == '200') {
						alert(resultMessage);					
						window.location.href="${pageContext.request.contextPath}/rater/announcement/detail.do"
					} else {
						alert(resultMessage);
					}
				}
			});
		}

	});
	
	function enterkey() {
		if (window.event.keyCode == 13) {
			if($("#raterRegisterForm").soValid()) {
				$.ajax({
					type : "post",
					data : $("#raterRegisterForm").serialize(),
					url : "${pageContext.request.contextPath}/rater/info/check.ajax",
					success : function(result) {
						let resultCode = result.code;
						let resultMessage = result.message;
						if (resultCode == '200') {
							alert(resultMessage);					
							window.location.href="${pageContext.request.contextPath}/rater/announcement/detail.do"
						} else {
							alert(resultMessage);
						}
					}
				});
			}

		}
	}
	
	$(".rtrBrthDt").on("focus", function(){
		let rtrBrthDts = $(".rtrBrthDt");
		for(let i = 0; i < rtrBrthDts.length; i++) {
			rtrBrthDts[i].value = '';
		}
	});
</script>