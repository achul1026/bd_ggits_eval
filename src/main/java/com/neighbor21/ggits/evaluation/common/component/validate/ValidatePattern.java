package com.neighbor21.ggits.evaluation.common.component.validate;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  ValidatePattern
 * @since : 2023-08-31
 */
public interface ValidatePattern {
    public static String ONLY_NUM = "^[0-9]*$";
    public static String ONLY_ENG = "^[a-zA-Z]*$";
    public static String ONLY_KOR = "^[가-힣]*$";
    public static String EMAIL = "\\w+@\\w+\\.\\w+(\\.\\w+)?";
    public static String TEL = "^\\d{2,3}-\\d{3,4}-\\d{4}$";
    public static String PHONE = "^01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$";
    public static String PASSWORD = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$";
    public static String DATE = "^\\d{4}-\\d{2}-\\d{2}$";
    


}
