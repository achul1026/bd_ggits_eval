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
	<div class="content-head">
	     <img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>평가 화면</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	     <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>평가자 정보 입력</p>
	          </li>
	          <li class="progress-complete">
	          	<p>평가지 정보 확인</p>
	          </li>
	           <li class="progress-complete">
	          	<p>평가 목록</p>
	          </li>
	          <li class="active">
	          	<p>평가 화면</p>
	          </li>
	          <li>
	          	<p>평가점수 확인</p>
	          </li>
	      </ul>
	</div>
	
	<div class="test-info">
		<dl>
			<dt>- 평가 대상 : </dt>
			<dd>${bddCmpNm}</dd>
		</dl>
		<dl>
			<dt>- 평가 위원명 :</dt>
			<dd id="signImgDiv">
				<span>${rtrInfoSession.rtrNm}</span>
				<c:if test="${signFileId ne null}">
				<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId=${signFileId}" />
				<input type="hidden" id="signed" value="true">
				</c:if>
				<c:if test="${signFileId eq null}">
				<button class="name-sign-btn-on">
					(서명)
				</button>
				<input type="hidden" id="signed" value="false">
				</c:if>
			</dd>
		</dl>
		<dl class="mj0">
			<dt>- 정성적 평가서명 : </dt>
			<dd>${shtInfoSession.shtNm }</dd>
		</dl>
	</div>
	
	<div class="table-exel-btn-wrap">
		<div class="total-score">
			<div>점수 (<span id="currentScr">0</span>/${totalScr}점)</div> / 
			<div>문항 (<span id="remainScrCount"></span>)</div>
		</div>
	</div>
	
	<div class="table-wrap test-table">	
		<c:choose>
			<c:when test="${evalQltInfo.evalShtSctrList[0].evalShtItemList[0].itmNm ne null and evalQltInfo.evalShtSctrList[0].evalShtItemList[0].itmNm ne ''}">
				<c:choose>
					<c:when test="${evalQltInfo.evalShtSctrList[0].evalShtItemList[0].itmElmnt ne null and evalQltInfo.evalShtSctrList[0].evalShtItemList[0].itmElmnt ne ''}">
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
		
		<div class="table-head tablet-table-head tablet-table-qlt-head ${sctrInfo eq 'sctrItem' ? 'rater-for-qnt-head' : ''}
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
                <li>
                	<div class="">평가 배점표</div>
                	<div class="tablet-table-qlt-sub-head">
                		<ul>
							<c:forEach var="oneScoreList" items="${evalQltInfo.evalShtSctrList[0].evalShtItemList[0].evalShtQltScrList }">
								<li>${oneScoreList.scrNm }</li>
							</c:forEach>
                		</ul>
                	</div>
                </li>
			</ul>
		</div>
		<c:set var="scrCount" value="0"/>
		<c:forEach var="evalShtSctrList" items="${evalQltInfo.evalShtSctrList}">
			<div class="table-body tablet-table-body tablet-table-qlt-body 
				<c:choose>
					<c:when test="${sctrInfo eq 'onlySctr'}">
						rater-three-qnt-body-width
					</c:when>
					<c:when test="${sctrInfo eq 'sctrItem'}">
						rater-for-qnt-body-width
					</c:when>
					<c:when test="${sctrInfo eq 'sctrItemElmnt'}">
						rater-all-qnt-body-width
					</c:when>
				</c:choose>
			">
				<!--  부문  -->
				<div class="table-list sub-head rater-qnt-width " 
					id="fldSctr">${evalShtSctrList.fldSctr}</div>
					
				<div class="table-list tablet-table-list ">
				
					<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
						<div class="table-sub-list tablet-table-sub-list tablet-table-qlt-sub-list rater-tablet-table-qlt-sub-list">
							<!--  항목  -->
							<c:if test="${sctrInfo ne 'onlySctr'}">
								<div class="addFldItmUl changUl">${evalShtItemList.itmNm}</div>
							</c:if>
							<!--  요소  -->
							<c:if test="${sctrInfo eq 'sctrItemElmnt'}">
								<div class="addFldElmntUl changUl">${evalShtItemList.itmElmnt}</div>
							</c:if>
							<div class="addDirectNumberUl changUl" data-max-scr="${evalShtItemList.evalShtQltScrList[0].scr}">
								${evalShtItemList.evalShtQltScrList[0].scr }점
							</div>
							<div class="scoreDiv changUl table-list-text-center pd0">
							<c:set var="shtItmId" value="${evalShtItemList.evalShtQltScrList[0].shtItmId}"/>
							<input type="hidden" class="shtItmId" value="${shtItmId }">
							<input type="hidden" name="rtrShtId" value="${rtrShtId}">
								<ul>
									<c:choose>
										<c:when test="${fn:length(evalRtrSctrScrs) ne 0 }">
											<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}">
												<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs }">
														<c:if test="${shtItmId eq evalRtrSctrScr.shtItmId }">
															<li>
																<input type="radio" class="scr" name="scr${scrCount}" value="${evalShtQltScrList.scr}" ${evalShtQltScrList.scr eq evalRtrSctrScr.scr ? 'checked' : ''} onclick="fnCountRemainScr(), fnCalcCurrentScr()"><br>
																<label>${evalShtQltScrList.scr}점</label>
															</li>
														</c:if>
												</c:forEach>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}">
												<li>
													<input type="radio" class="scr" name="scr${scrCount}" value="${evalShtQltScrList.scr}" ${evalShtQltScrList.scr eq evalRtrSctrScr.scr ? 'checked' : ''} onclick="fnCountRemainScr(), fnCalcCurrentScr()"><br>
													<label>${evalShtQltScrList.scr}점</label>
												</li>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									<c:set var="scrCount" value="${scrCount + 1 }"/>
								</ul>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
		
	</div>
	
	<div class="footer-wrap">
		<a href="${pageContext.request.contextPath}/rater/evaluation/list.do" class="mini-btn mini-sub-btn prev">이전</a>
		<button type="button" id="rateTmpSaveBtn" class="mini-sub-btn mini-btn" onClick="fnSaveBySaveType('tmp')">임시저장</button>
		<button type="button" id="rateSaveBtn" class="on-btn mini-btn" onClick="fnSaveBySaveType('${evalQltInfo.saveType}')">확인</button>
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
	
	(function() {
		fnCountRemainScr();
		fnCalcCurrentScr();
	})();
	
	function fnSaveBySaveType(saveType) {
		var evalRaterScrDTO = new Object();
		var tableBody = $(".table-body");
		var totalMaxScr = 0;
		var totalScr = 0;
		var confirmScrInfoList = new Array();
		var evalShtQltScrList = new Array();
		var isScrValidated = true;
		
		tableBody.each(function(idx,item){
			var confirmScrInfo = new Object();
//			var fldSctr = $(item).find("#fldSctr").val();
			var fldSctr = $(item).find('#fldSctr').text();
			var sctrScr = 0;
			var sctrMaxScr = 0;
			var tableSubList = $(item).find(".table-sub-list");
			tableSubList.each(function(scrIdx,scrItem){
				if(isScrValidated){
					
					var scr = $(scrItem).find("input[class='scr']:checked").val();
					if(scr == undefined){
						alert((idx+1) + "평가부문의 " + (scrIdx+1) + "번째 배점을 선택해주세요.")
						isScrValidated = false;
						return;
					}
					var maxScr = $(scrItem).find(".addDirectNumberUl").data("max-scr");
					
					sctrScr += Number(scr);
					sctrMaxScr += Number(maxScr);
					
					totalScr += Number(scr);
					totalMaxScr += Number(maxScr);
					
					var evalShtQltScr = new Object();
					var shtItmId = $(scrItem).find(".shtItmId").val(); 
					var rtrShtId = $(scrItem).find("input[name='rtrShtId']").val();
					
					evalShtQltScr.scr = scr;
					evalShtQltScr.shtItmId = shtItmId;
					evalShtQltScr.rtrShtId = rtrShtId;
					evalShtQltScrList.push(evalShtQltScr);
				}
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
		
		evalRaterScrDTO.saveType = saveType;
		
		if(isScrValidated) {
			if (saveType == 'save' || saveType == 'update') {
				if($('#signed').val() == 'true') {
					if(confirm('평가를 제출하시겠습니까?')) {
						$.ajax({
							type : "post",
							contentType: "application/json; charset=UTF-8",
							data : JSON.stringify(evalRaterScrDTO),
							url : "${pageContext.request.contextPath}/rater/evaluation/save.ajax",
							success : function(result) {
								let message = result.message;
								let isEvalCmplt = result.data.isEvalCmplt;
								let resultCode = result.data.resultCode;
								
								if(resultCode == "OK") {
									if(isEvalCmplt == false) {
										alert(message);
										window.location.href="${pageContext.request.contextPath}/rater/evaluation/list.do";
									} else {
										alert(message);
										window.location.href="${pageContext.request.contextPath}/main.do";
									}
								} else {
									alert(message);
								}
							}
						});
					}
				} else {
					alert('서명 완료되어야 평가를 제출할 수 있습니다.');
				}
			} else if (saveType == 'tmp') {
				$.ajax({
					type : "post",
					contentType: "application/json; charset=UTF-8",
					data : JSON.stringify(evalRaterScrDTO),
					url : "${pageContext.request.contextPath}/rater/evaluation/save.ajax",
					success : function(result) {
						let message = result.message;
						let isEvalCmplt = result.data.isEvalCmplt;
						let resultCode = result.data.resultCode;
						if (resultCode == 'OK') {
							alert(message);
							window.location.href="${pageContext.request.contextPath}/rater/evaluation/list.do";
						} else {
							alert(message);
						}
					}
				});
			}
		} // isScrValidated
	} 
	
	
	$("#saveSignBtn").on("click", function() {
		if(!confirm("서명을 저장하시겠습니까? \n저장한 서명은 수정할 수 없습니다.")){
			return;
		}

		var shtInfoId = $("#shtInfoId").val();
		var rtrShtId = '${rtrShtId}';

		var canvas = document.getElementById('signatureCanvas');
		var imgBase64 = canvas.toDataURL('image/png', 'image/octet-stream');
		var decodImg = atob(imgBase64.split(',')[1]);

		let array = [];
		for (let i = 0; i < decodImg.length; i++) {
			array.push(decodImg.charCodeAt(i));
		}

		var file = new Blob([ new Uint8Array(array) ], {
			type : 'image/png'
		});
		var fileName = 'sign_' + getDateFormatYYYYMMDDMISS() + '.png';
		let formData = new FormData();
		formData.append('file', file, fileName);
		formData.append('shtInfoId', shtInfoId);
		formData.append('rtrShtId', rtrShtId);

	    $.ajax({
		       type : 'post',
		       url : '${pageContext.request.contextPath}/common/sign/upload.ajax',
		       cache : false,
		       data : formData,
		       processData : false,
		       contentType : false,
		       success : function(result) {
					let html = "";
					let fileId = result.data.fileId;
					
					$('#signImgDiv').empty();
					html += '<span>${rtrInfoSession.rtrNm}</span>';
					html += '<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId='+fileId+'">';
					html += '<input type="hidden" id="signed" value="true">';
					$('#signImgDiv').append(html);
					
					$('.sign-wrap').hide();
					$("html, body").removeClass("not_scroll");
		       }
		   })
	})
	
		// 서명
	$(document).ready(function() {
	    var canvas = $('#signatureCanvas')[0];
	    var ctx = canvas.getContext('2d');
	    var drawing = false;

	    function resizeCanvas() {
	        // 서명 영역의 너비와 높이 설정
	        var canvasWidth = 416;
	        var canvasHeight = 200; // 원하는 높이로 조정
	        canvas.width = canvasWidth;
	        canvas.height = canvasHeight;

	        enableTouchDrawing();
			enableMouseDrawing();
	    }

	    // 페이지 로딩 시 Canvas 크기 설정
	    resizeCanvas();

	    // 윈도우 크기 변경 시 Canvas 크기 다시 조정
	    $(window).resize(function() {
	        resizeCanvas();
	    });

		 function enableMouseDrawing() {
		        canvas.addEventListener('mousedown', function() {
		            drawing = true;
		            ctx.lineWidth = 4; // 선 굵기 설정
		            ctx.strokeStyle = '#000'; // 선 색상 설정
		            ctx.beginPath();
		        });
		
		        canvas.addEventListener('mousemove', function(e) {
		            if (drawing) {
		                ctx.lineTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
		                ctx.stroke();
		            }
		        });
		
		        canvas.addEventListener('mouseup', function() {
		            drawing = false;
		            ctx.closePath();
		        });
		    }

	    function enableTouchDrawing() {
	        canvas.addEventListener('touchstart', function(e) {
	            drawing = true;
	            ctx.lineWidth = 4; // 선 굵기 설정
	            ctx.strokeStyle = '#000'; // 선 색상 설정
	            ctx.beginPath();
	            ctx.moveTo(e.touches[0].clientX - canvas.getBoundingClientRect().left, e.touches[0].clientY - canvas.getBoundingClientRect().top);
	        });

	        canvas.addEventListener('touchmove', function(e) {
	            if (drawing) {
	                ctx.lineTo(e.touches[0].clientX - canvas.getBoundingClientRect().left, e.touches[0].clientY - canvas.getBoundingClientRect().top);
	                ctx.stroke();
	            }
	        });

	        canvas.addEventListener('touchend', function() {
	            drawing = false;
	            ctx.closePath();
	        });
	    }

	    // 다시 그리기 버튼 클릭 이벤트 처리
	    $('#clearSignature').click(function() {
	        ctx.clearRect(0, 0, canvas.width, canvas.height);
	    });

		$(window).resize(function(){
		if (window.innerWidth > 1281) {  
			enableMouseDrawing();

		} else {
			enableTouchDrawing();
		}

	}).resize();
	 
	    // 다시 그리기 버튼 클릭 이벤트 처리
	    $('#clearSignature').click(function() {
	        ctx.clearRect(0, 0, canvas.width, canvas.height);
	    });
	   
	});
	
</script>