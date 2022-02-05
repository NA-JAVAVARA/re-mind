package edu.kh.mind.member.controller;

import edu.kh.mind.member.model.service.LoginService;
import edu.kh.mind.member.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/emailLogin/*")
@SessionAttributes({"loginMember"})
public class EmailLoginController {

    @Autowired
    private LoginService service;

    // 이메일 로그인
    @RequestMapping(value="emailLogin", method = RequestMethod.POST)
    public String emailLogin(Member member, RedirectAttributes ra, Model model) {

        Member loginMember = service.emailLogin(member);

        if (loginMember != null) {
            model.addAttribute("loginMember", loginMember);
        } else {
            ra.addFlashAttribute("message", "아이디 또는 비밀번호를 확인해 주세요.");
        }

        return "redirect:/";
    }

    // 로그아웃
    @RequestMapping("logout")
    public String logout(SessionStatus status) {
        status.setComplete();

        return "redirect:/";
    }
}
