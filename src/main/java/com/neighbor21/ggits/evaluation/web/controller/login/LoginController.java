package com.neighbor21.ggits.evaluation.web.controller.login;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neighbor21.ggits.evaluation.common.component.validate.ValidateBuilder;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateChecker;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateResult;
import com.neighbor21.ggits.evaluation.common.entity.CommonResponse;
import com.neighbor21.ggits.evaluation.common.entity.EvalAdmin;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.mapper.EvalAdminMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.common.util.PasswordUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;
import com.neighbor21.ggits.evaluation.web.service.login.LoginService;

@Controller
public class LoginController {

	@Autowired
	LoginService loginService;

	@Autowired
	EvalAdminMapper evalAdminMapper;

	/**
	 * @Method Name : viewLogin
	 * @작성일 : 2023. 8. 22.
	 * @작성자 : 82103
	 * @Method 설명 : 로그인 화면
	 * @return
	 */
	@GetMapping("/login.do")
	public String viewLogin() {
		return "login/login";

	}

	/**
	 * @Method Name : LoginProc
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 로그인 로직 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/login.ajax")
	public @ResponseBody CommonResponse<?> loginAjax(EvalAdmin evalAdmin, HttpSession session) {

		ValidateBuilder dtoValidator = new ValidateBuilder(evalAdmin);
		dtoValidator.addRule("userId", new ValidateChecker().setRequired()).addRule("userPw",
				new ValidateChecker().setRequired());

		ValidateResult dtoValidateResult = dtoValidator.isValid();

		if (!dtoValidateResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidateResult.getMessage());
		}

		try {
			EvalAdmin evalAdminInfo = loginService.findOneEvalAdminByUserId(evalAdmin);

			if (evalAdminInfo != null) {
				session.setAttribute("evalAdminInfo", evalAdminInfo);
				// 세션 유지 시간 최대 30분
				session.setMaxInactiveInterval(1800);
			}
		} catch (Exception e) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, e.getMessage());
		}

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "로그인 성공");
	}

	/**
	 * @Method Name : viewJoinUs
	 * @작성일 : 2023. 11. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 관리자 계정 생성 페이지 이동
	 * @return : String
	 */
	@GetMapping("/admin/joinUs.do")
	public String viewJoinUs() {

		if (evalAdminMapper.countAll() > 0) {
			return "login/login";
		}

		return "login/joinUs";
	}

	/**
	 * @Method Name : adminSave
	 * @작성일 : 2023. 11. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 관리자 계정 생성 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/admin/save.ajax")
	public @ResponseBody CommonResponse<?> adminSave(EvalAdmin evalAdmin) {

		ValidateBuilder dtoValidator = new ValidateBuilder(evalAdmin);
		dtoValidator.addRule("userId", new ValidateChecker().setRequired()).addRule("userPw",
				new ValidateChecker().setRequired());

		ValidateResult dtoValidateResult = dtoValidator.isValid();

		if (!dtoValidateResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidateResult.getMessage());
		}

		try {
			String adminId = GgitsCommonUtils.getUuid();
			String userPw = PasswordUtils.hashPassword(evalAdmin.getUserPw());

			evalAdmin.setAdminId(adminId);
			evalAdmin.setUserPw(userPw);

			evalAdminMapper.save(evalAdmin);

		} catch (Exception e) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, e.getMessage());
		}

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "어드민 정보가 등록되었습니다.");
	}

	/**
	 * @Method Name : adminSave
	 * @작성일 : 2023. 11. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 관리자 계정 생성 Ajax
	 * @return : CommonResponse
	 */
	@GetMapping("/logout.ajax")
	public @ResponseBody CommonResponse<?> logout(HttpSession session,
			@RequestParam(name = "user", required = true) String user) {

		if (user.equals("admin")) {
			try {
				EvalAdmin evalAdminInfo = (EvalAdmin) session.getAttribute("evalAdminInfo");

				if (evalAdminInfo != null) {
					session.invalidate();
				}

			} catch (CommonException e) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, e.getMessage());
			}
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "");

		} else {
			try {
				EvalRtr evalRtrInfo = (EvalRtr) session.getAttribute("rtrInfoSession");

				if (evalRtrInfo != null) {
					session.invalidate();
				}

			} catch (CommonException e) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, e.getMessage());
			}
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "");
		}

	}
}
