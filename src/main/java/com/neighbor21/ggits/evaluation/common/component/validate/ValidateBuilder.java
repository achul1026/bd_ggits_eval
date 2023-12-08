package com.neighbor21.ggits.evaluation.common.component.validate;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  ValidateChecker
 * @since : 2023-08-31
 */
public class ValidateBuilder {

    Object target;
    Map<String, ValidateChecker> checkers = new HashMap<>();

    public ValidateBuilder(Object obj){
        this.target = obj;
    }

    public ValidateBuilder addRule(String key, ValidateChecker checkers){
        this.checkers.put(key, checkers);
        return this;
    }

    public void isValidOtrThrow(){
        ValidateResult result = this.isValid();
        if(!result.isSuccess()){
            throw new ValidateException(result.getMessage());
        }
    }

    public ValidateResult isValid(){
        ValidateResult v = null;
        if(target instanceof Map){
            // map;
            v = _checkByMap(target);
        } else if(target instanceof List){
            // list<map>
            for(Object ta : (List)target) {
                v = _checkByMap(ta);
                if(!v.isSuccess()) {
                    break;
                }
            }
        }else{
            try {
                v = _checkByDto(target);
            } catch (ValidateException e) {
                v = new ValidateResult(false, e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
                v = new ValidateResult(false, e.getMessage());
            }
        }

        return v;
    }

    private ValidateResult _checkByMap(Object target){
        ValidateResult validateResult = new ValidateResult();
        Map<String,Object> targetMap = (Map) target;
        for (Map.Entry<String, ValidateChecker> iterMap : checkers.entrySet()) {
            ValidateChecker checker = iterMap.getValue();
            if(targetMap.get(iterMap.getKey()) != null){
                validateResult = checker.isValid(targetMap.get(iterMap.getKey()));
            }else{
                validateResult = new ValidateResult(false, "등록된 key가 없습니다.");
            }

            if (!validateResult.isSuccess()){
                validateResult.setMessage(String.format(validateResult.getMessage(), iterMap.getKey()));
                break;
            }
        }
        return validateResult;

    }

    private ValidateResult  _checkByDto(Object obj) throws Exception {
        ValidateResult validateResult = new ValidateResult();

        Class<?> clazz = obj.getClass();
        for (Map.Entry<String, ValidateChecker> iterMap : checkers.entrySet()) {
            ValidateChecker checker = iterMap.getValue();
            try {
            	String columNm = iterMap.getKey();
            	String columNmToCamelCase = columNm.substring(0, 1).toUpperCase()+columNm.substring(1); 
                Method getMethod = clazz.getDeclaredMethod("get" + columNmToCamelCase);
                Object returnValue = getMethod.invoke(obj);
                validateResult = checker.isValid(returnValue);
            }catch(NoSuchMethodException e) {
                throw new ValidateException(iterMap.getKey()+"는 존재하지 않습니다.");
            }
            if (!validateResult.isSuccess()){
                validateResult.setMessage(String.format(validateResult.getMessage(), iterMap.getKey()));
                break;
            }
        }


        return validateResult;
    }


}
