package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtrItemScr;

@Mapper
public interface EvalRtrItemScrMapper {
	
	/**
	 * @Method Name : findAllRtrItemScrJoinRtrShtByRtrShtId
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 작성 평가지 정보 조회
	 * @param rtrShtId
	 */
	public List<EvalRtrItemScr> findAllRtrItemScrJoinRtrShtByRtrShtId(String rtrShtId);
	
	public List<EvalRtrItemScr> findAllRtrItemScrJoinRtrShtAndEvalShtByRtrIdAndShtInfoId(@Param("shtInfoId") String shtInfoId
																			, @Param("rtrId") String rtrId
																			, @Param("shtType") String shtType);
	
	
	/**
	 * @Method Name : update
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 평가점수 저장
	 * @param evalRtrItemScr
	 */
	public void save(EvalRtrItemScr evalRtrItemScr);
	
	/**
	 * @Method Name : update
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 평가점수 업데이트
	 * @param evalRtrItemScr
	 */
	public void update(EvalRtrItemScr evalRtrItemScr);
	
	/**
	 * @Method Name : findTotalScrByRtrShtId
	 * @작성일 : 2023. 12. 18.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 완료 한 최종 평가 점수 조회
	 * @param rtrShtId
	 */
	public float findTotalScrByRtrShtId(String rtrShtId);
	
	
	
}
