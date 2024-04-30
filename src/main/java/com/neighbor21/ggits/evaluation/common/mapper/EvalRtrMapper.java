package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;

@Mapper
public interface EvalRtrMapper {
	
	/**
	  * @Method Name : findAllRtrByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가자 리스트 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalRtr> findAllRtrByShtInfoId(String shtInfoId);

	/**
	  * @Method Name : findAllJoinEvalRtrListByShtInfoId
	  * @작성일 : 2023. 10. 27.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 등록된 평가자 목록 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalRtr> findAllJoinEvalRtrList(EvalRtrList evalRtrListInfo);
	
	/**
	 * @Method Name : findOneRtrByBirtDt
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 생년월일 일치 확인
	 * @param rtrBrthDt
	 * @return
	 */
	public EvalRtr findOneRtrByBirtDtAndShtInfoId(EvalRtr evalRtr);
	
	/**
	  * @Method Name : findAll
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 목록 조회
	  * @param evalRtr
	  * @return
	  */
	public List<EvalRtr> findAll(EvalRtr evalRtr);
	
	/**
	  * @Method Name : countAll
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 목록 개수 조회
	  * @param evalRtr
	  * @return
	  */
	public int countAll(EvalRtr evalRtr);
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 12. 5.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 작성자 정보 저장
	  * @param evalRtr
	  */
	public void save(EvalRtr evalRtr);
	
	/**
	  * @Method Name : update
	  * @작성일 : 2023. 12. 5.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 작성자 정보 수정
	  * @param evalRtr
	  */
	public void update(EvalRtr evalRtr);
	
	/**
	  * @Method Name : findOneEvalRtrDuplChk
	  * @작성일 : 2023. 12. 7.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 중복 체크
	  * @param evalRtr
	  * @return
	  */
	public int findOneEvalRtrDuplChk(EvalRtr evalRtr);
	
	public String findOneRtrAgncyByRtrId(String rtrId);
}
