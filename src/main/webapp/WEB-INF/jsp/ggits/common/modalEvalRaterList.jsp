<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="sign-content">
	<div class="sign-head">
		평가자 목록 
		<img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="modal-close">
	</div>
	<div class="sign-body pd32">
		<div class=""></div>
		<div class="tester-list mj0">
			<div class="test-info mj0">
				<dl class=" ">
					<dt>- 평가인원 :</dt>
					<dd>${fn:length(evalRtrList)}명</dd>
				</dl>
			</div>
			<table class="test-list-table">
				<colgroup>

				</colgroup>
				<tr>
					<th scope="col">
						<select class="wdat pt0 pb0" id="modalEvalCmplt" onchange="fnChangeEvalRtrStts('${shtInfoId}');">
							<option value="all" ${evalCmplt eq 'all' ? 'selected="selected"' : '' }>상태</option>
							<option value="Y" ${evalCmplt eq 'Y' ? 'selected="selected"' : '' }>완료</option>
							<option value="N" ${evalCmplt eq 'N' ? 'selected="selected"' : '' }>진행중</option>
						</select>
					</th>
					<th scope="col">이름</th>
					<th scope="col">생년월일</th>
					<th scope="col">소속</th>
					<th scope="col">연락처</th>
				</tr>
				<c:forEach var="evalRtrList" items="${evalRtrList}">
					<tr>
						<td class="${evalRtrList.evalCmplt eq 'Y' ? 'complete' : 'writing' }">${evalRtrList.evalCmplt eq 'Y' ? '완료' : '진행중' }</td>
						<td>${evalRtrList.rtrNm}</td>
						<td>${evalRtrList.rtrBrthDt}</td>
						<td>${evalRtrList.rtrAgncy}</td>
						<td>${evalRtrList.rtrTel}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</div>
<script>

	$('.modal-close').click(function(){
		clearInterval(raterListTimer);
		$('.tester-list-wrap').hide();
		$('.sign-content').remove();
		location.reload();
	});
	function fnChangeEvalRtrStts(shtInfoId){
		fnEvalRaterList(shtInfoId);
	}
	
	$(fnRefreshRaterList('${shtInfoId}'));
</script>