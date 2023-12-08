package com.neighbor21.ggits.evaluation.support.exception;

public class NoLoginException extends RuntimeException{
	
	private ErrorCode errorCode;
	private String message;

	public NoLoginException() {
		super();
		this.errorCode = ErrorCode.NOT_FOUNT_USER_INFO;
		this.message = ErrorCode.NOT_FOUNT_USER_INFO.getMessage();
	}
	
	public NoLoginException(ErrorCode errorCode) {
		super();
		this.errorCode = errorCode;
		this.message = errorCode.getMessage();
	}

	public NoLoginException(ErrorCode errorCode, String message) {
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
