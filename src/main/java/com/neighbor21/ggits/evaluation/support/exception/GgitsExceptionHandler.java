package com.neighbor21.ggits.evaluation.support.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@ControllerAdvice
@RestControllerAdvice
public class GgitsExceptionHandler extends ResponseEntityExceptionHandler{
	
	@ExceptionHandler(value = Exception.class)
	public ModelAndView exceptionHandler(Exception e){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ErrorPage");
		mav.addObject("message", e.getMessage());
		return mav;
	}
	
	// LoginCheckException
	@ExceptionHandler(value = NoLoginException.class)
	public ModelAndView loginChkExceptionHandler(NoLoginException ne) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/login.do");
		return mav;
	}
	
	// customRuntimeException 
	@ExceptionHandler(value = CommonException.class)
	public ResponseEntity<ErrorResponse> adminExceptionHandler(CommonException ce, String message) {
		ErrorResponse response = new ErrorResponse(ce.getErrorCode());
		return new ResponseEntity<>(response, HttpStatus.valueOf(ce.getErrorCode().getCode()));
	}
	
	// NoRaterSessionException 
	@ExceptionHandler(value = NoRaterSessionException.class)
	public ModelAndView raterSessionChkExceptionHandler(NoRaterSessionException nrse) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/rater/code/check.do");
		return mav;
	}
}
