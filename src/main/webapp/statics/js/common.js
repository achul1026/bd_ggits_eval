var rtrIdList = new Array();
var rtrIdObject = new Object();
var rfpFileCount = 0;
var attachmentFileCount = 0;

function isNull(value) {
	return (value === undefined || value === null) ? true : false;
}

$(function () {
	$('.option').click(function () {
		$(this).next().toggle();
		$('.option').not(this).next().hide();
	});
	/*$('.file-one-change').on('change',function(){
		var fileName = $(".file-one-change").val();
		$(".file-one").val(fileName);
	});
	
	$('.file-all-change').on('change',function(){
		var fileName = $(".file-all-change").val();
		$(".file-all").val(fileName);
	});   */

	$('.close').click(function () {
		$('.sign-wrap').hide();
		$("html, body").removeClass("not_scroll");
	});
	/*$('.list-wrap').click(function(){
		$('.sign-wrap').show();
		$("html, body").addClass("not_scroll");
	})*/
	$('.name-sign-btn-on').click(function () {
		$('.name-sign-wrap').show();
		$("html, body").addClass("not_scroll");
	})
	$('.check-list-btn').click(function () {
		$(this).next().show();
		$("html, body").addClass("not_scroll");
	})
	$('.tester-list-on-btn').click(function () {
		$('.sign-wrap').show();
		$("html, body").addClass("not_scroll");
	});
	
});

/*$('.tester-list-on-btn').click(function(){
	var modalShtInfoId = $(this).data("shtinfoid");
	$.ajax({
		type : "get",
		url : __contextPath__+"/common/modal/rater/list.do",
		dataType: "html",
		success : function(html) {
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();
			
			$("#modalShtInfoId").val('');
			$("#modalShtInfoId").val(modalShtInfoId);
			}
	});
});*/

function pageMove(pageNo) {
	$("input[name='pageNo']").val(pageNo);
	fnSearchList();
}

function modalPageMove(pageNo) {
	$("input[name='modalPageNo']").val(pageNo);
	var pageLocation = $("#pageLocation").val();
	if (pageLocation == 'raterList') {
		fnRaterList('', 'search');
	}
}

function fnRaterList(modalShtInfoId = "", callType = "") {

	var evalRtrInfo = new Object;

	if (modalShtInfoId == "") {
		modalShtInfoId = $("#modalShtInfoId").val();
	}

	if (callType == 'search') {
		evalRtrInfo.schRtrNm = $("#modalRaterNm").val();
		evalRtrInfo.pageNo = $("#modalPageNo").val();
	}
	evalRtrInfo.shtInfoId = modalShtInfoId;

	evalRtrInfo.rtrIdList = rtrIdList;
	$.ajax({
		type: "get",
		url: __contextPath__ + "/common/modal/rater/list.do",
		data: evalRtrInfo,
		dataType: "html",
		success: function (html) {
			$('.sign-content').remove()
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();

			$("#modalShtInfoId").val('');
			$("#modalShtInfoId").val(modalShtInfoId);
		}
	});
}

function fnSaveRaterList(modalShtInfoId = "", callType = "") {

	$.ajax({
		type: "get",
		url: __contextPath__ + "/common/modal/rater/save/list.do",
		dataType: "html",
		success: function (html) {
			$('.sign-content').remove()
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();

			$("#modalShtInfoId").val('');
			$("#modalShtInfoId").val(modalShtInfoId);
		}
	});
}

function fnRaterListEnterKey(modalShtInfoId = "", callType = "") {
	if (window.event.keyCode == 13) {
		var evalRtrInfo = new Object;
	
		if (modalShtInfoId == "") {
			modalShtInfoId = $("#modalShtInfoId").val();
		}
	
		if (callType == 'search') {
			evalRtrInfo.schRtrNm = $("#modalRaterNm").val();
			evalRtrInfo.pageNo = $("#modalPageNo").val();
		}
		evalRtrInfo.shtInfoId = modalShtInfoId;
	
		evalRtrInfo.rtrIdList = rtrIdList;
		$.ajax({
			type: "get",
			url: __contextPath__ + "/common/modal/rater/list.do",
			data: evalRtrInfo,
			dataType: "html",
			success: function (html) {
				$('.sign-content').remove()
				$('.tester-list-wrap').append(html);
				$('.tester-list-wrap').show();
	
				$("#modalShtInfoId").val('');
				$("#modalShtInfoId").val(modalShtInfoId);
			}
		});
	}
}

function fnEvalRaterList(shtInfoId) {

	var evalCmplt = $("#modalEvalCmplt").val();

	$.ajax({
		type: "get",
		url: __contextPath__ + "/common/modal/eval/" + shtInfoId + "/rater/list.do",
		data: { "evalCmplt": evalCmplt, "shtInfoId": shtInfoId },
		dataType: "html",
		success: function (html) {
			clearInterval(raterListTimer);
			$('.sign-content').remove()
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();

			//$("#modalShtInfoId").val('');
			//$("#modalShtInfoId").val(modalShtInfoId);
		}
	});
}

function fnRaterMngList() {
	$.ajax({
		type: "get",
		url: __contextPath__ + "/common/modal/raterMng/list.do",
		// data: { "evalCmplt": evalCmplt, "shtInfoId": shtInfoId },
		dataType: "html",
		success: function (html) {
			clearInterval(raterListTimer);
			$('.sign-content').remove()
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();
		}
	});
}

function fnCmpSaveModal(shtInfoId) {
	$.ajax({
		type: "get",
		url: __contextPath__ + "/common/modal/cmp/save.do",
		dataType: "html",
		success: function (html) {
			clearInterval(raterListTimer);
			$('.sign-content').remove()
			$('.tester-list-wrap').append(html);
			$('.tester-list-wrap').show();
			$("#modalShtInfoId").val(shtInfoId);
		}
	});
}

function getDateFormatYYYYMMDDMISS(){
	var today = new Date();

	var year = today.getFullYear();
	var month = ('0' + (today.getMonth() + 1)).slice(-2);
	var day = ('0' + today.getDate()).slice(-2);
	var hours = ('0' + today.getHours()).slice(-2); 
	var minutes = ('0' + today.getMinutes()).slice(-2);
	var seconds = ('0' + today.getSeconds()).slice(-2); 

	var dateString = year+month+day+hours+minutes+seconds;
	
	return dateString;
}

function showPdfViewerModal(fileId, fileOgnNm){
	$.ajax({
		type : "get",
		url : __contextPath__+"/common/modal/pdf/view.do?fileId=" + fileId + "&fileOgnNm=" + fileOgnNm,
		dataType: "html",
		success : function(html) {
			$('#pdfViewerModal').append(html);
			$('#pdfViewer').show();
		}
	});
	
}

// function increaseFileCount(fileType) {
// 	if(fileType == 'requestForProposal') {
// 		rfpFileCount++;
// 	}
// 	if(fileType == 'attachment') {
// 		attachmentFileCount++;
// 	}
// }

var raterListTimer;

function fnRefreshRaterList(shtInfoId){
	raterListTimer = setInterval(function() {
		fnEvalRaterList(shtInfoId);
	}, 5000);
}
		
function logout(user) {
	let url;
	if(user == 'admin') {
		url = "admin";
	} else {
		url = "rater";
	}
	
	if(confirm("로그아웃 하시겠습니까?")){
		$.ajax({
			type : "get",
			url : __contextPath__+"/logout.ajax?user="+url,
			success : function(result){
				if(result.code == '200') {
					location.href = "/main.do";
				} else {
					alert(result.message);
				}
			}
		});
	}
}