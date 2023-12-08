<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="content">
	<input type="hidden" id="shtInfoId" value="${evalQntInfo.shtInfoId}" />
	<input type="hidden" id="shtId" value="${evalQntInfo.shtId}" />
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png"
			class="logo">
		<h1>평가지 작성(정량적)</h1>

		<div class="progressbar-wrapper">
			<ul class="progressbar">
				<li class="progress-complete">
					<p>평가정보 입력</p>
				</li>
				<li class="progress-complete">
					<p>평가대상 등록</p>
				</li>
				<li class="progress-complete">
					<p>평가유형 선택</p>
				</li>
				<li class="active">
					<p>평가지 작성</p>
				</li>
				<li class=>
					<p>평가지 상세정보</p>
				</li>
				<li>
					<p>평가결과 확인</p>
				</li>
			</ul>
		</div>
	</div>
	<div class="test-info form wdat">
		<dl class="mj0">
			<dt>- 정량적 평가서명 :</dt>
			<dd>${shtNm}</dd>
		</dl>
	</div>


	<div class="table-exel-btn-wrap">
		<div>
			평가 문항수
			<span id="totalCnt">
				<c:choose>
					<c:when test="${fn:length(evalQntInfo.evalShtSctrList) > 0}">
						(${fn:length(evalQntInfo.evalShtSctrList)})
					</c:when>
					<c:otherwise>
						(1)
					</c:otherwise>
				</c:choose>
			</span>
		</div>
		<div class="btn-sub-wrap">
			<a href="${pageContext.request.contextPath}/common/sample/file/download.ajax?fileName=sample_qnt_upload.csv" class="mini-btn mini-sub-btn">양식 다운로드</a>
			<label for="fileUpload" class="mini-btn mini-sub-btn mj0">양식 업로드</label>
			<input type="file" class="file-one-change uploadFile" id="fileUpload" accept=".csv">
		</div>
	</div>
	<div class="table-wrap test-table pc-table-qnt">
		<div class="table-head pc-table-qnt-head">
			<ul>
				<li>평가부문</li>
				<li>항목</li>
				<li>요소</li>
				<li>배점</li>
				<li>관리</li>
			</ul>
		</div>
		<c:choose>
			<c:when test="${fn:length(evalQntInfo.evalShtSctrList) > 0}">
				<c:forEach var="evalShtSctrList" items="${evalQntInfo.evalShtSctrList}">
					<div class="table-body pc-table-qnt-body">
						<c:set var="itemLength" value="${fn:length(evalShtSctrList.evalShtItemList)}" />
						<c:set var="height" value="${133 * itemLength}px" />
						<c:set var="lineHeight" value="${133 * itemLength}px" />
						<div class="table-list sub-head" style="height: ${height}; line-height: ${lineHeight};">
							<img src="/statics/images/table-plus.png" class="table-plus" onclick="fnAddToggle(${evalShtSctrList.fldOrdr});">
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
							<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해주세요." data-shtsctrid="${evalShtSctrList.shtSctrId}">${evalShtSctrList.fldSctr}</textarea>
						</div>
						<div class="table-list sub-body">
							<c:forEach var="evalShtItemList" items="${evalShtSctrList.evalShtItemList}">
								<div class="table-sub-list table-qnt-sub-list">
									<div class="addFldItmUl changUl">
										<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid="${evalShtItemList.shtItmId}">${evalShtItemList.itmNm}</textarea>
									</div>
									<div class="addFldElmntUl changUl">
										<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해주세요.">${evalShtItemList.itmElmnt}</textarea>
									</div>
									<div>
										<input type="text" class="evalShtQntScrInfo" name="fldScr" placeholder="ex) 10" maxlength="2" value="${evalShtItemList.evalShtQntScrInfo.fldScr}" data-qntscrid="${evalShtItemList.evalShtQntScrInfo.qntScrId}" onkeyup="isScrValidated(this)">
									</div>
									<div class="addRemoveBtnUl changUl">
										<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="${evalShtSctrList.fldOrdr}" data-remove-shtsctrid="${evalShtSctrList.shtSctrId}" data-remove-shtitmid="${evalShtItemList.shtItmId}" onclick="fnRemoveFldCctr(this,${evalShtItemList.itemOrdr})" />
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<div class="table-body pc-table-qnt-body">
					<div class="table-list sub-head">
						<img src="/statics/images/table-plus.png" class="table-plus"onclick="fnAddToggle(0);">
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
						<div class="addFldSctrUl changUl">
							<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid=""></textarea>
						</div>
					</div>
					<div class="table-list sub-body">
						<div class="table-sub-list table-qnt-sub-list">
							<div class="addFldItmUl changUl">
								<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid=""></textarea>
							</div>
							<div class="addFldElmntUl changUl text-length">
								<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해주세요."></textarea>
							</div>
							<div>
								<input type="text" class="evalShtQntScrInfo" name="fldScr" placeholder="ex) 10" maxlength="2" data-qntscrid="" onkeyup="isScrValidated(this)"> 
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
	

	<div class="footer-wrap">
		<a href="javascript:history.back();" class="mini-btn mini-sub-btn prev">이전</a>
		<div class="footer-left-btn">
			<c:choose>
				<c:when test="${evalQntInfo.saveType eq 'update'}">
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
	
	var delShtSctrIdArray = new Array();
	var delShtItmIdArray = new Array();

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
		var addClass = "";
		if(selectPointType == "3"){
			addClass = "display-none";
		}
		
		var html =	'<div class="table-body pc-table-qnt-body">'+
						'<div class="table-list sub-head">'+
							'<img src="/statics/images/table-plus.png" class="table-plus" onclick="fnAddToggle('+(sortNum+1)+');">'+
			            	'<div class="table-btn-wrap" style="display: none;">'+
								'<ul>'+
									'<li><button type="button" class="addFldCctr" onclick="fnAddFldCctr(this)" data-sort="'+(sortNum+1)+'"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">부문추가</button></li>'+
									'<li><button type="button" class="addFldItm" onclick="fnAddFldItm(this)" data-fld-order="'+(sortNum+1)+'"><img src="${pageContext.request.contextPath}/statics/images/table-inner-plus.png" class="table-inner-plus">항목추가</button></li>'+
								'</ul>'+
							'</div>'+
