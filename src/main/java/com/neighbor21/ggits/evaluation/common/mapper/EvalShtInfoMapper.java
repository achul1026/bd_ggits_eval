package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;

@Mapper
public interface EvalShtInfoMapper {
	
	/**
	 * @Method Name : insertEvalShtInfo
	 * @작성일 : 2023. 10. 17.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 정보 입력
	 * @param evalShtInfo
	 */
	public void save(EvalShtInfo evalShtInfo);
	
	/**
	 * @Method Name : updateEvalShtInfo
	 * @작성일 : 2023. 10. 17.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 정보 수정
	 * @param evalShtInfo
	 */
	public void update(EvalShtInfo evalShtInfo);
	
	
	/**
	  * @Method Name : findOneByShtInfoId
	  * @작성일 : 2023. 10. 18.
	  * @작성자 : NK.KIM
	  * @Method 설명 :	평가지 정보 조회
	  * @param shtInfoId
	  * @return
	  */
	public EvalShtInfo findOneByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : findAll
	 * @작성일 : 2023. 10. 18.
	 * @작성자 : NK.KIM
	 * @Method 설명 :	평가지 목록 조회
	 * @param shtInfoId
	 * @return
	 */
	public List<EvalShtInfo> findAll(EvalShtInfo evalShtInfo);
	
	/**
	 * @Method Name : countAll
	 * @작성일 : 2023. 10. 18.
	 * @작성자 : NK.KIM
	 * @Method 설명 :	평가지 목록 개수 조회
	 * @param shtInfoId
	 * @return
	 */
	public int countAll(EvalShtInfo evalShtInfo);
	
	/**
	  * @Method Name : deleteByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtInfoId
	  */
	public void deleteByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : findOneShtInfoByAccssCd
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : IK.MOON
	  * @Method 설명 :	평가지 정보 조회
	  * @param accssCd
	  * @return
	  */
	public EvalShtInfo findOneShtInfoByAccssCd(String accssCd);
	
	/**
	 * @Method Name : findOneShtInfoByShtInfoId
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 :	평가지 정보 조회
	 * @param shtInfoId
	 * @return
	 */
	public EvalShtInfo findOneShtInfoByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : countAllForShtAllStts
	  * @작성일 : 2023. 10. 25.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 목록 상태별 카운팅 정보
	  * @return
	  */
	public Map<String,Object> countAllForShtAllStts();
	
	/**
	  * @Method Name : countByAccssCode
	  * @작성일 : 2023. 10. 26.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 참여코드 중복 체크
	  * @param accssCd
	  * @return
	  */
	public int countByAccssCode(String accssCd);
	
	/**
	 * @Method Name : countAllByShtInfoIdAndShtAllStts
	 * @작성일 : 2023. 10. 30.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 상태 카운팅
	 * @param evalShtInfo
	 */
	public int countAllByShtInfoIdAndShtAllStts(EvalShtInfo evalShtInfo);
	
	/**
	 * @Method Name : updateShtAllSttsByshtInfoId
	 * @작성일 : 2023. 10. 30.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 정보 상태 업데이트
	 * @param evalShtInfo
	 */
	public void updateShtAllSttsByshtInfoId(EvalShtInfo evalShtInfo);
	
}
