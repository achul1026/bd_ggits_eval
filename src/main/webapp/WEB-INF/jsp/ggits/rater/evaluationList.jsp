<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="wrap">
<div class="content">
	<div class="login_wrap">
		<a href="${pageContext.request.contextPath}/rater/announcement/detail.do" class="back-btn">
			<img src="${pageContext.request.contextPath}/statics/images/back.png">
		</a>
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
	     <img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
			<h1>${rtrInfoSession.rtrNm} 평가자님의 정성적평가 참여 기업입니다.</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>제안평가<br>위원회 인증</p>
	          </li>
	          <li class="progress-complete">
	          	<p>제안평가<br>정보 확인</p>
	          </li>
	          <li class="active">
	          	<p>제안평가 목록</p>
	          </li>
	          <li>
	          	<p>제안평가위원회<br>점수 확인</p>
	          </li>
	      </ul>
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
		</form>
	</div>
		
	<div class="list-wrap border-none">
	  	<c:forEach var="evalBddCmp" items="${evalBddCmpList}" varStatus="loop">
			<div class="list" 
				<c:if test="${evalBddCmp.evalRtrSht[0].shtStts eq 'ERSSC004' || shtAllStts eq 'ESC007'}">
					onclick="fnEvalSheetView('qlt', '${evalBddCmp.evalRtrSht[0].rtrShtId}', '${evalBddCmp.bddCmpNm}')"
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
							<h2>[${shtInfoSession.shtNm }] (${evalBddCmp.bddCmpNm })</h2>
						</div>
						<div class="list-join-code">
							<c:if test="${evalBddCmp.evalRtrSht[0].shtSvDt ne null}">
								<fmt:formatDate var="shtSvDt" pattern="yyyy년 MM월 dd일" value="${evalBddCmp.evalRtrSht[0].shtSvDt}" />
								
								<fmt:formatNumber var="totalScr" value="${evalBddCmp.evalRtrSht[0].totalScr}" pattern=".0"/>
								<fmt:parseNumber var="intScr" value="${totalScr}" integerOnly="true"/>
								<c:if test="${totalScr - intScr eq 0}">
									<c:set var="totalScr" value="${intScr}"/>
								</c:if>
								
								<div class="complete-score">평가점수: ${totalScr} / ${qltMaxScr}</div>
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
</div>
<script type="text/javascript">

	// 평가지 선택 모달 -> 페이지 삭제로 주석
// 	function showTypeSelectModal(bddCmpId, bddCmpNm){
// 		$.ajax({
// 			type : "get",
// 			url : "${pageContext.request.contextPath}/common/modal/"+bddCmpId+"/list.do?bddCmpNm=" + bddCmpNm,
// 			dataType: "html",
// 			success : function(html) {
// 				$('#typeSelectModal').append(html);
// 				$('.sign-wrap').show();
// 			}
// 		});
// 	}
	
	function fnSearchList() {
		document.getElementById('searchForm').action = "${pageContext.request.contextPath}/rater/evaluation/list.do";
		document.getElementById('searchForm').submit();
	}
	
	function fnEvalSheetView(shtType, rtrShtId, bddCmpNm) {
		location.href="${pageContext.request.contextPath}/rater/evaluation/"+ shtType +"/save.do?rtrShtId="+rtrShtId+"&bddCmpNm="+bddCmpNm;
	}
</script>