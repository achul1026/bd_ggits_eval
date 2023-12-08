package com.neighbor21.ggits.evaluation.common.entity;

//관리자 계정
public class EvalAdmin {

  private String adminId; //관리자 ID
  private String userId; //사용자 계정 ID
  private String userPw; //사용자 계정 PW


  public String getAdminId() {
    return adminId;
  }

  public void setAdminId(String adminId) {
    this.adminId = adminId;
  }


  public String getUserId() {
    return userId;
  }

  public void setUserId(String userId) {
    this.userId = userId;
  }


  public String getUserPw() {
    return userPw;
  }

  public void setUserPw(String userPw) {
    this.userPw = userPw;
  }

//  	public static void main(String[] args) {
//  		int uuidtoMake = 1;
//  		for(int i = 0; i< uuidtoMake; i ++) {
//  			System.out.println(GgitsCommonUtils.getUuid());
//  		}
//		
//	}
}
