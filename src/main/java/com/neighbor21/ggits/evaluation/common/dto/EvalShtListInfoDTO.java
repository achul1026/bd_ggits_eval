package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;
import java.util.Map;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;

public class EvalShtListInfoDTO {

	List<EvalShtInfo> evalShtInfoList;			//평가지 목록

	Map<String,Object> countInfo;				//평가지 상태 통계

	public EvalShtListInfoDTO() {
		super();
	}

	public List<EvalShtInfo> getEvalShtInfoList() {
		return evalShtInfoList;
	}

	public void setEvalShtInfoList(List<EvalShtInfo> evalShtInfoList) {
		this.evalShtInfoList = evalShtInfoList;
	}

	public Map<String, Object> getCountInfo() {
		return countInfo;
	}

	public void setCountInfo(Map<String, Object> countInfo) {
		this.countInfo = countInfo;
	}
	
}
