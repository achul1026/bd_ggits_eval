<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<div class="content result-content">
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
			<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>평가 결과 확인</h1>
	</div>
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
	          <li class="progress-complete">
	          	<p>평가지 작성</p>
	          </li>
	           <li class=progress-complete>
	          	<p>평가지 상세정보</p>
	          </li>
	           <li class="active">
	          	<p>평가결과 확인</p>
	          </li>
	      </ul>
	</div>		
	
		<div class="test-info form wdat flex gap32">
			<dl class="mj0">
				<dt>- 평가사업명 :</dt>
				<dd>${evalResultInfo.shtNm}</dd>
			</dl>
		</div>
		<div class="btn-wrap pd0 flex-btn-wrap">
			<button type="button" class="on-btn mini-btn mj0 shtTypeBtn" onclick="fnEvalResult('all')">총 평가지</button>
			<button type="button" class="mini-btn mini-sub-btn mj0 shtTypeBtn" onclick="fnEvalResult('qnt')">정량적 평가지</button>
			<button type="button" class="mini-btn mini-sub-btn mj0 shtTypeBtn" onclick="fnEvalResult('qlt')">정성적 평가지</button>
		</div>
			
		<c:set var="evalResultHeaderInfo" value="${evalResultInfo.evalResultHeaderInfo}" />
		<c:set var="bddCmpNmLength" value="${fn:length(evalResultHeaderInfo.bddCmpNmList)}" />
		<div class="result-table info-table test-table wdat">
			<table>
	              <colgroup>
	                  <col width=""/>
					  <col width=""/>
	              </colgroup>
	              <tr>
	                <th colspan="2" rowspan="2">평가위원</th>
	                <th colspan="${bddCmpNmLength}">제안 업체</th>
	                <th colspan="3" rowspan="2">비고</th>
	              </tr>
	             <tr>
	             	<c:forEach var="bddCmpNmList" items="${evalResultHeaderInfo.bddCmpNmList}">
		             	<th>${bddCmpNmList}</th>
	             	</c:forEach>
	             </tr>
	             <tr>
	             	<td colspan="2">평균</td>
	             	<c:forEach var="totalAvgList" items="${evalResultHeaderInfo.totalAvgList}">
		             	<td>${totalAvgList}</td>
	             	</c:forEach>
	             </tr>
	              <tr>
	             	<td colspan="2">총계</td>
	             	<c:forEach var="totalSumList" items="${evalResultHeaderInfo.totalSumList}">
		             	<td>${totalSumList}</td>
	             	</c:forEach>
	             </tr>
	             <tr class="bg-f2">
	             	<td rowspan="3">제외점수</td>
	             	<td>소계</td>
	             	<c:forEach var="bddCmpNmList" items="${evalResultHeaderInfo.bddCmpNmList}">
		             	<td></td>
	             	</c:forEach>
	             </tr>
	             <tr class="bg-f2">
	             	<td>최고</td>
	             	<c:forEach var="maxScrList" items="${evalResultHeaderInfo.maxScrList}">
		             	<td>${maxScrList}</td>
	             	</c:forEach>
	             </tr>
	             <tr class="bg-f2">
	             	<td>최저</td>
	             	<c:forEach var="minScrList" items="${evalResultHeaderInfo.minScrList}">
		             	<td>${minScrList}</td>
	             	</c:forEach>
	             </tr>
	             <tr>
	                <td colspan="2">소계</td>
	                <c:forEach var="bddCmpNmList" items="${evalResultHeaderInfo.bddCmpNmList}">
		             	<td></td>
	             	</c:forEach>
	             </tr>
	             <c:forEach var="evalResultRtrInfoList" items="${evalResultInfo.evalResultRtrInfoList}">
	             <tr>
	                <td colspan="2">${evalResultRtrInfoList.rtrNm}</td>
	                <c:forEach var="sumSrc" items="${evalResultRtrInfoList.sumList}">
		             	<td>${sumSrc}</td>
	                </c:forEach>
	             </tr>
	             </c:forEach>
	        </table>
		</div>
		<div class="table-about-text">
			최상위와 최하위를 제외한 후 평균을 산정,
  		    최상위와 최하위 평점이 2개 이상인 경우에는 1개씩만 제외
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
		
	
		
		<div class="btn-wrap pd0 flex-btn-wrap">
			<!-- <a href="javascript:history.back();" class="mini-btn mini-sub-btn prev">이전</a> -->
			<button type="button" id="listMoveBtn" class="on-btn mini-btn mj0" onclick="javascript:history.back();">확인</button>
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
	
	
</script>