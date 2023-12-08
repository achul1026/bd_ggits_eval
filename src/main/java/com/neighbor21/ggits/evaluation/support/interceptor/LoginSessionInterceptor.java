package com.neighbor21.ggits.evaluation.support.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.neighbor21.ggits.evaluation.common.entity.EvalAdmin;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;
import com.neighbor21.ggits.evaluation.support.exception.NoLoginException;

public class LoginSessionInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		EvalAdmin evalAdmin = null;
		if (request.getSession() != null) {
			evalAdmin = (EvalAdmin) request.getSession().getAttribute("evalAdminInfo");
		}

		if (evalAdmin == null) {
			throw new NoLoginException(ErrorCode.NOT_FOUNT_USER_INFO);
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}
}
