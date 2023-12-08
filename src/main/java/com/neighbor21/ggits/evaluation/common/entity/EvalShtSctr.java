package com.neighbor21.ggits.evaluation.common.entity;

//평가 내용 부문
public class EvalShtSctr {

	private String shtSctrId; // 평가 부문 ID
	private String shtId; // 평가지 ID
	private String fldSctr; // 평가지 필드 (평가부문)
	private int fldOrdr; // 평가지 필드 순서

	public String getShtSctrId() {
		return shtSctrId;
	}

	public void setShtSctrId(String shtSctrId) {
		this.shtSctrId = shtSctrId;
	}

	public String getShtId() {
		return shtId;
	}

	public void setShtId(String shtId) {
		this.shtId = shtId;
	}

	public String getFldSctr() {
		return fldSctr;
	}

	public void setFldSctr(String fldSctr) {
		this.fldSctr = fldSctr;
	}


	public int getFldOrdr() {
		return fldOrdr;
	}

	public void setFldOrdr(int fldOrdr) {
		this.fldOrdr = fldOrdr;
	}


}
