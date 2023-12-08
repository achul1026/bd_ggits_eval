package com.neighbor21.ggits.evaluation.common.entity;

//평가지 파일 정보
public class EvalFile {

	private String fileId; // 파일 ID
	private String shtInfoId; // 평가지 정보 ID
	private String fileType; // 파일 타입(ex. FTP001)
	private String fileNm; // 파일 이름
	private String fileOgnNm; // 파일 이름 원본
	private String fileExtnsn; // 파일 확장자
	private String filePath; // 파일 경로
	private long fileSize; // 파일 크기
	private String bddCmpId; // 입찰기업 ID

	public String getFileId() {
		return fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	public String getShtInfoId() {
		return shtInfoId;
	}

	public void setShtInfoId(String shtInfoId) {
		this.shtInfoId = shtInfoId;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public String getFileOgnNm() {
		return fileOgnNm;
	}

	public void setFileOgnNm(String fileOgnNm) {
		this.fileOgnNm = fileOgnNm;
	}

	public String getFileExtnsn() {
		return fileExtnsn;
	}

	public void setFileExtnsn(String fileExtnsn) {
		this.fileExtnsn = fileExtnsn;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getBddCmpId() {
		return bddCmpId;
	}

	public void setBddCmpId(String bddCmpId) {
		this.bddCmpId = bddCmpId;
	}

	
}
