package com.neighbor21.ggits.evaluation.common.entity;

import java.sql.Date;
import java.util.List;

//평가자
public class EvalRtr {

	private String rtrId; // 평가자 ID
	private String rtrNm; // 평가자 이름
	private String rtrBrthDt; // 평가자 생년월일
	private String rtrAgncy; // 평가자 소속기관
	private String rtrTel; // 평가지 연락처
	private Date crtDt; // 등록일

	private Integer pageNo = 1; // 페이지 번호
	private String rtrExist; // 평가지 평가자 존재 유무
	private String shtInfoId; // 평가지 정보 ID
	
	//#EvalRtrList
	private String evalCmplt;
	
	//search option
	private List<String> rtrIdList; //평가자 Id 목록
	private String schRtrNm;
	
	public String getRtrId() {
		return rtrId;
	}

	public void setRtrId(String rtrId) {
		this.rtrId = rtrId;
	}
	
	public Date getCrtDt() {
		return crtDt;
	}

	public void setCrtDt(Date crtDt) {
		this.crtDt = crtDt;
	}

	public String getRtrNm() {
		return rtrNm;
	}

	public void setRtrNm(String rtrNm) {
		this.rtrNm = rtrNm;
	}

	public String getRtrBrthDt() {
		return rtrBrthDt;
	}

	public void setRtrBrthDt(String rtrBrthDt) {
		this.rtrBrthDt = rtrBrthDt;
	}

	public String getRtrAgncy() {
		return rtrAgncy;
	}

	public void setRtrAgncy(String rtrAgncy) {
		this.rtrAgncy = rtrAgncy;
	}

	public String getRtrTel() {
		return rtrTel;
	}

	public void setRtrTel(String rtrTel) {
		this.rtrTel = rtrTel;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public String getRtrExist() {
		return rtrExist;
	}

	public void setRtrExist(String rtrExist) {
		this.rtrExist = rtrExist;
	}

	public String getShtInfoId() {
		return shtInfoId;
	}

	public void setShtInfoId(String shtInfoId) {
		this.shtInfoId = shtInfoId;
	}
	
	public String getEvalCmplt() {
		return evalCmplt;
	}

	public void setEvalCmplt(String evalCmplt) {
		this.evalCmplt = evalCmplt;
	}

	public List<String> getRtrIdList() {
		return rtrIdList;
	}

	public void setRtrIdList(List<String> rtrIdList) {
		this.rtrIdList = rtrIdList;
	}

	public String getSchRtrNm() {
		return schRtrNm;
	}

	public void setSchRtrNm(String schRtrNm) {
		this.schRtrNm = schRtrNm;
	}
	
}
