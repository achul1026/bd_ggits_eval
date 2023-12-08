$.fn.soValid = function(){
	let $wrap = $(this);
	let passwordRegExp = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,32}$/;
	let dateRegExp = /^\d{4}-\d{2}-\d{2}$/;
	let valid = true;
	
	function checkEmail(email) {
		var regExp = /^[a-z0-9A-Z._-]+@[a-z0-9A-Z._-]+\.[a-zA-Z.-]*$/i;
		if (regExp.test(email)) {
	        return true;
	    } else {
	        return false;
	    }
	}
	function checkTel(tel) {
		tel = tel.replace(/-/gi, "");
	    var regExp = /^(010{1})[0-9]{3,4}[0-9]{4}$/i;
				//   /^[0-9]{2,4}-?[0-9]{3,4}-?[0-9]{4}$/ 
	    if (regExp.test(tel)) {
	        return true;
	    } else {
	        return false;
	    }
	}
	
	$wrap.find(".data-validate").each(function(){
		let $validElement = $(this);
		let tagName = $(this).get(0).tagName.toUpperCase();
		let value = "";
		let attributeName = "";
		let labelname = $(this).attr("data-valid-name");
		if(tagName == "SELECT"){
			value = $validElement.find("option:selected").val();
			
			if(typeof $validElement.attr("data-valid-required") !== "undefined" && (isNull(value) || value.replaceAll(" ", "") == "")){
				msg = "을(를) 선택해주세요.";
				alert(labelname+msg, function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
			}
		}else{
			if($validElement.attr("type").toUpperCase() == "RADIO" || $validElement.attr("type").toUpperCase() == "CHECKBOX"){
				attributeName = $validElement.attr("name");
				value = $wrap.find(`input[type='${$validElement.attr("type")}'][name='${attributeName}']:checked`).val();
			}else{
				value = $validElement.val();
			}
		}
		if(typeof $validElement.attr("data-valid-required") !== "undefined" && (isNull(value) || value.replaceAll(" ", "") == "")) {
			let msg = "을(를) 입력해 주세요.";
			if($validElement.attr("type").toUpperCase() == "RADIO" || $validElement.attr("type").toUpperCase() == "CHECKBOX"){
				msg = "을(를) 선택해 주세요.";
			}
	//		alert(labelname+msg, function(button, modal){
	//			$validElement.focus();
	//			modal.close();
	//		});
			(function(){
				alert(labelname+msg);
				$validElement.focus();
			})();
			valid = false;
			return false;
		}
		if(typeof $validElement.attr("data-valid-email") !== "undefined" && !checkEmail(value)) {
			alert("이메일 양식이 아닙니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		
		if(typeof $validElement.attr("data-valid-phone") !== "undefined" && !checkTel(value)) {
			alert("연락처 정보가 올바르지 않습니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		if(typeof $validElement.attr("data-valid-maximum") !== "undefined" && value.length > parseInt($validElement.attr("data-valid-maximum"))) {
			let max = $validElement.attr("data-valid-maximum");
			alert(labelname+"은(는) "+max+" 자리를 넘어갈 수 없습니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		
		if(typeof $validElement.attr("data-valid-minimum") !== "undefined" && value.length < parseInt($validElement.attr("data-valid-minimum"))) {
			let min = $validElement.attr("data-valid-minimum");
			alert(labelname+"은(는) "+min+"자리보다 커야합니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		
		if(typeof $validElement.attr("data-valid-maximum-number") !== "undefined" && parseInt(value) > parseInt($validElement.attr("data-valid-maximum-number"))) {
			let max = $validElement.attr("data-valid-maximum-number");
			alert(labelname+"은(는) "+max+"보다 클 수없습니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		
		if(typeof $validElement.attr("data-valid-minimum-number") !== "undefined" && parseInt(value) < parseInt($validElement.attr("data-valid-minimum-number"))) {
			let min = $validElement.attr("data-valid-minimum-number");
			alert(labelname+"은(는) "+min+"보다 커야합니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}
		
		if(typeof $validElement.attr("data-valid-password") !== 'undefined' && !passwordRegExp.test(value)) {
			alert("비밀번호 값이 올바르지 않습니다.", function(button, modal){
				$validElement.focus();
				modal.close();
			});
			valid = false;
			return false;
		}

		if(typeof $validElement.attr("data-valid-startDate") !== "undefined"){
			startDate = value;
		}

		if(typeof $validElement.attr("data-valid-endDate") !== "undefined"){
			endDate = value;
		}
		
		if(typeof $validElement.attr("data-valid-date") !== 'undefined' && !dateRegExp.test(value)) {
			(function(){
				alert("날짜 입력값이 올바르지 않습니다.");
				$validElement.focus();
			})();
			valid = false;
			return false;
		}
	});

	return valid;
}
$(document).on("keyup", ".vaild-tel", function() {
	var telReg = /(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/;
	var replaceVal = $(this).val().replace(/[^0-9]/g, "").replace(telReg,"$1-$2-$3").replace("--", "-"); 
	$(this).val(replaceVal);
})
$(document).on("keyup", ".vaild-birthday", function() {
	var birthReg = /(\d{4})(\d{2})(\d{2})/;
	var replaceVal = $(this).val().replace(/[^0-9]/g, "").replace(birthReg,"$1-$2-$3").replace("--", "-");
	$(this).val(replaceVal);
})