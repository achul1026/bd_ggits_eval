package com.neighbor21.ggits.evaluation.common.enums;

public enum EvalSttsCd {
	EVAL_COMPLETE("ESC000", "평가 완료"),
	EVAL_INFO_WRITING("ESC001", "평가정보 작성중"),
	EVAL_TARGER_WRITING("ESC002", "평가대상 작성중"),
	EVAL_QNT_FORM_WRITING("ESC003", "정량적 평가지 작성중"),
	EVAL_QLT_FORM_WRITING("ESC004", "정성적 평가지 작성중"),
	EVAL_WAITING("ESC005", "평가 대기"),
	EVAL_PROGRESS("ESC006", "평가 진행중"),
	EVAL_SCORE_GRADING("ESC007", "평가 채점 진행중"),
	EVAL_SOCRE_COMPLETE("ESC008", "평가 채점 완료")
	;
	
	private String code;
	private String name;
	
	private EvalSttsCd(String code, String name) {
		this.code = code;
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}
	
}
