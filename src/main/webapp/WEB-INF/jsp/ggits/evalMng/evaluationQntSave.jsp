<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="content">
	<div class="login_wrap">
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<input type="hidden" id="shtInfoId" value="${evalQntInfo.shtInfoId}">
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>평가 화면</h1>
	</div>
<!-- 	 <div class="progressbar-wrapper progressbar-wrapper-tablet"> -->
<!-- 	     <ul class="progressbar"> -->
<!-- 	          <li class="progress-complete"> -->
<!-- 	          	<p>평가자 정보 입력</p> -->
<!-- 	          </li> -->
<!-- 	          <li class="progress-complete"> -->
<!-- 	          	<p>평가지 정보 확인</p> -->
<!-- 	          </li> -->
<!-- 	           <li class="progress-complete"> -->
<!-- 	          	<p>평가 목록</p> -->
<!-- 	          </li> -->
<!-- 	          <li class="active"> -->
<!-- 	          	<p>평가 화면</p> -->
<!-- 	          </li> -->
<!-- 	          <li> -->
<!-- 	          	<p>평가점수 확인</p> -->
<!-- 	          </li> -->
<!-- 	      </ul> -->
<!-- 	</div> -->
	
	<div class="test-info">
		<dl>
			<dt>- 평가 대상 : </dt>
			<dd>${evalBddCmp.bddCmpNm}</dd>
		</dl>
<!-- 		<dl> -->
<!-- 			<dt>- 평가 위원명 : </dt> -->
<!-- 			<dd> -->
<!-- 				<div id="signDiv"> -->
<%-- 					<span>${rtrInfoSession.rtrNm}</span> --%>
<%-- 					<c:if test="${signFileId ne null}"> --%>
<%-- 					<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId=${signFileId}"> --%>
<!-- 					<input type="hidden" id="signed" value="true"> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${signFileId eq null}"> --%>
<!-- 					<button class="name-sign-btn-on"> -->
<!-- 						(서명) -->
<!-- 					</button> -->
<!-- 					<input type="hidden" id="signed" value="false"> -->
<%-- 					</c:if> --%>
<!-- 				</div> -->
<!-- 			</dd> -->
<!-- 		</dl> -->
		<dl class="mj0">
			<dt>- 정량적 평가서명 : </dt>
			<dd>${shtInfoSession.shtNm}</dd>
		</dl>
	</div>
	
	<div class="table-exel-btn-wrap">
		<div class="total-score">
			<div>점수 (<span id="currentScr">0</span>/${totalScr}점)</div> / 
			<div>문항 (<span id="remainScrCount"></span>/${totalScrCount})</div>
		</div>
	</div>
	
	<div class="table-wrap test-table pc-table-qlt">
		<c:choose>
			<c:when test="${evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmNm ne null and evalQntInfo.evalShtSctrList[0].evalShtItemList[0].itmNm eq ''}">
				<c:set var="isItmNmEmpty" value="true"/>
			</c:when>
			<c:otherwise>
				<c:set var="isItmNmEmpty" value="false"/>
			</c:otherwise>
		</c:choose>
		
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
		
		<div class="table-head eval-for-head ${isItmNmEmpty eq 'true' ? 'eval-for-head' : ''}">
			<ul>
				<li>평가부문</li>
				<c:if test="${isItmNmEmpty eq 'false'}">
				<li>항목</li>
				</c:if>
				<li>배점</li>
				<li>배점표</li>
			</ul>
		</div>
	<c:set var="scrCount" value="0"/>
	<c:forEach var="evalShtSctrList" items="${evalQntInfo.evalShtSctrList}">
		<div class="table-body eval-for-body-width ${isItmNmEmpty eq 'true' ? 'rater-three-qlt-body-width' : ''}">
		
			<!-- 부문 -->
			<div class="table-list sub-head ${isItmNmEmpty eq 'true' ? 'qlt-width-on' : ''}" 
				id="fldSctr">${evalShtSctrList.fldSctr}</div>
				
			<div class="table-list sub-body">
				<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
					<div class="table-sub-list table-qlt-sub-list">
					
					<c:if test="${isItmNmEmpty eq 'false'}">
						<!-- 항목 -->
						<div class="addFldItmUl changUl">${evalShtItemList.itmNm}</div>
					</c:if>
					
						<div id="maxScr" data-max-scr="${evalShtItemList.evalShtQntScrInfo.fldScr}">
							<!-- 배점 -->
							${evalShtItemList.evalShtQntScrInfo.fldScr}점
						</div>
						<!-- 배점표 -->
						<div class="addRemoveBtnUl changUl table-list-text-center">
							<!-- 점수 보이기 버튼 check-list-btn-->
							<div class="check-list-btn" id="scr${scrCount }">0</div>
							  <div class="sign-wrap test-list-wrap" >
								  <div class="scoreDiv sign-content">
									  	<div class="sign-head">
										 점수설정 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close">
										</div>
										<div class="sign-body test-list-text check-list">
											<div class="check-list-about-text">평가점수를 선택해 주세요.</div>
												<input type="hidden" class="shtItmId" value="${evalShtItemList.shtItmId}">
												<input type="hidden" name="rtrShtId" value="${rtrShtId}">
											<ul class="test-table">
												<c:set var="fldScr" value="${evalShtItemList.evalShtQntScrInfo.fldScr}"/>
												<c:forEach begin="1" end="${fldScr}" step="1" varStatus="fldScrStatus">
													<c:choose>
														<c:when test="${fn:length(evalRtrSctrScrs) eq 0}">
															<li>
																<input type="radio" class="scr" name="scr${scrCount}" value="${fldScrStatus.count}" onclick="fnCountRemainScr()">
																<label id="scrSelected${scrCount}">${fldScrStatus.count}점</label>
															</li>
														</c:when>
														<c:otherwise>
															<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs }">
																<c:if test="${ evalShtItemList.shtItmId eq evalRtrSctrScr.shtItmId}">
																	<li>
																		<input type="radio" class="scr" name="scr${scrCount }" value="${fldScrStatus.index }" ${fldScrStatus.count eq evalRtrSctrScr.scr ? 'checked':''} onclick="fnCountRemainScr()">
																		<label id="scrSelected${scrCount }">${fldScrStatus.index }점</label>
																	</li>
																</c:if>						
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</c:forEach>
													
											</ul>
											
											<div class="check-btn">
												<button type="button" class="mini-btn mini-sub-btn on-btn" onClick="fnScrTextChange('${scrCount }')">확인</button>
											</div>
										</div>
										
								  </div>
								</div>
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

