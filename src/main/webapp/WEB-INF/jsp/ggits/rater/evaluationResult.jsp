<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 평가 점수 확인 화면 -->
<div class="wrap">
<div class="content score-content">
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>모든 평가가 완료되었습니다</h1>
	</div>

	<div class="score-wrap">
		
		<div class="sub-score">
			<div class="score-head">
				<h3>최종 평가 점수</h3>
			</div>
			
			<div class="score-body">
				<c:forEach var="totalScrItm" items="${totalScrList}">
				<dl>
					<dt id="fldSctr">${totalScrItm.bddCmpNm}</dt>
					<dd><span>${totalScrItm.totalScr}점</span> / ${totalMaxScr}점</dd>
				</dl>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div class="btn-wrap pd0 score-btn-wrap tablet-btn-wrap">
		<button type="button" id="moveToMainBtn" class="on-btn mini-btn wd100">메인 페이지로 이동</button>
	</div>
</div>
</div>
<script type="text/javascript">
	
	$("#moveToMainBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/main.do"
	});
	
</script>