<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="sign-content">
	<input type="hidden" id="modalShtInfoId" name="modalShtInfoId" />
  	<div class="sign-head">
	  제안평가위원회 기업 추가하기 <img src="${pageContext.request.contextPath}/statics/images/close-white.png" class="modal-close">
	</div>
	<div class="sign-body">
		<form id="modalCmpyForm" onsubmit="return false;">
			<div class="company-list form">
				<label>평가 대상(평가 업체)</label>
				<input type="text" id="bddCmpNm" name="bddCmpNm" placeholder="평가 대상을 입력해주세요."/>
				<input type="hidden" id="modalShtInfoId" name="modalShtInfoId"/>
			</div>
			
			<div class="company-list form">
	 			<label>제안 요청서</label>
				<input class="upload-file-name file-one" value="제안 요청서" placeholder="제안 요청서" readonly="readonly">
			    <label for="requestForProposalFile" class="file-find file-one-btn mb0">추가</label> 
			    <input type="file" class="file-one-change uploadFile" id="requestForProposalFile" name="requestForProposalFile" data-value="requestForProposal" multiple accept=".pdf">
			    <div class="fileWrap test-table <c:if test="${fn:length(requestFileList) eq 0}">display-none</c:if>" id="requestForProposaFileWrap">
			    	<c:if test="${fn:length(requestFileList) ne 0}">
			    		<c:forEach var="requestFileList" items="${requestFileList}" varStatus="status">
							<div class="inner-file" id="file1">
								<div class="inner-file-name" id="rfpFile">${requestFileList.fileOgnNm}</div>
								<div class="inner-file-option">
									<div class="">
										<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFileList.fileId}','${requestFileList.fileOgnNm}')">미리보기</a>
									</div>
									<div class="close-height">
										<button type="button" onclick="removeFileBtn('${requestFileList.fileId}','${status.index+1}','requestForProposal')">
											<img src="/statics/images/inner-close.png" class="close">
										</button>
									</div>
								</div>
							</div>
			    		</c:forEach>
			    	</c:if>
				</div>
		 	</div>
		 	
		 	<div class="company-list form">
	 			<label>제안서</label>
				<input class="upload-file-name file-one" value="제안서" placeholder="제안서" readonly="readonly">
			    <label for="proposalFile" class="file-find file-one-btn mb0">추가</label> 
			    <input type="file" class="file-one-change uploadFile" id="proposalFile" name="proposalFile" data-value="proposal" multiple accept=".pdf">
			    <div class="fileWrap test-table <c:if test="${fn:length(requestFileList) eq 0}">display-none</c:if>" id="proposalFileWrap">
			    	<c:if test="${fn:length(requestFileList) ne 0}">
			    		<c:forEach var="requestFileList" items="${requestFileList}" varStatus="status">
							<div class="inner-file" id="file1">
								<div class="inner-file-name" id="rfpFile">${requestFileList.fileOgnNm}</div>
								<div class="inner-file-option">
									<div class="">
										<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFileList.fileId}','${requestFileList.fileOgnNm}')">미리보기</a>
									</div>
									<div class="close-height">
										<button type="button" onclick="removeFileBtn('${requestFileList.fileId}','${status.index+1}','requestForProposal')">
											<img src="/statics/images/inner-close.png" class="close">
										</button>
									</div>
								</div>
							</div>
			    		</c:forEach>
			    	</c:if>
				</div>
		 	</div>
		 	
		 	<div class="company-list form">
	 			<label>발표자료</label>
				<input class="upload-file-name file-one" value="발표자료" placeholder="발표자료" readonly="readonly">
			    <label for="presentationFile" class="file-find file-one-btn mb0">추가</label> 
			    <input type="file" class="file-one-change uploadFile" id="presentationFile" name="presentationFile" data-value="presentation" multiple accept=".pdf">
			    <div class="fileWrap test-table <c:if test="${fn:length(requestFileList) eq 0}">display-none</c:if>" id="presentationFileWrap">
			    	<c:if test="${fn:length(requestFileList) ne 0}">
			    		<c:forEach var="requestFileList" items="${requestFileList}" varStatus="status">
							<div class="inner-file" id="file1">
								<div class="inner-file-name" id="rfpFile">${requestFileList.fileOgnNm}</div>
								<div class="inner-file-option">
									<div class="">
										<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFileList.fileId}','${requestFileList.fileOgnNm}')">미리보기</a>
									</div>
									<div class="close-height">
										<button type="button" onclick="removeFileBtn('${requestFileList.fileId}','${status.index+1}','requestForProposal')">
											<img src="/statics/images/inner-close.png" class="close">
										</button>
									</div>
								</div>
							</div>
			    		</c:forEach>
			    	</c:if>
				</div>
		 	</div>
			
			<div class="modal-btn-wrap">
				<button class="mini-btn on-btn" onclick="fnModalSaveBtn();">확인</button>
			</div>
		</form>
	</div>
 </div>
