package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtrItemScr;

public class EvalRaterScrDTO {
	
	private int totalScr; // 정량 배점 사이즈
	private int totalMaxScr; // 평가지 순서
	private String saveType;
	private List<EvalRtrItemScr> evalRtrItemScrList;
	private List<ConfirmScrInfo> confirmScrInfoList;
	
		public static class ConfirmScrInfo {
			
			private String fldSctr; // 평가 부문
			private int scr; // 평가자 배점의 부문 총계
			private int maxScr;  // 부문 최대 배점
			public int getScr() {
				return scr;
			}
			public void setScr(int scr) {
				this.scr = scr;
			}
			public int getMaxScr() {
				return maxScr;
			}
			public void setMaxScr(int maxScr) {
				this.maxScr = maxScr;
			}
			public String getFldSctr() {
				return fldSctr;
			}
			public void setFldSctr(String fldSctr) {
				this.fldSctr = fldSctr;
			}
			
		}
	
		
	public List<EvalRtrItemScr> getEvalRtrItemScrList() {
		return evalRtrItemScrList;
	}

	public void setEvalRtrItemScrList(List<EvalRtrItemScr> evalRtrItemScrList) {
		this.evalRtrItemScrList = evalRtrItemScrList;
	}

	public List<ConfirmScrInfo> getConfirmScrInfoList() {
		return confirmScrInfoList;
	}

	public void setConfirmScrInfoList(List<ConfirmScrInfo> confirmScrInfoList) {
		this.confirmScrInfoList = confirmScrInfoList;
	}

	public int getTotalScr() {
		return totalScr;
	}

	public void setTotalScr(int totalScr) {
		this.totalScr = totalScr;
	}

	public int getTotalMaxScr() {
		return totalMaxScr;
	}

	public void setTotalMaxScr(int totalMaxScr) {
		this.totalMaxScr = totalMaxScr;
	}

	public String getSaveType() {
		return saveType;
	}

	public void setSaveType(String saveType) {
		this.saveType = saveType;
	}
	
	
	
}
