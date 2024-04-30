<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sign-wrap test-list-wrap pdf-modal-wrap" id="pdfViewer">
  	<div class="sign-content pdf-content">
  		<div class="sign-head">
			${fileOgnNm} <img src="${pageContext.request.contextPath}/statics/images/close-white.png"
				class="close modal-close" onclick="closePdfViewer()">
		</div>
		
		
		<div class="sign-body test-list-text">
			<div class="pdf-wrap">
				 <div class="pdf-pageer">
			    	<span>페이지: <span id="currentPage"></span> / <span id="totalPages"></span></span>
			    	<div class="pdf-prev-next pdf-zoom-btn">
			    		<button id="prev" class="mini-sub-btn pdf-prev mini-btn-sub"><img src="${pageContext.request.contextPath}/statics/images/arrow.png"></button>
	    				<button id="next" class="mini-sub-btn pdf-next"><img src="${pageContext.request.contextPath}/statics/images/arrow.png"></button>
			    	</div>
			     </div>
			     
			     <div class="pdf-zoom-btn">
	    			 <button id="zoominBtn" class=""><img src="${pageContext.request.contextPath}/statics/images/zoom-in.png"></button>
	    			 <button id="zoomoutBtn" class=""><img src="${pageContext.request.contextPath}/statics/images/zoom-out.png"></button>
	    			 <button id="defaultZoomBtn" class=""><img src="${pageContext.request.contextPath}/statics/images/base.png"></button>
			    </div>
			</div>
			
			<div class="pdfview-wrap">
				<canvas id="pdfView" class="pdfView" ></canvas>
			</div>
			
			
		</div>
		<script>
		function closePdfViewer() {
		    $('#pdfViewer').remove();
		    $("html, body").removeClass("not_scroll");
		}	
		
// 		 var filePath = '/upload/assets/test_horizontal001.pdf';
		var filePath = '${pageContext.request.contextPath}/common/file/${fileId}/view.ajax';
		
		// PDF.js 초기화
		var { pdfjsLib } = window;
		pdfjsLib.GlobalWorkerOptions.workerSrc = '${pageContext.request.contextPath}/statics/js/pdf.worker.js';

		var canvasWidth = 0;
		var defaultCanvasWidth = 0;
// 		var canvasWidth = 704;
// 		var defaultCanvasWidth = 704;

		var plusWidth = 300;

		var pdfDoc = null,
		    pageNum = 1,
		    pageRendering = false,
		    pageNumPending = null,
		    scale = 2, // 배율
		    canvas = document.getElementById('pdfView'),
		    ctx = canvas.getContext('2d');

		// 터치 이벤트 관련 변수
		var startX = null;
		var startY = null;
		var isZoomedIn = false; // 확대 여부를 나타내는 변수

		canvas.addEventListener('touchstart', function (e) {
		    startX = e.touches[0].clientX;
		    startY = e.touches[0].clientY;
		});

		canvas.addEventListener('touchend', function (e) {
		    var endX = e.changedTouches[0].clientX;
		    var endY = e.changedTouches[0].clientY;

		    var deltaX = endX - startX;
		    var deltaY = endY - startY;

		    // 확대되지 않았을 때만 페이지 전환 처리
		    if (!isZoomedIn && Math.abs(deltaX) > Math.abs(deltaY)) {
		        if (deltaX > 0) {
		            // 오른쪽으로 스와이프한 경우
		            onPrevPage();
		        } else {
		            // 왼쪽으로 스와이프한 경우
		            onNextPage();
		        }
		    }
		});

		// 줌인
		function fnZoomIn() {
		    canvasWidth += plusWidth;
		    if (canvasWidth > 2500) {
		        canvasWidth -= plusWidth;
		        return;
		    }
		    document.getElementById('pdfView').style.width = canvasWidth + 'px';
		    isZoomedIn = true; // 확대된 상태로 설정
		}
		document.getElementById('zoominBtn').addEventListener('click', fnZoomIn);

		// 줌아웃
		function fnZoomOut() {
		    canvasWidth -= plusWidth;
		    if (canvasWidth < defaultCanvasWidth) {
		        canvasWidth += plusWidth;
		        return;
		    }
		    document.getElementById('pdfView').style.width = canvasWidth + 'px';
		    isZoomedIn = false; // 원래 크기로 복원된 상태로 설정
		}
		document.getElementById('zoomoutBtn').addEventListener('click', fnZoomOut);

		// 원래 배율
		function fnZoomDefault() {
		    canvasWidth = defaultCanvasWidth;
		    document.getElementById('pdfView').style.width = canvasWidth + 'px';
		    isZoomedIn = false; // 원래 크기로 복원된 상태로 설정
		}
		document.getElementById('defaultZoomBtn').addEventListener('click', fnZoomDefault);
		
		

		function renderPage(num) {
		    pageRendering = true;
		    // Using promise to fetch the page
		    pdfDoc.getPage(num).then(function (page) {
		        var viewport = page.getViewport({ scale: scale });
		        canvas.height = viewport.height;
		        canvas.width = viewport.width;

		        // canvas안에 pdf 렌더링
		        var renderContext = {
		            canvasContext: ctx,
		            viewport: viewport
		        };
		        var renderTask = page.render(renderContext);

		        // Wait for rendering to finish
		        renderTask.promise.then(function () {
		            pageRendering = false;
		            if (pageNumPending !== null) {
		                // New page rendering is pending
		                renderPage(pageNumPending);
		                pageNumPending = null;
		            }
		        });
		    });

		    // 현재 페이지 값 업데이트
		    document.getElementById('currentPage').textContent = num;
		}

		function queueRenderPage(num) {
		    if (pageRendering) {
		        pageNumPending = num;
		    } else {
		        renderPage(num);
		    }
		}

		// 이전 페이지 이동
		function onPrevPage() {
		    if (pageNum <= 1) {
		        return;
		    }
		    pageNum--;
		    queueRenderPage(pageNum);
		}
		document.getElementById('prev').addEventListener('click', onPrevPage);

		// 다음 페이지 이동
		function onNextPage() {
		    if (pageNum >= pdfDoc.numPages) {
		        return;
		    }
		    pageNum++;
		    queueRenderPage(pageNum);
		}
		document.getElementById('next').addEventListener('click', onNextPage);

		
		// Asynchronously downloads PDF.
		pdfjsLib.getDocument(filePath).promise.then(function (pdfDoc_) {
		    pdfDoc = pdfDoc_;
		    document.getElementById('totalPages').textContent = pdfDoc.numPages;

		    // Initial/first page rendering
		    renderPage(pageNum);
			canvasWidth = canvas.clientWidth;
			defaultCanvasWidth = canvas.clientWidth;
		}).catch(error => {
		    alert("파일을 찾지 못했습니다.");
		    closePdfViewer();
		});
		</script>
	</div>
</div>