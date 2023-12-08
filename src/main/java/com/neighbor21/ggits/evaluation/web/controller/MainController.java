package com.neighbor21.ggits.evaluation.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    /**
     * @Method Name : viewMain
     * @작성일 : 2023. 9. 20.
     * @작성자 : 82103
     * @Method 설명 : 로그인 화면
     * @return
     */
   @GetMapping("/main.do")
   public String viewMain(){
       return "main/main";
   }
   
}
