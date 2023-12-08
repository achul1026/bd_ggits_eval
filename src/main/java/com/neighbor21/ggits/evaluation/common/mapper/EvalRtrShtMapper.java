package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;

@Mapper
public interface EvalRtrShtMapper {

	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가 작성 평가지 정보 저장
	  * @param evalRtrSht
	  */
	public void save(EvalRtrSht evalRtrSht);
	
	/**
	 * @Method Name : findAllRtrShtByShtInfoIdAndCmpId
	 * @작성일 : 2023. 10. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 작성 평가지 정보 조회
	 * @param rtrId, bddCmpId
	 */
	public List<EvalRtrSht> findAllRtrShtByRtrIdAndBddCmpId(@Param("rtrId") String rtrId,
			@Param("bddCmpId") String bddCmpId,
			@Param("shtType") String shtType);
	
	/**
	  * @Method Name : findAllJoinEvalShtByBddCmpIdAndRtrId
	  * @작성일 : 2023. 10. 25.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가자 > 평가지 조회
	  * @param evalRtrSht
	  */
	public List<EvalRtrSht> findAllJoinEvalShtByBddCmpIdAndRtrId (EvalRtrSht evalRtrSht);
	
	/**
	 * @Method Name : findAllRtrShtByRtrShtId
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 작성 평가지 정보 조회
	 * @param rtrShtId
	 */
	public List<EvalRtrSht> findAllRtrShtByRtrShtId(String rtrShtId);
	
	/**
	 * @Method Name : updateByRtrShtId
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 작성 평가지 정보 조회
	 * @param evalRtrSht
	 */
	public void updateShtSttsByRtrShtId(EvalRtrSht evalRtrSht);
	
	/**
	 * @Method Name : updateFileIdByRtrShtId
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 서명 파일 아이디 수정
	 * @param evalRtrSht
	 */
	public void updateFileIdByRtrShtId(EvalRtrSht evalRtrSht);
	
	/**
	 * @Method Name : countAllByRtrIdAndShtInfoIdAndShtStts
	 * @작성일 : 2023. 10. 30.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 작성 평가지 상태 조회
	 * @param shtInfoId, rtrId, shtStts
	 */
	public int countAllByRtrIdAndShtInfoIdAndShtStts(@Param("shtInfoId")String shtInfoId,
													@Param("rtrId")String rtrId,
													@Param("shtStts")String shtStts);
	
	/**
	 * @Method Name : countByShtSttsCdAndBddCmpIdList
	 * @작성일 : 2023. 11 03.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 작성 평가지 상태 카운트 조회
	 * @param rtrId, shtStts , bddCmpList
	 */
	public int counAllByshtTypeAndShtInfoIdAndRtrIdAndShtStts(@Param("shtType")String shtType,
															@Param("shtInfoId")String shtInfoId,
															@Param("rtrId")String rtrId,
															@Param("shtStts")String shtStts);
	
	/**
	 * @Method Name : findAllJoinEvalShtByRtrIdAndShtInfoId
	 * @작성일 : 2023. 11 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 작성 평가지 조회
	 * @param rtrId, shtInfoId
	 */
	public List<EvalRtrSht> findAllJoinEvalShtByRtrIdAndShtInfoId(
													@Param("rtrId")String rtrId,
													@Param("shtInfoId")String shtInfoId);
	
	/**
	 * @Method Name : findAllJoinEvalShtByShtTypeAndBddCmpIdAndShtInfoId
	 * @작성일 : 2023. 11 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 작성 평가지 조회
	 * @param rtrId, shtInfoId
	 */
	public List<EvalRtrSht> findAllJoinEvalShtByShtTypeAndBddCmpIdAndShtInfoId(
			@Param("shtType")String shtType,
			@Param("bddCmpId")String bddCmpId,
			@Param("shtInfoId")String shtInfoId);
	
	/**
	 * @Method Name : findAllJoinEvalShtByRtrIdAndShtInfoId
	 * @작성일 : 2023. 11 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 작성 평가지 조회
	 * @param evalRtrSht
	 */
	public void deleteByRtrShtId(EvalRtrSht evalRtrSht);
	
	/**
	  * @Method Name : deleteByBddCmpId
	  * @작성일 : 2023. 11. 9.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 평가지 삭제 
	  * @param bddCmpId
	  */
	public void deleteByBddCmpId(String bddCmpId);
}
