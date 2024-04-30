<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="sign-content">
	<input type="hidden" id="modalShtInfoId" name="modalShtInfoId" />
  	<div class="sign-head">
	  제안평가위원 목록 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="modal-close">
	</div>
	<div class="sign-body pd32">
		<form id="modalSearchForm" method="get" onsubmit="return false;">
			<input type="hidden" id="pageLocation" name="pageLocation" value="raterList" />
			<input type="hidden" id="modalPageNo" name="modalPageNo" value="1" />
			<div class="search-plus form wd100">
				<label>제안평가위원을 선택하세요. (최대 10명)</label>
				<input type="text" id="modalRaterNm" name="modalRaterNm" placeholder="평가자를 검색해주세요."
					class="border-input" value="${schRtrNm}" onkeyup="fnRaterListEnterKey('','search', 'list')"/>
				<button type="button" id="addTargetBtn" class="plus-btn mini-btn on-btn" onclick="fnRaterList('','search', 'list')">검색</button>
			</div>
		</form>
		
		<div class="tester-list">
			<div class="search-plus form wd100">
				<label>제안평가위원 리스트</label>
			</div>
			 <table>
	              <colgroup>
	                 
	              </colgroup>
	              <tr>
	                <th scope="col">체크</th>
	                <th scope="col">이름</th>
	                <th scope="col">년도</th>
	                <th scope="col">소속</th>
	                <th scope="col">전화번호</th>
	              </tr>
	              <c:choose>
					<c:when test="${fn:length(rtrIdList) eq 0}">
	              		<c:forEach var="evalRtrList" items="${evalRtrList}">
		              <tr>
		                <td>
		                	<input type="checkbox" name="rtrIdChk" value="${evalRtrList.rtrId}" data-rtrNm="${evalRtrList.rtrNm}" 
<%-- 		                		<c:if test="${evalRtrList.rtrExist eq 'TRUE' or fn:contains(rtrIdList, evalRtrList.rtrId)}">checked="checked"</c:if> --%>
		                		<c:if test="${evalRtrList.rtrExist eq 'TRUE'}">checked="checked"</c:if>
		                		 data-chk-id="${evalRtrList.rtrId}" 
		                		 >
		                </td>
		                <td>${evalRtrList.rtrNm}</td>
		                <td>${evalRtrList.rtrBrthDt}</td>
		                <td>${evalRtrList.rtrAgncy}</td>
		                <td>${evalRtrList.rtrTel}</td>
		              </tr>
	              		</c:forEach>
	              	</c:when>
	              	<c:otherwise>
	              	<c:forEach var="evalRtrList" items="${evalRtrList}">
		              <tr>
		                <td>
		                	<input type="checkbox" name="rtrIdChk" value="${evalRtrList.rtrId}" data-rtrNm="${evalRtrList.rtrNm}" 
		                		<c:if test="${fn:contains(rtrIdList, evalRtrList.rtrId)}">checked="checked"</c:if>
		                		 data-chk-id="${evalRtrList.rtrId}" 
		                		 >
		                </td>
		                <td>${evalRtrList.rtrNm}</td>
		                <td>${evalRtrList.rtrBrthDt}</td>
		                <td>${evalRtrList.rtrAgncy}</td>
		                <td>${evalRtrList.rtrTel}</td>
		              </tr>
	              		</c:forEach>
	              	</c:otherwise>
	              </c:choose>
	        </table>
	        <%@ include file="/WEB-INF/jsp/ggits/utils/modalPaging.jsp"%>
		</div>
		<div class="tester-check-wrap" id="selectRtrInfo">
			<c:choose>
				<c:when test="${fn:length(rtrIdList) eq 0}">
					<c:forEach var="modalCheckedList" items="${modalCheckedList}">
<%-- 						<c:if test="${modalCheckedList.rtrExist eq 'TRUE'  or fn:contains(rtrIdList, modalCheckedList.rtrId)}"> --%>
						<c:if test="${modalCheckedList.rtrExist eq 'TRUE'}">
							<c:if test="${not fn:contains(rtrIdList, modalCheckedList.rtrId)}">
								<script>rtrIdList.push("${modalCheckedList.rtrId}");</script>
							</c:if>
							<div class="tester-check" data-rtrid="${modalCheckedList.rtrId}">
								<span>${modalCheckedList.rtrNm}</span>
								<img src="${pageContext.request.contextPath}/statics/images/inner-close.png" 
								class="close" onclick="fnRemoveName('${modalCheckedList.rtrId}')">
							</div>
						</c:if>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach var="modalCheckedList" items="${modalCheckedList}">
						<c:if test="${fn:contains(rtrIdList, modalCheckedList.rtrId)}">
							<c:if test="${not fn:contains(rtrIdList, modalCheckedList.rtrId)}">
								<script>rtrIdList.push("${modalCheckedList.rtrId}");</script>
							</c:if>
							<div class="tester-check" data-rtrid="${modalCheckedList.rtrId}">
								<span>${modalCheckedList.rtrNm}</span>
								<img src="${pageContext.request.contextPath}/statics/images/inner-close.png" 
								class="close" onclick="fnRemoveName('${modalCheckedList.rtrId}')">
							</div>
						</c:if>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="check-btn">
			<button class="mini-btn on-btn" onclick="fnSaveRtrInfo();">확인</button>
		</div>
	</div>
	
 </div>
<script>
$('.modal-close').click(function(){
	rtrIdList = [];
   $('.tester-list-wrap').hide();
});

$("input[name='rtrIdChk']").on("click",function(){
	//var rtrChecked = $("input[name='rtrIdChk']:checked");
	var testerCheckList = $('.tester-check');
	if(testerCheckList.length > 9){
		alert("최대 10명까지 선택가능합니다.");
		$(this).prop("checked", false);
		return
	}
	var checkedVal =$(this).is(":checked");
	var rtrNm = $(this).data("rtrnm");
	var rtrId = $(this).val();
	
	if(checkedVal){
		var html = 	'<div class="tester-check modalRtrNm" data-rtrid="'+rtrId+'">'+
						'<span>'+rtrNm+'</span><img src="${pageContext.request.contextPath}/statics/images/inner-close.png" class="close" onclick="fnRemoveName(\''+rtrId+'\')">'+
					'</div>';
		
		$("#selectRtrInfo").append(html);
		rtrIdList.push(rtrId);
	}else{
		rtrIdList = rtrIdList.filter((x) => x != rtrId);
		$("div[data-rtrid='"+rtrId+"']").remove();
	}
})

function fnRemoveName(rtrId){
	$("input[data-chk-id='"+rtrId+"']").attr("checked",false);
	rtrIdList = rtrIdList.filter((x) => x != rtrId);
	$("div[data-rtrid='"+rtrId+"']").remove();
}
</script>