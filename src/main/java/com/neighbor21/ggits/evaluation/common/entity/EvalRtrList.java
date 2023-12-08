package com.neighbor21.ggits.evaluation.common.entity;

//평가자 리스트
public class EvalRtrList {

  private String rtrLstId; //평가자 리스트 ID
  private String rtrId; //평가자 ID
  private String shtInfoId; //평가지 정보  ID
  private String evalCmplt; //평가 완료(Y or N)


  public String getRtrLstId() {
    return rtrLstId;
  }

  public void setRtrLstId(String rtrLstId) {
    this.rtrLstId = rtrLstId;
  }


  public String getRtrId() {
    return rtrId;
  }

  public void setRtrId(String rtrId) {
    this.rtrId = rtrId;
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

}
