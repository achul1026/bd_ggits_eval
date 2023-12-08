<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<div class="content">
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>평가대상 등록</h1>
	</div>
	 <div class="progressbar-wrapper">
	      <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>평가정보 입력</p>
	          </li>
	          <li class="active">
	          	<p>평가대상 등록</p>
	          </li>
	          <li class="">
	          	<p>평가유형 선택</p>
	          </li>
	          <li class="">
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
	<div class="">
	
		<div class="form wd100">
			<label>평가대상(평가업체)</label>
			<div class="search-plus ">
				<input type="text" id="companyNm" placeholder="평가대상을 입력해주세요." class="plus-input border-input"/>
				<button type="button" id="addTargetBtn" class="plus-btn mini-btn on-btn">추가</button>
			</div>
		</div>
		
		<div class="search-list-wrap">
		<form id="cmpSaveForm" name="cmpSaveForm">
			<input type="hidden" id="shtInfoId" value="${shtInfoId}">
			<div class="search-list-title form wd100">
				<label>평가대상 리스트</label>
			</div>
			<div class="search-list-sub-wrap test-table" id="cmpSortable" >
				<c:if test="${fn:length(evalBddCmpList) ne 0}">
					<c:forEach var="evalBddCmpList" items="${evalBddCmpList}" varStatus="status">
						<div class="search-list" id="company${status.index}" class="companyDiv">
							<div class="list-company-name">
							<span class="bddCmpNbrSpan" id="bddCmpNbrSpan${evalBddCmpList.bddCmpNbr}">${evalBddCmpList.bddCmpNbr}. </span>
								${evalBddCmpList.bddCmpNm}
							</div>
							<div class="list-company-name">
								<button type="button" onclick="removeCompanyBtn('${status.index}')">	
								<img src="${pageContext.request.contextPath}/statics/images/delete.png" class="close">
								</button>	
							</div>
							<input type="hidden" name="bddCmpId" value="${evalBddCmpList.bddCmpId}">
							<input type="hidden" name="bddCmpNm" value="${evalBddCmpList.bddCmpNm}">
							<input type="hidden" name="bddCmpNbr" value="${evalBddCmpList.bddCmpNbr}">
						</div>
					</c:forEach>
				</c:if>
			</div>
		</form>
		</div>
		
		
		<div class="footer-wrap">
			<button type="button" id="cancelBtn" class="mini-btn mini-sub-btn prev" onClick="fnEvalInfoUpdate('${shtInfoId}')">이전</button>
			<div class="footer-left-btn">
				<c:choose>
					<c:when test="${fn:length(evalBddCmpList) ne 0}">
						<button type="button" class="on-btn mini-btn mr8" onclick="fnEvalCmpInfoSave('update')">다음</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="mini-sub-btn mini-btn" onclick="fnEvalCmpInfoSave('tmp')">임시 저장</button>
						<button type="button" class="on-btn mini-btn mr8" onclick="fnEvalCmpInfoSave('save')">다음</button>				
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
</div>
<script>
	
	var delBddCmpIdArray = new Array();
	
	// 평가 대상 추가 버튼
	$("#addTargetBtn").on('click',function(){
		var html = "";
		var companyNm = $("#companyNm").val();
		var	company = $(".search-list");
		var idx = $("input[name='bddCmpNm']").length;

		var bddCmpNm = $("input[name='bddCmpNm']");
		var dupleChk = false;
		//업체명 중복 체크
		bddCmpNm.each(function(idx,item){
			if($(item).val().trim() == companyNm){
				dupleChk = true;
			};
		});
		if(dupleChk){
			alert("중복된 평가대상이 존재합니다.");
			return false;
		}
		if(companyNm != null && companyNm != ''){
			html += '<div class="search-list" id="company'+company.length+'" class="companyDiv">';
			html += '	<div class="list-company-name">';
			html += '		<span id="bddCmpNbrSpan'+(idx+1)+'">'+(idx+1)+'. </span>';
			html +=			companyNm
			html += '	</div>';
			html += '	<div class="list-company-name">';
			html += '		<button type="button" onclick="removeCompanyBtn(\''+company.length+'\')">'	
			html += '		<img src="${pageContext.request.contextPath}/statics/images/delete.png" class="close">'
			html += '		</button>'	
			html += '	</div>';
			html += '	<input type="hidden" name="bddCmpId" value="">'
			html += '	<input type="hidden" name="bddCmpNm" value="' + companyNm + '">'
			html += '	<input type="hidden" name="bddCmpNbr" value="' + (idx+1) + '">'
			html += '</div>';
			$("#cmpSortable").append(html);
			$("#companyNm").val("");
		} else {
			alert("평가대상을 입력해주세요.");
			return false;
		}
		
	});
	
	// 평가 대상 삭제 버튼
	function removeCompanyBtn(idx){
		var company = $("#company"+idx);
		var bddCmpId = company.find("input[name='bddCmpId']").val();
		if(bddCmpId != null && bddCmpId != ''){
			delBddCmpIdArray.push(bddCmpId);
		}
		company.remove();
		
		var bddCmpNbr = $("input[name='bddCmpNbr']");
		var bddCmpNbrSpan = $(".bddCmpNbrSpan");
		bddCmpNbr.each(function(idx,item){
			$(item).val(idx+1);
			bddCmpNbrSpan.eq(idx).text(idx+1);
		});
	}
	
	function fnEvalCmpInfoSave(type){
			var shtInfoId = $("#shtInfoId").val();
			var searchList = $(".search-list");
			
			var cmpSaveInfo = new Object;
			
			var targetInfoList = new Array();
			searchList.each(function(idx,item){
				
				var targetInfoObject = new Object;
				
				var bddCmpNmVal = $(item).find("input[name='bddCmpNm']").val(); 
				var bddCmpNbrVal = $(item).find("input[name='bddCmpNbr']").val(); 
				var bddCmpIdVal = $(item).find("input[name='bddCmpId']").val(); 
				
				targetInfoObject.bddCmpNm = bddCmpNmVal;
				targetInfoObject.bddCmpNbr = bddCmpNbrVal;
				targetInfoObject.bddCmpId = bddCmpIdVal;
				targetInfoObject.shtInfoId = shtInfoId;
				
				targetInfoList.push(targetInfoObject)
			})
			cmpSaveInfo.evalBddCmpList = targetInfoList; 
			cmpSaveInfo.delBddCmpIdList = delBddCmpIdArray;
			if(cmpSaveInfo.evalBddCmpList.length < 1) {
				alert("평가 대상을 하나 이상 입력해 주세요");
				return false;	
			}

			var url = "${pageContext.request.contextPath}/evaluation/management/cmp/save.ajax";
			if(type == "update"){
				url = "${pageContext.request.contextPath}/evaluation/management/cmp/update.ajax";
			}
			$.ajax({
	   			type : "post",
	   			contentType: 'application/json; charset=utf-8',
	   			data : JSON.stringify(cmpSaveInfo),
	   			url : url,
	   			success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					let shtInfoId = result.data.shtInfoId;
					
					if(resultCode == 200) {
						alert(resultMessage);	
						if(type == 'tmp'){
			  				window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
						}else{
			  				window.location.href="${pageContext.request.contextPath}/evaluation/management/type/"+shtInfoId+"/save.do?type="+type;
						}
					} else {
						alert(resultMessage);
					}
	   			}
	   		});
	}
	
	$("#cmpSortable").sortable({
		// 모든 이동이 끝난 후에 마지막으로 실행
        stop : function(event, ui){
			var bddCmpNbr = $("input[name='bddCmpNbr']");
			var bddCmpNbrSpan = $("span[id^='bddCmpNbrSpan']");
			bddCmpNbr.each(function(idx,item){
				$(item).val(idx+1);
			});
			bddCmpNbrSpan.each(function(idx,item){
				$(item).text(idx+1+'. ');
			})
        }
    });
	
	function fnEvalInfoUpdate(shtInfoId){
		window.location.href = "${pageContext.request.contextPath}/evaluation/management/save.do?shtInfoId="+shtInfoId;
	}
</script>