// 						 	'<input type="text" name="fldSctr" maxlength="255" placeholder="내용을 입력해주세요." data-shtsctrid=""">'+
						 	'<textarea name="fldSctr" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid=""></textarea>'+
						'</div>'+
						'<div class="table-list sub-body">'+
							'<div class="table-sub-list table-qnt-sub-list">'+
								'<div class="addFldItmUl changUl">'+
// 									'<input type="text" name="fldItm" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid="">'+
									'<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid=""></textarea>'+
								'</div>'+
								'<div class="addFldElmntUl changUl">'+
									'<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해주세요."></textarea>'+
								'</div>'+
								'<div>'+
								   	'<input type="text" class="evalShtQntScrInfo" name="fldScr" placeholder="ex) 10" maxlength="2" data-qntscrid="" onkeyup="isScrValidated(this)">'+
								'</div>'+
								'<div class="addRemoveBtnUl changUl">'+
									'<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="'+(sortNum+1)+'" data-remove-shtsctrid="" data-remove-shtitmid="" onclick="fnRemoveFldCctr(this,'+0+')" />'+
								'</div>'+
							'</div>'+
						'</div>'+
					'</div>';
		
			
			$(".table-body").eq(sortNum).after(html);
			fldSctrAreaHeight(selectPointType,(sortNum+1));
			$("#totalCnt").text("("+(addFldCctr.length+1)+")")
			$('.table-btn-wrap').hide();
		
	}
	
	//항목추가
	function fnAddFldItm(_this){
		var sortNum = Number($(_this).attr("data-fld-order"));
		var subBody = $(".sub-body");
		var selectPointType = $("#selectPointType").val();
		var addClass = "";
		if(selectPointType == "3"){
			addClass = "display-none";
		}
		
		var removeChildIdx = subBody.eq(sortNum).find(".table-sub-list").length;
		
		//배점 html 추가
		var html =		'<div class="table-sub-list table-qnt-sub-list">'+
							'<div class="addFldItmUl changUl">'+
								'<textarea name="fldItm" maxlength="255" placeholder="내용을 입력해주세요." data-shtitmid=""></textarea>'+
							'</div>'+
							'<div class="addFldElmntUl changUl">'+
								'<textarea name="fldElmnt" maxlength="255" placeholder="내용을 입력해주세요."></textarea>'+
							'</div>'+
							'<div>'+
							   	'<input type="text" class="evalShtQntScrInfo" name="fldScr" placeholder="ex) 10" maxlength="2" data-qntscrid="" onkeyup="isScrValidated(this)">'+
							'</div>'+
							'<div>'+ 
								'<img src="/statics/images/delete.png" class="close removeBtn" data-remove-order="'+sortNum+'" data-remove-shtsctrid="" data-remove-shtitmid="" onclick="fnRemoveFldCctr(this,'+removeChildIdx+')" />'+
							'</div>'+
						'</div>';
						
		subBody.eq(sortNum).append(html);
		
		fldSctrAreaHeight(selectPointType,sortNum);
			
		$('.table-btn-wrap').hide();
	
	}

	function fnAddToggle(idx){
		$('.table-btn-wrap').eq(idx).toggle();
	}
	
	function fnRemoveFldCctr(_this,removeIdx){
		var parentIdx = $(_this).data("remove-order");
		
		var tableBody = $(".table-body");
		var tableSubList = tableBody.eq(parentIdx).find(".table-sub-list");
		
		
		if(tableBody.length == 1 && tableSubList.length == 1){
			alert("평가부문 행이 최소 하나 이상은 존재해야합니다.");
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
			var removeBtn = subBody.eq(idx).find(".removeBtn");
			removeBtn.attr("data-remove-order",idx)
			removeBtn.each(function(removeIdx,removeItem){
				$(removeItem).attr("onclick","fnRemoveFldCctr(this,"+removeIdx+")")	
			})
		});
		
		$("#totalCnt").text("("+$(".table-body").length+")");
	}
	
	$("#selectPointType").on("change",function(){
		var typeVal = $(this).val();
		if(typeVal == "5"){
			$(".addPoints").removeClass("display-none");
			$(".addScrNm").attr("name","scrNm");
			$(".addScr").attr("name","scrNm");
			
		}else{
			$(".addPoints").addClass("display-none");
			$(".addScrNm").attr("name","addScrNm");
			$(".addScr").attr("name","addScr");
		}
		var bigHead = $(".sub-head");
		bigHead.each(function(idx,item){
			fldSctrAreaHeight(typeVal,idx);
		})
		$("input[name='scrNm']").val('');
		$("input[name='scr']").val('');
		
	})
	
	function fnEvalInfoSave(type){
		
		var shtInfoId = $("#shtInfoId").val();
		var shtId = $("#shtId").val();
		
		var tableBody = $(".table-body");
		
		//정체 정보 저장
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
					alert((idx+1)+"번째 평가부문 내용을 입력해주세요.");
					vaildChk = false;
					return;
				}
			}
			var shtSctrId = $(item).find("textarea[name='fldSctr']").data("shtsctrid");
			evalShtSctrInfo.fldSctr = fldSctr;
			evalShtSctrInfo.shtSctrId = shtSctrId;
			evalShtSctrInfo.fldOrdr = idx;
			//평가 항목 저장(항목 정보가 있는 div)
			var evalShtItemList  = new Array();
			var tableSubList = $(item).find(".table-sub-list");
			
			
			tableSubList.each(function(subIdx,subItem){
				var evalShtItemInfo = new Object();
// 				var itmNm = $(subItem).find("input[name='fldItm']").val(); //항목 val
				var itmNm = $(subItem).find("textarea[name='fldItm']").val(); //항목 val
				var itmElmnt 	= $(subItem).find("textarea[name='fldElmnt']").val(); // 요소 val
				
				if(idx == 0 && subIdx == 0 && vaildChk){
					if(itmNm == null || itmNm == ''){
						isFldItmEmpty = true;		
					}	
				}
				
				if(idx == 0 && subIdx == 0 && vaildChk) {
					if(itmElmnt == null || itmElmnt == ''){
						isFldItmEmntEmpty = true;
					}	
				}
				
				if(isFldItmEmpty && vaildChk) {
					if(itmNm != '' ){
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목을 확인해 주세요.");
						vaildChk = false;
						return;
					}
				} else if (!isFldItmEmpty && vaildChk) {
					if(itmNm == '') {
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목 내용을 입력해주세요.");
						vaildChk = false;
						return;
					}
				}
				
				if(isFldItmEmntEmpty && vaildChk) {
					if(itmElmnt != '' ){
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 요소를 확인해 주세요.");
						vaildChk = false;
						return;
					}
				} else if (!isFldItmEmntEmpty && vaildChk) {
					if(itmElmnt == '') {
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 요소 내용을 입력해주세요.");
						vaildChk = false;
						return;
					}
				}
				
// 				var shtItmId = $(subItem).find("input[name='fldItm']").data("shtitmid") 
				var shtItmId = $(subItem).find("textarea[name='fldItm']").data("shtitmid") 
				
				evalShtItemInfo.shtItmId = shtItmId;
				evalShtItemInfo.itmNm = itmNm;
				evalShtItemInfo.itmElmnt = itmElmnt;
				evalShtItemInfo.itemOrdr = subIdx;
				
				//배점 정보 저장
				var evalShtQntScrInfo = new Object();
				var fldScr = $(subItem).find("input[name='fldScr']").val();
				if(vaildChk){
					if(fldScr.length > 2) {
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목 배점을 확인해 주세요.\n배점은 2자리를 넘을 수 없습니다.");
						vaildChk = false;
						return;
					}
				}
				if(vaildChk){
					if(fldScr == null || fldScr == ''){
						alert((idx+1)+"번째 평가부문의 "+(subIdx+1)+"번째 항목 배점을 입력해주세요.");
						vaildChk = false;
						return;
					}	
				}
				
				var qntScrId = $(subItem).find("input[name='fldScr']").data("qntscrid");
				evalShtQntScrInfo.fldScr = fldScr;
				evalShtQntScrInfo.qntScrId = qntScrId;
				evalShtItemInfo.evalShtQntScrInfo = evalShtQntScrInfo;
				
				evalShtItemList.push(evalShtItemInfo);
			})
			
			evalShtSctrInfo.evalShtItemList = evalShtItemList;
			evalShtSctrList.push(evalShtSctrInfo);
		})
		evalShtInfo.evalShtSctrList = evalShtSctrList;
		evalShtInfo.shtInfoId = shtInfoId;
		evalShtInfo.shtId = shtId;
		evalShtInfo.shtType = 'qnt';
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
								if(evalSttsCode == 'ESC003'){ //평가지 작성중
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
		
		if(selectScrType == '5'){
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
	
	$("#fileUpload").on("change",function(){
		
		if(confirm("기존에 등록한 정보는 삭제 됩니다. 업로드 진행하시겠습니가?")) {
			var formData = new FormData();
			var shtInfoId = $("#shtInfoId").val();
			var shtId = $("#shtId").val();
			
			formData.append("file",$(this)[0].files[0]);
			formData.append("shtInfoId",shtInfoId);
			formData.append("shtId",shtId);
			formData.append("shtType","qnt");
			
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
						window.location.reload();
					} else {
						alert(resultMessage)				
					}
	   			}
	   		});
		}
	})
	
	function isScrValidated(_this,sctrIdx,itemIdx){
		
		var thisVal = $(_this).val();
		var replaeVal = thisVal.replace(/[^0-9]/gi, '');		
		$(_this).val(replaeVal);
		
	}
	
</script>