package com.neighbor21.ggits.evaluation.common.util;

import org.apache.commons.lang3.StringUtils;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  BDStringUtil
 * @since : 2023-08-31
 */
public class BDStringUtil extends StringUtils {

    public static boolean isEmail(){
        return true;
    }

    public static boolean isHp(){

        return true;
    }

    /**
     * String null || ""
     *
     * @param str the str
     * @return the boolean
     */
    public static boolean isNull(String str) {
        return StringUtils.isEmpty(str);
    }


}