<script>
//파일 관련
var requestForProposalFile = $("#requestForProposalFile");
$(".uploadFile").click(function() {
    const inputFile = requestForProposalFile[0].files;
    $(".uploadFile").off().on("change", function() {
    	const dataTransfer = new DataTransfer();
    	Array.from(inputFile).forEach(file => {
	        dataTranster.items.add(file);
	    });
    	requestForProposalFile.prop('files',dataTransfer.files);
    });
});
// $(".uploadFile").on('change',function(){
// 	var fileChk = $(this).data("value");
// 	var html = "";
// 	var files = this.files;
// 	var fileLength = 0;
// 	const dataTranster = new DataTransfer();

// 	Array.from(files)
// 	    .forEach(file => {
// 	        dataTranster.items.add(file);
// 	    });
	
// 	if(fileChk == 'requestForProposal'){
// 		fileLength = $("#requestForProposaFileWrap .inner-file").length;
// 		$('#requestForProposalFile').files = dataTranster.files;
// 	}else if(fileChk == 'proposal'){
// 		fileLength = $("#proposaFileWrap .inner-file").length;
// 		$('#requestForProposalFile').files = dataTranster.files;
// 	}else if(fileChk == 'presentation'){
// 		fileLength = $("#presentationFileWrap .inner-file").length;
// 		$('#presentationFile').files = dataTranster.files;
		
// 	}
	
// 	for(var i = 0; i < this.files.length; i++){
// 		html +=		'<div class="inner-file" id="file'+fileLength+'">'+
// 	    				'<div class="inner-file-name" id="rfpFile">'+this.files[i].name+'</div>'+
// 			    		'<div class="inner-file-option">'+
// 			    			'<div class="close-height">'+
// 			    				'<button type="button" onclick="removeFileBtn(\'\',\''+fileLength+'\',\''+fileChk+'\')">'+
// 			    					'<img src="${pageContext.request.contextPath}/statics/images/inner-close.png" class="close">'+
// 	    						'</button>'+
// 			    			'</div>'+
// 			    		'</div>'+
// 		    		'</div>';
// 	}
	
// 	if(fileChk == 'requestForProposal'){
// 		$("#requestForProposaFileWrap").append(html);
// 		$("#requestForProposaFileWrap").removeClass("display-none");
// 	}else if(fileChk == 'proposal'){
// 		$("#proposalFileWrap").append(html);
// 		$("#proposalFileWrap").removeClass("display-none");
// 	}else if(fileChk == 'presentation'){
// 		$("#presentationFileWrap").append(html);
// 		$("#presentationFileWrap").removeClass("display-none");
// 	}
// });

//첨부 파일 삭제 버튼
function removeFileBtn(fileId,idx,removeFileType){
	
	var fileRemoveChk = false;
	if(fileId != ""){
		if(confirm("저장된 파일이 삭제됩니다. 삭제하시겠습니까?")){
			$.ajax({
	   			type : "get",
	   			url : "${pageContext.request.contextPath}/common/file/"+fileId+"/delete.ajax",
	   			success : function(result) {
	   				let resultCode = result.code;
					if(resultCode == 200) {
						window.location.reload();
					} 
	   			}
	   		});
		}	
	}else{
		fileRemoveChk = true;
	}
	
	if(fileRemoveChk){
		var removeFile = "";
		if(removeFileType == 'requestForProposal'){
			removeFile = $("#requestForProposaFileWrap .inner-file");
			if(removeFile.length == 1){
				$("#requestForProposaFileWrap").addClass("display-none");			
			}
			
		}			
		if(removeFileType == 'proposal'){
			removeFile = $("#proposalFileWrap .inner-file")
			if(removeFile.length == 1){
				$("#proposalFileWrap").addClass("display-none");			
			}
		}
		if(removeFileType == 'presentation'){
			removeFile = $("#presentationFileWrap .inner-file")
			if(removeFile.length == 1){
				$("#presentationFileWrap").addClass("display-none");			
			}
		}
		removeFile.eq(idx).remove();
	}
}

function fnModalSaveBtn(){
	var modalShtInfoId = $("#modalShtInfoId").val();
	var formData = new FormData($('#modalCmpyForm')[0]);
// 	if($("#modalCmpyForm").soValid()){
// 		$.ajax({
//    			type : "post",
//    			enctype: 'multipart/form-data',
//    			data : formData,
//    			contentType : false,
//    	        processData : false, 
//    			url : "${pageContext.request.contextPath}/evaluation/management/cmp/"+modalShtInfoId+"/save.ajax",
//    			success : function(result) {
//    				let resultCode = result.code;
// 				let resultMessage = result.message;
// 				if(resultCode == 200) {
// 					let shtInfoId = result.data.shtInfoId;
// 					alert(resultMessage);
// 	  				window.location.reload();
// 				} else {
// 					alert(resultMessage);
// 				}
//    			}
//    		});
// 	} // if
	
	
}
</script>