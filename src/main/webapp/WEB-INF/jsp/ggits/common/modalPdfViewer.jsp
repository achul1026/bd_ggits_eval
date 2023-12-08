<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="sign-wrap test-list-wrap pdf-modal-wrap" id="pdfViewer">
  	<div class="sign-content pdf-content">
  		<div class="sign-head">
			${fileOgnNm} <img src="${pageContext.request.contextPath}/statics/images/close-white.png"
				class="close modal-close" onclick="closePdfViewer()">
		</div>
		<div class="sign-body test-list-text">
			<div class="pdfview-wrap" style="height:400px;overflow-y:scroll;overflow-x:scroll;">
				<canvas id="pdfView" class="pdfView" ></canvas>
			</div>
			
			
			<div class="pdfview-wrap-sub">
			    <div class="pdf-pageer">
			    	<span>페이지: <span id="currentPage"></span> / <span id="totalPages"></span></span>
			    </div>
			    
			    <div class="pdf-btn-wrap">
			    	<ul>
			    		<li>
			    			 <button id="prev" class="mini-btn mini-sub-btn prev">이전 페이지</button>
			    		</li>
			    		<li>
			    			 <button id="next" class="on-btn mini-btn">다음 페이지</button>
			    		</li>
			    					    		<li>
			    			 <button id="zoominBtn" class="on-btn mini-btn">확대</button>
			    		</li>
			    		<li>
			    			 <button id="zoomoutBtn" class="on-btn mini-btn">축소</button>
			    		</li>
			    		<li>
			    			 <button id="defaultZoomBtn" class="on-btn mini-btn">기본 배율</button>
			    		</li>
			    	</ul>
			    </div>
			</div>
		</div>
		<script>
		function closePdfViewer() {
			$('#pdfViewer').remove();
		}
		
		// pdf렌더링
// 			var filePath = '/upload/assets/test_horizontal001.pdf';
// 	  		var filePath = '/upload/assets/test_vertical001.pdf';
  		var filePath = '${pageContext.request.contextPath}/common/file/${fileId}/view.ajax';
		
        // Loaded via <script> tag, create shortcut to access PDF.js exports.
        var { pdfjsLib } = globalThis;

        pdfjsLib.GlobalWorkerOptions.workerSrc = '${pageContext.request.contextPath}/statics/js/pdf.worker.js';
		
        var canvasWidth = 704;
        var defaultCanvasWidth = 704;
      	var plusWidth = 300;
        
        var pdfDoc = null,
            pageNum = 1,
            pageRendering = false,
            pageNumPending = null,
            scale = 2, // 배율
            canvas = document.getElementById('pdfView'),
            ctx = canvas.getContext('2d');
        

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

        /**
         * If another page rendering in progress, waits until the rendering is
         * finised. Otherwise, executes rendering immediately.
         */
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

        /**
         * Asynchronously downloads PDF.
         */
        pdfjsLib.getDocument(filePath).promise.then(function (pdfDoc_) {
            pdfDoc = pdfDoc_;
            document.getElementById('totalPages').textContent = pdfDoc.numPages;

            // Initial/first page rendering
            renderPage(pageNum);
        }).catch(error => {
        	alert("파일을 찾지 못했습니다.");
        	closePdfViewer();
        	}
        );
        
        // 줌인
        function fnZoomIn() {
            canvasWidth += plusWidth;
            if(canvasWidth > 2500) {
                canvasWidth -= plusWidth;
                return;
            }
            document.getElementById('pdfView').style.width = canvasWidth+'px';
        }
        document.getElementById('zoominBtn').addEventListener('click', fnZoomIn);

        // 줌아웃
        function fnZoomOut() {
            canvasWidth -= plusWidth;
            if(canvasWidth < defaultCanvasWidth) {
                canvasWidth += plusWidth;
                return;
            }
            document.getElementById('pdfView').style.width = canvasWidth+'px';
        }
        document.getElementById('zoomoutBtn').addEventListener('click', fnZoomOut);

        // 원래 배율
        function fnZoomDefault() {
            canvasWidth = defaultCanvasWidth;
            document.getElementById('pdfView').style.width = canvasWidth+'px';
        }
        document.getElementById('defaultZoomBtn').addEventListener('click', fnZoomDefault);
		</script>
	</div>
</div>