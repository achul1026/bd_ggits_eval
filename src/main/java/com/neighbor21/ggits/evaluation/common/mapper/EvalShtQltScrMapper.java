package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtQltScr;

@Mapper
public interface EvalShtQltScrMapper {
	
	/**
	  * @Method Name : deleteByShtItmId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtSctrId
	  */
	public void deleteByShtItmId(String shtItmId);
	
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정성적 평가 배점 정보 저장
	  * @param evalShtQltScr
	  */
	public void save(EvalShtQltScr evalShtQltScr);

	/**
	  * @Method Name : update
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정성적 평가 배점 정보 수정
	  * @param evalShtQltScr
	  */
	public void update(EvalShtQltScr evalShtQltScr);
	
	
	/**
	  * @Method Name : findOneByShtSctrId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정성적 평가지 배점 정보 조회
	  * @param shtSctrId
	  * @return
	  */
	public EvalShtQltScr findOneByShtItmId(String shtSctrId);
	
	/**
	  * @Method Name : findAllByShtSctrId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정량적 평가 배점 목록 조회
	  * @param shtSctrId
	  * @return
	  */
	public List<EvalShtQltScr> findAllByShtItmId(String shtItmId);
}
