package com.neighbor21.ggits.evaluation.common.entity;

//정량적 평가지 배점 (quantitative)
public class EvalShtQntScr {

	private String qntScrId; // 정성적 평가지 배점 ID
	private String shtItmId; // 평가 항목 ID
	private float fldScr; // 평가지 필드 점수

	
	public String getQntScrId() {
		return qntScrId;
	}

	public void setQntScrId(String qntScrId) {
		this.qntScrId = qntScrId;
	}

	public String getShtItmId() {
		return shtItmId;
	}

	public void setShtItmId(String shtItmId) {
		this.shtItmId = shtItmId;
	}

	public float getFldScr() {
		return fldScr;
	}

	public void setFldScr(float fldScr) {
		this.fldScr = fldScr;
	}

}
