package edu.kh.mind.board.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

import edu.kh.mind.board.model.service.BoardService;
import edu.kh.mind.board.model.service.ReplyService;
import edu.kh.mind.board.model.vo.Board;
import edu.kh.mind.board.model.vo.Empathy;
import edu.kh.mind.board.model.vo.Image;
import edu.kh.mind.board.model.vo.Reply;
import edu.kh.mind.board.model.vo.Report;
import edu.kh.mind.board.model.vo.Scrap;
import edu.kh.mind.common.util.Util;
import edu.kh.mind.member.model.vo.Member;

@Controller
@RequestMapping("/free/*")
@SessionAttributes({"loginMember"})
public class FreeBoardController {

	@Autowired
    private BoardService service;
	
	@Autowired
	private ReplyService rService;
	//-------- 모바일 댓글창 --------------
	
	@RequestMapping("mobileComment")
    public String mobileCommentView(Model model) {
    	
    	model.addAttribute("css", "board/mobileComment"); //각 페이지 css 추가 태그 
    	model.addAttribute("header", "main"); //헤더구분 사이드메뉴가 없는 페이지일 경우 main작성  
    	 
        return "board/mobileComment";
    }

	//--------------자유게시판--------------------
	
	
    //게시판 리스트 연결
	@ResponseBody
	@RequestMapping(value = "list", method = RequestMethod.POST)
    public Map<String, String>  freeBoardList(@RequestParam Map<String, String> param, HttpSession session) {
		
		
		if(session.getAttribute("loginMember") != null) {
			param.put("memberNo",((Member)session.getAttribute("loginMember")).getMemberNo()+"");
		}
		
		Map<String, String> map = new HashMap<>();
		
    	List<Board> freeBoardList = service.selectBoardList(param);
    	System.out.println(freeBoardList.size());

    	//map.put("freeBoardList", freeBoardList);
    	int listCount = service.countFreeList();
    	map.put("listCount", listCount+"");
    	
    	String gson = new Gson().toJson(freeBoardList);
    	map.put("result", gson);
    	
    	
        return  map;
    }
    
	//게시판 글작성,게시판 페이지 연결
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public String freeBoardinsert(Model model) {
    	
    	model.addAttribute("css", "board/freeList");
    	model.addAttribute("header", "community");
    	
    	return "free/insert";
	}
	
	// 글작성 기능 
	@ResponseBody
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public int freeBoardInsert(Model model, @ModelAttribute("loginMember") Member loginMember, 
			@RequestPart(value = "images",required = false) List<MultipartFile> images,  HttpSession session,
			Board board, String contentFiles) throws Exception {

		board.setMemberNo(loginMember.getMemberNo());

		//웹 접근경로(web path), 서버 저장경로(serverPath)
		String webPath = "/resources/images/board/";
		String serverPath= session.getServletContext().getRealPath(webPath);

		//게시글 작성 후 상세 조회(DB에 입력된 게시글)할 boardNo
		int result = service.insertFreeBoard(board, images, webPath, serverPath);
		
		return result;
	}
	
	
    //게시판 상세조회
    @RequestMapping("view/{boardNo}")
    public String SecretView(Model model, 
    							@PathVariable("boardNo") int boardNo,
    							RedirectAttributes ra, 
    							HttpSession session) {
    	model.addAttribute("css", "board/freeView");
    	model.addAttribute("header", "community");
    	
    	int memberNo = 0;
    	
		if(session.getAttribute("loginMember") != null) {
			memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();
		}
    	
		Board board = service.selectBoard(boardNo, memberNo);
		
    	if(board != null) {
    		// 댓글 
    		List<Reply> rList = rService.selectList(boardNo);
    		
    		Map<String, Integer> empathyMap = new HashMap<>();
            if (board.getWorryEmpathyArray() != null) {
                String empathyArr[] = board.getWorryEmpathyArray().split(",");
                String cntArr[] = board.getWorryCntArray().split(",");


                for (int i=1001; i<1006; i++) {
                    String keyStr = Integer.toString(i);
                    System.out.println("keyStr : " + keyStr);


                    int key = Arrays.asList(empathyArr).indexOf(keyStr);
                    System.out.println("key : " + key);
                    

                    if (key >= 0) {
                        empathyMap.put(keyStr, Integer.valueOf(cntArr[key]));
                    } else {
                        empathyMap.put(keyStr, 0);
                    }
                } 
            }
            System.out.println(empathyMap);
    		model.addAttribute("rList", rList);
    		model.addAttribute("board", board);
    		model.addAttribute("empathyMap", empathyMap);
    		return "free/view";
    		
    	}else {
    		return "redirect:";
    	}
    	
    }
    
    //게시판 글수정 화면 전환

    //게시판 글수정 화면 전환
    @RequestMapping(value="updateForm")
    public String freeBoardUpdate(int boardNo, Model model) {
    	model.addAttribute("css", "board/update");
    	model.addAttribute("header", "community");
    	
    	Board board = service.selectBoard(boardNo);
    	model.addAttribute("board", board);
    	return "free/update";
    }
	// 수정
    
