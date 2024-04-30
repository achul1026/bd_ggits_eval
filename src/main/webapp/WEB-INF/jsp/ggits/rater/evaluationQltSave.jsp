<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="wrap">
<div class="content scroll-content">
	<div class="login_wrap">
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
	     <img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>제안평가</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	     <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>제안평가위원<br> 정보 입력</p>
	          </li>
	          <li class="progress-complete">
	          	<p>제안평가<br>정보 확인</p>
	          </li>
	           <li class="progress-complete">
	          	<p>제안평가 목록</p>
	          </li>
	          <li class="active">
	          	<p>제안평가위원회<br>점수 확인</p>
	          </li>
	      </ul>
	</div>
	
	<div class="test-info">
		<dl>
			<dt>- 제안평가 대상 : </dt>
			<dd>${bddCmpNm}</dd>
		</dl>
		<dl>
			<dt>- 제안평가 위원명 :</dt>
			<dd id="signImgDiv">
				<span>${rtrInfoSession.rtrNm}</span>
				<c:if test="${signFileId ne null}">
				<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId=${signFileId}"/>(인)
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
		<dl>
			<dt>- 제안평가 명 : </dt>
			<dd>${shtInfoSession.shtNm }</dd>
		</dl>
		
	</div>
	
	<div class="table-exel-btn-wrap">
		<div class="total-score">
			<div>현재 점수 (<span id="currentScr">0</span>/${totalScr}점)</div> / 
			<div>잔여 문항 (<span id="remainScrCount"></span>/${totalScrCount})</div>
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
                	<div class="rater-head-last">배점표</div>
					<c:if test="${evalQltInfo.selectQntScrType eq 'SCT001'}">
	                	<div class="tablet-table-qlt-sub-head">
	                		<ul>
								<c:forEach var="oneScoreList" items="${evalQltInfo.evalShtSctrList[0].evalShtItemList[0].evalShtQltScrList }">
									<li>${oneScoreList.scrNm }</li>
								</c:forEach>
	                		</ul>
	                	</div>
					</c:if>
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
					id="fldSctr"><div class="whspace">${evalShtSctrList.fldSctr}</div></div>
					
				<div class="table-list tablet-table-list ">
				
					<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
						<div class="table-sub-list tablet-table-sub-list tablet-table-qlt-sub-list rater-tablet-table-qlt-sub-list">
							<!--  항목  -->
							<c:if test="${sctrInfo ne 'onlySctr'}">
								<div class="addFldItmUl changUl"><div class="whspace">${evalShtItemList.itmNm}</div></div>
							</c:if>
							<!--  요소  -->
							<c:if test="${sctrInfo eq 'sctrItemElmnt'}">
								<div class="addFldElmntUl changUl"><div class="whspace">${evalShtItemList.itmElmnt}</div></div>
							</c:if>
							
							<c:choose>
								<c:when test="${evalQltInfo.selectQntScrType eq 'SCT001'}">
									<!-- 한도 -->
									<fmt:parseNumber var="intMaxScr" value="${evalShtItemList.evalShtQltScrList[0].scr}" integerOnly="true"/>
									<div class="addDirectNumberUl changUl" data-max-scr="${intMaxScr}"><div class="whspace">${intMaxScr}</div></div>
									<!-- 배점 -->
									<div class="scoreDiv changUl table-list-text-center pd0">
									<c:set var="shtItmId" value="${evalShtItemList.evalShtQltScrList[0].shtItmId}"/>
										<input type="hidden" class="shtItmId" value="${shtItmId}">
										<input type="hidden" name="rtrShtId" value="${rtrShtId}">
										<ul>
											<c:choose>
												<c:when test="${fn:length(evalRtrSctrScrs) ne 0 }">
													<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}">
														<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs }">
																<c:if test="${shtItmId eq evalRtrSctrScr.shtItmId }">
																	<li class="rater-height" onclick="fnChckChildRadioBtn(this)">
																		<fmt:parseNumber var="intScr" value="${evalShtQltScrList.scr}"/>
																		<input type="radio" class="scr" name="scr${scrCount}" value="${intScr}" ${evalShtQltScrList.scr eq evalRtrSctrScr.scr ? 'checked' : ''} onclick="fnCountRemainScr(), fnCalcCurrentScr()"><br>
																		<label>${intScr}</label>
																	</li>
																</c:if>
														</c:forEach>
													</c:forEach>
												</c:when>
												<c:otherwise>
													<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}">
														<li class="rater-height" onclick="fnChckChildRadioBtn(this)">
															<fmt:parseNumber var="intScr" value="${evalShtQltScrList.scr}"/>
															<input type="radio" class="scr" name="scr${scrCount}" value="${intScr}" ${evalShtQltScrList.scr eq evalRtrSctrScr.scr ? 'checked' : ''} onclick="fnCountRemainScr(), fnCalcCurrentScr()"><br>
															<label>${intScr}</label>
														</li>
													</c:forEach>
												</c:otherwise>
											</c:choose>
											<c:set var="scrCount" value="${scrCount + 1 }"/>
										</ul>
									</div>
								</c:when>
								<c:otherwise>
									<!-- 한도 -->
									<div class="addDirectNumberUl changUl" data-max-scr="${evalShtItemList.evalShtQltScrList[0].scr}">
										<div class="whspace"><fmt:parseNumber value="${evalShtItemList.evalShtQltScrList[0].scr}" integerOnly="true"/></div>
									</div>
									<!-- 배점표 -->
									<div class="addRemoveBtnUl changUl table-list-text-center">
										<div class="check-list-btn" id="scr${scrCount}">채점</div>
										<div class="sign-wrap test-list-wrap">
											<div class="scoreDiv sign-content">
											  	<div class="sign-head">
												 점수설정 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close" onclick="fnCancelScr('${scrCount}')">
												</div>
												<div class="sign-body test-list-text check-list">
													<div class="check-list-about-text">평가점수를 선택해 주세요.</div>
													<input type="hidden" class="shtItmId" value="${evalShtItemList.shtItmId}">
													<input type="hidden" name="rtrShtId" value="${rtrShtId}">
													<ul class="test-table">
														<c:set var="fldScr" value="${evalShtItemList.evalShtQltScrList[0].scr}"/>
														<fmt:parseNumber var="fldScr" value="${fldScr}" integerOnly="true"/>
														<c:forEach begin="1" end="5" step="1" varStatus="fldScrStatus">
															<c:choose>
																<c:when test="${fn:length(evalRtrSctrScrs) eq 0 or evalQltInfo.selectQntScrType eq 'SCT002'}">
																	<c:choose>
																		<c:when test="${fldScrStatus.count ne 1}">
																			<c:if test="${fldScrStatus.count eq 2}">
																				<c:set var="percentage" value="0.9"/>
																			</c:if>
																			<c:if test="${fldScrStatus.count eq 3}">
																				<c:set var="percentage" value="0.8"/>
																			</c:if>
																			<c:if test="${fldScrStatus.count eq 4}">
																				<c:set var="percentage" value="0.7"/>
																			</c:if>
																			<c:if test="${fldScrStatus.count eq 5}">
																				<c:set var="percentage" value="0.6"/>
																			</c:if>
																			
																			<fmt:formatNumber var="percentagedScr" value="${fldScr * percentage}" pattern=".0"/>
																			<fmt:formatNumber type="number" var="percentagedText" value="${100 * percentage}"/>
																			<fmt:parseNumber var="intScr" value="${percentagedScr}" integerOnly="true"/>
																			<c:if test="${percentagedScr - intScr eq 0}">
																				<c:set var="percentagedScr" value="${intScr}"/>
																			</c:if>
																			<li onclick="fnChckChildRadioBtn(this)">
																				<div>
																					<input type="radio" class="scr" name="scr${scrCount}" value="${percentagedScr}">
																					<label id="scrSelected${scrCount}">${percentagedScr}점</label>
																				</div>
																				<div class="point-text">배점의 ${percentagedText}%</div>
																			</li>
																		
																		</c:when>
																		<c:otherwise>
																			<li onclick="fnChckChildRadioBtn(this)">
																				<div>
																					<input type="radio" class="scr" name="scr${scrCount}" value="${fldScr}">
																					<label id="scrSelected${scrCount}">${fldScr}점</label>
																				</div>
																				<div class="point-text">배점의 100%</div>
																			</li>
																		</c:otherwise>
																	</c:choose>
																</c:when>
																<c:otherwise>
																	<li onclick="fnChckChildRadioBtn(this)">
																		<input type="radio" class="scr" name="scr${scrCount}" value="${fldScr}" 
																			${fldScr eq evalRtrSctrScr.scr ? 'checked':''}>
																		<label id="scrSelected${scrCount}">${fldScr}점</label>
																	</li>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</ul>
													<div class="check-btn">
														<button type="button" class="mini-btn mini-sub-btn on-btn" onClick="fnScrTextChange('${scrCount}')">확인</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<c:set var="scrCount" value="${scrCount + 1}"/>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:forEach>
		
	</div>
	
	<div class="rater-file-wrap rater-file-wrap">
		<div class="">
			<div class="rater-table-file-name">제안요청서</div>
			<div class="rater-table-file-scroll">
 		       	<c:choose>
             		<c:when test="${not empty requestFileList}">
                		<c:forEach var="requestFile" items="${requestFileList}" varStatus="status">
							<div class="inner-file-img-wrap">
			                	<img src="${pageContext.request.contextPath}/statics/images/test_img01.png" onClick="showPdfViewerModal('${requestFile.fileId}','${requestFile.fileOgnNm}')">
							</div>
               			</c:forEach>
             		</c:when>
             		<c:otherwise>
						<div class="inner-file-img-wrap">
							<div class="rater-inner-file inner-file inner-file-rater" >
             					<span>첨부된 파일이 없습니다.</span>
							</div>
						</div>
             		</c:otherwise>
             	</c:choose>
			</div>
		</div>
		<div>
			<div class="rater-table-file-name">제안서</div>
			<div class="rater-table-file-scroll">
				<c:choose>
               		<c:when test="${not empty proposalFileList}">
		                <c:forEach var="proposalFile" items="${proposalFileList}" varStatus="status">
							<div class="inner-file-img-wrap">
			                	<img src="${pageContext.request.contextPath}/statics/images/test_img02.png" onClick="showPdfViewerModal('${proposalFile.fileId}','${proposalFile.fileOgnNm}')">
							</div>
		                </c:forEach>
               		</c:when>
               		<c:otherwise>
						<div class="inner-file-img-wrap">
							<div class="rater-inner-file inner-file inner-file-rater" >
             					<span>첨부된 파일이 없습니다.</span>
							</div>
						</div>
               		</c:otherwise>
               	</c:choose>
			</div>
		</div>
		<div class="mj0">
			<div class="rater-table-file-name">발표자료</div>
			<div class="rater-table-file-scroll">
	               	<c:choose>
	               		<c:when test="${not empty presentationDocFileList}">
			                <c:forEach var="presentationDocFile" items="${presentationDocFileList}" varStatus="status">
								<div class="inner-file-img-wrap">
			                		<img src="${pageContext.request.contextPath}/statics/images/test_img03.png" onClick="showPdfViewerModal('${presentationDocFile.fileId}','${presentationDocFile.fileOgnNm}')">
								</div>
			                </c:forEach>
	               		</c:when>
	               		<c:otherwise>
							<div class="inner-file-img-wrap">
								<div class="rater-inner-file inner-file inner-file-rater" >
	             					<span>첨부된 파일이 없습니다.</span>
								</div>
							</div>
	               		</c:otherwise>
	               	</c:choose>
			</div>
		</div>

	</div>
	<div class="footer-wrap">
		<a href="${pageContext.request.contextPath}/rater/evaluation/list.do" class="mini-btn mini-sub-btn prev">이전</a>
		<c:if test="${shtAllStts ne 'ESC007'}">
			<button type="button" id="rateTmpSaveBtn" class="mini-sub-btn mini-btn" onClick="fnSaveBySaveType('tmp')">임시저장</button>
		</c:if>
		<button type="button" id="rateSaveBtn" class="on-btn mini-btn" onClick="fnSaveBySaveType('${evalQltInfo.saveType}')">확인</button>
	</div>
