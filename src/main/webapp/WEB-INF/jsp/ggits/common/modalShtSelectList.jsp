<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sign-wrap test-list-wrap">
  <div class="sign-content">
	  	<div class="sign-head">
		 평가유형 선택 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close modal-close">
		</div>
		<div class="sign-body test-list-text">
			[${shtInfoSession.shtNm }](${bddCmpNm}) 평가지 입니다.<br>
			우선 평가 할 평가 유형을 선택해주세요.
			
			<div class="sign-btn">
			<c:forEach var="evalSht" items="${evalShtList }">
				<c:if test="${evalSht.shtType eq 'qlt'}">

					<c:forEach var="evalRtrSht" items="${evalRtrShtList }">
						<c:if test="${evalRtrSht.shtId eq evalSht.shtId}">
							<c:if test="${evalRtrSht.shtStts eq 'ERSSC000'}">
								<!-- 평가 완료 -->
								<button class="mini-btn mini-sub-btn" id="qltBtn" onClick="fnEvalSheetView('qlt', '${evalRtrSht.rtrShtId }', '${bddCmpNm }')">정성적 평가 (완료)</button>
							</c:if>
							<c:if test="${evalRtrSht.shtStts eq 'ERSSC004'}"> 
								<!-- 평가 진행중 -->
								<button class="mini-btn mini-sub-btn" id="qltBtn" onClick="fnEvalSheetView('qlt', '${evalRtrSht.rtrShtId }', '${bddCmpNm }')">정성적 평가</button>
							</c:if>
						</c:if>
					</c:forEach>

				</c:if>
				<c:if test="${evalSht.shtType eq 'qnt'}">

					<c:forEach var="evalRtrSht" items="${evalRtrShtList }">
						<c:if test="${evalRtrSht.shtId eq evalSht.shtId}">
							<c:if test="${evalRtrSht.shtStts eq 'ERSSC000'}">
								<!-- 평가 완료 -->
								<button class="mini-btn mini-sub-btn" id="qltBtn" onClick="fnEvalSheetView('qnt', '${evalRtrSht.rtrShtId }', '${bddCmpNm }')">정량적 평가 (완료)</button>
							</c:if>
							<c:if test="${evalRtrSht.shtStts eq 'ERSSC004'}">
								<!-- 평가 진행중 -->
								<button class="mini-btn mini-sub-btn" id="qltBtn" onClick="fnEvalSheetView('qnt', '${evalRtrSht.rtrShtId }', '${bddCmpNm }')">정량적 평가</button>
							</c:if>
						</c:if>
					</c:forEach>

				</c:if>
			</c:forEach>
		</div>
		</div>
		
  </div>
	<script>
		$('.modal-close').click(function(){
			$('.sign-wrap').remove();
		});
		
		function fnEvalSheetView(shtType, rtrShtId, bddCmpNm) {
			location.href="${pageContext.request.contextPath}/rater/evaluation/"+ shtType +"/save.do?rtrShtId="+rtrShtId+"&bddCmpNm="+bddCmpNm;
		}
	</script>
</div>

