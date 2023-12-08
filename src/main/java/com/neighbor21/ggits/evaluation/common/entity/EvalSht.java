package com.neighbor21.ggits.evaluation.common.entity;

//평가지
public class EvalSht {

  private String shtId; //평가지 ID
  private String shtInfoId; //평가지 정보  ID
  private String shtType; //평가지 타입 (정량: qnt, 정성: qlt)


  public String getShtId() {
    return shtId;
  }

  public void setShtId(String shtId) {
    this.shtId = shtId;
  }


  public String getShtInfoId() {
    return shtInfoId;
  }

  public void setShtInfoId(String shtInfoId) {
    this.shtInfoId = shtInfoId;
  }


  public String getShtType() {
    return shtType;
  }

  public void setShtType(String shtType) {
    this.shtType = shtType;
  }

}
