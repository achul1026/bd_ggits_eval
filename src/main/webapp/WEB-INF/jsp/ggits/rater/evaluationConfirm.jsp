<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 평가 점수 확인 화면 -->
<div class="wrap">
<div class="content score-content">
	<div class="login_wrap">
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>경기도청 교통시스템 기술능력 평가</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>제안평가<br> 정보 입력</p>
	          </li>
	          <li class="progress-complete">
	          	<p>평가지 정보 확인</p>
	          </li>
	          <li class="progress-complete">
	          	<p>제안평가<br> 목록</p>
	          </li>
	          <li class="progress-complete">
	          	<p>제안평가<br> 화면</p>
	          </li>
	          <li class="active">
	          	<p>제안평가<br> 점수 확인</p>
	          </li>
	      </ul>
	</div>
	
	<div class="test-info ">
		<dl>
			<dt>- 제안평가위원회 대상 (제안평가위원회 업체) : </dt>
			<dd>${bddCmpNbr}번</dd>
		</dl>
	</div>

	<div class="score-wrap">
		<div class="last-score">
			<dl>
				<dt>최종점수</dt>
				<dd><span>${evalRaterScrDTOSession.totalScr }점</span> / ${evalRaterScrDTOSession.totalMaxScr }점</dd>
			</dl>
		</div>
		
		<div class="sub-score">
			<div class="score-head">
				<h3>제안평가위원회 부문별</h3>
			</div>
			
			<div class="score-body">
				<c:forEach var="confirmScrInfoList" items="${evalRaterScrDTOSession.confirmScrInfoList}">
				<dl>
					<dt id="fldSctr">${confirmScrInfoList.fldSctr}</dt>
					<dd><span>${confirmScrInfoList.scr}점</span> / ${confirmScrInfoList.maxScr }점</dd>
				</dl>
				</c:forEach>
			</div>
		</div>
	</div>


	<div class="btn-wrap pd0 score-btn-wrap tablet-btn-wrap">
		<c:choose>
			<c:when test="${isEvalComplete eq true }">
				<a href="${pageContext.request.contextPath}/rater/evaluation/list.do" class="mini-btn mini-sub-btn prev one-btn">이전</a>		
			</c:when>
			<c:otherwise>
				<a href="javascript:history.back();" class="mini-btn mini-sub-btn prev">이전</a>
				<button type="button" id="rateSaveBtn" class="on-btn mini-btn">제출</button>
			</c:otherwise>
		</c:choose>
	</div>
</div>
</div>
<script type="text/javascript">

	// 내용에 따라, textarea height 수정
	$(".score-body").find("textarea").each(function(idx, item){
		item.style.height = "1px";
		item.style.height = (12+item.scrollHeight)+"px";
	})
	
	$("#rateSaveBtn").on("click", function(){
		$.ajax({
			type : "post",
			url : "${pageContext.request.contextPath}/rater/evaluation/save.ajax?saveType=${saveType}",
			success : function(result) {
				let resultCode = result.code;
				let resultMessage = result.message;
				if (resultCode == '200') {
					alert(resultMessage);
					window.location.href="${pageContext.request.contextPath}/rater/evaluation/list.do";
				} else {
					alert(resultMessage);
				}
			}
		});
	});
	
</script>