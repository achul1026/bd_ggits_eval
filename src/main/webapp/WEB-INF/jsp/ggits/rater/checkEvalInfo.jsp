<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="wrap">
<div class="content">
	<div class="login_wrap">
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1><span class="point-name">[${rtrInfoSession.rtrAgncy}] ${rtrInfoSession.rtrNm} 평가자님</span><br> 아래 정보를 확인하신 후 평가를 시작해 주세요</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="progress-complete">
	            <p>제안평가위원<br> 정보 입력</p>
	          </li>
	          <li class="active">
	       	   	  <p>제안평가<br>정보 확인</p>
	          </li>
	          <li>
	           <p>제안평가<br> 화면</p>
	          </li>
	          <li>
	          	<p>제안평가위원회<br>점수 확인</p>
	          </li>
	      </ul>
	</div>
		
	<div class="test-info form wdat flex gap32">
				<dl class="mj0">
					<dt>[제안평가명] :</dt>
					<dd> ${shtInfoSession.shtNm }</dd>
				</dl>
			</div>
		<c:set var="shtInfo" value="${evalShtInfoDetail }"/>	
			<div class="info-table wd100">
				<table>
		              <colgroup>
		                  <col width="35%"/>
						  <col width="65%"/>
		              </colgroup>
		              <tr>
		                <th>제안공고 URL</th>
		                <td>
		                	<c:choose>
		                		<c:when test="${shtInfo.infoUrl eq '' || shtInfo.infoUrl eq null}">
		                			<span style="color:#D9D9D9;">등록된 제안공고 URL이 없습니다.</span>
		                		</c:when>
		                		<c:otherwise>
				                	<a href="${shtInfo.infoUrl }" target="_blank" class="float-none">${shtInfo.infoUrl }</a>
		                		</c:otherwise>
		                	</c:choose>
	                	</td>
		              </tr>
		              <tr>
		                <th>제안요청서</th>
		                <td>
        		        	<c:choose>
		                		<c:when test="${not empty requestFileList}">
					                <div class="file-down-wrap">
					                	<c:forEach var="requestFile" items="${requestFileList}" varStatus="status">
						                	<div class="file-down-list">
						                		<div>
						                			<span>${requestFile.fileOgnNm}</span>
						                		</div>
						                		<div>
						                			<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFile.fileId}','${requestFile.fileOgnNm}')">미리보기</a>
						                		</div>
						                	</div>
					                	</c:forEach>
					                </div>
		                		</c:when>
		                		<c:otherwise>
		                			<span style="color:#D9D9D9;">첨부된 파일이 없습니다.</span>
		                		</c:otherwise>
		                	</c:choose>
	                	</td>
		              </tr>
		              <tr>
		                <th>제안서</th>
		                <td>
		                	<c:choose>
		                		<c:when test="${not empty proposalFileList}">
				                	<div class="file-down-wrap">
				                		<c:forEach var="proposalFile" items="${proposalFileList}" varStatus="status">
					                		<div class="file-down-list">
					                			<div>
					                				<span>${proposalFile.fileOgnNm}</span>
					                			</div>
					                			<div>
					                				<a href="javascript:void(0)" onClick="showPdfViewerModal('${proposalFile.fileId}','${proposalFile.fileOgnNm}')">미리보기</a>
					                			</div>
					                		</div>
				                		</c:forEach>
				                	</div>
		                		</c:when>
		                		<c:otherwise>
		                			<span style="color:#D9D9D9;">첨부된 파일이 없습니다.</span>
		                		</c:otherwise>
		                	</c:choose>
		                </td>
		              </tr>
		              <tr>
		                <th>발표자료</th>
		                <td>
		                	<c:choose>
		                		<c:when test="${not empty presentationDocFileList}">
					                	<div class="file-down-wrap">
					                		<c:forEach var="presentationDocFile" items="${presentationDocFileList}" varStatus="status">
						                		<div class="file-down-list">
						                			<div>
						                				<span>${presentationDocFile.fileOgnNm}</span>
						                			</div>
						                			<div>
						                				<a href="javascript:void(0)" onClick="showPdfViewerModal('${presentationDocFile.fileId}','${presentationDocFile.fileOgnNm}')">미리보기</a>
						                			</div>
						                		</div>
					                		</c:forEach>
					                	</div>
		                		</c:when>
		                		<c:otherwise>
		                			<span style="color:#D9D9D9;">첨부된 파일이 없습니다.</span>
		                		</c:otherwise>
		                	</c:choose>
		                </td>
		              </tr>
		             
		        </table>
			</div>
		
		<div class="btn-wrap tablet-btn-wrap center pd0">
			<button type="button" id="evalStartBtn" class="on-btn mini-btn wd100">정성적평가 시작하기</button>
		</div>
</div>		
<div id="pdfViewerModal"></div>
</div>
	
<script type="text/javascript">
	
	$("#evalStartBtn").on("click",function(){
		alert("평가를 시작합니다");
		location.href="${pageContext.request.contextPath}/rater/evaluation/list.do";
	})

</script>
