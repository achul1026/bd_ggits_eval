package com.neighbor21.ggits.evaluation.common.entity;
public class EvalShtItem {
    private String    shtItmId;        //평가 항목 ID
    private String    shtSctrId;        //평가 부문 ID
    private String    itmNm;        //평가지 필드 (평가항목)
    private String    itmElmnt;        //평가지 필드 (평가요소)
    private long      itemOrdr;        //평가지 항목 순서


  public String getShtItmId() {
    return shtItmId;
  }

  public void setShtItmId(String shtItmId) {
    this.shtItmId = shtItmId;
  }


  public String getShtSctrId() {
    return shtSctrId;
  }

  public void setShtSctrId(String shtSctrId) {
    this.shtSctrId = shtSctrId;
  }


  public String getItmNm() {
    return itmNm;
  }

  public void setItmNm(String itmNm) {
    this.itmNm = itmNm;
  }


  public String getItmElmnt() {
    return itmElmnt;
  }

  public void setItmElmnt(String itmElmnt) {
    this.itmElmnt = itmElmnt;
  }


  public long getItemOrdr() {
    return itemOrdr;
  }

  public void setItemOrdr(long itemOrdr) {
    this.itemOrdr = itemOrdr;
  }

}
