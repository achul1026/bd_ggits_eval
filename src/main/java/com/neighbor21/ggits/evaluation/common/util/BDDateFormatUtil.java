package com.neighbor21.ggits.evaluation.common.util;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

import org.apache.commons.lang3.time.DateFormatUtils;

/**
 * 설명
 *
 * @author : Charles Kim
 * @fileName :  BDDateFormatUtil
 * @since : 2023-08-31
 */
public class BDDateFormatUtil extends DateFormatUtils {
	/**
	  * @Method Name : isNow
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : KC.KIM
	  * @Method 설명 : 현재 날짜 구하기(LocalDate 반환)
	  * @param 
	  * @return LocalDate
	  */
	public static LocalDate isNow() {
		LocalDate now = LocalDate.now();
		return now;
	}
	
	/**
	  * @Method Name : isNowStr
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : KC.KIM
	  * @Method 설명 : 현재 날짜 구하기(String 반환)
	  * @param pattern
	  * @return String
	  */
	public static String isNowStr(String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		Date now = new Date();
		
		return sdf.format(now);
	}
}
