<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="content">
	<div class="login_wrap">
		<button type="button" onclick="logout('admin')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>제안평가위원별 평가점수 확인</h1>
	</div>	

	<div class="info-table">
		<div class="test-info form wdat">
			<dl>
				<dt>- 제안평가 사업명 :</dt>
				<dd>${evalShtInfo.shtNm}</dd>
			</dl>
			<dl>
				<dt>- 제안평가위원 :</dt>
				<dd>
				<span id="rtrNm"></span>
				<img src="${pageContext.request.contextPath}/common/sign/image/view.do?fileId=${signFileId}"/>(인)
				</dd>
			</dl>
			<dl>
				<dt>- 소속 :</dt>
				<dd>${rtrAgncy}</dd>
			</dl>
		</div>
	</div>
	
	
	
	<div class="table-exel-btn-wrap">
		<div class="total-score">
			<div></div>
		</div>
		
		<form id="searchForm" method="get" class="type-check">
			<select id="rtrId" name="rtrId">
				<c:forEach var="rater" items="${raterList}">
					<option value="${rater.rtrId}" ${rater.rtrId eq rtrId ? 'selected="selected"' : ''}>${rater.rtrNm}</option>
				</c:forEach>
			</select>
			<button class="on-btn mini-btn mj0 shtTypeBtn" onclick="fnSearchList()">제안평가위원회 점수 확인</button>
		</form>
	</div>
	
	<c:set var="evalResultHeaderInfo" value="${evalResultInfo.evalResultHeaderInfo}" />
	<c:set var="bddCmpNmLength" value="${fn:length(bddCmpList)}" />
	<c:set var="cmpCount" value="0"/>
	<c:set var="raterCount" value="0"/>
	<div class="result-table info-table test-table wdat">
			<table>
	              <colgroup>
	                  <col width=""/>
					  <col width=""/>
	              </colgroup>
	              <tr>
	                <th colspan="2" rowspan="2">평가항목</th>
	                <th rowspan="2">배점</th>
	                <th colspan="${bddCmpNmLength}">제안 업체</th>
	              </tr>
	             <tr>
	             	<c:forEach var="bddCmpNmList" items="${bddCmpList}">
		             	<th>${bddCmpNmList.bddCmpNm}</th>
	             	</c:forEach>
	             </tr>
	             <c:set var="maxScrTotal" value="0"/>
	             <c:choose>
	             	<c:when test="${evalShtInfoDTO.evalShtSctrList[0].evalShtItemList[0].itmNm ne ''}">
	             		<c:forEach var="evalShtSctr" items="${evalShtInfoDTO.evalShtSctrList}">
	             			<c:forEach var="evalShtItem" items="${evalShtSctr.evalShtItemList}">
					             <tr>
			             			<td colspan="2">${evalShtItem.itmNm}</td>
			             			<fmt:parseNumber var="intMaxScr" value="${evalShtItem.evalShtQltScrList[0].scr}" integerOnly="true"/>
			             			<td>${intMaxScr}</td>
			             			<c:set var="maxScrTotal" value="${maxScrTotal + intMaxScr}"/>
			             			<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs}">
			             				<c:if test="${evalRtrSctrScr.shtItmId eq evalShtItem.evalShtQltScrList[0].shtItmId}">
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
	             				<td colspan="2">${evalShtSctr.fldSctr}</td>
	             				<fmt:parseNumber var="intMaxScr" value="${evalShtItem.evalShtQltScrList[0].scr}" integerOnly="true"/>
	             				<td>${intMaxScr}</td>
	             				<c:set var="maxScrTotal" value="${maxScrTotal + intMaxScr}"/>
		             			<c:forEach var="evalRtrSctrScr" items="${evalRtrSctrScrs}">
		             				<c:if test="${evalRtrSctrScr.shtItmId eq evalShtItem.evalShtQltScrList[0].shtItmId}">
				             			<td>${evalRtrSctrScr.scr}</td>
		             				</c:if>
		             			</c:forEach>
	             			</tr>
	             		</c:forEach>
	             	</c:otherwise>
	             </c:choose>
	             
	             <c:forEach var="evalResultRtrInfoList" items="${evalResultRtrInfoList}">
	             <tr>
	                <td colspan="2">총 계</td>
	                <td id="">${maxScrTotal}</td>
	                <c:forEach var="sumSrc" items="${evalResultRtrInfoList.sumList}" varStatus="status">
		             	<td id="raterScr${status.index}${raterCount}">${sumSrc}</td>
	                </c:forEach>
	                <c:set var="raterCount" value="${raterCount + 1}"/>
	             </tr>
	             </c:forEach>
	             
	             
	             
	             
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

<script type="text/javascript">

	function fnSearchList() {
		document.getElementById('searchForm').action = "${pageContext.request.contextPath}/evaluation/management/${shtInfoId}/indv/result.do";
		document.getElementById('searchForm').submit();
	}
	
	$("#printBtn").on("click",function(){
		window.print();
	});
	
	var rtrNm = $("#rtrId option:selected").text();
	$("#rtrNm").text(rtrNm);
	
</script>