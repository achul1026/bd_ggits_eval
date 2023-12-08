package com.neighbor21.ggits.evaluation.support.exception;

public class NoRaterSessionException extends RuntimeException{
	
	private ErrorCode errorCode;
	private String message;

	public NoRaterSessionException() {
		super();
		this.errorCode = ErrorCode.SESSION_NOT_FOUND;
		this.message = ErrorCode.SESSION_NOT_FOUND.getMessage();
	}
	
	public NoRaterSessionException(ErrorCode errorCode) {
		super();
		this.errorCode = errorCode;
		this.message = errorCode.getMessage();
	}

	public NoRaterSessionException(ErrorCode errorCode, String message) {
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
