package com.neighbor21.ggits.evaluation.common.mapper;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalAdmin;

@Mapper
public interface EvalAdminMapper {

	/**
	 * @Method Name : findOneEvalAdminByUserId
	 * @작성일 : 2023. 10. 16.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 유저 정보 조회 (이메일 , 비밀번호)
	 * @param evalAdmin
	 */
	public EvalAdmin findOneEvalAdminByUserId(EvalAdmin evalAdmin);

	/**
	 * @Method Name : countAll
	 * @작성일 : 2023. 11. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 관리자 계정 카운트 조회
	 * @param evalAdmin
	 */
	public int countAll();
	
	/**
	 * @Method Name : save
	 * @작성일 : 2023. 11. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 관리자 계정 생성(최초 1회)
	 * @param evalAdmin
	 */
	public void save(EvalAdmin evalAdmin);
	
}
