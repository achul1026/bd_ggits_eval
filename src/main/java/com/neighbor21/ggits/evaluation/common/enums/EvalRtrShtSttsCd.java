package com.neighbor21.ggits.evaluation.common.enums;

public enum EvalRtrShtSttsCd {
	EVAL_COMPLETE("ERSSC000", "평가 완료"),
	EVAL_WAITING("ERSSC004", "평가 진행중"),
	;
	
	private String code;
	private String name;
	
	private EvalRtrShtSttsCd(String code, String name) {
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
