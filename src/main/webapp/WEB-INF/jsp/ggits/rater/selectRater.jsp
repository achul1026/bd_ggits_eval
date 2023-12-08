<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="content">
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>평가자정보 입력</h1>		
	</div>
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="active">
	          	<p>평가자정보 입력</p>
	          </li>
	          <li>
	          	<p>평가지 정보 확인</p>
	          </li>
	          <li>
	          	<p>평가 목록</p>
	          </li>
	          <li>
	          	<p>평가 화면</p>
	          </li>
	          <li>
	          	<p>평가점수 확인</p>
	          </li>
	      </ul>
	</div>
	
	<div>
		<form id="raterRegisterForm" onsubmit="return false;">	
				<input type="hidden" id="shtInfoId" value="ba3d3f82965247e28238f241565bb37e">
				<div class="search-list-title form wd100">
					<label>평가자 목록에서 본인을 선택하세요.</label>
				</div>
				<div class="test-table">
					<table class="">
					<colgroup>
						<col width="">
					</colgroup>
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col">이름</th>
				      <th scope="col">소속</th>
				      <th scope="col">생년월일</th>
				    </tr>
				   	<c:forEach var="evalRtr" items="${evalRtrList }" varStatus="status">
				   		<tr>
				   			<td>${status.count }</td>
				   			<td>${evalRtr.rtrNm }</td>
				   			<td>${evalRtr.rtrAgncy }</td>
				   			<td>
						      	<input type="number" id="rtrBrthDt" name="rtrBrthDt${status.count}" placeholder="생년월일을 입력해주세요."
									 class="data-input rtrBrthDt data-validate" data-valid-required data-valid-name="생년월일"
									 data-rtr-id="${evalRtr.rtrId}" onkeyup="enterkey()">
				   			</td>
				   		</tr>
				   	</c:forEach>
				 </table>
				</div>
				
			<div class="tablet-footer-btn-wrap">
				<a href="${pageContext.request.contextPath}/rater/code/check.do" class="mini-btn mini-sub-btn prev">이전</a>
				<button type="button" id="raterRegisterBtn" class="on-btn mini-btn">다음</button>
			</div>
		</form>
	</div>
</div>


<script type="text/javascript">
	$("#raterRegisterBtn").on("click", function(){
		let rtrBrthDts = $(".rtrBrthDt");
		let rtrBrthDt, rtrId;
		for(let i = 0; i < rtrBrthDts.length; i++) {
			if(rtrBrthDts[i].value != '' && rtrBrthDts[i].value != 'null') {
				rtrBrthDt = rtrBrthDts.eq(i).val();
				rtrId = rtrBrthDts.eq(i).data("rtr-id");
			}
		}
		if(rtrBrthDt == null) {
			alert('생년월일을 입력해 주세요.');
			return false;
		}
		$.ajax({
			type : "post",
			data : {"rtrBrthDt": rtrBrthDt, "rtrId": rtrId},
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
	});
	
	function enterkey() {
		if (window.event.keyCode == 13) {
			let rtrBrthDts = $(".rtrBrthDt");
			let rtrBrthDt, rtrId;
			for(let i = 0; i < rtrBrthDts.length; i++) {
				if(rtrBrthDts[i].value != '' && rtrBrthDts[i].value != 'null') {
					rtrBrthDt = rtrBrthDts.eq(i).val();
					rtrId = rtrBrthDts.eq(i).data("rtr-id");
				}
			}
			if(rtrBrthDt == null) {
				alert('생년월일을 입력해 주세요.');
				return false;
			}
			$.ajax({
				type : "post",
				data : {"rtrBrthDt": rtrBrthDt, "rtrId": rtrId},
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
	
	$(".rtrBrthDt").on("focus", function(){
		let rtrBrthDts = $(".rtrBrthDt");
		for(let i = 0; i < rtrBrthDts.length; i++) {
			rtrBrthDts[i].value = '';
		}
	});
</script>