package com.neighbor21.ggits.evaluation.common.entity;

//입찰 기업
public class EvalBddCmp {

  private String bddCmpId; //입찰기업 ID
  private String shtInfoId; //평가지 정보  ID
  private String bddCmpNm; //입찰기업 이름
  private int bddCmpNbr; //입찰 기업 순번
  private int pageNo; // 페이지 번호

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


  public String getBddCmpNm() {
    return bddCmpNm;
  }

  public void setBddCmpNm(String bddCmpNm) {
    this.bddCmpNm = bddCmpNm;
  }


  public int getBddCmpNbr() {
    return bddCmpNbr;
  }

  public void setBddCmpNbr(int bddCmpNbr) {
    this.bddCmpNbr = bddCmpNbr;
  }

	public int getPageNo() {
		return pageNo;
	}
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

}
