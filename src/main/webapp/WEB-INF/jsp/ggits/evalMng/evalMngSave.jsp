<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
// 	rfpFileCount = 0;
// 	attachmentFileCount = 0;
</script>
<div class="content">
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>평가정보 입력</h1>
	</div>
	 <div class="progressbar-wrapper">
	      <ul class="progressbar">
	          <li class="active">
	          	<p>평가정보 입력</p>
	          </li>
	          <li>
	          	<p>평가대상 등록</p>
	          </li>
	          <li>
	          	<p>평가유형 선택</p>
	          </li>
	          <li>
	          	<p>평가지 작성</p>
	          </li>
	           <li>
	          	<p>평가지 상세정보</p>
	          </li>
	           <li>
	          	<p>평가결과 확인</p>
	          </li>
	      </ul>
	</div>
	
	 
	 <div class="input-wrap">
	 	<form id="evalInfoForm" class="flex gap24 flex-wrap">
	 		<input type="hidden" name="shtInfoId" value="${shtInfoId}">
	 		
	 		<div class="form form-two">
	 			<label>평가지명</label>
				<input type="text" id="shtNm" name="shtNm" maxlength="100" value="${evalShtInfo.shtNm}"
					class="data-validate border-input" data-valid-required required data-valid-name="평가지명">
		 	</div>
		 	<div class="form form-two">
	 			<label>제안공고 URL</label>
				<input type="text" id="infoUrl" name="infoUrl" maxlength="100" value="${evalShtInfo.infoUrl}" class="border-input">
<!-- 					class="data-validate" data-valid-required data-valid-name="제안공고 URL"> -->
		 	</div>
		 	<div class="form">
	 			<label>제안 요청서</label>
				<input class="upload-file-name file-one" value="제안 요청서" placeholder="제안 요청서">
			    <label for="requestForProposalFile" class="file-find file-one-btn mb0 fileUploadBtn">추가</label> 
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
		 	<div class="form">
		 		<label>제안서</label>
			 	<input class="upload-file-name file-all" value="제안서" placeholder="제안서">
			    <label for="attachmentFile" class="file-find file-all-btn fileUploadBtn">추가</label> 
			    <input type="file" class="file-all-change uploadFile" id="attachmentFile" name="attachmentFile" data-value="attachment" multiple accept=".pdf">
				<div class="fileWrap test-table <c:if test="${fn:length(attachmentFileList) eq 0}">display-none</c:if>" id="attachmentFileFileWrap">
					<c:if test="${fn:length(attachmentFileList) ne 0}">
			    		<c:forEach var="attachmentFileList" items="${attachmentFileList}" varStatus="status">
							<div class="inner-file" id="file1">
								<div class="inner-file-name">${attachmentFileList.fileOgnNm}</div>
								<div class="inner-file-option">
									<div class="">
										<a href="javascript:void(0)" onClick="showPdfViewerModal('${attachmentFileList.fileId}','${attachmentFileList.fileOgnNm}')">미리보기</a>
									</div>
									<div class="close-height">
										<button type="button" onclick="removeFileBtn('${attachmentFileList.fileId}','${status.index}','attachment')">
											<img src="/statics/images/inner-close.png" class="close">
										</button>
									</div>
								</div>
							</div>
			    		</c:forEach>
			    	</c:if>
				</div>
		 	</div>
		 	<div class="form">
		 		<label>발표자료</label>
			 	<input class="upload-file-name file-all" value="발표자료" placeholder="발표자료">
			    <label for="presentationFile" class="file-find file-all-btn fileUploadBtn">추가</label> 
			    <input type="file" class="file-all-change uploadFile" id="presentationFile" name="presentationFile" data-value="presentation" multiple accept=".pdf">
				<div class="fileWrap test-table <c:if test="${fn:length(presentationFileList) eq 0}">display-none</c:if>" id="presentationFileWrap">
					<c:if test="${fn:length(presentationFileList) ne 0}">
			    		<c:forEach var="presentationFileList" items="${presentationFileList}" varStatus="status">
							<div class="inner-file" id="file1">
								<div class="inner-file-name">${presentationFileList.fileOgnNm}</div>
								<div class="inner-file-option">
									<div class="">
										<a href="javascript:void(0)" onClick="showPdfViewerModal('${presentationFileList.fileId}','${presentationFileList.fileOgnNm}')">미리보기</a>
									</div>
									<div class="close-height">
										<button type="button" onclick="removeFileBtn('${presentationFileList.fileId}','${status.index}','attachment')">
											<img src="/statics/images/inner-close.png" class="close">
										</button>
									</div>
								</div>
							</div>
			    		</c:forEach>
			    	</c:if>
				</div>
		 	</div>
		</form>
	 </div>
	
		<div class="footer-wrap">
			<button type="button" id="cancelBtn" class="mini-btn mini-sub-btn prev">이전</button>
			<div class="footer-left-btn">
				<c:choose>
					<c:when test="${shtInfoId ne null and shtInfoId ne '' and evalShtInfo.shtAllStts eq 'ESC001' }">
						<button type="button" class="mini-sub-btn mini-btn" onclick="fnEvalInfoSave('tmpUpdate')">임시 저장</button>
						<button type="button" class="on-btn mini-btn" onclick="fnEvalInfoSave('update')">다음</button>
					</c:when>
					<c:when test="${shtInfoId ne null and shtInfoId ne '' and evalShtInfo.shtAllStts ne 'ESC001' }">
						<button type="button" class="on-btn mini-btn" onclick="fnEvalInfoSave('update')">다음</button>
					</c:when>
					<c:otherwise>
						<button type="button" class="mini-sub-btn mini-btn" onclick="fnEvalInfoSave('tmp')">임시 저장</button>
						<button type="button" class="on-btn mini-btn" onclick="fnEvalInfoSave('save')">다음</button>
					</c:otherwise>
				</c:choose>
			</div>
			
		</div>
