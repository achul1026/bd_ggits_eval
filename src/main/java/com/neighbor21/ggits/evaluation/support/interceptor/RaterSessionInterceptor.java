package com.neighbor21.ggits.evaluation.support.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;
import com.neighbor21.ggits.evaluation.support.exception.NoRaterSessionException;

public class RaterSessionInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		EvalRtr rtrInfoSession = null;

		if (request.getSession() != null) {
			rtrInfoSession = (EvalRtr) request.getSession().getAttribute("rtrInfoSession");
		}

		if (rtrInfoSession == null) {
			throw new NoRaterSessionException(ErrorCode.SESSION_NOT_FOUND);
		}
		return true;
	}
	
}
