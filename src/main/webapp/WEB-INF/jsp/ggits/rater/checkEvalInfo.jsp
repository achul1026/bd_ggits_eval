<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="content">
	<div class="login_wrap">
		<button type="button" onclick="logout('rater')">
			<img src="${pageContext.request.contextPath}/statics/images/logout.png">
				로그아웃
		</button>
	</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>[${rtrInfoSession.rtrAgncy}] ${rtrInfoSession.rtrNm} 평가자님<br> 아래 정보를 확인
		하신 후 평가를 시작해 주세요</h1>
	</div>
	
	<div class="progressbar-wrapper progressbar-wrapper-tablet">
	      <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>평가자 정보 입력</p>
	          </li>
	          <li class="active">
	          	<p>평가지 정보 확인</p>
	          </li>
	          <li>
	          	<p>평가 목록</p>
	          </li>
	          <li>
	          	<p>평가 화면</p>
	          </li>
	          <li>
	          	<p>평가점수 확인</p>
	          </li>
	      </ul>
	</div>
		
	<div class="test-info form wdat flex gap32">
				<dl class="mj0">
					<dt>[진행중] :</dt>
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
		                <th>제안공고</th>
		                <td><a href="${shtInfo.infoUrl }" target="_blank" class="float-none">${shtInfo.infoUrl }</a></td>
		              </tr>
		              <tr>
		                <th>제안요청서</th>
		                <td>
			                <c:forEach var="requestFile" items="${requestFileList }" varStatus="status">
			               		<span>${requestFile.fileOgnNm}</span>
			               		<a href="javascript:void(0)" onClick="showPdfViewerModal('${requestFile.fileId}','${requestFile.fileOgnNm}')">미리보기</a><br>
			                </c:forEach>
	                	</td>
		              </tr>
		              <tr>
		                <th>제안서</th>
		                <td>
			                <c:forEach var="attachmentFile" items="${attachmentFileList}" varStatus="status">
			                	<span>${attachmentFile.fileOgnNm}</span>
			                	<a href="javascript:void(0)" onClick="showPdfViewerModal('${attachmentFile.fileId}','${attachmentFile.fileOgnNm}')">미리보기</a><br>
			                </c:forEach>
		                </td>
		              </tr>
		              <tr>
		                <th>발표자료</th>
		                <td>
			                <c:forEach var="presentationDocFile" items="${presentationDocFileList}" varStatus="status">
			                	<span>${presentationDocFile.fileOgnNm}</span>
			                	<a href="javascript:void(0)" onClick="showPdfViewerModal('${presentationDocFile.fileId}','${presentationDocFile.fileOgnNm}')">미리보기</a><br>
			                </c:forEach>
		                </td>
		              </tr>
		             
		        </table>
			</div>
		
		<div class="btn-wrap tablet-btn-wrap center pd0">
			<button type="button" id="evalStartBtn" class="on-btn mini-btn wd100">평가 시작하기</button>
		</div>
</div>		
<div id="pdfViewerModal"></div>
	
<script type="text/javascript">
	
	$("#evalStartBtn").on("click",function(){
		alert("평가를 시작합니다");
		location.href="${pageContext.request.contextPath}/rater/evaluation/list.do";
	})

</script>
