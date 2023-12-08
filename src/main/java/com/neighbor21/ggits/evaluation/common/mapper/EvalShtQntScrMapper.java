package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtQntScr;

@Mapper
public interface EvalShtQntScrMapper {
	
	
	/**
	  * @Method Name : deleteByShtSctrId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtSctrId
	  */
	public void deleteByShtItmId(String shtItmId);
	

	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @param evalSht
	  */
	public void save(EvalShtQntScr evalShtQntScr);
	
	/**
	 * @Method Name : save
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @param evalSht
	 */
	public void update(EvalShtQntScr evalShtQntScr);
	
	/**
	  * @Method Name : findAllByShtSctrId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정량적 평가 배점 목록 조회
	  * @param shtSctrId
	  * @return
	  */
	public List<EvalShtQntScr> findAllByShtItmId(String shtItmId);
	
	/**
	  * @Method Name : findOneByShtSctrId
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 정성적 평가지 배점 정보 조회
	  * @param shtSctrId
	  * @return
	  */
	public EvalShtQntScr findOneByShtItmId(String shtSctrId);
}
