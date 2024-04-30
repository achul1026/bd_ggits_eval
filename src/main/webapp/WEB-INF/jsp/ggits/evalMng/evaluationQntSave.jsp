<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content">
	<div class="login_wrap">
		<button type="button" onclick="logout('admin')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<input type="hidden" id="shtInfoId" value="${evalQntInfo.shtInfoId}">
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>정량적 평가표</h1>
	</div>
	
	<div class="test-info">
		<dl>
			<dt>- 평가대상 : </dt>
			<dd>${evalBddCmp.bddCmpNm}</dd>
		</dl>
		<dl class="mj0">
			<dt>- 정성적 평가서명 : </dt>
			<dd>${shtInfoSession.shtNm}</dd>
		</dl>
	</div>
	
	<div class="table-exel-btn-wrap">
		<div class="total-score">
			<div>현재 점수 (<span id="currentScr">0</span>/${totalScr}점)</div> / 
			<div>잔여 문항 (<span id="remainScrCount">${totalScrCount}</span>/${totalScrCount})</div>
		</div>
	</div>
	
	<div class="table-wrap test-table pc-table-qlt">
		
		<c:choose>
			<c:when test="${evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmNm ne null and evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmNm ne ''}">
				<c:choose>
					<c:when test="${evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmElmnt ne null and evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmElmnt ne ''}">
						<c:set var="sctrInfo" value="sctrItemElmnt"/>
					</c:when>
					<c:otherwise>
						<c:set var="sctrInfo" value="sctrItem"/>
					</c:otherwise>
				</c:choose>
			</c:when>
			
			<c:otherwise>
				<c:set var="sctrInfo" value="onlySctr"/>
			</c:otherwise>
		</c:choose>
		
		<div class="table-head
			<c:choose>
				<c:when test="${sctrInfo eq 'onlySctr'}">
					eval-three-head
				</c:when>
				<c:when test="${sctrInfo eq 'sctrItem'}">
					eval-for-head
				</c:when>
				<c:when test="${sctrInfo eq 'sctrItemElmnt'}">
					eval-all-head
				</c:when>
			</c:choose>
		">
			<ul>
				<li>평가부문</li>
				<c:if test="${sctrInfo ne 'onlySctr'}">
				<li>항목</li>
				</c:if>
				<c:if test="${sctrInfo eq 'sctrItemElmnt'}">
				<li>요소</li>
				</c:if>
				<li>한도</li>
				<li>배점표</li>
			</ul>
		</div>
	<c:set var="scrCount" value="0"/>
	<c:forEach var="evalShtSctrList" items="${evalQntInfo.evalShtSctrList}">
		<div class="table-body 
			<c:choose>
				<c:when test="${sctrInfo eq 'onlySctr'}">
					eval-three-body-width
				</c:when>
				<c:when test="${sctrInfo eq 'sctrItem'}">
					eval-for-body-width
				</c:when>
				<c:when test="${sctrInfo eq 'sctrItemElmnt'}">
					eval-all-body-width
				</c:when>
			</c:choose>
		">
		
			<!-- 부문 -->
			<div class="table-list sub-head " 
				id="fldSctr"><div class="whspace">${evalShtSctrList.fldSctr}</div></div>
				
			<div class="table-list sub-body">
				<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
					<div class="table-sub-list table-qlt-sub-list">
					
					<c:if test="${sctrInfo ne 'onlySctr'}">
						<!-- 항목 -->
						<div class="addFldItmUl changUl"><div class="whspace">${evalShtItemList.itmNm}</div></div>
					</c:if>
					<c:if test="${sctrInfo eq 'sctrItemElmnt'}">
						<!-- 요소 -->
						<div class="addFldItmUl changUl"><div class="whspace">${evalShtItemList.itmElmnt}</div></div>
					</c:if>
					
						<!-- 배점 -->
						<div id="maxScr" data-max-scr="${evalShtItemList.evalShtQntScrInfo.fldScr}"><fmt:parseNumber value="${evalShtItemList.evalShtQntScrInfo.fldScr}" integerOnly="true"/></div>
						<!-- 배점표 -->
						<div class="addRemoveBtnUl changUl table-list-text-center">
							<!-- 점수 보이기 버튼 check-list-btn-->
							<div class="check-list-btn" id="scr${scrCount}">채점</div>
							  <div class="sign-wrap test-list-wrap" >
								  <div class="scoreDiv sign-content">
									  	<div class="sign-head">
										 평가점수 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close" onclick="fnCancelScr('${scrCount}')">
										</div>
										<div class="sign-body test-list-text check-list">
											<div class="check-list-about-text">평가점수를 입력해 주세요. (최대 <fmt:parseNumber value="${evalShtItemList.evalShtQntScrInfo.fldScr}" integerOnly="true"/>점)</div>
											<input type="hidden" class="shtItmId" value="${evalShtItemList.shtItmId}">
