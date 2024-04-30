<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div>
	<div class="content">
		<div class="login_wrap">
			<button type="button" onclick="logout('admin')">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
		
		<div class="content-head">
			<img src="${pageContext.request.contextPath}/statics/images/logo.png"
				class="logo">
			<h1>경기도 제안평가 목록</h1>

			<div class="status" id="statusCntDiv">
				<ul>
					<li>
						<button type="button" onclick="refreshBtn()">
							<img src="${pageContext.request.contextPath}/statics/images/reroad.png">
						</button>
					</li>
					<li>전체<span class="all">(${countInfo.totalCnt})</span></li>
					<li>작성중<span class="writing">(${countInfo.writingCnt})</span></li>
					<li>대기<span class="waiting">(${countInfo.waitingCnt})</span></li>
					<li>평가중<span class="evaluating">(${countInfo.progressCnt})</span></li>
					<li>완료<span class="complete">(${countInfo.completeCnt})</span></li>
				</ul>
			</div>
		</div>
		<form id="searchForm" method="get">
			<input type="hidden" id="pageNo" name="pageNo" value="${paging.pageNo}" />
			<div class="search-wrap">
				<select id="schSchStts" name="schSchStts" onchange="fnSearchList();">
					<option value="all">전체</option>
					<option value="writing" ${schSchStts eq 'writing' ? 'selected="selected"' : ''}>작성중</option>
					<option value="waiting" ${schSchStts eq 'waiting' ? 'selected="selected"' : ''}>대기</option>
					<option value="progress" ${schSchStts eq 'progress' ? 'selected="selected"' : ''}>평가중</option>
					<option value="complete" ${schSchStts eq 'complete' ? 'selected="selected"' : ''}>완료</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요." class="search" name="schShtNm" onkeyup="fnSearchFunction();" value="${schShtNm}">
			</div>
		</form>

		<div class="btn-wrap">
			<button type="button" id="saveEvalBtn" class="btn-make">평가지 생성</button>
			<button type="button" class="btn-make"onclick="fnRaterList('', '', 'save');"> 제안평가위원 관리</button>
		</div>

		<div class="list-wrap" id="listDiv">
			<c:forEach var="evalShtInfoList" items="${evalShtInfoList}">
				<div class="list">
					<div
						class="list-status
						<c:choose>
							<c:when test="${evalShtInfoList.shtAllStts eq 'ESC001' or 
											evalShtInfoList.shtAllStts eq 'ESC002' or
											evalShtInfoList.shtAllStts eq 'ESC003' or
											evalShtInfoList.shtAllStts eq 'ESC004'}">
								writing-back
							</c:when>
							<c:when test="${evalShtInfoList.shtAllStts eq 'ESC005'}">
								waiting-back
							</c:when>
							<c:when test="${evalShtInfoList.shtAllStts eq 'ESC006'}">
								evaluating-back
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
						">
						<span> 
							<c:choose>
								<c:when
										test="${evalShtInfoList.shtAllStts eq 'ESC001' or 
												evalShtInfoList.shtAllStts eq 'ESC002' or
												evalShtInfoList.shtAllStts eq 'ESC003'or
												evalShtInfoList.shtAllStts eq 'ESC004'}">
									작성 중
								</c:when>
								<c:when test="${evalShtInfoList.shtAllStts eq 'ESC005'}">
									대기
								</c:when>
								<c:when test="${evalShtInfoList.shtAllStts eq 'ESC006'}">
									평가 중
								</c:when>
								<c:otherwise>
									완료
								</c:otherwise>
							</c:choose>
						</span>
					</div>
					<div class="list-content">
						<div class="search-content">
							<div class="list-title">
								<h2>${evalShtInfoList.shtNm}</h2>
							</div>
							<div class="list-join-code">
								참여 코드 : <span>${evalShtInfoList.accssCd}</span>
							</div>
							<div class="list-date">
								등록 : <span> ${evalShtInfoList.strCrtDt}
								</span>
							</div>
						</div>
						<div class="search-option">
							<img src="${pageContext.request.contextPath}/statics/images/gear.png" class="option">
							<div class="option-list">
								<ul>
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC000' or 
												evalShtInfoList.shtAllStts eq 'ESC006'or 
 												evalShtInfoList.shtAllStts eq 'ESC005'or 
												evalShtInfoList.shtAllStts eq 'ESC007'or 
 												evalShtInfoList.shtAllStts eq 'ESC008' 
 												}"> 
									<li onclick="fnDetailView('${evalShtInfoList.shtInfoId}','${evalShtInfoList.shtAllStts}')">
										<img src="${pageContext.request.contextPath}/statics/images/detail.png">
										<span>평가지 상세</span> 
									</li>
									</c:if>
									<!-- 평가대기 / 평가지 작성중일 경우  -->
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC001' or 
												evalShtInfoList.shtAllStts eq 'ESC002' or
												evalShtInfoList.shtAllStts eq 'ESC003'or
												evalShtInfoList.shtAllStts eq 'ESC004'or
												evalShtInfoList.shtAllStts eq 'ESC005'
												}">
										<li onclick="fnEvalInfoUpdate('${evalShtInfoList.shtInfoId}','${evalShtInfoList.shtAllStts}')">
											<img src="${pageContext.request.contextPath}/statics/images/pen.png">
											<span>평가지 수정</span> 
										</li>
									</c:if>
									<!-- 평가 대기중일 경우 -->
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC005'}">
										<li onclick="fnChangeAccssCd('${evalShtInfoList.shtInfoId}');">
											<img src="${pageContext.request.contextPath}/statics/images/code.png">
											<span>참여 코드 변경</span> 
										</li>
										<li class="" onclick="fnRaterList('${evalShtInfoList.shtInfoId}', '', 'list')">
											<img src="${pageContext.request.contextPath}/statics/images/registration.png">
											<span>평가자 등록</span> 
										</li>