// 	var totalScrVar = ${totalScr};

	var totalScrCountVar = ${totalScrCount};
// 	var totalScrCountVar = 1;
	var scrCountVar = ${scrCount};
	var isAllScrChecked = false;
	var rtrNm = '${rtrInfoSession.rtrNm}';
	
	function fnSaveBySaveType(saveType) {

		var evalRaterScrDTO = new Object();
		var tableBody = $(".table-body");
		var totalMaxScr = 0;
		var totalScr = 0;
		var confirmScrInfoList = new Array();
		var evalShtQltScrList = new Array();
		
		tableBody.each(function(idx,item){
			var confirmScrInfo = new Object();
//			var fldSctr = $(item).find("#fldSctr").val();
			var fldSctr = $(item).find("#fldSctr").text();
			var sctrScr = 0;
			var sctrMaxScr = 0;
			var tableSubList = $(item).find(".table-sub-list");
			tableSubList.each(function(scrIdx,scrItem){
				var scr = $(scrItem).find("input[class='scr']:checked").val();
				var maxScr = $(scrItem).find("#maxScr").data("max-scr");
				sctrScr += Number(scr);
				sctrMaxScr += Number(maxScr);
				
				totalScr += Number(scr);
				totalMaxScr += Number(maxScr);
				
				var evalShtQntScr = new Object();
				var shtItmId = $(scrItem).find(".shtItmId").val(); 
				var rtrShtId = $(scrItem).find("input[name='rtrShtId']").val();
				
				evalShtQntScr.scr = scr;
				evalShtQntScr.shtItmId = shtItmId;
				evalShtQntScr.rtrShtId = rtrShtId;
				evalShtQltScrList.push(evalShtQntScr);
			})
			confirmScrInfo.scr = sctrScr; 
			confirmScrInfo.fldSctr = fldSctr; 
			confirmScrInfo.maxScr = sctrMaxScr;
			confirmScrInfoList.push(confirmScrInfo);
		})
		
		evalRaterScrDTO.totalScr = totalScr;
		evalRaterScrDTO.totalMaxScr = totalMaxScr;
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
				alert('평가 점수를 모두 입력해 주세요.');
			}
		}
	}	
	
// 	$("#saveSignBtn").on("click",function(){
// 		if(!confirm("서명을 저장하시겠습니까? \n저장한 서명은 수정할 수 없습니다.")){
// 			return;
// 		}
		
// 		var shtInfoId = $("#shtInfoId").val();
// 		var rtrShtId = '${rtrShtId}';
		
// 		var canvas = document.getElementById('signatureCanvas');
// 		var imgBase64 = canvas.toDataURL('image/png', 'image/octet-stream');
// 		var decodImg = atob(imgBase64.split(',')[1]);

// 	    let array = [];
// 	    for (let i = 0; i < decodImg.length; i++) {
// 	       array.push(decodImg.charCodeAt(i));
// 	    }

// 	    var file = new Blob([ new Uint8Array(array) ], {
// 	       type : 'image/png'
// 	    });
// 	    var fileName = 'sign_' + getDateFormatYYYYMMDDMISS() + '.png';
// 	    let formData = new FormData();
// 	    formData.append('file', file, fileName);
// 	    formData.append('shtInfoId', shtInfoId);
// 	    formData.append('rtrShtId', rtrShtId);