<%-- 											<input type="hidden" name="rtrShtId" value="${rtrShtId}"> --%>
											
											<input type="text" class="scr" name="scr${scrCount}" 
												oninput="checkScr(this, ${evalShtItemList.evalShtQntScrInfo.fldScr})" 
												style="background-color: #EFEFEF; width: 100% !important; margin-top: 10px;">
											
											<div class="check-btn">
												<button type="button" class="mini-btn mini-sub-btn on-btn" onClick="fnScrTextChange('${scrCount }')">확인</button>
											</div>
										</div>
										
								  </div>
								</div>
								
								<!-- 채점 방식 변경 전 -->
<!-- 							  <div class="sign-wrap test-list-wrap" > -->
<!-- 								  <div class="scoreDiv sign-content"> -->
<!-- 									  	<div class="sign-head"> -->
<%-- 										 평가점수 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close" onclick="fnCancelScr('${scrCount}')"> --%>
<!-- 										</div> -->
<!-- 										<div class="sign-body test-list-text check-list"> -->
<!-- 											<div class="check-list-about-text">평가점수를 선택해 주세요.</div> -->
<%-- 											<input type="hidden" class="shtItmId" value="${evalShtItemList.shtItmId}"> --%>
<%-- 											<input type="hidden" name="rtrShtId" value="${rtrShtId}"> --%>
<!-- 											<ul class="test-table"> -->
<%-- 												<c:set var="fldScr" value="${evalShtItemList.evalShtQntScrInfo.fldScr}"/> --%>
<%-- 												<fmt:parseNumber var="fldScr" value="${fldScr}" integerOnly="true"/> --%>
<%-- 												<c:forEach begin="1" end="5" step="1" varStatus="fldScrStatus"> --%>
<%-- 													<c:choose> --%>
<%-- 														<c:when test="${fn:length(evalRtrSctrScrs) eq 0}"> --%>
<%-- 															<c:choose> --%>
<%-- 																<c:when test="${fldScrStatus.count ne 1}"> --%>
<%-- 																	<c:if test="${fldScrStatus.count eq 2}"> --%>
<%-- 																		<c:set var="percentage" value="0.9"/> --%>
<%-- 																	</c:if> --%>
<%-- 																	<c:if test="${fldScrStatus.count eq 3}"> --%>
<%-- 																		<c:set var="percentage" value="0.8"/> --%>
<%-- 																	</c:if> --%>
<%-- 																	<c:if test="${fldScrStatus.count eq 4}"> --%>
<%-- 																		<c:set var="percentage" value="0.7"/> --%>
<%-- 																	</c:if> --%>
<%-- 																	<c:if test="${fldScrStatus.count eq 5}"> --%>
<%-- 																		<c:set var="percentage" value="0.6"/> --%>
<%-- 																	</c:if> --%>
																	
<%-- 																	<fmt:formatNumber var="percentagedScr" value="${fldScr * percentage}" pattern=".0"/> --%>
<%-- 																	<fmt:formatNumber type="number" var="percentagedText" value="${100 * percentage}"/> --%>
<%-- 																	<fmt:parseNumber var="intScr" value="${percentagedScr}" integerOnly="true"/> --%>
<%-- 																	<c:if test="${percentagedScr - intScr eq 0}"> --%>
<%-- 																		<c:set var="percentagedScr" value="${intScr}"/> --%>
<%-- 																	</c:if> --%>
<!-- 																	<li onclick="fnChckChildRadioBtn(this)"> -->
<!-- 																		<div> -->
<%-- 																			<input type="radio" class="scr" name="scr${scrCount}" value="${percentagedScr}"> --%>
<%-- 																			<label id="scrSelected${scrCount}">${percentagedScr}점</label>															 --%>
<!-- 																		</div> -->
																		
<!-- 																		<div class="point-text"> -->
<%-- 																			배점의 ${percentagedText}% --%>
<!-- 																		</div> -->
																		
<!-- 																	</li> -->
																
<%-- 																</c:when> --%>
<%-- 																<c:otherwise> --%>
<!-- 																	<li onclick="fnChckChildRadioBtn(this)"> -->
<!-- 																		<div> -->
<%-- 																			<input type="radio" class="scr" name="scr${scrCount}" value="${fldScr}"> --%>
<%-- 																			<label id="scrSelected${scrCount}">${fldScr}점</label> --%>
<!-- 																		</div> -->
																		
