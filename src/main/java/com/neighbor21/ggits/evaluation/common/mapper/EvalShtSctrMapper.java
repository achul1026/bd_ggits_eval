package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtSctr;

@Mapper
public interface EvalShtSctrMapper {
	
	/**
	  * @Method Name : deleteByShtSctrId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtSctrId
	  */
	public void deleteByShtSctrId(String shtSctrId);
	
	/**
	  * @Method Name : findAllByShtId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 :	평가 내용 부문 목록 호출
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalShtSctr> findAllByShtId(String shtInfoId);
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @param evalSht
	  */
	public void save(EvalShtSctr evalShtSctr);
	
	/**
	 * @Method Name : update
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @param evalSht
	 */
	public void update(EvalShtSctr evalShtSctr);
}
