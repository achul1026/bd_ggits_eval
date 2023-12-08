package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;

public class EvalBddCmpEvalListDto {
	private String bddCmpId; //입찰기업 ID
	private String shtInfoId; // 평가지 정보 ID
	private String rtrId; // 평가자 ID
	
	private String bddCmpNm; //입찰기업 이름
	private int bddCmpNbr; //입찰 기업 순번
	private int pageNo; // 페이지 번호
	private List<EvalRtrSht> evalRtrSht; // 평가자 작성 평가지 List
	
	public String getBddCmpId() {
		return bddCmpId;
	}
	public void setBddCmpId(String bddCmpId) {
		this.bddCmpId = bddCmpId;
	}
	public String getShtInfoId() {
		return shtInfoId;
	}
	public void setShtInfoId(String shtInfoId) {
		this.shtInfoId = shtInfoId;
	}
	public String getRtrId() {
		return rtrId;
	}
	public void setRtrId(String rtrId) {
		this.rtrId = rtrId;
	}
	public int getBddCmpNbr() {
		return bddCmpNbr;
	}
	public void setBddCmpNbr(int bddCmpNbr) {
		this.bddCmpNbr = bddCmpNbr;
	}
	
	public List<EvalRtrSht> getEvalRtrSht() {
		return evalRtrSht;
	}
	public String getBddCmpNm() {
		return bddCmpNm;
	}
	public void setBddCmpNm(String bddCmpNm) {
		this.bddCmpNm = bddCmpNm;
	}
	public void setEvalRtrSht(List<EvalRtrSht> evalRtrSht) {
		this.evalRtrSht = evalRtrSht;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	
}
