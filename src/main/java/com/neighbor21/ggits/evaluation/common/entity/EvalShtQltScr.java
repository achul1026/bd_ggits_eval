package com.neighbor21.ggits.evaluation.common.entity;

//정성적 평가지 배점(qualitative)
public class EvalShtQltScr {

	private String qltScrId; // 정량적 평가지 배점 ID
	private String shtItmId; // 평가 항목 ID
	private String scrNm; // 점수 이름(EX. 수 우 미 양 가)
	private float scr; // 배점
	private int scrOrdr; // 배점 순서
	private String scrType; //배점 타입 
	
	public String getQltScrId() {
		return qltScrId;
	}

	public void setQltScrId(String qltScrId) {
		this.qltScrId = qltScrId;
	}

	public String getShtItmId() {
		return shtItmId;
	}

	public void setShtItmId(String shtItmId) {
		this.shtItmId = shtItmId;
	}

	public String getScrNm() {
		return scrNm;
	}

	public void setScrNm(String scrNm) {
		this.scrNm = scrNm;
	}

	public float getScr() {
		return scr;
	}

	public void setScr(float scr) {
		this.scr = scr;
	}

	public int getScrOrdr() {
		return scrOrdr;
	}

	public void setScrOrdr(int scrOrdr) {
		this.scrOrdr = scrOrdr;
	}

	public String getScrType() {
		return scrType;
	}

	public void setScrType(String scrType) {
		this.scrType = scrType;
	}
	
}
