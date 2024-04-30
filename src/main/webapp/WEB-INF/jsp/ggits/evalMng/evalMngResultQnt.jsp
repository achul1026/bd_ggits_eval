<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="content result-content">
	<div class="login_wrap">
			<button type="button" onclick="logout('admin')">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
			<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>제안평가 결과 확인</h1>
	</div>
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
	          <li class="progress-complete">
	          	<p>평가지 작성</p>
	          </li>
	           <li class=progress-complete>
	          	<p>평가지 상세정보</p>
	          </li>
	           <li class="active">
	          	<p>평가 결과 확인</p>
	          </li>
	      </ul>
	</div>		
	
		<div class="test-info form wdat flex gap32">
			<dl class="mj0">
				<dt>- 제안평가 사업명 :</dt>
				<dd>${evalResultInfo.shtNm}</dd>
			</dl>
		</div>
		<div class="btn-wrap pd0 flex-btn-wrap print-type-btn">
			<button type="button" class="on-btn mini-btn mj0 shtTypeBtn" onclick="fnEvalResult('all')">총 평가지</button>
			<button type="button" class="mini-btn mini-sub-btn mj0 shtTypeBtn" onclick="fnEvalResult('qnt')">정량적 평가지</button>
			<button type="button" class="mini-btn mini-sub-btn mj0 shtTypeBtn" onclick="fnEvalResult('qlt')">정성적 평가지</button>
		</div>
			
		<c:set var="evalResultHeaderInfo" value="${evalResultInfo.evalResultHeaderInfo}" />
		<c:set var="bddCmpNmLength" value="${fn:length(evalResultHeaderInfo.bddCmpNmList)}" />
		<c:set var="cmpCount" value="0"/>
		<c:set var="raterCount" value="0"/>
		<div class="result-table info-table test-table wdat">
			<table>
	              <colgroup>
	                  <col width=""/>
					  <col width=""/>
	              </colgroup>
	              <tr>
	                <th colspan="2" rowspan="2">평가 문항</th>
	                <th colspan="${bddCmpNmLength}">제안 업체</th>
	                <th colspan="3" rowspan="2">비고</th>
	              </tr>
	             <tr>
	             	<c:forEach var="bddCmpNmList" items="${evalResultHeaderInfo.bddCmpNmList}">
		             	<th>${bddCmpNmList}</th>
	             	</c:forEach>
	             </tr>
	              <tr>
	             	<td colspan="2">총계</td>
	             	<c:forEach var="totalSumList" items="${evalResultHeaderInfo.totalSumList}">
		             	<td>${totalSumList}</td>
	             	</c:forEach>
	             </tr>
	             <c:choose>
	             	<c:when test="${evalShtInfoDTO.evalShtSctrList[0].evalShtItemList[0].itmNm ne ''}">
	             		<c:forEach var="evalShtSctr" items="${evalShtInfoDTO.evalShtSctrList}">
	             			<c:forEach var="evalShtItem" items="${evalShtSctr.evalShtItemList}">
					             <tr>
			             			<fmt:parseNumber var="intMaxScr" value="${evalShtItem.evalShtQntScrInfo.fldScr}" integerOnly="true"/>
			             			<td colspan="2">${evalShtItem.itmNm} (${intMaxScr}점)</td>
			             			<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs}">
			             				<c:if test="${evalRtrSctrScr.shtItmId eq evalShtItem.evalShtQntScrInfo.shtItmId}">
					             			<td>${evalRtrSctrScr.scr}</td>
			             				</c:if>
			             			</c:forEach>
					             </tr>
					          </c:forEach>
	             		</c:forEach>
	             	</c:when>
	             	<c:otherwise>
	             		<c:forEach var="evalShtSctr" items="${evalShtInfoDTO.evalShtSctrList}">
             				<c:set var="evalShtItem" value="${evalShtSctr.evalShtItemList[0]}"/>
	             			<tr>
	             				<fmt:parseNumber var="intMaxScr" value="${evalShtItem.evalShtQntScrInfo.fldScr}" integerOnly="true"/>
	             				<td colspan="2">${evalShtSctr.fldSctr} (${intMaxScr}점)</td>
		             			<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs}">
		             				<c:if test="${evalRtrSctrScr.shtItmId eq evalShtItem.evalShtQntScrInfo.shtItmId}">
				             			<td>${evalRtrSctrScr.scr}</td>
		             				</c:if>
		             			</c:forEach>
	             			</tr>
	             		</c:forEach>
	             	</c:otherwise>
	             </c:choose>
				 
	        </table>
		</div>
		<div class="result-sign-wrap">
			<div class="sign-today">
				20&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<p>.</p><p>.</p>
			</div>	
				
			<div class="sign-manager test-info flex gap32">
				<dl class="mj0">
					<dt>- 작성자 :</dt>
					<dd class="sign-manager-name"><input type="text" placeholder="ex)담당 주무관"></dd>
				</dl>
				
				<dl>
					<dt>성명 : </dt>
					<dd><div class="sign-border"></div>(서명)</dd>
				</dl>
			</div>
			<div class="sign-manager test-info flex gap32">
				<dl class="mj0">
					<dt>- 검토자 :</dt>
					<dd class="sign-manager-name"><input type="text" placeholder="ex)교통정보운영팀장"></dd>
				</dl>
				
				<dl>
					<dt>성명 : </dt>
					<dd><div class="sign-border"></div>(서명)</dd>
				</dl>
			</div>
			<div class="sign-manager test-info flex gap32">
				<dl class="mj0">
					<dt>- 확인자 :</dt>
					<dd class="sign-manager-name"><input type="text" placeholder="ex)평가 위원장"></dd>
				</dl>
				
				<dl>
					<dt>성명 : </dt>
					<dd><div class="sign-border"></div>(서명)</dd>
				</dl>
			</div>
		</div>
		
	
		
		<div class="btn-wrap pd0 flex-btn-wrap print-btn-none">
			<button type="button" id="listMoveBtn" class="on-btn mini-btn mj0" onclick="location.href='${pageContext.request.contextPath}/evaluation/management/detailinfo/${shtInfoId}/detail.do?shtAllStts=ESC000';">확인</button>
			<button type="button" id="printBtn" class="mini-btn mini-sub-btn">출력</button>
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
						<button id="clearSignature" class="mini-btn mini-sub-btn">다시그리기</button>
						<button id="saveSignBtn" class="mini-btn on-btn">확인</button>
					</div>
				</div>
				
		  </div>
		</div>
