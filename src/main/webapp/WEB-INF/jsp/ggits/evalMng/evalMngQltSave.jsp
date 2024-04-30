<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content test-register-content scroll-content">
	<input type="hidden" id="shtInfoId" value="${evalQltInfo.shtInfoId}" />
	<input type="hidden" id="shtId" value="${evalQltInfo.shtId}" />
	<div class="login_wrap">
			<button type="button" onclick="logout('admin')">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png"
			class="logo">
		<h1>정성적 평가 작성</h1>

		<div class="progressbar-wrapper">
			<ul class="progressbar">
				<li class="progress-complete">
					 <p>제안평가<br> 정보 입력</p>
				</li>
				<li class="progress-complete">
					<p>제안평가<br> 대상 등록</p>
				</li>
				<li class="progress-complete">
					<p>평가 유형 선택</p>
				</li>
				<li class="active">
					<p>평가지 작성</p>
				</li>
				<li class=>
					<p>평가지 상세정보</p>
				</li>
				<li>
					<p>평가 결과 확인</p>
				</li>
			</ul>
		</div>
	</div>
	<div class="test-info form wdat">
		<dl class="mj0">
			<dt>- 정성적 평가서명 :</dt>
			<dd>${shtNm}</dd>
		</dl>
	</div>
	
	<c:set var="evalShtSctrListLength" value="${fn:length(evalQltInfo.evalShtSctrList)}"/>
	<div class="table-exel-btn-wrap mb8">
		<div class="test-remain">
			평가 문항수
			<span id="totalCnt"></span>
			<span id="totalScr">0점</span>
			
		</div>
		<div class="btn-sub-wrap SCT002 ${evalQltInfo.selectQntScrType eq 'SCT001' ? 'display-none' : ''}"">
			<a href="${pageContext.request.contextPath}/common/sample/file/download.ajax?fileName=sample_qnt_upload.csv" class="mini-btn mini-sub-btn mj0">(자율 배점)양식 다운로드</a>
			<label for="fileUpload" class="mini-btn mini-sub-btn mj0">(자율 배점)양식 업로드</label>
			<input type="file" class="file-one-change uploadFile" id="fileUpload" accept=".csv">
		</div>
	</div>
	<div class="table-wrap test-table">
		<div class="table-head ${evalQltInfo.selectQntScrType eq 'SCT001' ? 'table-head-all' : ''}">
			<ul>
				<li>평가부문</li>
				<li>항목</li>
				<li>요소</li>
				<li class="SCT001 ${evalQltInfo.selectQntScrType ne 'SCT001' ? 'display-none' : ''}">한도</li>
				<li class="">
					<select class="scrType" id="selectPointType">
						<option value="SCT001">배점 선택</option>
						<option value="SCT001" ${evalQltInfo.selectQntScrType eq 'SCT001' ? 'selected="selected"' : '' }>5개</option>
						<option value="SCT002" ${evalQltInfo.selectQntScrType eq 'SCT002' ? 'selected="selected"' : '' }>자율 배점</option>
					</select>
				<!-- 5개일 때만 -->
				<span class="table-about-text SCT001 ${evalQltInfo.selectQntScrType ne 'SCT001' ? 'display-none' : ''}">
					높은순부터 입력
				</span>
				</li>
				<li>관리</li>
			</ul>
		</div>
		<div class="table-body-wrap">
		
		
		<c:choose>
			<c:when test="${fn:length(evalQltInfo.evalShtSctrList) > 0}">
				<c:forEach var="evalShtSctrList" items="${evalQltInfo.evalShtSctrList}">
					<div class="table-body ${evalQltInfo.selectQntScrType eq 'SCT001' ? 'table-body-all' : ''}">
						<c:set var="itemLength" value="${fn:length(evalShtSctrList.evalShtItemList)}" />
						<c:set var="height" value="${evalQltInfo.selectQntScrType ne 'SCT001' ? 133 : 214}" />
						<c:set var="lineHeight" value="${evalQltInfo.selectQntScrType ne 'SCT001' ? 133 : 190}" />
						<div class="table-list sub-head" style="height: ${height*itemLength}px; line-height: ${lineHeight*itemLength}px;">
							<button type="button" class="table-plus" onclick="fnAddToggle(${evalShtSctrList.fldOrdr});">
								<img src="/statics/images/table_plus.png" class="table-plus-icon">문항추가
							</button>
							<div class="table-btn-wrap" style="display: none;">
								<ul>
									<li>
										<button type="button" class="addFldCctr" onclick="fnAddFldCctr(this)" data-sort="${evalShtSctrList.fldOrdr}"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">부문추가</button>
									</li>
									<li>
										<button type="button" class="addFldItm" onclick="fnAddFldItm(this)" data-fld-order="${evalShtSctrList.fldOrdr}"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">항목추가</button>
									</li>
								</ul>
							</div>
							<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해 주세요." 
							data-shtsctrid="${evalShtSctrList.shtSctrId}">${evalShtSctrList.fldSctr}</textarea>
						</div>
						<div class="table-list sub-body">
							<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
								<div class="table-sub-list ${evalQltInfo.selectQntScrType eq 'SCT001' ? 'table-sub-list-all' : ''}" style="height:${height}px; line-height:${lineHeight}px;">
									<div class="addFldItmUl changUl">
										<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해 주세요." data-shtitmid="${evalShtItemList.shtItmId}">${evalShtItemList.itmNm}</textarea>
									</div>
									<div class="addFldElmntUl changUl">
										<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해 주세요.">${evalShtItemList.itmElmnt}</textarea>
									</div>
									<div class="addDirectNumberUl changUl SCT001 ${evalQltInfo.selectQntScrType ne 'SCT001'? 'display-none' : ''}">
										<fmt:parseNumber var="intScr" value="${evalShtItemList.evalShtQltScrList[0].scr}" integerOnly="true"/>
										<input type="text" class="directNumber" placeholder="ex) 1" onkeyup="isScrValidated(this)" readonly="readonly" value="${intScr}">
									</div>
									<div class="addScrInfoUl changUl score-input-wrap addFldItm-plus flex flex-wrap gap8 SCT001 ${evalQltInfo.selectQntScrType ne 'SCT001'? 'display-none' : ''}">
										<c:choose>
											<c:when test="${evalQltInfo.selectQntScrType eq 'SCT001'}">
												<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}" varStatus="scrStatus">
													<fmt:parseNumber var="intScr" value="${evalShtQltScrList.scr}"/>
													<input type="text" class="evalShtQntScrInfo ${(scrStatus.index eq 3 or scrStatus.index eq 4) ? 'addPoints' : ''}" name="scrNm" maxlength="10" placeholder="우수" value="${evalShtQltScrList.scrNm}" data-scrnm-order="${evalShtQltScrList.scrOrdr}" onkeyup="modifyScrNmSame(this)"> 
													<input type="text" class="evalShtQntScrInfo ${(scrStatus.index eq 3 or scrStatus.index eq 4) ? 'addPoints' : ''} ${evalShtQltScrList.scrOrdr eq 0 ? 'highestPoint' : 'point'}" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="${evalShtQltScrList.scrOrdr}" value="${intScr}" data-qltscrid="${evalShtQltScrList.qltScrId}" onkeyup="isScrValidated(this,${evalShtSctrList.fldOrdr},${evalShtItemList.itemOrdr})">
												</c:forEach>
											</c:when>
											<c:otherwise>
												<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="0" onkeyup="modifyScrNmSame(this)"> 
												<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,${evalShtSctrList.fldOrdr},${evalShtItemList.itemOrdr})"> 
												<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="1" onkeyup="modifyScrNmSame(this)">
												<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="1" data-qltscrid="" readonly="readonly">  
												<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="2" onkeyup="modifyScrNmSame(this)">
												<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="2" data-qltscrid="" readonly="readonly"> 
												<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="3" onkeyup="modifyScrNmSame(this)"> 
												<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="scr" placeholder="ex) 1" data-scr-order="3" data-qltscrid="" readonly="readonly">  
												<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="4" onkeyup="modifyScrNmSame(this)">  
												<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="scr" placeholder="ex) 1" data-scr-order="4" data-qltscrid="" readonly="readonly">
											</c:otherwise>
										</c:choose>
