package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalMaxMinScrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalResultHeaderInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalResultRtrInfo;
import com.neighbor21.ggits.evaluation.common.entity.EvalSht;

@Mapper
public interface EvalShtMapper {
	
	/**
	  * @Method Name : deleteByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtInfoId
	  */
	public void deleteByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : findAllByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 목록 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalSht> findAllByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : findAllJoinEvalShtInfoByShtInfoId
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 > 평가지 조회
	 * @param shtInfoId
	 * @return
	 */
	public List<EvalSht> findAllJoinEvalShtInfoByShtInfoId(String shtInfoId);
	
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @param evalSht
	  */
	public void save(EvalSht evalSht);
	
	/**
	  * @Method Name : countByShtInfoIdAndShtType
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 개수 조회
	  * @param ShtInfoId
	  * @param ShtType
	  * @return
	  */
	public int countByShtInfoIdAndShtType(EvalSht evalSht);
	
	
	/**
	  * @Method Name : findOneShtExistCheck
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 타입 체크(존재하지 않으면 : BOTH_EMPTY, 정량적 평가지 존재하면 : QLT_EMPTY, 정상적 평가지 존재하면 : QNT_EMPTY, 앞 조건에 해당하지않으면 :BOTH_EXIST)
	  * @param shtInfoId
	  * @return
	  */
	public String findOneShtExistCheck(String shtInfoId);
	
	/**
	  * @Method Name : findOneByShtInfoIdAndShtType
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정성적 평가 목록 호출
	  * @param evalSht
	  * @return
	  */
	public EvalSht findOneByShtInfoIdAndShtType(EvalSht evalSht);
	
	/**
	  * @Method Name : findOneRsultHeaderInfoByShtInfoIdAndShtId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 결과 header (회사명 / 평균 / 합계 / 최고 / 최저 ) 정보 조회
	  * @param Map<String,Object)
	  * @return
	  */
	public EvalResultHeaderInfo findOneRsultHeaderInfoByShtInfoIdAndShtId(Map<String,Object> map);

	/**
	  * @Method Name : findOneMaxMinRtrId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 최대 값 / 최소 값 정보 조회
	  * @param Map<String,Object)
	  * @return
	  */
	public EvalMaxMinScrInfo findOneMaxMinRtrId(String shtId);
	
	/**
	  * @Method Name : findAllRsultRtrScrInfoByShtInfoIdAndShtId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 결과 (평가자 / 점수)
	  * @param Map<String,Object)
	  * @return
	  */
	public List<EvalResultRtrInfo> findAllRsultRtrScrInfoByShtInfoIdAndShtId(Map<String,Object> map);
	
}
