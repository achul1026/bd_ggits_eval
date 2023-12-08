 <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="content">
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png"
			class="logo">
		<h1>평가지 상세정보</h1>
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
	           <li class="active">
	          	<p>평가지 상세정보</p>
	          </li>
	           <li>
	          	<p>평가결과 확인</p>
	          </li>
	      </ul>
    </div>

	<div class="info-table">
			<div class="test-info form wdat">
				<dl>
					<dt>
					- 
					<c:choose>
						<c:when test="${shtAllStts eq 'ESC000' }">
							평가 완료	
						</c:when>
						<c:when test="${shtAllStts eq 'ESC005'}">
							평가 대기
						</c:when>
						<c:when test="${shtAllStts eq 'ESC006'}">
							평가 중
						</c:when>
						<c:otherwise>
							평가지 작성 중
						</c:otherwise>
					</c:choose>
					 :
					</dt>
					<dd>${evalShtInfo.shtNm}</dd>
				</dl>
				<dl>
					<dt>- 참여 코드 :</dt>
					<dd>${evalShtInfo.accssCd}</dd>
				</dl>
				<dl>
					<dt>- 등록 :</dt>
					<dd>
						<fmt:formatDate var="crtDt" pattern="yyyy년 MM월 dd일" value="${evalShtInfo.crtDt}" />
					${crtDt}<!-- yyyy년 mm월 dd일 -->
					</dd>
				</dl>
				<dl class="mj0">
					<dt>- 평가인원 :</dt>
					<dd>${rtrTotalCnt}명 <span class="tester-list-on-btn" onclick="fnEvalRaterList('${evalShtInfo.shtInfoId}')">(리스트 보기)</span></dd>
				</dl>
			</div>
			<table>
	              <colgroup>
	                  <col width="35%"/>
					  <col width="65%"/>
	              </colgroup>
<!-- 	              <tr> -->
<!-- 	                <th>담당자</th> -->
<%-- 	                <td>${evalShtInfo.mngrNm}</td> --%>
<!-- 	              </tr> -->
	              <tr>
	                <th>제안공고</th>
	                <td>
	                	<a href="${evalShtInfo.infoUrl}" class="float-none" target="_blank">
	                		${evalShtInfo.infoUrl}
	                	</a>
	                </td>
	              </tr>
	              <tr>
	                <th>제안요청서</th>
	                <td>
	                	<c:forEach var="requestFileList" items="${requestFileList}">
	                 		<div class="file-down-wrap">
                				<div>
                					<span>
				                		<a href="${pageContext.request.contextPath}/common/file/${requestFileList.fileId}/download.ajax">${requestFileList.fileOgnNm}</a>
				                	</span> 
                				</div>
	                			<div>
									<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFileList.fileId}','${requestFileList.fileOgnNm}')">미리보기</a><br>
	                			</div>
                			</div>
	                	</c:forEach>
	                </td>
	              </tr>
<!-- 	              <tr> -->
<!-- 	                <th>공고 마감일</th> -->
<%-- 	                <td>${evalShtInfo.endDt}</td> --%>
<!-- 	              </tr> -->
	              <tr>
	                <th>제안서</th>
	                <td>
                		<c:forEach var="attachmentFileList" items="${attachmentFileList}">
                			<div class="file-down-wrap">
                				<div>
                					<span>
				                		<a href="${pageContext.request.contextPath}/common/file/${attachmentFileList.fileId}/download.ajax">${attachmentFileList.fileOgnNm}</a>
				                	</span> 
                				</div>
	                			<div>
									<a href="javascript:void(0)" onClick="showPdfViewerModal('${attachmentFileList.fileId}','${attachmentFileList.fileOgnNm}')">미리보기</a><br>
	                			</div>
                			</div>
	                	</c:forEach>
	                </td>
	              </tr>
	              <tr>
	                <th>발표자료</th>
	                <td>
                		<c:forEach var="presentationFileList" items="${presentationFileList}">
                			<div class="file-down-wrap">
                				<div>
                					<span>
				                		<a href="${pageContext.request.contextPath}/common/file/${presentationFileList.fileId}/download.ajax">${presentationFileList.fileOgnNm}</a>
				                	</span> 
                				</div>
	                			<div>
									<a href="javascript:void(0)" onClick="showPdfViewerModal('${presentationFileList.fileId}','${presentationFileList.fileOgnNm}')">미리보기</a><br>
	                			</div>
                			</div>
	                	</c:forEach>
	                </td>
	              </tr>
	              <tr>
	                <th>평가업체</th>
	                <td>
	                	<span>
	                		${evalBddCmp.bddCmpNm}
	                	</span> 
	                </td>
	              </tr>
	        </table>
		</div>
		<div class="footer-wrap">
			<button type="button" id="cancelBtn" class="mini-btn mini-sub-btn prev">이전</button>
			<c:if test="${shtAllStts eq 'ESC000' }">
				<a href="javascript:void(0)" onclick="fnEvalResult('${evalShtInfo.shtInfoId}')">
					<button type="button" class="on-btn mini-btn result-go">평가 결과보기</button>
				</a>
			</c:if>
			</div>
</div>
<div id="pdfViewerModal"></div>
<div class="sign-wrap tester-list-wrap"></div>
<script type="text/javascript">
	
	function fnEvalResult(shtInfoId){
		window.location.href = "${pageContext.request.contextPath}/evaluation/management/"+shtInfoId+"/result.do";
	}
	
	$("#cancelBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/evaluation/management/list.do"
	});
	
</script>