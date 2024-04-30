package com.neighbor21.ggits.evaluation.common.entity;

import java.sql.Timestamp;

//평가자 작성 평가지
public class EvalRtrSht {

	private String rtrShtId; // 평가자 작성 평가지 ID
	private String shtId; // 평가지 ID
	private String rtrId; // 평가자 ID
	private String fileId; // 파일 ID (서명)
	private String bddCmpId; // 입찰기업 ID
	private String shtStts; // 평가지 상태(임시 저장, 작성 완료)
	private Timestamp shtSvDt; // 평가 등록일

	private float totalScr; // 평가 총점

	public String getRtrShtId() {
		return rtrShtId;
	}

	public void setRtrShtId(String rtrShtId) {
		this.rtrShtId = rtrShtId;
	}

	public String getShtId() {
		return shtId;
	}

	public void setShtId(String shtId) {
		this.shtId = shtId;
	}

	public String getRtrId() {
		return rtrId;
	}

	public void setRtrId(String rtrId) {
		this.rtrId = rtrId;
	}

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getBddCmpId() {
		return bddCmpId;
	}

	public void setBddCmpId(String bddCmpId) {
		this.bddCmpId = bddCmpId;
	}

	public String getShtStts() {
		return shtStts;
	}

	public void setShtStts(String shtStts) {
		this.shtStts = shtStts;
	}

	public Timestamp getShtSvDt() {
		return shtSvDt;
	}

	public void setShtSvDt(Timestamp shtSvDt) {
		this.shtSvDt = shtSvDt;
	}

	public float getTotalScr() {
		return totalScr;
	}

	public void setTotalScr(float totalScr) {
		this.totalScr = totalScr;
	}

}
