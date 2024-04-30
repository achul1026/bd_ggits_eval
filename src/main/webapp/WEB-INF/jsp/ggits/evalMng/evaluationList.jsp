<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="content">
	<div class="login_wrap">
		<button type="button" id="cancelBtn" class="back-btn">
			<img src="${pageContext.request.contextPath}/statics/images/back.png">
		</button>
		<button type="button" onclick="logout('admin')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
	     <img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>제안평가 대상 기업 목록</h1>
	</div>
		
	<div class="status status-left">
		<form id="searchForm" method="get">
		<div class='tablet-status'>
			<ul>
				<li>전체<span class="all">(${paging.totalCount})</span></li>
				<li>평가중<span class="writing">(${paging.totalCount-finishCnt})</span></li>
				<li>완료<span class="complete">(${finishCnt})</span></li>
			</ul>
		</div>
			<input type="hidden" id="pageNo" name="pageNo" value="1" />
			<input type="hidden" id="shtNm" name="shtNm" value="${shtNm}" />
			<input type="hidden" id="shtInfoId" name="shtInfoId" value="${shtInfoId}" />
		</form>
	</div>
		
	<div class="list-wrap border-none">
	  	<c:forEach var="evalBddCmp" items="${evalBddCmpList}" varStatus="loop">
			<div class="list" 
				<c:if test="${evalBddCmp.evalRtrSht[0].shtStts eq 'ERSSC004'}">
					onclick="fnEvalSheetView('${shtInfoId}', '${evalBddCmp.bddCmpNm}', '${evalBddCmp.bddCmpId }')"
				</c:if>
			>
				<div class="list-status 
					<c:if test="${evalBddCmp.evalRtrSht[0].shtStts eq 'ERSSC004'}">
						writing-back
					</c:if> 
				">
					<span>
						<c:choose>
							<c:when test="${evalBddCmp.evalRtrSht[0].shtStts eq 'ERSSC004'}">
								평가중									
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
							<h2>[${shtNm}] (${evalBddCmp.bddCmpNm })</h2>
						</div>
						<div class="list-join-code">
							<c:if test="${evalBddCmp.evalRtrSht[0].shtSvDt ne null}">
								<fmt:formatDate var="shtSvDt" pattern="yyyy년 MM월 dd일" value="${evalBddCmp.evalRtrSht[0].shtSvDt}" />
								
								<fmt:formatNumber var="totalScr" value="${evalBddCmp.evalRtrSht[0].totalScr}" pattern=".00"/>
								<fmt:parseNumber var="intScr" value="${totalScr}" integerOnly="true"/>
								<c:if test="${totalScr - intScr eq 0}">
									<c:set var="totalScr" value="${intScr}"/>
								</c:if>			
													
								<div class="complete-score">평가점수: ${totalScr} / ${qntMaxScr}</div>
								<div>평가등록 : ${shtSvDt}</div>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<%@ include file="/WEB-INF/jsp/ggits/utils/paging.jsp"%>
	
</div>
<div id="typeSelectModal"></div>

<script type="text/javascript">
	
	function fnSearchList() {
		document.getElementById('searchForm').action = "${pageContext.request.contextPath}/evaluation/management/eval/list.do";
		document.getElementById('searchForm').submit();
	}
	
// 	function fnEvalSheetView(shtType, rtrShtId, bddCmpNm) {
// 		location.href="${pageContext.request.contextPath}/rater/evaluation/"+ shtType +"/save.do?rtrShtId="+rtrShtId+"&bddCmpNm="+bddCmpNm;
// 	}
	function fnEvalSheetView(shtInfoId, bddCmpNm, bddCmpId) {
// 		location.href="${pageContext.request.contextPath}/evaluation/management/admin/"+shtInfoId+"/save.do?bddCmpNm="+bddCmpNm;
		location.href="${pageContext.request.contextPath}/evaluation/management/admin/"+shtInfoId+"/save.do?bddCmpNm="+bddCmpNm+"&bddCmpId="+bddCmpId;
	}
	
	$("#cancelBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/evaluation/management/list.do"
	});
</script>