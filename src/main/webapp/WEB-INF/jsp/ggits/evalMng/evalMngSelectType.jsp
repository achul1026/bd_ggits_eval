<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div class="login-content">
	<div class="login_wrap">
			<button type="button" onclick="logout()">
				<img src="${pageContext.request.contextPath}/statics/images/logout.png">
					로그아웃
			</button>
		</div>
	<div class="content-head">
		<img src="${pageContext.request.contextPath}/statics/images/logo.png" class="logo">
		<h1>평가 유형을 선택해 주세요.</h1>	
		
		 <div class="progressbar-wrapper">
	      <ul class="progressbar">
	          <li class="progress-complete">
	          	<p>평가정보 입력</p>
	          </li>
	          <li class="progress-complete">
	          	<p>평가대상 등록</p>
	          </li>
	          <li class="active">
	          	<p>평가유형 선택</p>
	          </li>
	           <li class="">
	          	<p>평가지 작성</p>
	          </li>
	           <li class=>
	          	<p>평가지 상세정보</p>
	          </li>
	           <li>
	          	<p>평가결과 확인</p>
	          </li>
	      </ul>
	</div>
	</div>
	<div class="type-select-btn">
		<button type="button" class="main-btn" onclick="fnEvalType('qlt')">
		정성적 평가<c:if test="${shtExistCheck eq 'QNT_EMPTY'}"> (완료)</c:if>
		</button>
		<br>
		<button type="button" class="main-btn" onclick="fnEvalType('qnt')">
		정량적 평가<c:if test="${shtExistCheck eq 'QLT_EMPTY'}"> (완료)</c:if>
		</button>						
		<br>
		<button type="button" id="cancelBtn" class="main-btn ">취소</button>						
	</div>
</div>
<script>
	
	var shtInfoId = '${shtInfoId}';
	var shtExistCheck = '${shtExistCheck}';
	var type = '${type}';
	
	if(type == 'save' && shtExistCheck == 'BOTH_EXIST'){
		window.location.href="${pageContext.request.contextPath}/evaluation/management/list.do";
	}
	function fnEvalType(evalType){
		if(evalType == 'qlt'){
			if(shtExistCheck == 'QNT_EMPTY'){
				alert("완료된 정성적 평가지 정보가 있습니다. 정량적 평가를 진행해주세요.");
				return false;
			}
			window.location.href="${pageContext.request.contextPath}/evaluation/management/qlt/"+shtInfoId+"/save.do"
		}else{
			if(shtExistCheck == 'QLT_EMPTY'){
				alert("완료된 정량적 평가지 정보가 있습니다. 정성적 평가를 진행해주세요.");
				return false;
			}
			window.location.href="${pageContext.request.contextPath}/evaluation/management/qnt/"+shtInfoId+"/save.do"
		}
	}
	// 정량적 평가지 이동
	$("#cancelBtn").on('click',function(){
		location.href="${pageContext.request.contextPath}/evaluation/management/list.do"
	});
</script>