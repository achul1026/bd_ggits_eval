package com.neighbor21.ggits.evaluation.common.dto;

import java.util.List;

import com.neighbor21.ggits.evaluation.common.entity.EvalBddCmp;

public class EvalBddCmpInfoSaveDTO {

	private List<EvalBddCmp> evalBddCmpList;
	private List<String> delBddCmpIdList;
	
	public List<EvalBddCmp> getEvalBddCmpList() {
		return evalBddCmpList;
	}
	public void setEvalBddCmpList(List<EvalBddCmp> evalBddCmpList) {
		this.evalBddCmpList = evalBddCmpList;
	}
	public List<String> getDelBddCmpIdList() {
		return delBddCmpIdList;
	}
	public void setDelBddCmpIdList(List<String> delBddCmpIdList) {
		this.delBddCmpIdList = delBddCmpIdList;
	}
}