<%-- 										<li class="tester-list-on-btn" onclick="location.href='${pageContext.request.contextPath}/evaluation/management/eval/list.do?shtInfoId=${evalShtInfoList.shtInfoId}&shtNm=${evalShtInfoList.shtNm}'"> --%>
										<li class="" onclick="fnViewEvalList('${evalShtInfoList.shtInfoId}', '${evalShtInfoList.shtNm}')">
											<img src="${pageContext.request.contextPath}/statics/images/test.png">
											<span>평가하기</span> 
										</li>
									</c:if>
									<!-- 평가 완료일 경우 -->
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC000' or evalShtInfoList.shtAllStts eq 'ESC007' or evalShtInfoList.shtAllStts eq 'ESC008'}">
										<li onclick="fnEvalInfoCopy('${evalShtInfoList.shtInfoId}')">
											<img src="${pageContext.request.contextPath}/statics/images/recicle.png">
											<span>재사용</span> 
										</li>
									</c:if>
									<!-- 평가지 작성중 경우 -->
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC001' or 
												evalShtInfoList.shtAllStts eq 'ESC002' or
												evalShtInfoList.shtAllStts eq 'ESC003' or
												evalShtInfoList.shtAllStts eq 'ESC004' or
												evalShtInfoList.shtAllStts eq 'ESC005'}">
										<li onclick="fnEvalInfoDelete('${evalShtInfoList.shtInfoId}')">
											<img src="${pageContext.request.contextPath}/statics/images/delete.png">
											<span>삭제</span> 
										</li>
									</c:if>
									<!-- 평가지 진행중 경우 -->
									<c:if test="${evalShtInfoList.shtAllStts eq 'ESC006'}">
										<li class="" onclick="fnViewEvalList('${evalShtInfoList.shtInfoId}', '${evalShtInfoList.shtNm}')">
											<img src="${pageContext.request.contextPath}/statics/images/test.png">
											<span>평가하기</span> 
										</li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div> <!-- listDiv -->
		<%@ include file="/WEB-INF/jsp/ggits/utils/paging.jsp"%>
	</div>
</div>

<div class="sign-wrap tester-list-wrap mx500">
			
