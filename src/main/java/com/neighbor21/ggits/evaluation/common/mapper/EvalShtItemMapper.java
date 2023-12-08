package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalShtItem;

@Mapper
public interface EvalShtItemMapper {
	
	/**
	  * @Method Name : findAllByShtSctrId
	  * @작성일 : 2023. 10. 24.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 항목 목록 호출
	  * @param shtSctrId
	  * @return
	  */
	public List<EvalShtItem> findAllByShtSctrId(String shtSctrId); 
	
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 24.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가 항목 저장
	  * @param evalShtItem
	  */
	public void save(EvalShtItem evalShtItem);
	
	/**
	 * @Method Name : save
	 * @작성일 : 2023. 10. 24.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가 항목 수정
	 * @param evalShtItem
	 */
	public void update(EvalShtItem evalShtItem);
	
	/**
	  * @Method Name : deleteByShtItmId
	  * @작성일 : 2023. 10. 25.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 항목 삭제
	  * @param shtItmId
	  */
	public void deleteByShtItmId(String shtItmId);
}