<script type="text/javascript">

	var shtType = '${shtType}';
	var shtInfoId = '${shtInfoId}';
	const cmpCountConst = ${cmpCount};
	const raterCountConst = ${raterCount};
	
	if("all" === shtType){
		$(".shtTypeBtn").eq(1).removeClass("on-btn");
		$(".shtTypeBtn").eq(2).removeClass("on-btn");
		$(".shtTypeBtn").eq(0).addClass("on-btn");
		
		$(".shtTypeBtn").eq(0).removeClass("mini-sub-btn");
		$(".shtTypeBtn").eq(1).addClass("mini-sub-btn");
		$(".shtTypeBtn").eq(2).addClass("mini-sub-btn");
	}else if("qnt"=== shtType){
		$(".shtTypeBtn").eq(0).removeClass("on-btn");
		$(".shtTypeBtn").eq(2).removeClass("on-btn");
		$(".shtTypeBtn").eq(1).addClass("on-btn");

		$(".shtTypeBtn").eq(1).removeClass("mini-sub-btn");
		$(".shtTypeBtn").eq(0).addClass("mini-sub-btn");
		$(".shtTypeBtn").eq(2).addClass("mini-sub-btn");
	}else{
		$(".shtTypeBtn").eq(0).removeClass("on-btn");
		$(".shtTypeBtn").eq(1).removeClass("on-btn");
		$(".shtTypeBtn").eq(2).addClass("on-btn");

		$(".shtTypeBtn").eq(2).removeClass("mini-sub-btn");
		$(".shtTypeBtn").eq(0).addClass("mini-sub-btn");
		$(".shtTypeBtn").eq(1).addClass("mini-sub-btn");
		
	}
// 	$("#listMoveBtn").on("click",function(){
// 		window.location.href = "${pageContext.request.contextPath}/evaluation/management/list.do";
// 	})
	$("#printBtn").on("click",function(){
		window.print();
	})
	
	function fnEvalResult(paramShtType){
		window.location.href = "${pageContext.request.contextPath}/evaluation/management/"+shtInfoId+"/result.do?shtType="+paramShtType;
	}
	
	window.onbeforeprint = function () { 
		$(".mini-sub-btn").addClass("display-none");
	};

	window.onafterprint = function () { 
		$(".mini-sub-btn").removeClass("display-none");
	};

</script>