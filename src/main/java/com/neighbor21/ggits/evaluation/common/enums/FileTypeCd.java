package com.neighbor21.ggits.evaluation.common.enums;

public enum FileTypeCd {
	REQUEST_FOR_PROPOSAL("FTC001", "제안 요청서", "requestForProposal"),
	OTHER_ATTACHMENT("FTC002", "기타 첨부 파일","attachment"),
	PROPOSALS("FTC003", "제안서","proposals"),
	PRESENTATION_DOC("FTC004", "발표 자료","presentationDoc"),

	SHEET_FORM("FTC201", "평가지 등록 양식","sheetForm"),

	RATER_SIGN("FTC301", "평가자 서명","sign"),
	
	;

	private String code;
	private String name;
	private String filePath;

	private FileTypeCd(String code, String name, String filePath) {
		this.code = code;
		this.name = name;
		this.filePath = filePath;
	}

	public String getFileCode() {
		return code;
	}

	public String getFileName() {
		return name;
	}

	public String getFilePath() {
		return filePath;
	}
	
	public static FileTypeCd getEnum(String code) {
		for(FileTypeCd fileTypeCd : FileTypeCd.values()) {
			if(fileTypeCd.getFileCode().equals(code)) {
				return fileTypeCd;
			}
		}
		return null;
	}
	
}
