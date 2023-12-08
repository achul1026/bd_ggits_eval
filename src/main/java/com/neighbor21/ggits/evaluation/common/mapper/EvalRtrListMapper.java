package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;

@Mapper
public interface EvalRtrListMapper {
	
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 리스트 정보 저장
	  * @param evalRtrList
	  */
	public void save(EvalRtrList evalRtrList);

	
	/**
	  * @Method Name : countAllByShtInfoId
	  * @작성일 : 2023. 10. 24.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 목록 개수 조회
	  * @param shtInfoId
	  * @return
	  */
	public int countAllByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : updateEvalCmpltByRtrIdAndShtInfoId
	  * @작성일 : 2023. 10. 30.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가자 목록 상태 변경
	  * @param evalRtrList
	  * @return
	  */
	public void updateEvalCmpltByRtrIdAndShtInfoId(EvalRtrList evalRtrList);
	
	/**
	 * @Method Name : countAllByShtInfoIdAndEvalCmplt
	 * @작성일 : 2023. 10. 30.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 목록 완료 상태 조회
	 * @param evalRtrList
	 * @return
	 */
	public int countAllByShtInfoIdAndEvalCmplt(EvalRtrList evalRtrList);
	
	/**
	 * @Method Name : findAllByShtInfoId
	 * @작성일 : 2023. 10. 30.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 전체 평가자 리스트 조회
	 * @param shtInfoId
	 * @return
	 */
	public List<Map<String,Object>> findAllByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : deleteByRtrListId
	 * @작성일 : 2023. 11. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 리스트에서 삭제
	 * @param rtrListId
	 * @return
	 */
	public void deleteByRtrListId(String rtrListId);
}
