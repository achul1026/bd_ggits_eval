package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;

import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;

public class EvalResultDTO {
	
	private String shtNm;
	private EvalResultHeaderInfo evalResultHeaderInfo;
	private List<EvalResultRtrInfo> evalResultRtrInfoList;
	private EvalMaxMinScrInfo evalMaxMinScrInfo; 
	
	public static class EvalResultHeaderInfo {
		private List<String> bddCmpIdList;
		private List<String> bddCmpNmList;
		private List<String> totalSumList;
		private List<String> totalAvgList;
		private List<String> maxScrList;
		private List<String> minScrList;
		private List<String> qltTotalSumList;
		private List<String> qntTotalSumList;
		
		public List<String> getBddCmpIdList() {
			return bddCmpIdList;
		}
		public void setBddCmpIdList(String bddCmpIdList) {
			if(!GgitsCommonUtils.isNull(bddCmpIdList)) {
				this.bddCmpIdList = GgitsCommonUtils.stringArrayToList(bddCmpIdList.split(","));
			}
		}
		public List<String> getBddCmpNmList() {
			return bddCmpNmList;
		}
		public void setBddCmpNmList(String bddCmpNmList) {
			if(!GgitsCommonUtils.isNull(bddCmpNmList)) {
				this.bddCmpNmList = GgitsCommonUtils.stringArrayToList(bddCmpNmList.split(","));
			}
		}
		public List<String> getTotalSumList() {
			return totalSumList;
		}
		public void setTotalSumList(String totalSumList) {
			if(!GgitsCommonUtils.isNull(totalSumList)) {
				this.totalSumList = GgitsCommonUtils.stringArrayToList(totalSumList.split(",")); 
			}
		}
		public List<String> getTotalAvgList() {
			return totalAvgList;
		}
		public void setTotalAvgList(String totalAvgList) {
			if(!GgitsCommonUtils.isNull(totalAvgList)) {
				this.totalAvgList = GgitsCommonUtils.stringArrayToList(totalAvgList.split(",")); 
			}
		}
		public List<String> getMaxScrList() {
			return maxScrList;
		}
		public void setMaxScrList(String maxScrList) {
			if(!GgitsCommonUtils.isNull(maxScrList)) {
				this.maxScrList = GgitsCommonUtils.stringArrayToList(maxScrList.split(","));
			}
		}
		public List<String> getMinScrList() {
			return minScrList;
		}
		public void setMinScrList(String minScrList) {
			if(!GgitsCommonUtils.isNull(minScrList)) {
				this.minScrList = GgitsCommonUtils.stringArrayToList(minScrList.split(",")); 
			}
		}
		
		
		public List<String> getQltTotalSumList() {
			return qltTotalSumList;
		}
		public void setQltTotalSumList(String qltTotalSumList) {
			if(!GgitsCommonUtils.isNull(qltTotalSumList)) {
				this.qltTotalSumList = GgitsCommonUtils.stringArrayToList(qltTotalSumList.split(",")); 
			}
		}
		
		public List<String> getQntTotalSumList() {
			return qntTotalSumList;
		}
		public void setQntTotalSumList(String qntTotalSumList) {
			if(!GgitsCommonUtils.isNull(qntTotalSumList)) {
				this.qntTotalSumList = GgitsCommonUtils.stringArrayToList(qntTotalSumList.split(",")); 
			}
		}
		
	}
	
	public static class EvalResultRtrInfo {
		private String rtrNm;
		private List<String> sumList;
		
		public String getRtrNm() {
			return rtrNm;
		}
		public void setRtrNm(String rtrNm) {
			this.rtrNm = rtrNm;
		}
		public List<String> getSumList() {
			return sumList;
		}
		public void setSumList(String sumList) {
			if(!GgitsCommonUtils.isNull(sumList)) {
				this.sumList = GgitsCommonUtils.stringArrayToList(sumList.split(",")); 
			}
		}
	}
	
	public static class EvalMaxMinScrInfo {
		private int maxScr;
		private String maxRtrId;
		private int minScr;
		private String minRtrId;
		public int getMaxScr() {
			return maxScr;
		}
		public void setMaxScr(int maxScr) {
			this.maxScr = maxScr;
		}
		public String getMaxRtrId() {
			return maxRtrId;
		}
		public void setMaxRtrId(String maxRtrId) {
			this.maxRtrId = maxRtrId;
		}
		public int getMinScr() {
			return minScr;
		}
		public void setMinScr(int minScr) {
			this.minScr = minScr;
		}
		public String getMinRtrId() {
			return minRtrId;
		}
		public void setMinRtrId(String minRtrId) {
			this.minRtrId = minRtrId;
		}
	}
	
	public String getShtNm() {
		return shtNm;
	}

	public void setShtNm(String shtNm) {
		this.shtNm = shtNm;
	}

	public EvalResultHeaderInfo getEvalResultHeaderInfo() {
		return evalResultHeaderInfo;
	}

	public void setEvalResultHeaderInfo(EvalResultHeaderInfo evalResultHeaderInfo) {
		this.evalResultHeaderInfo = evalResultHeaderInfo;
	}

	public List<EvalResultRtrInfo> getEvalResultRtrInfoList() {
		return evalResultRtrInfoList;
	}

	public void setEvalResultRtrInfoList(List<EvalResultRtrInfo> evalResultRtrInfoList) {
		this.evalResultRtrInfoList = evalResultRtrInfoList;
	}

	public EvalMaxMinScrInfo getEvalMaxMinScrInfo() {
		return evalMaxMinScrInfo;
	}

	public void setEvalMaxMinScrInfo(EvalMaxMinScrInfo evalMaxMinScrInfo) {
		this.evalMaxMinScrInfo = evalMaxMinScrInfo;
	}
	
}