</div>
<script>

	function refreshBtn(){
		getEvalShtInfoListInit();
	}
	
	function getEvalShtInfoListInit(){
		var schShtNm = '${schShtNm}';
		var schSchStts = '${schSchStts}';
		var pageNo = '${paging.pageNo}';
		
		var obj = new Object();
		obj.schSchStts = schSchStts;
		obj.schShtNm = schShtNm;
		obj.pageNo = pageNo;
		 
		$.ajax({
   			type : "post",
   			contentType: 'application/json; charset=utf-8',
   			data : JSON.stringify(obj),
   			url : "${pageContext.request.contextPath}/evaluation/management/list.ajax",
   			success : function(result) {
				var countHtml = "";
				var tableHtml = "";
				
				var countInfo = result.countInfo;
				var evalShtInfoList = result.evalShtInfoList;
				
				//카운트 영역 비동기
				if(countInfo != null){
					$("#statusCntDiv").empty();
					
					countHtml += '	<ul>';
					countHtml += 		'<li>';
					countHtml += 			'<button type="button" onclick="refreshBtn()">';
					countHtml += 				'<img src="${pageContext.request.contextPath}/statics/images/reroad.png">';
					countHtml +=			'</button>';
					countHtml += 		'</li>';
					countHtml += '		<li>전체<span class="all">('+countInfo.totalCnt+')</span></li>';
					countHtml += '		<li>작성중<span class="writing">('+countInfo.writingCnt+')</span></li>';
					countHtml += '		<li>대기<span class="waiting">('+countInfo.waitingCnt+')</span></li>';
					countHtml += '		<li>평가중<span class="evaluating">('+countInfo.progressCnt+')</span></li>';
					countHtml += '		<li>완료<span class="complete">('+countInfo.completeCnt+')</span></li>';
					countHtml += '	</ul>';
					
					$("#statusCntDiv").append(countHtml);
				}
				
				//테이블 영역 비동기
				if(evalShtInfoList != null) {
					$('#listDiv').empty();
					for(let evalShtInfo of evalShtInfoList) {
						// 상태
						let shtAllStts = evalShtInfo.shtAllStts;
						let shtInfoId = evalShtInfo.shtInfoId;
						let shtNm = evalShtInfo.shtNm;
						let accssCd = evalShtInfo.accssCd;
						let crtDt = evalShtInfo.strCrtDt;
						
						tableHtml += '<div class="list">';
						tableHtml += '	<div class="list-status';
						if(shtAllStts == 'ESC001' || shtAllStts == 'ESC002' || shtAllStts == 'ESC003' || shtAllStts == 'ESC004') {
							tableHtml += '				writing-back';
						} else if(shtAllStts == 'ESC005') {
							tableHtml += '				waiting-back';
						} else if(shtAllStts == 'ESC006') {
							tableHtml += '				evaluating-back';
						}
						tableHtml += '	">';
						
						tableHtml += '	<span>';
						if(shtAllStts == 'ESC001' || shtAllStts == 'ESC002' || shtAllStts == 'ESC003' || shtAllStts == 'ESC004') {
							tableHtml += '				작성 중';
						} else if(shtAllStts == 'ESC005') {
							tableHtml += '				대기';
						} else if(shtAllStts == 'ESC006') {
							tableHtml += '				평가 중';
						} else {
							tableHtml += '				완료';
						}
						tableHtml += '	</span>';
						tableHtml += '	</div>';
						
						// content
						tableHtml += '	<div class="list-content">';
						tableHtml += '		<div class="search-content">';
						tableHtml += '			<div class="list-title">';
						tableHtml += '				<h2>'+shtNm+'</h2>';
						tableHtml += '			</div>';
						tableHtml += '			<div class="list-join-code">';
						tableHtml += '				참여 코드 : <span>'+accssCd+'</span>';
						tableHtml += '			</div>';
						tableHtml += '			<div class="list-date">';
						tableHtml += '				등록 : <span>'+crtDt+'</span>';
						tableHtml += '			</div>';
						tableHtml += '		</div>';
						
						//톱니바퀴 영역
						tableHtml += '			<div class="search-option">';
						tableHtml += '				<img src="${pageContext.request.contextPath}/statics/images/gear.png" class="option">';
						tableHtml += '				<div class="option-list">';
						tableHtml += '					<ul>';
						if(shtAllStts == 'ESC000' || shtAllStts == 'ESC005' || shtAllStts == 'ESC006' || shtAllStts == 'ESC007' || shtAllStts == 'ESC008'){
							tableHtml += '         				<li onclick="fnDetailView(\''+shtInfoId+'\',\''+shtAllStts+'\')">';
							tableHtml += '          				<img src="${pageContext.request.contextPath}/statics/images/detail.png">';
							tableHtml += '           				<span>평가지 상세</span>';
							tableHtml += '         				</li>';
						}
						//완료가 아니면
						if(shtAllStts == 'ESC001' || shtAllStts == 'ESC002' || shtAllStts == 'ESC003' || shtAllStts == 'ESC004' || shtAllStts == 'ESC005'){
							tableHtml += ' <li onclick="fnEvalInfoUpdate('+shtInfoId+',\''+shtAllStts+'\')">';
							tableHtml += '<img src="${pageContext.request.contextPath}/statics/images/pen.png">';
							tableHtml += '<span>평가지 수정</span> ';
							tableHtml += '</li>';
							switch(shtAllStts){
							case "ESC005": 
								// 대기중
								tableHtml += ' <li onclick="fnChangeAccssCd(\''+shtInfoId+'\')">';
								tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/code.png">';
								tableHtml += ' 		<span>참여 코드 변경</span> ';
								tableHtml += ' </li>';
								tableHtml += ' <li onclick="fnRaterList(\''+shtInfoId+'\', \'\', \'list\')">';
								tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/registration.png">';
								tableHtml += ' 		<span>평가자 등록</span> ';
								tableHtml += ' </li>';
								tableHtml += ' <li onclick="fnViewEvalList(\''+shtInfoId+'\', \''+shtNm+'\')">';
								tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/test.png">';
								tableHtml += ' 		<span>평가하기</span>'; 
								tableHtml += ' </li>';
								tableHtml += ' <li onclick="fnEvalInfoDelete(\''+shtInfoId+'\')">';
								tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/delete.png">';
								tableHtml += ' 		<span>삭제</span> ';
								tableHtml += ' </li>';
								break;
							default :
								tableHtml += ' <li onclick="fnEvalInfoDelete(\''+shtInfoId+'\')">';
								tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/delete.png">';
								tableHtml += ' 		<span>삭제</span> ';
								tableHtml += ' </li>';
								break;
							}
						} else if(shtAllStts == 'ESC000' || shtAllStts == 'ESC007' || shtAllStts == 'ESC008'){ //완료일때
							tableHtml += ' <li onclick="fnEvalInfoCopy(\''+shtInfoId+'\')">';
							tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/recicle.png">';
							tableHtml += ' 		<span>재사용</span> ';
							tableHtml += ' </li>';
						} else if(shtAllStts == 'ESC006') {
							tableHtml += ' <li onclick="fnViewEvalList(\''+shtInfoId+'\', \''+shtNm+'\')">';
							tableHtml += '		<img src="${pageContext.request.contextPath}/statics/images/test.png">';
							tableHtml += ' 		<span>평가하기</span>'; 
							tableHtml += ' </li>';
						}
						tableHtml += '					</ul>';
						tableHtml += ' 				</div>';
					    tableHtml += '			</div>';
						tableHtml += '		</div>';
						tableHtml += '</div>';
					} 
					$('#listDiv').append(tableHtml);
				}
				
				$('.option').click(function () {
					$(this).closest('.content').next().show();
					$(this).next().toggle();
					$('.option').not(this).next().hide();
				});
   			}
   		});
	}

	$("#saveEvalBtn").on('click',function() {
		location.href = "${pageContext.request.contextPath}/evaluation/management/save.do"
	});

	function fnSearchList() {
		document.getElementById('searchForm').action = "${pageContext.request.contextPath}/evaluation/management/list.do";
		document.getElementById('searchForm').submit();
	}
	
	function fnEvalInfoDelete(shtInfoId){
		if(confirm("평가지 정보를 삭제하시겠습니까?")) {
			$.ajax({
    			type : "get",
    			url : "${pageContext.request.contextPath}/evaluation/management/"+shtInfoId+"/delete.ajax",
    			success : function(result) {
    				let resultCode = result.code;
					let resultMessage = result.message;
					if(resultCode == 200) {
						alert(resultMessage);
						window.location.reload();
					} else {
						alert(resultMessage);
					}
	  			}
   			});
	  	}
	}
	
	function fnSearchFunction(){
		if (window.event.keyCode == 13) {
			fnSearchList();
	    }
	}
	
	function fnSaveRtrInfo(){
		
		var shtInfoId = $("#modalShtInfoId").val();
		var testerCheckList = $('.tester-check');
		
		if(testerCheckList.length < 3){
			alert("최소 3명을 선택해야 합니다.");
			return
		} else if(testerCheckList.length > 10) {
			alert("최대 10명까지 선택 가능합니다.");
			return
		}
		
		var evalRtrList = new Array();
		
		testerCheckList.each(function(idx,item){
			
			var evalRtrObject = new Object;
			
			var rtrId = $(item).data("rtrid");
			evalRtrObject.rtrId = rtrId;
			evalRtrObject.shtInfoId = shtInfoId;
			
			evalRtrList.push(evalRtrObject)
		})
		
		$.ajax({
   			type : "post",
   			contentType: 'application/json; charset=utf-8',
   			data : JSON.stringify(evalRtrList),
   			url : "${pageContext.request.contextPath}/evaluation/management/rtr/save.ajax",
   			success : function(result) {
				let resultCode = result.code;
				let resultMessage = result.message;
				
				if(resultCode == 200) {
					alert(resultMessage);
					window.location.reload();
				} else {
					alert(resultMessage);
				}
   			}
   		});
	}
	
	function fnChangeAccssCd(shtInfoId){
		if(confirm("참여 코드를 변경하시겠습니까?")) {
			$.ajax({
	   			type : "get",
	   			data : {"shtInfoId" : shtInfoId},
	   			url : "${pageContext.request.contextPath}/evaluation/management/"+shtInfoId+"/accss/code/change.ajax",
	   			success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					
					if(resultCode == 200) {
						alert(resultMessage);
						window.location.reload();
					} else {
						alert(resultMessage);
					}
	   			}
	   		});
		}
	}
	
	
	function fnEvalInfoUpdate(shtInfoId,shtAllStts){
		//평가 완료 / 평가 대기 / 평가 진행중 인경우 상세페이지 아닌 경우 작성중이 화면으로 이동
		var basicPath = "${pageContext.request.contextPath}/evaluation/management";
		var url = "";
		if(shtAllStts == 'ESC000' || shtAllStts == 'ESC005' || shtAllStts == 'ESC006' || shtAllStts == 'ESC007' || shtAllStts == 'ESC008'){
			url = basicPath + "/save.do?shtInfoId="+shtInfoId;
		}else{
			if(shtAllStts == 'ESC001'){ //평가 정보 화면 으로 이동
				url = basicPath + "/save.do?shtInfoId="+shtInfoId;	
			}else if(shtAllStts == 'ESC002'){ //평가 대상 정보 화면으로 이동
				url = basicPath + "/cmp/"+shtInfoId+"/save.do";				
			}else if(shtAllStts == 'ESC003'){ //정량적 평가지 작성
				url = basicPath + "/qnt/"+shtInfoId+"/save.do";
			}else if(shtAllStts == 'ESC004'){ //정성적 평가지 작성
				url = basicPath + "/qlt/"+shtInfoId+"/save.do";
			}else{
				alert("해당 평가지 상태를 확인해 주세요.");
			}
		}
		if(url == ""){
			alert("해당 평가지 상태를 확인해 주세요.");
			return;
		}
		window.location.href = url;
// 		window.location.href = "${pageContext.request.contextPath}/evaluation/management/save.do?shtInfoId="+shtInfoId;
	}
	
	
	function fnDetailView(shtInfoId,shtAllStts){
		
		//평가 완료 / 평가 대기 / 평가 진행중 인경우 상세페이지 아닌 경우 작성중이 화면으로 이동
		var basicPath = "${pageContext.request.contextPath}/evaluation/management";
		var url = "";
		if(shtAllStts == 'ESC000' || shtAllStts == 'ESC005' || shtAllStts == 'ESC006'|| shtAllStts == 'ESC007' || shtAllStts == 'ESC008'){
			url = basicPath + "/detailinfo/"+shtInfoId+"/detail.do";
		}else{
			if(shtAllStts == 'ESC001'){ //평가 정보 화면 으로 이동
				url = basicPath + "/save.do?shtInfoId="+shtInfoId;	
			}else if(shtAllStts == 'ESC002'){ //평가 대상 정보 화면으로 이동
				url = basicPath + "/cmp/"+shtInfoId+"/save.do";				
			}else if(shtAllStts == 'ESC003'){ //정량적 평가지 작성
				url = basicPath + "/qnt/"+shtInfoId+"/save.do";
			}else if(shtAllStts == 'ESC004'){ //정성적 평가지 작성
				url = basicPath + "/qlt/"+shtInfoId+"/save.do";
			}else{
				alert("해당 평가지 상태를 확인해 주세요.");
			}
		}
		if(url == ""){
			alert("해당 평가지 상태를 확인해 주세요.");
			return;
		}
		window.location.href = url;
		
	}
	
	function fnEvalInfoCopy(shtInfoId){
		if(confirm('평가지를 재사용 하시겠습니까?')){
			$.ajax({
	   			type : "get",
	   			data : {"shtInfoId" : shtInfoId},
	   			url : "${pageContext.request.contextPath}/evaluation/management/"+shtInfoId+"/copy.ajax",
	   			success : function(result) {
					let resultCode = result.code;
					let resultMessage = result.message;
					
					if(resultCode == 200) {
						alert(resultMessage);
						window.location.reload();
					} else {
						alert(resultMessage);
					}
	   			}
	   		});
		}
	}
	
	function fnViewEvalList(shtInfoId, shtNm) {
		$('.tester-list-wrap').empty();
		$.ajax({
   			type : "get",
   			url : "${pageContext.request.contextPath}/evaluation/management/eval/rater/"+shtInfoId+"/check.ajax",
   			success : function(result) {
				$('.tester-list-wrap').hide();
				let resultCode = result.code;
				let resultMessage = result.message;
				
				if(resultCode == 200) {
					window.location.href = "${pageContext.request.contextPath}/evaluation/management/eval/list.do?shtInfoId="+shtInfoId+"&shtNm="+shtNm;
				} else {
					alert(resultMessage);
				}
   			}
   		});
	}
	</script>