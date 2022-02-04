package edu.kh.mind.adminPro.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.mind.adminPro.model.service.AdminProService;
import edu.kh.mind.common.util.Util;
import edu.kh.mind.member.model.vo.Profession;

@Controller
@RequestMapping("adminPro/*")
@SessionAttributes({"loginPro"})
public class AdminProController {
	
	@Autowired
	private AdminProService service;

	//등록화면 연결
	@RequestMapping(value = "proLogin", method = RequestMethod.GET )
	public String proLogin() {
		
		return "adminPro/proLogin";
	}
	
	//등록화면 연결
	@RequestMapping(value = "proRegister", method = RequestMethod.GET )
	public String proRegister() {
		
		return "adminPro/proRegister";
	}
	
	@RequestMapping(value = "emailDupCheck", method=RequestMethod.GET)
	@ResponseBody
	public int emailDupCheck(String inputEmail) {
		
		//아이디 중복검사 Service 호출
		int result = service.idChk(inputEmail);
		
		return result;
	}
	
	
	//등록 & 이메일 인증
	@RequestMapping(value = "proRegister", method = RequestMethod.POST )
	public String proRegister(Profession profession, Model model, RedirectAttributes ra) throws Exception{
		
		service.proRegister(profession);
			
       return "redirect:adminPro/proLogin";
		
	}
	
    //이메일 인증 코드 검증
    @RequestMapping(value = "emailConfirm", method = RequestMethod.GET)
    public String emailConfirm(Profession profession, Model model, RedirectAttributes ra) { 
        
        Profession loginpro = new Profession();
        
        loginpro = service.chkAuth(profession);
        
        if(loginpro == null) {
            Util.swalSetMessage("다시 인증해주세요","","error", ra);;
            return "redirect:/";
        }else {
        	model.addAttribute("loginPro", loginpro);
        	return "adminPro/proRegisterDetail";
        }
    }
    

	
    //예외처리
	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e, Model model) {
		
		//Model : 데이터 전달용 객체(Map형식, request범위)
		
		model.addAttribute("errorMessage", "회원 관련 서비스 이용 중 문제가 발생했습니다.");
		model.addAttribute("e", e);
		
		return "/common/error";
	}
	
}
