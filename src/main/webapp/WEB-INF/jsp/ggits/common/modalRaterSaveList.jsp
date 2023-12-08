<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="sign-content">
	<input type="hidden" id="modalShtInfoId" name="modalShtInfoId" />
  	<div class="sign-head">
	  평가자 목록 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="modal-close">
	</div>
	<div class="sign-body pd32">
		<form id="modalSearchForm" method="get" onsubmit="return false;">
			<input type="hidden" id="pageLocation" name="pageLocation" value="raterList" />
			<input type="hidden" id="modalPageNo" name="modalPageNo" value="1" />
			<div class="search-plus form wd100">
				<label>평가자를 검색하세요.</label>
				<input type="text" id="modalRaterNm" name="modalRaterNm" placeholder="평가자를 검색해주세요."
					class="border-input" value="${schRtrNm}" onkeyup="fnRaterListEnterKey('','search')"/>
				<button type="button" id="addTargetBtn" class="plus-btn mini-btn on-btn" onclick="fnRaterList('','search')">검색</button>
			</div>
		</form>
		
		<div class="tester-list">
			<div class="search-plus form wd100">
				<label>평가자 리스트</label>
			</div>
			 <table>
	              <colgroup>
	                 
	              </colgroup>
	              <tr>
	                <th scope="col">이름</th>
	                <th scope="col">년도</th>
	                <th scope="col">소속</th>
	                <th scope="col">전화번호</th>
	              </tr>
	              	<c:forEach var="evalRtrList" items="${evalRtrList}">
		              <tr onclick="fnRtrInfo('${evalRtrList.rtrNm}','${evalRtrList.rtrBrthDt}','${evalRtrList.rtrAgncy}','${evalRtrList.rtrTel}','${evalRtrList.rtrId}')">
		                <td>${evalRtrList.rtrNm}</td>
		                <td>${evalRtrList.rtrBrthDt}</td>
		                <td>${evalRtrList.rtrAgncy}</td>
		                <td>${evalRtrList.rtrTel}</td>
		              </tr>
              		</c:forEach>
	        </table>
	        <%@ include file="/WEB-INF/jsp/ggits/utils/modalPaging.jsp"%>
			
		</div>
		<form id="raterSaveForm" name="raterSaveForm">
			<div class="tester-plus-wrap">
				<div class="search-plus form wd100">
					<label>평가자 리스트</label>
				</div>
				<div class="tester-plus-list-wrap">
					<div>
						<input type="hidden" id="rtrId" name="rtrId" class="border-input"/>
						<label>이름</label>
						<input type="text" id="rtrNm" name="rtrNm" placeholder="작성자명" class="border-input" maxlength="20"/>
					</div>
					<div>
						<label>생년월일</label>
						<input type="text" id="rtrBrthDt" name="rtrBrthDt" placeholder="생년월일" class="border-input vaild-birthday" maxlength="10"/>
					</div>
					<div>
						<label>소속</label>
						<input type="text" id="rtrAgncy" name="rtrAgncy" placeholder="소속" class="border-input" maxlength="50"/>
					</div>
					<div>
						<label>전화번호</label>
						<input type="text" id="rtrTel" name="rtrTel" placeholder="전화번호" class="border-input vaild-tel" maxlength="13"/>
					</div>
					<div class="tester-btn-wrap">
						<button type="button" class="mini-sub-btn mini-btn" id="saveRaterBtn">신규 등록</button>
						<button type="button" class="plus-btn mini-btn on-btn" id="rtrInfoBtn" data-type="save">추가</button>
					</div>
				</div>
			</div>
		</form>	
		
		<div class="check-btn">
		<button class="mini-btn on-btn" onclick="fnConfirmBtn();">확인</button>
	</div>		
	</div>
	
 </div>
<script>
function fnRtrInfo(rtrNm,rtrBrthDt,rtrAgncy,rtrTel,rtrId){
	$("#rtrId").val(rtrId);
	$("#rtrNm").val(rtrNm);
	$("#rtrBrthDt").val(rtrBrthDt);
	$("#rtrAgncy").val(rtrAgncy);
	$("#rtrTel").val(rtrTel);
	$("#rtrInfoBtn").text("수정");
	$("#rtrInfoDeleteBtn").removeClass("display-none");
	$("#rtrInfoBtn").attr("data-type","update");
}

$("#saveRaterBtn").on("click",function(){
	$("#rtrId").val('');
	$("#rtrNm").val('');
	$("#rtrBrthDt").val('');
	$("#rtrAgncy").val('');
	$("#rtrTel").val('');
	$("#rtrInfoBtn").text("추가");
	$("#rtrInfoDeleteBtn").addClass("display-none");
	$("#rtrInfoBtn").attr("data-type","save");	
})
$('.modal-close').click(function(){
	rtrIdList = [];
   $('.tester-list-wrap').hide();
});

$("#rtrInfoBtn").on("click",function(){
	var type = $(this).attr("data-type");
	var urlInfo = "${pageContext.request.contextPath}/evaluation/management/rater/save.ajax";
	var typeInfo = "post";
	if(type == "update"){
		var rtrId = $("#rtrId").val();
		if(rtrId == null || rtrId == ''){
			alert("작성자 정보를 확인해주세요.");
			return;
		}
		//TODO::벨리데이션 추가 작업
		
		typeInfo = "get";
		urlInfo = "${pageContext.request.contextPath}/evaluation/management/rater/"+rtrId+"/update.ajax";
	}
	
	$.ajax({
		type : typeInfo,
		url : urlInfo,
		data : $("#raterSaveForm").serialize(), 
		success : function(result) {
			var resultCode = result.code; 
			var resultMsg = result.message;
			if(resultCode == '200'){
				alert(resultMsg)
				window.location.reload();
			}else{
				alert(resultMsg)
			}
		}
	})
	
	
})
$("#rtrInfoDeleteBtn").on("click",function(){
	var rtrId = $("#rtrId").val();
	if(rtrId == null || rtrId == ''){
		alert("작성자 정보를 확인해주세요.");
		return;
	}
	if(confirm("작성자를 삭제하시겠습니까?")){
		$.ajax({
   			type : "get",
   			url : "${pageContext.request.contextPath}/evaluation/rater/{rtrId}/delete.ajax",
   			success : function(result) {
   				
   			}
		})
	}
})
function fnConfirmBtn(){
	$('.tester-list-wrap').hide();
}
</script>