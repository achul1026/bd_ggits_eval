package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtQltScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQntScr;

public class EvalShtInfoDTO {

	private String saveType; // 저장 타입
	private String shtId; // 평가지 ID
	private String shtInfoId; // 평가지 id
	private String shtType; // 평가지 타입 (정상 , 정량)
	private List<EvalShtSctrInfo> evalShtSctrList;
	private List<String> delShtSctrIdArray;
	private List<String> delShtItmIdArray;
	
	private String selectQntScrType = "SCT001"; // 기본값 5개 
	
	public static class EvalShtSctrInfo {

		private String shtSctrId; // 평가 부문 ID
		private String shtId; // 평가지 ID
		private String fldSctr; // 평가지 필드 (평가부문)
		private int qntScrListSize; // 정량 배점 사이즈
		private List<EvalShtItemInfo> evalShtItemList; // 항목 목록
		private int fldOrdr; // 평가지 순서
		
		public static class EvalShtItemInfo {
			
			private String    shtItmId;        //평가 항목 ID
		    private String    shtSctrId;        //평가 부문 ID
		    private String    itmNm;        //평가지 필드 (평가항목)
		    private String    itmElmnt;        //평가지 필드 (평가요소)
		    private long      itemOrdr;        //평가지 항목 순서
			private List<EvalShtQltScr> evalShtQltScrList; //정성적 배점 정보 목록
			private EvalShtQntScr evalShtQntScrInfo; //정량적 배점 정보
			
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
			public List<EvalShtQltScr> getEvalShtQltScrList() {
				return evalShtQltScrList;
			}
			public void setEvalShtQltScrList(List<EvalShtQltScr> evalShtQltScrList) {
				this.evalShtQltScrList = evalShtQltScrList;
			}
			public EvalShtQntScr getEvalShtQntScrInfo() {
				return evalShtQntScrInfo;
			}
			public void setEvalShtQntScrInfo(EvalShtQntScr evalShtQntScrInfo) {
				this.evalShtQntScrInfo = evalShtQntScrInfo;
			}
			
		}

		public String getShtSctrId() {
			return shtSctrId;
		}

		public void setShtSctrId(String shtSctrId) {
			this.shtSctrId = shtSctrId;
		}

		public String getShtId() {
			return shtId;
		}

		public void setShtId(String shtId) {
			this.shtId = shtId;
		}

		public String getFldSctr() {
			return fldSctr;
		}

		public void setFldSctr(String fldSctr) {
			this.fldSctr = fldSctr;
		}

		public List<EvalShtItemInfo> getEvalShtItemList() {
			return evalShtItemList;
		}

		public void setEvalShtItemList(List<EvalShtItemInfo> evalShtItemList) {
			this.evalShtItemList = evalShtItemList;
		}

		public int getFldOrdr() {
			return fldOrdr;
		}

		public void setFldOrdr(int fldOrdr) {
			this.fldOrdr = fldOrdr;
		}
		public int getQntScrListSize() {
			return qntScrListSize;
		}

		public void setQntScrListSize(int qntScrListSize) {
			this.qntScrListSize = qntScrListSize;
		}
	}
	
	public String getSaveType() {
		return saveType;
	}

	public void setSaveType(String saveType) {
		this.saveType = saveType;
	}
	
	public String getSelectQntScrType() {
		return selectQntScrType;
	}

	public void setSelectQntScrType(String selectQntScrType) {
		this.selectQntScrType = selectQntScrType;
	}

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

	public List<EvalShtSctrInfo> getEvalShtSctrList() {
		return evalShtSctrList;
	}

	public void setEvalShtSctrList(List<EvalShtSctrInfo> evalShtSctrList) {
		this.evalShtSctrList = evalShtSctrList;
	}

	public List<String> getDelShtSctrIdArray() {
		return delShtSctrIdArray;
	}

	public void setDelShtSctrIdArray(List<String> delShtSctrIdArray) {
		this.delShtSctrIdArray = delShtSctrIdArray;
	}

	public List<String> getDelShtItmIdArray() {
		return delShtItmIdArray;
	}

	public void setDelShtItmIdArray(List<String> delShtItmIdArray) {
		this.delShtItmIdArray = delShtItmIdArray;
	}

	
}