</div>

	<div class="sign-wrap name-sign-wrap">
	  <div class="sign-content">
		  	<div class="sign-head">
			  서명하기 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="close-sign-wrap">
			</div>
			<div class="sign-body">
				<canvas id="signatureCanvas"></canvas>
				<div class="sign-btn">
					<button class="mini-btn mini-sub-btn" id="clearSignature">다시 그리기</button>
					<button class="mini-btn on-btn" id="saveSignBtn">확인</button>
				</div>
			</div>
	  </div>
	</div>
</div>
<div id="pdfViewerModal"></div>
<script type="text/javascript">
	var totalScrCountVar = ${totalScrCount};
	var scrCountVar = ${scrCount};
	
	function fnCountRemainScr() {
		let checkedScr = 0;
		for(i = 0; i < scrCountVar; i++) {	
			var scrChecked = $("input[name='scr"+i+"']:checked").val();
			if(scrChecked != null) {
				$('#scr' + i).text(scrChecked);
				checkedScr++;
			}
		}
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
		
		$('#currentScr').text(currentScrVar.toFixed(1));
	}
	
	function fnScrTextChange(idx) {
		let checkedScrCnt = 0;
		let currentScrVar = 0;
		
		var scr = $("input[name='scr"+idx+"']:checked").val();
		$('#scr' + idx).text(scr);

		for(i = 0; i < scrCountVar; i++) {
			var scrChecked = $("input[name='scr"+i+"']:checked").val();
			if(scrChecked != null) {
				checkedScrCnt++;
				currentScrVar += Number(scrChecked);
			}
		}
		
		let remainScrCount = totalScrCountVar - checkedScrCnt;
		$('#remainScrCount').text(remainScrCount);
		
		$('#remainScrCount').text(totalScrCountVar - checkedScrCnt);
		$('#currentScr').text(currentScrVar.toFixed(1));
		
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
	}
	
	function fnCancelScr(idx) {
		$("input[name='scr"+idx+"']:checked").prop("checked", false);
		$("#scr"+idx).text('채점');
		
		fnCountRemainScr();
		fnCalcCurrentScr();
		
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
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
		
		evalRaterScrDTO.totalScr = parseFloat(totalScr.toFixed(1));
		evalRaterScrDTO.totalMaxScr = totalMaxScr;
		evalRaterScrDTO.evalRtrItemScrList = evalShtQltScrList; 
		evalRaterScrDTO.confirmScrInfoList = confirmScrInfoList;
		
		evalRaterScrDTO.saveType = saveType;
		
		if(isScrValidated) {
			if (saveType == 'save' || saveType == 'update') {
				if($('#signed').val() == 'true') {
					// $('.name-sign-btn-on').removeClass('name-no-sign');
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
										let rtrId = result.data.rtrId;
										let shtInfoId = result.data.shtInfoId;
										alert(message);
										window.location.href="${pageContext.request.contextPath}/rater/evaluation/result.do?rtrId="+rtrId+"&shtInfoId="+shtInfoId;
									}
								} else {
									alert(message);
								}
							}
						});
					}
				} else {
					alert('서명 완료되어야 평가를 제출할 수 있습니다.');
					$('.name-sign-wrap').show();
					$("html, body").addClass("not_scroll");
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
					html += '<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId='+fileId+'">(인)';
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
	    
	    function touchCanvas() {
	        // 서명 영역의 너비와 높이 설정
	        var canvasWidth = 416;
	        var canvasHeight = 300; // 원하는 높이로 조정
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
			touchCanvas();
		}

	}).resize();
	 
	    // 다시 그리기 버튼 클릭 이벤트 처리
	    $('#clearSignature').click(function() {
	        ctx.clearRect(0, 0, canvas.width, canvas.height);
	    });
	   
	});
	
	$('.close-sign-wrap').click(function () {
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
	});
	
</script>