    @RequestMapping(value="update", method=RequestMethod.POST)
    public String secretUpdate(Model model, Board board,
						RedirectAttributes ra, HttpSession session, @ModelAttribute("loginMember") Member loginMember) {
    	
    			// 2) 게시글 수정 Service 호출 
    			board.setMemberNo(loginMember.getMemberNo());
    			int result = service.updateBoard(board);
    			
    			String path = null;
    			if(result > 0) { 
    				 	Util.swalSetMessage("게시글 수정 성공", null, "success", ra);
    				 	path = "view/" + board.getBoardNo();
    				 	
    				 				
    			}else { 
    					Util.swalSetMessage("게시글 수정 실패", null, "error", ra);
    					path = "updateForm";
    			}
    			
    			return "redirect:"+path;
    		}
    		
    //게시글 삭제
    @RequestMapping(value="delete")
    public String freeBoarDelete(int boardNo, Model model, RedirectAttributes ra) {
    	model.addAttribute("header", "community");
    	model.addAttribute("css", "board/freeList");
    	
    	int result = service.deleteBoard(boardNo);
    	
    	String path = null;
		
		if(result > 0) {
			Util.swalSetMessage("게시글 삭제 성공", null, "success", ra);
			path = "insert";
			
		}else {
			Util.swalSetMessage("게시글 삭제 실패", null, "error", ra);
			path = "view/" + boardNo;
		}
    	return "redirect:" + path;
    }
    
    
    //스크랩하기 
    @ResponseBody
    @RequestMapping(value = "boardScrap", method = RequestMethod.GET)
    public int boardScrap(@RequestParam int memberNo, @RequestParam int boardNo) {
    	Scrap scrap =new Scrap();
    	scrap.setBoardNo(boardNo);
    	scrap.setMemberNo(memberNo);
    	
    	int result = service.boardScrap(scrap);
    	
    	return result;
    }
    
    // 회원 차단
    @ResponseBody
    @RequestMapping(value = "block", method = RequestMethod.GET)
    public int memberBlock(@ModelAttribute("loginMember") Member loginMember, int muteMember) {
    	
    	System.out.println(loginMember.getMemberNo());
    	System.out.println(muteMember);
    	
    	 HashMap<String, Integer> map = new HashMap<>();
    	 map.put("loginMember", loginMember.getMemberNo());
    	 map.put("memberNo", muteMember);
    	 
    	 int result = 0;
    	 
    	 if(loginMember.getMemberNo()== muteMember) {
    		 result = 0;
    	 }else {
    		 result = service.memberBlock(map);
    	 }
    	 
    	return result;
    }
	
    
    // 공감 
    @ResponseBody
    @RequestMapping(value = "insertEmpathy")
    public int insertEmpathy(@RequestParam int memberNo, @RequestParam int boardNo, 
    						@RequestParam int empathyStatusCode) {
    	
    	Empathy empathy =new Empathy();
    	empathy.setBoardNo(boardNo);
    	empathy.setMemberNo(memberNo);
    	empathy.setEmpathyStatusCode(empathyStatusCode);
    	
    	int result = service.insertEmpathy(empathy);
    	
    	return result;
    }
    
    
    // 공감 수 
    @ResponseBody
    @RequestMapping(value = "countEmpathy")
    public int countEmpathy( @RequestParam int boardNo, 
    						@RequestParam int empathyStatusCode) {
    	
    	Empathy empathy =new Empathy();
    	empathy.setBoardNo(boardNo);
    	empathy.setEmpathyStatusCode(empathyStatusCode);
    	
    	int result = service.countEmpathy(empathy);
    	
    	return result;
    }
    
    //신고하기
    @ResponseBody
    @RequestMapping(value = "insertReport", method = RequestMethod.POST)
    public int insertReport(Report report,  @ModelAttribute("loginMember") Member loginMember, HttpSession session,
    		RedirectAttributes ra) {
    	int result =0;
    	if(session.getAttribute("loginMember") != null) {
    		report.setMemberNo(((Member)session.getAttribute("loginMember")).getMemberNo());
    		//같은 게시글or 댓글 신고 이력 조회
    		Report selectReport = service.selectReport(report);
    		
    		if(selectReport == null) {
    			//조회 결과 없으면 insert 진행 
    			result = service.insertReport(report);
    			
    			if(result > 0) {
    				result = 1;
    			}else{
    				result = 2;
    			}
    		}else {
    			result = 3;
    		}
    	}
    	
    	return result;
    }
    
    
    //예외처리
//	@ExceptionHandler(Exception.class)
//	public String exceptionHandler(Exception e, Model model) {
//		
//		//Model : 데이터 전달용 객체(Map형식, request범위)
//		
//		model.addAttribute("errorMessage", "회원 관련 서비스 이용 중 문제가 발생했습니다.");
//		model.addAttribute("e", e);
//		
//		return "/common/error";
//	}
//  
	
	
	
	
	

}
