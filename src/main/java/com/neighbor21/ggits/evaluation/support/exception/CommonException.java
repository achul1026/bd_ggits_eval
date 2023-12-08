package com.neighbor21.ggits.evaluation.support.exception;

public class CommonException extends RuntimeException{

	private ErrorCode errorCode;
	private String message;

	public CommonException() {
		super();
	}
	
	public CommonException(ErrorCode errorCode) {
		super();
		this.errorCode = errorCode;
		this.message = errorCode.getMessage();
	}

	public CommonException(ErrorCode errorCode, String message) {
		super();
		this.errorCode = errorCode;
		this.message = message;
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(ErrorCode errorCode) {
		this.errorCode = errorCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
	
}
