package com.neighbor21.ggits.evaluation.common.component.validate;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  ValidateResult
 * @since : 2023-09-04
 */
public class ValidateResult {
    boolean success;
    String message = "";

    public ValidateResult() {
        this.success = true;
    }

    public ValidateResult(boolean success, String message) {
        this.success = success;
        this.message = message;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
