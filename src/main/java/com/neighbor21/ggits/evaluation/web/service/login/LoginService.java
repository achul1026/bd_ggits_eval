package com.neighbor21.ggits.evaluation.web.service.login;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neighbor21.ggits.evaluation.common.entity.EvalAdmin;
import com.neighbor21.ggits.evaluation.common.mapper.EvalAdminMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.common.util.PasswordUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;

@Service
public class LoginService{
	
	@Autowired
	EvalAdminMapper evalAdminMapper;
	
	/** 
	 * @Method Name : findOneEvalAdminByUserId
	 * @작성일 : 2023. 10. 16
	 * @작성자 : IK.MOON
	 * @Method 설명 : 로그인 유저 존재 유무 체크
	 * @return
	 */
	public EvalAdmin findOneEvalAdminByUserId(EvalAdmin evalAdmin) {
		String userPw = evalAdmin.getUserPw();
		
		if(GgitsCommonUtils.isNull(userPw) || GgitsCommonUtils.isNull(evalAdmin.getUserId())) {
			throw new CommonException(ErrorCode.PARAMETER_DATA_NULL);
		}
		
		EvalAdmin evalAdminInfo = evalAdminMapper.findOneEvalAdminByUserId(evalAdmin);
		
		if(evalAdminInfo == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL, "유저 정보가 존재하지 않습니다.");
		}
		
		if(!PasswordUtils.checkPassword(userPw, evalAdminInfo.getUserPw())) {
			throw new CommonException(ErrorCode.PASSWORD_MISMATCH);
		}
		
		return evalAdminInfo;
	}
	
}
