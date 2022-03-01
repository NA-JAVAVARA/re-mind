package edu.kh.mind.generalManager;

import com.google.gson.Gson;
import edu.kh.mind.common.util.Util;
import edu.kh.mind.member.model.service.LoginService;
import edu.kh.mind.member.model.vo.Member;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("generalManager/*")
@SessionAttributes({"loginMember"})
public class GMController {

    @Autowired
    private LoginService service;

    @GetMapping("gm")
    public String generalManager(@ModelAttribute("loginMember") Member loginMember,
                                 RedirectAttributes ra, HttpSession session){

        String path = "redirect:/";
        int result = 0;

        if(session.getAttribute("loginMember") != null){
            result = service.selectAuthority(loginMember.getMemberNo());

            if(result == 9){
                path = "generalManager/gm";
            }else{
                Util.swalSetMessage("권한이 없습니다.", null, "error", ra);
            }
        }else{
            // 왜 에러나는거지...
            Util.swalSetMessage("로그인 후 이용해주시기 바랍니다.", null, "error", ra);
        }
        return path;
    }

    @GetMapping("getGmMember")
    @ResponseBody
    public String getGmMember(){
        List<Member> mList = service.selectMember();
        for(Member m : mList){
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일");
            m.setMemberDate(sdf.format(m.getMemberEnrollDate()));
        }
        return new Gson().toJson(mList);
    }

    @PostMapping("isPrime")
    @ResponseBody
    public int isPrime(@RequestParam Map<String, Integer> map){
        return service.isPrime(map);
    }
}