// 	    $.ajax({
// 	       type : 'post',
// 	       url : '${pageContext.request.contextPath}/common/sign/upload.ajax',
// 	       cache : false,
// 	       data : formData,
// 	       processData : false,
// 	       contentType : false,
// 	       success : function(result) {
// 				let html = "";
// 				let fileId = result.data.fileId;
				
// 				$('#signDiv').empty();
// 				html += '<span>'+rtrNm+'</span>';
// 				html += '<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId='+fileId+'">';
// 				html += '<input type="hidden" id="signed" value="true">';
// 				$('#signDiv').append(html);
				
// 				$('.sign-wrap').hide();
// 				$("html, body").removeClass("not_scroll");
// 	       }
// 	   })
		
//    });
	
	function fnCountRemainScr() {
		let checkedScr = 0;
		for(i = 0; i < scrCountVar; i++) {	
			var scr = $("input[name='scr"+i+"']:checked").val();
			if(scr != null) {
				$('#scr' + i).text(scr);
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
			var scr = $("input[name='scr"+i+"']:checked").val();
			
			if(scr != null) {
				currentScrVar += Number(scr);
			}
		}
		
		$('#currentScr').text(currentScrVar);
	}
	
	function fnScrTextChange(idx) {
		var scrChecked = $("input[name='scr"+idx+"']:checked").val();
		$('#scr' + idx).text(scrChecked);
		
		fnCalcCurrentScr();
		
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
	}
	
	(function() {
		fnCountRemainScr();
		fnCalcCurrentScr();
	})();
	
	
	// 서명
// 	$(document).ready(function() {
// 	    var canvas = $('#signatureCanvas')[0];
// 	    var ctx = canvas.getContext('2d');
// 	    var drawing = false;

// 	    function resizeCanvas() {
// 	        // 서명 영역의 너비와 높이 설정
// 	        var canvasWidth = 416;
// 	        var canvasHeight = 200; // 원하는 높이로 조정
// 	        canvas.width = canvasWidth;
// 	        canvas.height = canvasHeight;

// 	        enableTouchDrawing();
// 			enableMouseDrawing();
// 	    }

// 	    // 페이지 로딩 시 Canvas 크기 설정
// 	    resizeCanvas();

// 	    // 윈도우 크기 변경 시 Canvas 크기 다시 조정
// 	    $(window).resize(function() {
// 	        resizeCanvas();
// 	    });

// 		 function enableMouseDrawing() {
// 		        canvas.addEventListener('mousedown', function() {
// 		            drawing = true;
// 		            ctx.lineWidth = 4; // 선 굵기 설정
// 		            ctx.strokeStyle = '#000'; // 선 색상 설정
// 		            ctx.beginPath();
// 		        });
		
// 		        canvas.addEventListener('mousemove', function(e) {
// 		            if (drawing) {
// 		                ctx.lineTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
// 		                ctx.stroke();
// 		            }
// 		        });
		
// 		        canvas.addEventListener('mouseup', function() {
// 		            drawing = false;
// 		            ctx.closePath();
// 		        });
// 		    }

// 	    function enableTouchDrawing() {
// 	        canvas.addEventListener('touchstart', function(e) {
// 	            drawing = true;
// 	            ctx.lineWidth = 4; // 선 굵기 설정
// 	            ctx.strokeStyle = '#000'; // 선 색상 설정
// 	            ctx.beginPath();
// 	            ctx.moveTo(e.touches[0].clientX - canvas.getBoundingClientRect().left, e.touches[0].clientY - canvas.getBoundingClientRect().top);
// 	        });

// 	        canvas.addEventListener('touchmove', function(e) {
// 	            if (drawing) {
// 	                ctx.lineTo(e.touches[0].clientX - canvas.getBoundingClientRect().left, e.touches[0].clientY - canvas.getBoundingClientRect().top);
// 	                ctx.stroke();
// 	            }
// 	        });

// 	        canvas.addEventListener('touchend', function() {
// 	            drawing = false;
// 	            ctx.closePath();
// 	        });
// 	    }

// 	    // 다시 그리기 버튼 클릭 이벤트 처리
// 	    $('#clearSignature').click(function() {
// 	        ctx.clearRect(0, 0, canvas.width, canvas.height);
// 	    });

// 		$(window).resize(function(){
// 		if (window.innerWidth > 1281) {  
// 			enableMouseDrawing();

// 		} else {
// 			enableTouchDrawing();
// 		}

// 	}).resize();
	 
// 	    // 다시 그리기 버튼 클릭 이벤트 처리
// 	    $('#clearSignature').click(function() {
// 	        ctx.clearRect(0, 0, canvas.width, canvas.height);
// 	    });
	   
// 	});
	
</script>