<!-- 																		<div class="point-text">배점의 100%</div> -->
<!-- 																	</li> -->
<%-- 																</c:otherwise> --%>
<%-- 															</c:choose> --%>
<%-- 														</c:when> --%>
<%-- 														<c:otherwise> --%>
<!-- 															<li onclick="fnChckChildRadioBtn(this)"> -->
<%-- 																<input type="radio" class="scr" name="scr${scrCount}" value="${fldScr}"  --%>
<%-- 																	${fldScr eq evalRtrSctrScr.scr ? 'checked':''}> --%>
<%-- 																<label id="scrSelected${scrCount}">${fldScr}점</label> --%>
<!-- 															</li> -->
<%-- 														</c:otherwise> --%>
<%-- 													</c:choose> --%>
<%-- 												</c:forEach> --%>
													
<!-- 											</ul> -->
											
<!-- 											<div class="check-btn"> -->
<%-- 												<button type="button" class="mini-btn mini-sub-btn on-btn" onClick="fnScrTextChange('${scrCount }')">확인</button> --%>
<!-- 											</div> -->
<!-- 										</div> -->
										
<!-- 								  </div> -->
<!-- 								</div> -->
						</div>
						<c:set var="scrCount" value="${scrCount + 1}"/>
						
						
					</div>
				</c:forEach>
			</div>
		</div>
	</c:forEach>
	</div>

<div class="footer-wrap">
	<a href="javascript:history.back();" class="mini-btn mini-sub-btn">이전</a>
<!-- 	<button type="button" id="rateTmpSaveBtn" class="mini-sub-btn mini-btn" onClick="fnSaveBySaveType('tmp')">임시저장</button> -->
	<button type="button" id="rateSaveBtn" class="on-btn mini-btn" onClick="fnSaveBySaveType('${evalQntInfo.saveType}')">확인</button>
</div>

</div>

<div class="sign-wrap name-sign-wrap">
  <div class="sign-content">
	  	<div class="sign-head">
		  서명하기 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close">
		</div>
		<div class="sign-body">
			<canvas id="signatureCanvas"></canvas>
			
			<div class="sign-btn">
				<button class="mini-btn mini-sub-btn" id="clearSignature">다시그리기</button>
				<button class="mini-btn on-btn" id="saveSignBtn">확인</button>
			</div>
		</div>
		
  </div>
</div>