</div>
<div id="pdfViewerModal"></div>
<script>
	//파일 관련
	
	var requestForProposalFile = $("#requestForProposalFile");
	var attachmentFile = $("#attachmentFile");
	var presentationFile = $("#presentationFile");
	
	$(".fileUploadBtn").on("click",function(){
        const requestForProposalFiles = requestForProposalFile[0].files;
        const attachmentFiles = attachmentFile[0].files;
        const presentationFiles = presentationFile[0].files;
        
        $(".uploadFile").off().on("change", function() {
        	var fileChk = $(this).data("value");
    		var files = this.files;
    		var fileLength = 0;
    		var fileTextTag = "";
   			if(fileChk == 'requestForProposal'){
	   			fileLength = $("#requestForProposaFileWrap .inner-file").length;
	   			fileTextTag = $("#requestForProposaFileWrap");
	   			fnAddFile(requestForProposalFiles,requestForProposalFile,files,fileLength,fileChk,fileTextTag)
   			}else if(fileChk == 'attachment'){
	   			fileLength = $("#attachmentFileFileWrap .inner-file").length;
	   			fileTextTag = $("#attachmentFileFileWrap");
	   			fnAddFile(attachmentFiles,attachmentFile,files,fileLength,fileChk,fileTextTag)
   			}else if(fileChk == 'presentation'){
	   			fileLength = $("#presentationFileWrap .inner-file").length;
	   			fileTextTag = $("#presentationFileWrap");
	   			fnAddFile(presentationFiles,presentationFile,files,fileLength,fileChk,fileTextTag)
   			}
        });
    });
	function fnAddFile(inputFiles,fileTag,addFiles,fileLength,fileChk,fileTextTag){
		var html = "";
		for(var i = 0; i < addFiles.length; i++){
			var fileNm = addFiles[i].name;
			var dupleChk = Array.from(fileTextTag.find(".inner-file-name")).filter(x => x.outerText == fileNm).length;
			if(dupleChk > 0 ){
				alert("중복된 파일명이 존재합니다. 파일을 확인해주세요.")
				return false;
			}
			html +=		'<div class="inner-file" id="file'+fileLength+'">'+
		    				'<div class="inner-file-name" id="rfpFile">'+fileNm+'</div>'+
				    		'<div class="inner-file-option">'+
				    			'<div class="close-height">'+
				    				'<button type="button" onclick="removeFileBtn(\'\',\''+fileLength+'\',\''+fileChk+'\')">'+
				    					'<img src="${pageContext.request.contextPath}/statics/images/inner-close.png" class="close">'+
		    						'</button>'+
				    			'</div>'+
				    		'</div>'+
			    		'</div>';
		}
		
		if(fileChk == 'requestForProposal'){
			$("#requestForProposaFileWrap").append(html);
			$("#requestForProposaFileWrap").removeClass("display-none");
		}else if(fileChk == 'attachment'){
			$("#attachmentFileFileWrap").append(html);
			$("#attachmentFileFileWrap").removeClass("display-none");
		}else if(fileChk == 'presentation'){
			$("#presentationFileWrap").append(html);
			$("#presentationFileWrap").removeClass("display-none");
		}
		
		if(inputFiles.length > 0){
			fileChangeAddEvent(inputFiles,fileTag,addFiles)
        } else{
        	fileTag.prop('files',addFiles);
        }
	}
	
	function fileChangeAddEvent(inputFileArr,fileTag,addFileArr){
        const dataTransfer = new DataTransfer();
        Array.from(inputFileArr).forEach(file => {
            dataTransfer.items.add(file);
        });
        Array.from(addFileArr).forEach(file => {
            dataTransfer.items.add(file);
        });
        fileTag.prop('files',dataTransfer.files);
    }
	
	// 첨부 파일 삭제 버튼
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
			var removeFileInfo = "";
			var removeFileTag;
			var dataTransfer = new DataTransfer();
			
			if(removeFileType == 'requestForProposal'){
				removeFileInfo = $("#requestForProposaFileWrap .inner-file");
				removeFileTag = requestForProposalFile;
				if(removeFileInfo.length == 0){
					$("#requestForProposaFileWrap").addClass("display-none");			
				}
				
			}			
			if(removeFileType == 'attachment'){
				removeFileInfo = $("#attachmentFileFileWrap .inner-file")
				removeFileTag = attachmentFile;
				if(removeFileInfo.length == 0){
					$("#attachmentFileFileWrap").addClass("display-none");			
				}
			}	
			if(removeFileType == 'presentation'){
				removeFileInfo = $("#presentationFileWrap .inner-file")
				removeFileTag = presentationFile;
				if(removeFileInfo.length == 0){
					$("#presentationFileWrap").addClass("display-none");			
				}
			}
			var removeFiles = removeFileTag[0].files;
			var fileNm = removeFileInfo.eq(idx).find(".inner-file-name").text();
			Array.from(removeFiles).filter(file => file.name != fileNm).forEach(file => {
               dataTransfer.items.add(file);
           	});
			removeFileTag.prop('files',dataTransfer.files);
			removeFileInfo.eq(idx).remove();
		}
	}
	
	function fnEvalInfoSave(type){
		//TODO :: 파일 전역변수 배열로 관리 필요 
		var formData = new FormData($('#evalInfoForm')[0]);
		
		var url = "${pageContext.request.contextPath}/evaluation/management/save.ajax";
		if(type == "update" || type == "tmpUpdate") {
			url = "${pageContext.request.contextPath}/evaluation/management/update.ajax";
		}
		
		if(type == 'tmp' || type == "tmpUpdate") {
			if($("#evalInfoForm").soValid()){
				$.ajax({
		   			type : "post",
		   			enctype: 'multipart/form-data',
		   			data : formData,
		   			contentType : false,
		   	        processData : false, 
		   			url : url,
		   			success : function(result) {
		   				let resultCode = result.code;
						let resultMessage = result.message;
						if(resultCode == 200) {
							alert(resultMessage);
			  				window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
						} else {
							alert(resultMessage);
						}
		   			}
		   		});
			}
		} else {
			if($("#evalInfoForm").soValid()){
// 				if(rfpFileCount < 1) {
// 					alert('제안 요청서를 업로드 해주세요');
// 					return false;
// 				}
// 				if(attachmentFileCount < 1) {
// 					alert('첨부파일을 업로드 해주세요');
// 					return false;
// 				}
				$.ajax({
		   			type : "post",
		   			enctype: 'multipart/form-data',
		   			data : formData,
		   			contentType : false,
		   	        processData : false, 
		   			url : url,
		   			success : function(result) {
		   				let resultCode = result.code;
						let resultMessage = result.message;
						if(resultCode == 200) {
							let shtInfoId = result.data.shtInfoId;
							alert(resultMessage);
			  				window.location.href="${pageContext.request.contextPath}/evaluation/management/cmp/"+shtInfoId+"/save.do";
						} else {
							alert(resultMessage);
						}
		   			}
		   		});
			} // if
		} // else
		
	}
	
	$("#cancelBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/evaluation/management/list.do"
	});
</script>