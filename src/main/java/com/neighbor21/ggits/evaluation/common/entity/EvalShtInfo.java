package com.neighbor21.ggits.evaluation.common.entity;

import java.sql.Timestamp;

//평가지 정보
public class EvalShtInfo {

	private String shtInfoId; // 평가지 정보 ID
	private String shtNm; // 평가지 이름
	private String accssCd; // 평가지 참여 코드
	private String infoUrl; // 공고 URL
//	private String endDt; // 공고 마감일
//	private String mngrNm; // 담당자 이름
	private Timestamp crtDt; // 평가지 생성일
	private String shtAllStts; // 전체 평가지 상태 (EX. 작성중/ 평가 대기중)

	//result 
	private String strCrtDt; // 평가지 생성일  String
	
	//search
	private String schSchStts;
	private String schShtNm;
	
	private int pageNo = 1; // 페이지 번호

	public String getShtInfoId() {
		return shtInfoId;
	}

	public void setShtInfoId(String shtInfoId) {
		this.shtInfoId = shtInfoId;
	}

	public String getShtNm() {
		return shtNm;
	}

	public void setShtNm(String shtNm) {
		this.shtNm = shtNm;
	}

	public String getAccssCd() {
		return accssCd;
	}

	public void setAccssCd(String accssCd) {
		this.accssCd = accssCd;
	}

	public String getInfoUrl() {
		return infoUrl;
	}

	public void setInfoUrl(String infoUrl) {
		this.infoUrl = infoUrl;
	}

//	public String getEndDt() {
//		return endDt;
//	}
//
//	public void setEndDt(String endDt) {
//		this.endDt = endDt;
//	}
//
//	public String getMngrNm() {
//		return mngrNm;
//	}
//
//	public void setMngrNm(String mngrNm) {
//		this.mngrNm = mngrNm;
//	}
	
	public Timestamp getCrtDt() {
		return crtDt;
	}

	public String getStrCrtDt() {
		return strCrtDt;
	}

	public void setStrCrtDt(String strCrtDt) {
		this.strCrtDt = strCrtDt;
	}

	public void setCrtDt(Timestamp crtDt) {
		this.crtDt = crtDt;
	}

	public String getShtAllStts() {
		return shtAllStts;
	}

	public void setShtAllStts(String shtAllStts) {
		this.shtAllStts = shtAllStts;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}


	public String getSchSchStts() {
		return schSchStts;
	}

	public void setSchSchStts(String schSchStts) {
		this.schSchStts = schSchStts;
	}

	public String getSchShtNm() {
		return schShtNm;
	}

	public void setSchShtNm(String schShtNm) {
		this.schShtNm = schShtNm;
	}

	
}