<%-- 										<c:if test="${fn:length(evalShtItemList.evalShtQltScrList) eq 3}"> --%>
<%-- 											<c:forEach var="i" begin="3" end="4"> --%>
<%-- 												<input type="text" class="scrNm evalShtQntScrInfo addPoints display-none" name="addScrNm" maxlength="10" placeholder="우수"  data-scrnm-order="${i}" onkeyup="modifyScrNmSame(this)">  --%>
<%-- 												<input type="text" class="scr evalShtQntScrInfo addPoints display-none point" name="addScr" placeholder="ex) 1" data-scr-order="${i}" onkeyup="isScrValidated(this,${evalShtSctrList.fldOrdr},${evalShtItemList.itemOrdr})"> --%>
<%-- 											</c:forEach> --%>
<%-- 										</c:if> --%>
									</div>
									<div class="SCT002 ${evalQltInfo.selectQntScrType ne 'SCT002'? 'display-none' : ''}">
									<c:choose>
										<c:when test="${evalQltInfo.selectQntScrType eq 'SCT001'}">
											<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="2" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,0,0)"> 
										</c:when>
										<c:otherwise>
											<c:forEach var="evalShtQltScrList" items="${evalShtItemList.evalShtQltScrList}" varStatus="scrStatus">
												<fmt:parseNumber var="intScr" value="${evalShtItemList.evalShtQltScrList[0].scr}" integerOnly="true"/>
												<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="2" placeholder="ex) 1" data-scr-order="${evalShtQltScrList.scrOrdr}" value="${intScr}" data-qltscrid="${evalShtQltScrList.qltScrId}" onkeyup="isScrValidated(this,${evalShtSctrList.fldOrdr},${evalShtItemList.itemOrdr})">
											</c:forEach> 
										</c:otherwise>
									</c:choose>
									</div>
									
									<div class="addRemoveBtnUl changUl">
										<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="${evalShtSctrList.fldOrdr}" data-remove-shtsctrid="${evalShtSctrList.shtSctrId}" data-remove-shtitmid="${evalShtItemList.shtItmId}" onclick="fnRemoveFldCctr(this,${evalShtItemList.itemOrdr})"/>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="table-body table-body-all">
					<div class="table-list sub-head">
						<button type="button" class="table-plus" onclick="fnAddToggle(0);">
							<img src="/statics/images/table_plus.png" class="table-plus-icon">문항추가
						</button>
						<div class="table-btn-wrap" style="display: none;">
							<ul>
								<li>
									<button type="button" class="addFldCctr" onclick="fnAddFldCctr(this)" data-sort="0"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">부문추가</button>
								</li>
								<li>
									<button type="button" class="addFldItm" onclick="fnAddFldItm(this)" data-fld-order="0"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">항목추가</button>
								</li>
							</ul>
						</div>
						<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해 주세요." data-shtsctrid=""></textarea>
					</div>
					<div class="table-list sub-body">
						<div class="table-sub-list table-sub-list-all">
							<div class="addFldItmUl changUl">
								<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해 주세요." data-shtitmid=""></textarea>
							</div>
							<div class="addFldElmntUl changUl text-length">
								<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해 주세요."></textarea>
							</div>
								<div class="addDirectNumberUl changUl SCT001  ${evalQltInfo.selectQntScrType ne 'SCT001'? 'display-none' : ''}">
									<input type="text" class="directNumber" placeholder="ex) 1" readonly="readonly">
								</div>
								<div class="addScrInfoUl changUl score-input-wrap addFldItm-plus flex flex-wrap gap8 SCT001 ${evalQltInfo.selectQntScrType ne 'SCT001'? 'display-none' : ''}">
									<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="0" onkeyup="modifyScrNmSame(this)"> 
									<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,0,0)"> 
									<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="1" onkeyup="modifyScrNmSame(this)">
									<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="1" data-qltscrid="" readonly="readonly">  
									<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="2" onkeyup="modifyScrNmSame(this)">
									<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="2" data-qltscrid="" readonly="readonly"> 
									<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="3" onkeyup="modifyScrNmSame(this)"> 
									<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="scr" placeholder="ex) 1" data-scr-order="3" data-qltscrid="" readonly="readonly"> 
									<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="4" onkeyup="modifyScrNmSame(this)">  
									<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="scr" placeholder="ex) 1" data-scr-order="4" data-qltscrid="" readonly="readonly">
								</div>
							<div class="SCT002 ${evalQltInfo.selectQntScrType ne 'SCT002'? 'display-none' : ''}">
								<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="2" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,0,0)"> 
							</div>
							<div class="addRemoveBtnUl changUl">
								<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="0" data-remove-shtsctrid="" data-remove-shtitmid="" onclick="fnRemoveFldCctr(this,0)" />
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		</div>
	</div>
	

	<div class="footer-wrap">
