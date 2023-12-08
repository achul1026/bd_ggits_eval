package com.neighbor21.ggits.evaluation.common.component.validate;


import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.neighbor21.ggits.evaluation.common.util.BDStringUtil;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  ValidateType
 * @since : 2023-08-31
 */
public class ValidateChecker {

    List<ValidateChecker> checker = new ArrayList<>();
    ValidateRules rule;
    String defaultFailMessage = "Invalid Parameter : %s";
    String failMessage = "";
    int maxLength;

    public ValidateChecker(){}

    public ValidateChecker(ValidateRules rule){
        this.rule = rule;
        this.failMessage = failMessage;
    }

    public ValidateChecker(ValidateRules rule, String failMessage){
        this.rule = rule;
        this.failMessage = failMessage;
    }
    
    public ValidateChecker(ValidateRules rule, String failMessage, int maxLength){
        this.rule = rule;
        this.failMessage = failMessage;
        this.maxLength = maxLength;
    }

    public ValidateChecker setRequired(){
        setRequired(this.defaultFailMessage);
        return this;
    }

    public ValidateChecker setRequired(String failMessage){
        checker.add(new ValidateChecker(ValidateRules.REQUIRED, failMessage));
        return this;
    }
    
    public ValidateChecker setMaxLength(int maxlength) {
    	setMaxLength(maxlength, this.defaultFailMessage);
    	return this;
    }
    
    public ValidateChecker setMaxLength(int maxlength, String failMessage) {
    	checker.add(new ValidateChecker(ValidateRules.MAXLENGTH, failMessage, maxlength));
    	return this;
    }

    public ValidateChecker setEmail(){
        this.setEmail(defaultFailMessage);
        return this;
    }

    public ValidateChecker setEmail(String failMessage){
        checker.add(new ValidateChecker(ValidateRules.EMAIL, failMessage));
        return this;
    }
    public ValidateChecker setEnglish(){
    	this.setEnglish(defaultFailMessage);
    	return this;
    }
    
    public ValidateChecker setEnglish(String failMessage){
    	checker.add(new ValidateChecker(ValidateRules.ONLY_ENG, failMessage));
    	return this;
    }
    public ValidateChecker setKorean(){
    	this.setKorean(defaultFailMessage);
    	return this;
    }
    
    public ValidateChecker setKorean(String failMessage){
    	checker.add(new ValidateChecker(ValidateRules.ONLY_KOR, failMessage));
    	return this;
    }
    public ValidateChecker setPassword(){
    	this.setPassword(defaultFailMessage);
    	return this;
    }
    
    public ValidateChecker setPassword(String failMessage){
    	checker.add(new ValidateChecker(ValidateRules.PASSWORD, failMessage));
    	return this;
    }
    
    public ValidateChecker setPhone(){
    	checker.add(new ValidateChecker(ValidateRules.PHONE, failMessage));
    	return this;
    }
    
    public ValidateChecker setPhone(String failMessage){
    	checker.add(new ValidateChecker(ValidateRules.PHONE, failMessage));
    	return this;
    }
    
    public ValidateChecker setDate(String failMessage){
    	checker.add(new ValidateChecker(ValidateRules.DATE, failMessage));
    	return this;
    }

    public ValidateResult isValid(Object value){
        ValidateResult validateResult = new ValidateResult();
        boolean result = true;
        for(ValidateChecker check : checker){
            String message =  BDStringUtil.isNull(check.getFailMessage()) ? check.getDefaultFailMessage() : check.getFailMessage();
            Pattern pattern;
            Matcher matcher;
            
            switch (check.getRule()) {
                case REQUIRED:
                    result = BDStringUtil.isNotEmpty(String.valueOf(value));
                    break;
                case MAXLENGTH:
                	result = String.valueOf(value).length() < check.maxLength;
                    break;
                case MINLENGTH:
                	break;
                case EMAIL:
                    pattern = Pattern.compile(ValidatePattern.EMAIL);
                    matcher = pattern.matcher(String.valueOf(value));
                    result = matcher.find();
                    break;
                case PHONE:
                	pattern = Pattern.compile(ValidatePattern.PHONE);
                    matcher = pattern.matcher(String.valueOf(value));
                    result = matcher.find();
                    break;
                case ONLY_NUMBER:
                	pattern = Pattern.compile(ValidatePattern.ONLY_NUM);
                    matcher = pattern.matcher(String.valueOf(value));
                    result = matcher.find();
                    break;
                case PASSWORD:
                	pattern = Pattern.compile(ValidatePattern.PASSWORD);
                    matcher = pattern.matcher(String.valueOf(value));
                    result = matcher.find();
                	break;
                case ONLY_ENG:
                	pattern = Pattern.compile(ValidatePattern.ONLY_ENG);
                    matcher = pattern.matcher(String.valueOf(value));
                    result = matcher.find();
                    break;
                case ONLY_KOR:
                	pattern = Pattern.compile(ValidatePattern.ONLY_KOR);
                	matcher = pattern.matcher(String.valueOf(value));
                	result = matcher.find();
                	break;
                case DATE:
                	pattern = Pattern.compile(ValidatePattern.DATE);
                	matcher = pattern.matcher(String.valueOf(value));
                	result = matcher.find();
                	break;
            }
            if(!result) {
                validateResult = new ValidateResult(false, message);
                break;
            }
        }
        return validateResult;
    }

    public List<ValidateChecker> getChecker() {
        return checker;
    }

    public ValidateRules getRule() {
        return rule;
    }

    public String getDefaultFailMessage() {
        return defaultFailMessage;
    }

    public String getFailMessage() {
        return failMessage;
    }
}
