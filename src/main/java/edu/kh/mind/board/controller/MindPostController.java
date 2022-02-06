package edu.kh.mind.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.kh.mind.board.model.service.MindPostService;
import edu.kh.mind.board.model.vo.MindPost;
import edu.kh.mind.board.model.vo.Pagination;
import edu.kh.mind.common.util.Util;
import edu.kh.mind.member.model.vo.Member;

@Controller
@RequestMapping("/post/*")
@SessionAttributes({"loginMember"})
public class MindPostController {

	@Autowired
    private MindPostService service;

	
	//목록
    @RequestMapping("list")
    public String MindPostList( @RequestParam(value="cp", required=false, defaultValue="1") int cp
    							,Model model) {
    	
    	Pagination pagination = service.getPagination(cp);
    	
    	List<MindPost> postList = service.selectPostList(pagination);
    	
    	model.addAttribute("pagination", pagination);
    	model.addAttribute("postList", postList);
    	model.addAttribute("css", "board/mindPost");
    	model.addAttribute("header", "community");
    	 
        return "board/mindPost";
    }
    
    
    // 글 작성 
    @RequestMapping(value="insert", method=RequestMethod.POST)
    public String postInsert(MindPost post, 
    		//@ModelAttribute("loginMember") Member loginMember,
    		RedirectAttributes ra) {
    	
    	post.setMemberNo(60);
    	
    	int postNo = service.insertPost(post);
    	
    	String title;
		String icon;
		
    	if(postNo > 0) { 
    			title="연구 성공!";
				icon = "success";
    		}else {
    			title="연구 실패";
 				icon = "error";
    		}
    	
    		ra.addFlashAttribute("title", title);
			ra.addFlashAttribute("icon", icon);
		
    	return "redirect:/post/list";
    }
    
    
   /* //상세조회
    @RequestMapping("view/{postNo}")
	public String selectPost(@PathVariable("postNo") int postNo,
							@RequestParam(value="cp", required=false, defaultValue="1")int cp,
							Model model, RedirectAttributes ra, HttpSession session) {
		
		int memberNo = 0;
		
		if(session.getAttribute("loginMember") != null) {
			memberNo = ( (Member)session.getAttribute("loginMember") ).getMemberNo();
		}
		
		MindPost post = service.selectPost(postNo, memberNo);
		
		String path = null;
		if(post != null) { 
			
			model.addAttribute("post", post);
	    	model.addAttribute("css", "board/mindPost");
	    	model.addAttribute("css", "popup");
			path = "popup/studyView";
			
		}else { 
			
			Util.swalSetMessage("해당 글이 존재하지 않습니다.", null, "info", ra);
			path = "redirect:../list";
			
		}
		
		return path;
	}*/



}
