package com.neighbor21.ggits.evaluation.common.entity;

//평가자 작성 평가지 항문 점수
public class EvalRtrItemScr {

	private String rtrSctrScrId; // 평가 점수 ID
	private String rtrShtId; // 평가자 작성 평가지 ID
	private String shtItmId; // 평가 항목 ID
	private int scr; // 평가 점수

	public String getRtrSctrScrId() {
		return rtrSctrScrId;
	}

	public void setRtrSctrScrId(String rtrSctrScrId) {
		this.rtrSctrScrId = rtrSctrScrId;
	}

	public String getRtrShtId() {
		return rtrShtId;
	}

	public void setRtrShtId(String rtrShtId) {
		this.rtrShtId = rtrShtId;
	}

	public String getShtItmId() {
		return shtItmId;
	}

	public void setShtItmId(String shtItmId) {
		this.shtItmId = shtItmId;
	}

	public int getScr() {
		return scr;
	}

	public void setScr(int scr) {
		this.scr = scr;
	}

}
