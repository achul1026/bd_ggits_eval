package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalBddCmp;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;

@Mapper
public interface EvalBddCmpMapper {
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 17.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 파일정보 저장
	  * @param evalFile
	  */
	public void save(EvalBddCmp evalBddCmp);
	
	/**
	  * @Method Name : deleteByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtInfoId
	  */
	public void deleteByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : deleteByBddCmpId
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 삭제
	 * @param bddCmpId
	 */
	public void deleteByBddCmpId(String bddCmpId);
	
	/**
	  * @Method Name : findAllJoinEvalShtByShtInfoId
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 업체명 평가지 정보 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<Map<String,Object>> findAllJoinEvalShtByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : findAllByShtInfoId
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 업체명 목록 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalBddCmp> findAllByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : findOneByBddCmpId
	 * @작성일 : 2023. 10. 20.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 업체명 정보 조회
	 * @param bddCmpId
	 * @return
	 */
	public EvalBddCmp findOneByBddCmpId(String bddCmpId);
	
	/**
	 * @Method Name : update
	 * @작성일 : 2023. 10. 20.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 업체명 정보 수정
	 * @param EvalBddCmp
	 * @return
	 */
	public void update(EvalBddCmp evalBddCmp);
	
	/**
	  * @Method Name : findAllBddCmpByShtInfoIdOrderByCmpNbr
	  * @작성일 : 2023. 10. 23.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 업체명 목록 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalBddCmp> findAllBddCmpByShtInfoIdOrderByCmpNbr(EvalShtInfo evalShtInfo);
	
	/**
	 * @Method Name : countAllBddCmpByShtInfoId
	 * @작성일 : 2023. 10. 20.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 업체명 정보 수정
	 * @param shtInfoId
	 * @return
	 */
	public int countAllBddCmpByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : findAllBddCmpByShtInfoIdOrderByCmpNbrGroupByBddCmpNm
	  * @작성일 : 2023. 10. 24.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 업체명 이름 목록 가져오기
	  * @param shtInfoId
	  * @return
	  */
	public EvalBddCmp findOneBddCmpByShtInfoIdOrderByCmpNbrGroupByBddCmpNm(String shtInfoId);
	
	/**
	  * @Method Name : findAllCmpInfoByShtInfoId
	  * @작성일 : 2023. 11. 03.
	  * @작성자 : KY.LEE
	  * @Method 설명 : 업체명 이름 목록 가져오기
	  * @param shtInfoId
	  * @return List<String>
	  */
	public List<String> findAllCmpInfoByShtInfoId(String shtInfoId);
	
}
