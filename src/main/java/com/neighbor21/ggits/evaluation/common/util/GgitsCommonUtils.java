package com.neighbor21.ggits.evaluation.common.util;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;
import java.util.UUID;

public class GgitsCommonUtils {

	private GgitsCommonUtils() {};
	
	
	/**
	  * @Method Name : getUuid
	  * @작성일 : 2023. 9. 11.
	  * @작성자 : KY.LEE
	  * @Method 설명 : UUID 생성
	  * @param paramVal
	  * @return String
	  */
	public static String getUuid() {
		String uuid = UUID.randomUUID().toString().replaceAll("-", "");
		return uuid;
	}
	
	/**
	  * @Method Name : isNull
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : 82103
	  * @Method 설명 : Null Check
	  * @param paramVal
	  * @return boolean
	  */
	public static boolean isNull(Object paramVal) {
		boolean result = false;
		if("".equals(paramVal) || paramVal == null) {
			result = true;
		}
		return result;
	}
	
	/**
	  * @Method Name : phoneNumAddHyphen
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : KC.KIM
	  * @Method 설명 : 휴대전화번호 하이픈 추가
	  * @param 
	  * @return number
	  */
	public static String phoneNumAddHyphen(String number) {
		  if(GgitsCommonUtils.isNull(number)) {
			  return "";
		  }
	      String regEx = "(\\d{3})(\\d{3,4})(\\d{4})";
	      return number.replaceAll(regEx, "$1-$2-$3");
	}
	
	/**
	  * @Method Name : removeHyphen
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : KC.KIM
	  * @Method 설명 : removeHyphen
	  * @param 
	  * @return number
	  */
	public static String removeHyphen(String str) {
		  if(GgitsCommonUtils.isNull(str)) {
			  return "";
		  }
	      return str.replace("-", "");
	}

	/**
	  * @Method Name : removeHyphen
	  * @작성일 : 2023. 8. 22.
	  * @작성자 : KC.KIM
	  * @Method 설명 : removeHyphen
	  * @param 
	  * @return number
	  */
	public static String dateToDatetimeStr(String date, String type) {
		if(!GgitsCommonUtils.isNull(date)) {
			String result = "";
			switch (type) {
			case "startDate":
				result = date + " 00:00:01";
				break;
			case "endDate":
				result = date + " 23:59:59";
				break;
			}
			
			return result;
		  }
		return null;
	}
	
	
	
	 public static Object getData(Class<?> clazz,String methodName) throws Exception {
		 	
//	        Class<?> clazz = obj.getClass();
	        Object returnValue = new Object();
	        Object test = new Object();
            try {
                Method getMethod = clazz.getDeclaredMethod(methodName);
                returnValue = getMethod.invoke(clazz.newInstance());
            }catch(NoSuchMethodException e) {
            	System.out.println(e.getMessage());
//                throw new ValidateException(iterMap.getKey()+"는 존재하지 않습니다.");
            }

	        return returnValue;
	    }
	 
	//인증키 생성
	public static String getRandomKey(int key_len) {
		Random rnd = new Random();
		StringBuffer buf = new StringBuffer();
		for (int i = 1; i <= key_len; i++) {
			if (rnd.nextBoolean())
				buf.append((char) (rnd.nextInt(26) + 65)); // 0~25(26개) + 65
			else
				buf.append(rnd.nextInt(10));
		}
		return buf.toString();
	}
	
	public static List<String> stringArrayToList(String[] strArr){
        List<String> list = new ArrayList<String>();
		if(strArr.length > 0) {
			list = Arrays.asList(strArr);
		}
		return list;
	}
}
