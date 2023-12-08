package com.neighbor21.ggits.evaluation.common.dto;

import org.springframework.web.multipart.MultipartFile;

import com.neighbor21.ggits.evaluation.common.entity.EvalFile;

public class EvalFileInfoDTO {

	private MultipartFile file; // 업로드 파일
	private EvalFile evalFile;		 
	
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}
	public EvalFile getEvalFile() {
		return evalFile;
	}
	public void setEvalFile(EvalFile evalFile) {
		this.evalFile = evalFile;
	}
	

	
}