<script type="text/javascript">

	var totalScrCountVar = ${totalScrCount};
	var scrCountVar = ${scrCount};
	var isAllScrChecked = false;
	
	function fnSaveBySaveType(saveType) {

		var evalRaterScrDTO = new Object();
		var tableBody = $(".table-body");
		var totalMaxScr = 0;
		var totalScr = 0;
		var confirmScrInfoList = new Array();
		var evalShtQltScrList = new Array();
		
		tableBody.each(function(idx,item){
			var confirmScrInfo = new Object();
			var fldSctr = $(item).find("#fldSctr").text();
// 			var sctrScr = 0;
// 			var sctrMaxScr = 0;
			var tableSubList = $(item).find(".table-sub-list");
			tableSubList.each(function(scrIdx,scrItem){
// 				var scr = $(scrItem).find("input[class='scr']:checked").val();
				var scr = $(scrItem).find("input[class='scr']").val();
				var maxScr = $(scrItem).find("#maxScr").data("max-scr");
// 				sctrScr += Number(scr);
// 				sctrMaxScr += Number(maxScr);
				
// 				totalScr += Number(scr);
// 				totalMaxScr += Number(maxScr);
				
				var evalShtQntScr = new Object();
				var shtItmId = $(scrItem).find(".shtItmId").val(); 
				var rtrShtId = $(scrItem).find("input[name='rtrShtId']").val();
				
				evalShtQntScr.scr = scr;
				evalShtQntScr.shtItmId = shtItmId;
				evalShtQntScr.rtrShtId = rtrShtId;
				evalShtQltScrList.push(evalShtQntScr);
			})
// 			confirmScrInfo.scr = sctrScr; 
// 			confirmScrInfo.fldSctr = fldSctr; 
// 			confirmScrInfo.maxScr = sctrMaxScr;
// 			confirmScrInfoList.push(confirmScrInfo);
		})
		
// 		evalRaterScrDTO.totalScr = totalScr;
// 		evalRaterScrDTO.totalMaxScr = totalMaxScr;
		evalRaterScrDTO.evalRtrItemScrList = evalShtQltScrList; 
		evalRaterScrDTO.confirmScrInfoList = confirmScrInfoList;
		
		if (saveType == 'save' || saveType == 'update') {
			evalRaterScrDTO.saveType = saveType;
			if(isAllScrChecked) {
				if(confirm('평가를 제출하시겠습니까?')) {
					$.ajax({
						type : "post",
						contentType: "application/json; charset=UTF-8",
						data : JSON.stringify(evalRaterScrDTO),
						url : "${pageContext.request.contextPath}/evaluation/management/eval/${evalQntInfo.shtInfoId}/save.ajax?bddCmpId=${evalBddCmp.bddCmpId}",
						success : function(result) {
							let resultCode = result.code;
							let resultMessage = result.message;
							if (resultCode == '200') {
								alert(resultMessage);
								window.location.href="${pageContext.request.contextPath}/evaluation/management/eval/list.do?shtInfoId=${evalQntInfo.shtInfoId}&shtNm=${shtInfoSession.shtNm}";
							} else {
								alert(resultMessage);
							}
						}
					});
				}
			} else {
				alert('채점이 완료되지 않은 문항이 있습니다.');
			}
		}
	}	
	
	function fnCountRemainScr() {
		let checkedScr = 0;
		for(i = 0; i < scrCountVar; i++) {	
// 			var scr = $("input[name='scr"+i+"']:checked").val();
			var scr = $("input[name='scr"+i+"']").val();
// 			if(scr != null) {
			if(scr != '') {
// 				$('#scr' + i).text(scr);
				checkedScr++;
			}
		}
		let remainScrCount = totalScrCountVar - checkedScr;
		$('#remainScrCount').text(totalScrCountVar - checkedScr);
		
		if(remainScrCount == 0) {
			isAllScrChecked = true;
		}
	}
	
	function fnCalcCurrentScr() {
		let currentScrVar = 0;
		
		for(i = 0; i < scrCountVar; i++) {	
			var scr = $("input[name='scr"+i+"']").val();
			
// 			if(scr != null) {
			if(scr != '') {
				currentScrVar += Number(scr);
			}
		}
		currentScrVar = currentScrVar.toFixed(2);
		if (currentScrVar.endsWith('.00')) {
			currentScrVar = currentScrVar.slice(0, -3)
		}
		
		$('#currentScr').text(currentScrVar);
	}
	
	function fnScrTextChange(idx) {
		let checkedScrCnt = 0;
		let currentScrVar = 0;
		
// 		var scr = $("input[name='scr"+idx+"']:checked").val();
		var scr = $("input[name='scr"+idx+"']").val();
		
		scr = Number(scr);
		
		if (scr == '') {
			$("#scr" + idx).text('채점');
		} else {
			$('#scr' + idx).text(scr);
			$("input[name='scr"+idx+"']").val(scr);
		};

		for(i = 0; i < scrCountVar; i++) {
// 			var scrChecked = $("input[name='scr"+i+"']:checked").val();
			var scrChecked = $("input[name='scr"+i+"']").val();
// 			if(scrChecked != null) {
			if(scrChecked != '') {
				checkedScrCnt++;
				currentScrVar += Number(scrChecked);
			}
		}
		
		let remainScrCount = totalScrCountVar - checkedScrCnt;
		$('#remainScrCount').text(remainScrCount);
		
		if(remainScrCount == 0) {
			isAllScrChecked = true;
		}
		
		$('#remainScrCount').text(totalScrCountVar - checkedScrCnt);
		
		currentScrVar = currentScrVar.toFixed(2);
		if (currentScrVar.endsWith('.00')) {
			currentScrVar = currentScrVar.slice(0, -3);
		}
		
		$('#currentScr').text(currentScrVar);
		
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
	}
	
	function fnCancelScr(idx) {
// 		$("input[name='scr"+idx+"']:checked").prop("checked", false);
		$("input[name='scr"+idx+"']").val('');
		$("#scr"+idx).text('채점');
		isAllScrChecked = false;
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
		 fnCountRemainScr();
		 fnCalcCurrentScr();
	}
	
// 	(function() {
// 		fnCountRemainScr();
// 		fnCalcCurrentScr();
// 	})();
	
	function checkScr(scrElmnt, maxScr) {
		let scr = Number(scrElmnt.value);
		
		if(isNaN(scr)) {
			scrElmnt.value = '';
			return false;
		}
		
		if (scr > maxScr) {
			scrElmnt.value = '';
			return false;
		}
				
		const pattern = /^\d+(\.\d{1,2})?$/;
		
		if (!pattern.test(scr)) {
			scrElmnt.value = '';
			return false;
		}

	}

</script>