<!-- 		<a href="javascript:history.back();" class="mini-btn mini-sub-btn prev">이전</a> -->
		<a href="${pageContext.request.contextPath}/evaluation/management/type/${evalQltInfo.shtInfoId}/save.do?type=update" class="mini-btn mini-sub-btn prev">이전</a>
		<div class="footer-left-btn">
			<c:choose>
				<c:when test="${evalQltInfo.saveType eq 'update'}">
					<button type="button" class="on-btn mini-btn" onclick="fnEvalInfoSave('update');">확인</button>
				</c:when>
				<c:otherwise>
					<button type="button" class="mini-btn mini-sub-btn" onclick="fnEvalInfoSave('tmp');">임시 저장</button>
					<button type="button" class="on-btn mini-btn" onclick="fnEvalInfoSave('save');">확인</button>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>


<script>
	fnChangeTotalCnt();
	fnSetTotalScr();
	var delShtSctrIdArray = new Array();
	var delShtItmIdArray = new Array();
	
	// 평가 문항수 변경
	function fnChangeTotalCnt() {
		$("#totalCnt").text("("+$(".table-sub-list").length+")");
	}
	
	// 최고점 합 계산
	function fnSetTotalScr() {
		var selectPointType  = '${evalQltInfo.selectQntScrType}';
		
		if(!isNull(selectPointType)){
			var highestPoint = $("."+selectPointType +" .highestPoint");
			var totalScr = 0;
			highestPoint.each(function(idx,item){
				totalScr += Number($(item).val());
				
			})
			
			if(totalScr > 0){
				totalScr = totalScr.toFixed(1)
			}
			
			$('#totalScr').text(parseFloat(totalScr)+'점');
		}
	}
	
	//부문 추가
	function fnAddFldCctr(_this){
		
		var sortNum = Number($(_this).data("sort"));
		
		var thisClassName = $(_this).attr("class");
		var addFldCctr = $("."+thisClassName);
		var addFldItm = $(".addFldItm");
		var tablePlus = $(".table-plus");
		var subBody = $(".sub-body");
		
		addFldCctr.each(function(idx,item){
			if(idx >= (sortNum+1)){
				$(item).attr("data-sort",idx+1);
				addFldItm.eq(idx).attr("data-fld-order",idx+1);
				tablePlus.eq(idx).attr("onclick","fnAddToggle("+(idx+1)+")")
				subBody.eq(idx).find(".removeBtn").attr("data-remove-order",idx+1)
			}
		});
		
		var selectPointType = $("#selectPointType").val();
		var addScrNmClassName = "scrNm";
		var addScrClassName = "scr";
		var addSelectScrClass = "";
		var addFreeScrClass = "";
		var addTableBodyClass = "";
		var addTableSubListClass = "";
		if(selectPointType == "SCT001"){
			addFreeScrClass = "display-none";
			addTableBodyClass = "table-body-all";
			addTableSubListClass = "table-sub-list-all";
		}else{
			addSelectScrClass = "display-none"
		}
		
		var html =	'<div class="table-body '+addTableBodyClass+'">'+
						'<div class="table-list sub-head">'+
							'<button type="button" class="table-plus" onclick="fnAddToggle('+(sortNum+1)+');">'+
								'<img src="/statics/images/table_plus.png" class="table-plus-icon">문항추가'+
							'</button>'+
			            	'<div class="table-btn-wrap" style="display: none;">'+
								'<ul>'+
									'<li><button type="button" class="addFldCctr" onclick="fnAddFldCctr(this)" data-sort="'+(sortNum+1)+'"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">부문추가</button></li>'+
									'<li><button type="button" class="addFldItm" onclick="fnAddFldItm(this)" data-fld-order="'+(sortNum+1)+'"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">항목추가</button></li>'+
								'</ul>'+
							'</div>'+
						 	'<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해 주세요." data-shtsctrid=""></textarea>'+
						'</div>'+
						'<div class="table-list sub-body">'+
							'<div class="table-sub-list '+addTableSubListClass+'">'+
								'<div class="addFldItmUl changUl">'+
									'<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해 주세요." data-shtitmid=""></textarea>'+
								'</div>'+
								'<div class="addFldElmntUl changUl">'+
									'<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해 주세요."></textarea>'+
								'</div>'+
								'<div class="addDirectNumberUl changUl SCT001 '+addSelectScrClass+'">'+
									'<input type="text" class="directNumber" placeholder="ex) 1" readonly="readonly">'+
								'</div>'+
								'<div class="addScrInfoUl changUl score-input-wrap addFldItm-plus flex flex-wrap gap8 SCT001 '+addSelectScrClass+'">'+
								   	'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="0" value="'+$("input[data-scrnm-order='0']").val()+'" onkeyup="modifyScrNmSame(this)">'+
								   	'<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,'+(sortNum+1)+','+0+')">'+
								   	'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="1" value="'+$("input[data-scrnm-order='1']").val()+'" onkeyup="modifyScrNmSame(this)">'+
								   	'<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="1" data-qltscrid="" readonly="readonly">'+
							   		'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="2" value="'+$("input[data-scrnm-order='2']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   		'<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="2" data-qltscrid="" readonly="readonly">'+
									'<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="'+addScrNmClassName+'" maxlength="10" placeholder="우수" data-scrnm-order="3" value="'+$("input[data-scrnm-order='3']").val()+'" onkeyup="modifyScrNmSame(this)">'+
									'<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="'+addScrClassName+'" placeholder="ex) 1" data-scr-order="3" data-qltscrid="" readonly="readonly">'+
									'<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="'+addScrNmClassName+'" maxlength="10" placeholder="우수" data-scrnm-order="4" value="'+$("input[data-scrnm-order='4']").val()+'" onkeyup="modifyScrNmSame(this)">'+
									'<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="'+addScrClassName+'" placeholder="ex) 1" data-scr-order="4" data-qltscrid="" readonly="readonly">'+
								'</div>'+
								 '<div class="SCT002 '+addFreeScrClass+'">'+
									'<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="2" placeholder="ex) 1" data-scr-order="0" data-qltscrid="" onkeyup="isScrValidated(this,'+(sortNum+1)+','+0+')">'+ 
							  	'</div>'+
								'<div class="addRemoveBtnUl changUl">'+
									'<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="'+(sortNum+1)+'" data-remove-shtsctrid="" data-remove-shtitmid="" onclick="fnRemoveFldCctr(this,'+0+')" />'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>';
		
			
			$(".table-body").eq(sortNum).after(html);
			fldSctrAreaHeight(selectPointType,(sortNum+1));
// 			$("#totalCnt").text("("+(addFldCctr.length+1)+")")
			fnChangeTotalCnt();
			$('.table-btn-wrap').hide();
		
	}
	
	//항목추가
	function fnAddFldItm(_this){
		var sortNum = Number($(_this).attr("data-fld-order"));
		var subBody = $(".sub-body");
		var selectPointType = $("#selectPointType").val();
		var addScrNmClassName = "scrNm";
		var addScrClassName = "scr";
		var scrTypeHtml = "";
		var addSelectScrClass = "";
		var addFreeScrClass = "";
		var addTableSubListClass = "";
		if(selectPointType == "SCT001"){
			addFreeScrClass = "display-none";
			addTableSubListClass = "table-sub-list-all";
		}else{
			addSelectScrClass = "display-none"
		}

		var removeChildIdx = subBody.eq(sortNum).find(".table-sub-list").length;
		
		//배점 html 추가
		var html =		'<div class="table-sub-list '+addTableSubListClass+'">'+
							'<div class="addFldItmUl changUl">'+
								'<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해 주세요." data-shtitmid=""></textarea>'+
							'</div>'+
							'<div class="addFldElmntUl changUl">'+
								'<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해 주세요."></textarea>'+
							'</div>'+
							'<div class="addDirectNumberUl changUl SCT001 '+addSelectScrClass+'">'+
								'<input type="text" class="directNumber" placeholder="ex) 1" readonly="readonly">'+
							'</div>'+
							'<div class="score-input-wrap addFldItm-plus flex flex-wrap gap8 SCT001 '+addSelectScrClass+'">'+
							   	'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="0" value="'+$("input[data-scrnm-order='0']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   	'<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="0" onkeyup="isScrValidated(this,'+sortNum+','+removeChildIdx+')">'+
							   	'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="1" value="'+$("input[data-scrnm-order='1']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   	'<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="1" readonly="readonly">'+
							   	'<input type="text" class="evalShtQntScrInfo" name="scrNm" maxlength="10" placeholder="우수" data-scrnm-order="2" value="'+$("input[data-scrnm-order='2']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   	'<input type="text" class="evalShtQntScrInfo point" name="scr" maxlength="3" placeholder="ex) 1" data-scr-order="2"  readonly="readonly" >'+
							   	'<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="'+addScrNmClassName+'" maxlength="10" placeholder="우수" data-scrnm-order="3" value="'+$("input[data-scrnm-order='3']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   	'<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="'+addScrClassName+'" placeholder="ex) 1" data-scr-order="3" readonly="readonly">'+
							   	'<input type="text" class="addScrNm evalShtQntScrInfo addPoints" name="'+addScrNmClassName+'" maxlength="10" placeholder="우수"  data-scrnm-order="4" value="'+$("input[data-scrnm-order='4']").val()+'" onkeyup="modifyScrNmSame(this)">'+
							   	'<input type="text" class="addScr evalShtQntScrInfo addPoints point" name="'+addScrClassName+'" placeholder="ex) 1" data-scr-order="4" readonly="readonly">'+
							'</div>'+
							'<div class="SCT002 '+addFreeScrClass+'">'+
								'<input type="text" class="evalShtQntScrInfo highestPoint" name="scr" maxlength="2" placeholder="ex) 1" data-scr-order="0" onkeyup="isScrValidated(this,'+sortNum+','+removeChildIdx+')">'+ 
						  	'</div>'+
							'<div>'+ 
								'<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="'+sortNum+'" data-remove-shtsctrid="" data-remove-shtitmid="" onclick="fnRemoveFldCctr(this,'+removeChildIdx+')" />'+
							'</div>'+
						'</div>';
						
		subBody.eq(sortNum).append(html);
		
		fldSctrAreaHeight(selectPointType,sortNum);
		fnChangeTotalCnt();
		$('.table-btn-wrap').hide();
	
	}
	
	
	function fnAddToggle(idx){
		$('.table-btn-wrap').eq(idx).toggle();
	}
	// 부문 삭제
	function fnRemoveFldCctr(_this,removeIdx){
		if(confirm('평가 항목을 삭제하시겠습니까?')) {
			var parentIdx = $(_this).data("remove-order");
			
			var tableBody = $(".table-body");
			var tableSubList = tableBody.eq(parentIdx).find(".table-sub-list");
			
			
			if(tableBody.length == 1 && tableSubList.length == 1){
				alert("평가부문 행이 최소 하나 이상 존재해야 합니다.");
				return;
			}
			
			var removeShtSctrId = $(_this).data("remove-shtsctrid"); 
			var removeShtItmId = $(_this).data("remove-shtitmid");
			
			if(tableSubList.length == 1){
				if(removeShtSctrId != "" && removeShtSctrId != null){
					delShtSctrIdArray.push(removeShtSctrId)
				}
				tableBody.eq(parentIdx).remove();
			}else{
				if(removeShtItmId != "" && removeShtItmId != null){
					delShtItmIdArray.push(removeShtItmId);
				}
				tableSubList.eq(removeIdx).remove();
				var selectPointType = $("#selectPointType").val();
				fldSctrAreaHeight(selectPointType,parentIdx);
			}
			
			var addFldCctr = $(".addFldCctr");
			var tablePlus = $(".table-plus");
			var subBody = $(".sub-body");
			var addFldItm = $(".addFldItm");
			
			addFldCctr.each(function(idx,item){
	
				$(item).attr("data-sort",idx);
				tablePlus.eq(idx).attr("onclick","fnAddToggle("+idx+")")
				addFldItm.eq(idx).attr("data-fld-order",idx)
				
				//삭제버튼 idx 재설정
				var removeBtn = subBody.eq(idx).find(".removeBtn");
				removeBtn.attr("data-remove-order",idx)
				removeBtn.each(function(removeIdx,removeItem){
					$(removeItem).attr("onclick","fnRemoveFldCctr(this,"+removeIdx+")")	
				})
				
				//배점 idx 재설정
				var tableSubList = subBody.eq(idx).find(".table-sub-list");
				tableSubList.each(function(subIdx,subItem){
					$(subItem).find("input[name='scr']").attr("onkeyup","isScrValidated(this,"+idx+","+subIdx+")");
				})
			});
			
			fnChangeTotalCnt();
			fnSetTotalScr();
			
		}
	}
	
	$("#selectPointType").on("change",function(){
		var typeVal = $(this).val();
		if(typeVal == "SCT001"){
			$(".SCT001").removeClass("display-none");
			$(".SCT002").addClass("display-none");
			$(".table-head").addClass("table-head-all");
			$(".table-body").addClass("table-body-all");
			$(".table-sub-list").addClass("table-sub-list-all");
		}else{
			$(".SCT002").removeClass("display-none");
			$(".SCT001").addClass("display-none");
			$(".table-head").removeClass("table-head-all");
			$(".table-body").removeClass("table-body-all");
			$(".table-sub-list").removeClass("table-sub-list-all");
		}
		var bigHead = $(".sub-head");
		bigHead.each(function(idx,item){
			fldSctrAreaHeight(typeVal,idx);
		})
		$("input[name='scrNm']").val('');
		$("input[name='scr']").val('');
		
		// 최고점 초기화
		$('#totalScr').text('0점');
	})
	
	function fnEvalInfoSave(type){
			
		var shtInfoId = $("#shtInfoId").val();
		var shtId = $("#shtId").val();
		var selectPointType = $("#selectPointType").val();
		
		var tableBody = $(".table-body");
		
		//전체 정보 저장
		var evalShtInfo = new Object();
		
		//평가 부문 목록 Array
		var evalShtSctrList  = new Array();
		var vaildChk = true;
		var isFldItmEmpty = false;
		var isFldItmEmntEmpty = false;
		//평가부문 개수 만큼 조회
		tableBody.each(function(idx,item){
			
			//평가부문 정보 저장
			var evalShtSctrInfo = new Object();
			var fldSctr = $(item).find("textarea[name='fldSctr']").val();
			if(vaildChk){
				if(fldSctr == null || fldSctr == ''){
					alert((idx+1)+"번째 평가부문 내용을 입력해 주세요.");
					vaildChk = false;
					return;
				}
			}
			var shtSctrId = $(item).find("textarea[name='fldSctr']").data("shtsctrid");
			evalShtSctrInfo.shtSctrId = shtSctrId;
			evalShtSctrInfo.fldSctr = fldSctr;
			evalShtSctrInfo.fldOrdr = idx;
			//평가 항목 저장(항목 정보가 있는 div)
			var evalShtItemList  = new Array();
			var tableSubList = $(item).find(".table-sub-list");
			tableSubList.each(function(subIdx,subItem){
				var evalShtItemInfo = new Object();
				var itmNm 		= $(subItem).find("textarea[name='fldItm']").val(); //항목 val
				var shtItmId	= $(subItem).find("textarea[name='fldItm']").data("shtitmid") 
				var itmElmnt 	= $(subItem).find("textarea[name='fldElmnt']").val(); // 요소 val
				
				if(idx == 0 && subIdx == 0 && vaildChk) {
					if(itmNm == null || itmNm == ''){
						isFldItmEmpty = true;	
						isFldItmEmntEmpty = true;
					}	
				}
				if(idx == 0 && subIdx == 0 && vaildChk) {
					if(itmElmnt == null || itmElmnt == ''){
						isFldItmEmntEmpty = true;
					}	
				}
				
				//항목 체크
				if(isFldItmEmpty && vaildChk) {
					if(itmNm != '' ){
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목을 확인해 주세요.");
						vaildChk = false;
						return;
					}
				} else if(!isFldItmEmpty && vaildChk) {
					if(itmNm == '') {
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목 내용을 입력해 주세요.");
						vaildChk = false;
						return;
					}

				}
				
				//부문 체크
				if(isFldItmEmntEmpty && vaildChk) {
					if(itmElmnt != '' ){
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 요소를 확인해 주세요.");
						vaildChk = false;
						return;
					}
				} else if (!isFldItmEmntEmpty && vaildChk) {
					if(itmElmnt == '') {
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 요소 내용을 입력해 주세요.");
						vaildChk = false;
						return;
					}
				}
				
				evalShtItemInfo.shtItmId = shtItmId;
				evalShtItemInfo.itmNm = itmNm;
				evalShtItemInfo.itmElmnt = itmElmnt;
				evalShtItemInfo.itemOrdr = subIdx;
				
				//배점 정보 저장
				var evalShtQntScrInfo = $(subItem).find("."+selectPointType+" .evalShtQntScrInfo")
				var evalShtQltScrList  = new Array();
				var evalShtItemScrInfo = new Object();
				evalShtQntScrInfo.each(function(scrIdx,scrItem){
// 					if(scrIdx < selectPointType * 2 ){
						var inputNm = $(scrItem).attr("name");
						var inputVal = $(scrItem).val();
						if(selectPointType == 'SCT001'){
							if(inputNm == 'scrNm'){
								if(vaildChk){
									if(inputVal == null || inputVal == ''){
										alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목의 배점 정보를 입력해 주세요.");
										vaildChk = false;
										return;
									}	
								}
								evalShtItemScrInfo.scrNm = inputVal; 
							}
						}
						if(inputNm == 'scr'){
							//selectPointType 분기 처리 
							if(vaildChk){
								if(inputVal == null || inputVal == ''){
									alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목의 배점을 입력해 주세요.");
									vaildChk = false;
									return;
								}	
							}
							var scrOrder = $(scrItem).data("scr-order");
							var qltScrId = $(scrItem).data("qltscrid");
							
							evalShtItemScrInfo.qltScrId= qltScrId;
							evalShtItemScrInfo.scrOrdr= scrOrder;
							evalShtItemScrInfo.scr= inputVal;
							evalShtItemScrInfo.scrType = selectPointType;
						}
						if(selectPointType == 'SCT001'){
							if(scrIdx%2){
								if(JSON.stringify(evalShtItemScrInfo) !== '{}'){
									evalShtQltScrList.push(evalShtItemScrInfo);
									evalShtItemScrInfo = new Object();
								}
							}
						}else{
							if(JSON.stringify(evalShtItemScrInfo) !== '{}'){
								evalShtQltScrList.push(evalShtItemScrInfo);
								evalShtItemScrInfo = new Object();
							}
						}
// 					}
				
				}) // each end
				evalShtItemInfo.evalShtQltScrList = evalShtQltScrList; 
				evalShtItemList.push(evalShtItemInfo);
			}) // each end
			
			evalShtSctrInfo.evalShtItemList = evalShtItemList;
			evalShtSctrList.push(evalShtSctrInfo);
		})
		evalShtInfo.evalShtSctrList = evalShtSctrList;
		evalShtInfo.shtInfoId = shtInfoId;
		evalShtInfo.shtId = shtId;
		evalShtInfo.shtType = 'qlt';
		evalShtInfo.saveType = type;
		evalShtInfo.delShtSctrIdArray = delShtSctrIdArray;
		evalShtInfo.delShtItmIdArray = delShtItmIdArray;
		
		var url = "${pageContext.request.contextPath}/evaluation/management/sht/scr/save.ajax";
		if(type == "update"){
			url = "${pageContext.request.contextPath}/evaluation/management/sht/scr/update.ajax";
		}
		if(vaildChk){
			$.ajax({
	   			type : "post",
	   			contentType: 'application/json; charset=utf-8',
	   			data : JSON.stringify(evalShtInfo),
	   			url : url,
	   			success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					if(resultCode == 200) {
						alert(resultMessage);			
						let evalSttsCode = result.data.evalSttsCode;
						if(type == 'tmp'){
							window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
						}else{
							//평가지 대기 상태일경우는 목록으로
							//정상적 작성지 미작성시에는 type 화면으로 이동
							if(evalSttsCode == 'ESC004'){ //평가지 작성중
				  				window.location.href="${pageContext.request.contextPath}/evaluation/management/type/"+shtInfoId+"/save.do";
							}else{ //평가 대기
								window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";	
							}
						}
					} else {
						alert(resultMessage);
					}
	   			}
	   		});
		}
	}
	
	function fldSctrAreaHeight(selectScrType,idx){
		var addHeight = 133;
		var addLineHeight = 115;
		
		if(selectScrType == 'SCT001'){
			addHeight = 214;
			addLineHeight = 190;
		}
		
		$('.table-sub-list').css({
			'height': addHeight+'px',
            'line-height': addLineHeight+'px'
		})
		var bigHead = $(".sub-head");
		
		//평가부문 height/line-height 추가
		var totalLiLength = $(".sub-body").eq(idx).find('.table-sub-list').length;
		if(totalLiLength == 0){
			totalLiLength = 1;
		}
		var heightVal = addHeight * totalLiLength;
		var lineHeightVal = addLineHeight * totalLiLength;
		
		bigHead.eq(idx).css({
							"height": heightVal+"px",
							"line-height": lineHeightVal+"px"
							});
		
	}
	
	function isScrValidated(_this,sctrIdx,itemIdx){
		
		var thisVal = $(_this).val();
		
		var selectPointType = $("#selectPointType").val();
		var replaeVal = thisVal.replace(/[^0-9]/gi, '');
		
		//최고점 합 
		if($(_this).hasClass("highestPoint")){
			var highestPoint = $("."+selectPointType +" .highestPoint");
			var totalScr = 0;
			highestPoint.each(function(idx,item){
				totalScr += Number($(item).val());
				
			})
			if(totalScr > 0){
				totalScr = totalScr.toFixed(1);
			}
			$('#totalScr').text(parseFloat(totalScr)+'점');
		}
		
		if(selectPointType == 'SCT001'){
				
			replaeVal = thisVal.replace(/[^0-9\.]/g, '');	
			const regex = /^\d/;
	        if (!regex.test(thisVal)) {
	        	$(_this).val('');
	        	$(_this).nextAll('.point').val('');
	            return false;
	        }
			$(_this).val(replaeVal);
			var tableBody = $(".table-body");
			var tableSubList = $(".table-sub-list");
			var itemLocation = tableBody.eq(sctrIdx).find(tableSubList).eq(itemIdx);
			var highestPoint = itemLocation.find(".highestPoint").val(); 
			if($(_this).hasClass("highestPoint")){
				itemLocation.find(".directNumber").val(replaeVal);
				
				$(_this).nextAll('.point').each(function(idx,item){
					var percent = 0;
					if(idx == 0){
						percent = 0.9;
					}else if(idx == 1){
						percent = 0.8;
					}else if(idx == 2){
						percent = 0.7;
					}else if(idx == 3){
						percent = 0.6;
					}
					var resultVal = replaeVal*percent;
					$(item).val(resultVal.toFixed(1));
				})
			}else{
				if(Number(replaeVal) > Number(highestPoint)){
					$(_this).val(highestPoint);
				}
			}
		}else{
			$(_this).val(replaeVal);
		}
		
	}
	
	$("#fileUpload").on("change",function(){
		if(confirm("기존에 등록한 정보는 삭제됩니다. 업로드를 진행하시겠습니까?")) {
			var formData = new FormData();
			var shtInfoId = $("#shtInfoId").val();
			var shtId = $("#shtId").val();
			
			formData.append("file",$(this)[0].files[0]);
			formData.append("shtInfoId",shtInfoId);
			formData.append("shtId",shtId);
			formData.append("shtType","qlt");
			
			$.ajax({
	   			type : "post",
	   			data : formData,
	   			contentType : false,
	   	        processData : false, 
	   			url : "${pageContext.request.contextPath}/common/csv/file/upload.ajax",
	   			success : function(result) {
	   				let resultCode = result.code;
					let resultMessage = result.data.message;
					if(resultCode == 200) {
						alert(resultMessage)
						var evalShtInfoDTO = result.data.evalShtInfoDTO; 
						var param = encodeURI(evalShtInfoDTO)
// 						window.location.href="${pageContext.request.contextPath}/evaluation/management/qlt/"+shtInfoId+"/save.do?evalShtInfoDTO="+param;
						window.location.reload();
					} else {
						alert(resultMessage)				
					}
	   			}
	   		});
		}
	})
	
	function modifyScrNmSame(this_) {
		var order = $(this_).data("scrnm-order");
		var scrNmVal = $(this_).val();
		$("input[data-scrnm-order='"+order+"']").val(scrNmVal);
	}
	
</script>