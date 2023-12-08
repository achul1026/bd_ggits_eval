package com.neighbor21.ggits.evaluation.support.exception;

public class ErrorResponse {
	
	private int status;
	private String message;
	
	public ErrorResponse(ErrorCode e) {
		this.status = e.getCode();
		this.message = e.getMessage();
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
