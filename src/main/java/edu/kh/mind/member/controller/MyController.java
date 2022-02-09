package edu.kh.mind.member.controller;

import com.google.gson.Gson;
import edu.kh.mind.board.model.vo.Board;
import edu.kh.mind.board.model.vo.Image;
import edu.kh.mind.board.model.vo.Pagination;
import edu.kh.mind.common.util.Util;
import edu.kh.mind.member.model.service.MyService;

import edu.kh.mind.member.model.vo.EmotionCategory;
import edu.kh.mind.member.model.vo.EmotionDiary;
import edu.kh.mind.member.model.vo.Member;
import edu.kh.mind.member.model.vo.ProfessionHospital;
import edu.kh.mind.member.model.vo.Review;

import edu.kh.mind.member.model.vo.*;
import edu.kh.mind.member.social.naver.vo.Naver;

import edu.kh.mind.pro.model.vo.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/my/*")
@SessionAttributes({"loginMember", "naver"})
public class MyController {

    @Autowired
    private MyService service;
    

    // 상담 예약 조회
    @RequestMapping("appointment")
    public String appointment(Model model, @ModelAttribute("loginMember") Member loginMember) {

        int memberNo = loginMember.getMemberNo();

        List<Reservation> reservationList = service.selectReservation(memberNo);

    	model.addAttribute("reservationList", reservationList);

    	model.addAttribute("css", "my");
        return "my/appointment";
    }

    // 상담 예약 취소
    @ResponseBody
    @RequestMapping(value="appointmentCancel", method=RequestMethod.POST)
    public int appointmentCancel(@ModelAttribute("loginMember") Member loginMember, Reservation reservation) {

        System.out.println(loginMember.getMemberNo());
        System.out.println(reservation.getReservationNo());

        reservation.setMemberNo(loginMember.getMemberNo());
        int result = service.appointmentCancel(reservation);


        return result;
    }



    @RequestMapping("appointment/past")
    public String appointmentPast(Model model) {
    	model.addAttribute("css", "my");
        return "my/appointmentPast";
    }

    // 감정 기록 페이지
    @RequestMapping("emotionRecord")
    public String emotionRecord(Model model, HttpSession session) {
        List<EmotionCategory> emotionCategoryList = service.emotionCategory();

        // 감정 기록 등록일 list
        String emotionDiaryDate = "[]";

        String gsonData = "";
        if (session.getAttribute("loginMember")  != null) {
            int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();

            // 감정 기록 등록일
            List<String> emotionDiaryDateList = service.selectEmotionDiaryDate(memberNo);
            emotionDiaryDate = new Gson().toJson(emotionDiaryDateList);

            // 오늘 등록된 감정 기록
            Map<String, String> map = new HashMap<String, String>();
            map.put("memberNo", memberNo +"");
            map.put("selectDate", todayFormat());
            EmotionDiary emotionRecordData = service.selectEmotionRecord(map);
            gsonData = new Gson().toJson(emotionRecordData);
        }

        model.addAttribute("emotionRecordData", gsonData);
        model.addAttribute("emotionDiaryDate", emotionDiaryDate);
        model.addAttribute("emotionCategoryList", emotionCategoryList);
        model.addAttribute("css", "my");

        return "my/emotionRecord";
    }

    // 감정 기록 select
    @RequestMapping(value="emotionRecordData", method=RequestMethod.POST)
    @ResponseBody
    public EmotionDiary emotionRecordData(String selectDate, HttpSession session, RedirectAttributes ra) {
        EmotionDiary emotionRecordData = null;
        if(session.getAttribute("loginMember") != null) {
            int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();

            Map<String, String> map = new HashMap<String, String>();
            map.put("memberNo", memberNo +"");
            map.put("selectDate", selectDate);

            emotionRecordData = service.selectEmotionRecord(map);
        } else {
            Util.swalSetMessage("로그인이 필요합니다.", null, "info", ra);
        }

        return emotionRecordData;
    }


    // 감정기록 form
    @RequestMapping(value="emotionDiary", method= RequestMethod.GET)
    public String emotionDiary(Model model, HttpSession session, RedirectAttributes ra) {

        if (session.getAttribute("loginMember") != null) {
            List<EmotionCategory> emotionCategoryList = service.emotionCategory();

            int memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();

            // 오늘 등록된 감정 기록
            Map<String, String> map = new HashMap<String, String>();
            map.put("memberNo", memberNo +"");
            map.put("selectDate", todayFormat());
            EmotionDiary emotionRecordData = service.selectEmotionRecord(map);
            String gsonData = new Gson().toJson(emotionRecordData);
            System.out.println(gsonData);

            model.addAttribute("emotionRecordData", gsonData);
            model.addAttribute("emotionCategoryList", emotionCategoryList);
            model.addAttribute("css", "my");

            return "my/emotionDiary";
        } else {
            Util.swalSetMessage("로그인이 필요합니다.", null, "info", ra);
            return "redirect:emotionRecord";
        }


    }

    // 감정기록 등록
    @RequestMapping(value="emotionDiary", method=RequestMethod.POST)
    public String emotionDiaryInsert(EmotionDiary emotionDiary, @ModelAttribute("loginMember") Member loginMember, HttpServletRequest req, HttpSession session, RedirectAttributes ra) {

        if (req.getParameter("stressAgree") != null) {
            emotionDiary.setStressAgree(1);
        } else {
            emotionDiary.setStressAgree(0);
        }

        if (req.getParameter("diaryAgree") != null) {
            emotionDiary.setDiaryAgree(1);
        } else {
            emotionDiary.setDiaryAgree(0);
        }

        emotionDiary.setEmotionDate(todayFormat());

        if (session.getAttribute("loginMember") != null) {
            emotionDiary.setMemberNo(loginMember.getMemberNo());
            int result = service.insertEmotionDiary(emotionDiary);

            return "redirect:/my/emotionRecord";

        } else {
            Util.swalSetMessage("로그인이 필요합니다.", null, "info", ra);
            return null;
        }

    }

    private String todayFormat() {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date today = new Date(System.currentTimeMillis());
        return dateFormat.format(today);
    }
    
    // 리뷰 등록
    @ResponseBody
    @RequestMapping(value="reviewInsert", method=RequestMethod.POST)
    public int reviewInsert(@ModelAttribute("loginMember") Member loginMember,Review review) {
    	
    	// 전문가 번호 추가해야함
    	review.setMemberNo(loginMember.getMemberNo());

    	int result = service.reviewInsert(review);

    	return result;
    }


    @GetMapping("counselor")
    public String counselor(Model model, HttpSession session, RedirectAttributes ra, Board board,
                            @RequestParam(value="cp", required = false, defaultValue="1")int cp){
    	model.addAttribute("css", "my/counselor");

        int memberNo = 0;
        Pagination pagination = null;
        List<Board> counselorList = null;
        String path = "";

        if(session.getAttribute("loginMember") != null) {
            memberNo = ((Member)session.getAttribute("loginMember")).getMemberNo();

//            System.out.println(memberNo);
            pagination = service.getCounselorPagination(cp, memberNo);
            System.out.println(pagination);

            counselorList = service.selectCounselorList(pagination);

            model.addAttribute("pagination", pagination);
            model.addAttribute("counselorList", counselorList);
            path = "my/counselor";
        } else {
            Util.swalSetMessage("로그인 후 이용해주시기 바랍니다.", null, "info", ra);

            path = "redirect:/";
        }

        return path;
    }

    @GetMapping("enquiry")
    public String enquiry(Model model){
    	model.addAttribute("css", "my/enquiry");
        return "my/enquiry";
    }

    @GetMapping("letterList")
    public String letterList(Model model){
    	model.addAttribute("css", "my/letterList");
        return "my/letterList";
    }

    @GetMapping("map")
    public String map(Model model){
        model.addAttribute("css", "my/map");

        return "my/map";
    }

    @GetMapping("muteMember")
    public String muteMember(Model model, @ModelAttribute("loginMember") Member loginMember){
        model.addAttribute("css", "my/muteMember");
//        model.addAttribute("header", "main");
        List<Mute> mList = service.selectMuteMember(loginMember.getMemberNo());

        model.addAttribute("mList", mList);

        return "my/muteMember";
    }

    @GetMapping("clearMember")
    @ResponseBody
    public int clearMember(@ModelAttribute("loginMember") Member loginMember,
                              @RequestParam(value = "muteNo", required = false) int muteNo){

        Mute mute = new Mute();
        mute.setMemberNo(loginMember.getMemberNo());
        mute.setMuteNo(muteNo);

        int result = service.clearMember(mute);

        return result;
    }

    @GetMapping("myBoardList")
    public String myBoardList(Model model){
        model.addAttribute("css", "my/myBoardList");

        return "my/myBoardList";
    }

    @GetMapping("postscript")
    public String postscript(Model model){
        model.addAttribute("css", "my/postscript");
        return "my/postscript";
    }

    @GetMapping("secession")
    public String secession(Model model, HttpSession session){
        model.addAttribute("css", "my/secession");

        Naver naver = ((Naver)session.getAttribute("naver"));
        model.addAttribute("naver", naver);

        return "my/secession";
    }

    @PostMapping("secessionMember")
    public String secessionMember(Model model, @ModelAttribute("loginMember") Member loginMember,
                                  HttpSession session, RedirectAttributes ra, SessionStatus status,
                                  @RequestParam(value = "memberPw", required = false) String memberPw){

        Naver naver = ((Naver)session.getAttribute("naver"));

        int result = service.secessionMember(naver, loginMember);

        if(result > 0) {
            Util.swalSetMessage("회원 탈퇴 성공", null, "success", ra);
            status.setComplete();
        }else {
            Util.swalSetMessage("회원 탈퇴 실패", null, "info", ra);
        }

        return "redirect:/";
    }

    @GetMapping("updateMyInfo")
    public String updateMyInfo(Model model, HttpSession session, RedirectAttributes ra,
                               @ModelAttribute("loginMember") Member loginMember){
        Naver naver = ((Naver)session.getAttribute("naver"));

        String path = null;
        Image image = null;
        if(naver == null){
            image = service.getMyImage(loginMember.getMemberNo());
            path = "my/updateMyInfo";
        }else{
            Util.swalSetMessage("소셜로그인 회원은 정보수정이 불가능합니다.", null, "info", ra);
            path = "redirect:/";
        }

        model.addAttribute("memberImage", image);
        return path;
    }
    @PostMapping("updateMyInfoo")
    public String updateMyInfo(Member member,
                               Image image,
                               @ModelAttribute("loginMember") Member loginMember,
                               HttpSession session, RedirectAttributes ra,
                               MultipartHttpServletRequest multiReq,
                               @RequestParam(value = "images", required = false) MultipartFile images){

        // 1) 로그인 회원 번호를 image에 세팅
        image.setMemberNo(loginMember.getMemberNo());

        // 2) 웹 접근 경로, 서버 저장 경로
        String webPath = "/resources/images/my/";
        String serverPath = session.getServletContext().getRealPath(webPath);
        System.out.println("serverPath : " + serverPath);

        // 3) 게시글 삽입 Service 호출
        int result = service.updateMyForm(image, images, webPath, serverPath);
        // -> Service 수행 후 삽입된 게시글 번호를 얻어올 예정



        return null;
    }

    @GetMapping("loadProMap")
    @ResponseBody
    public String loadProMap(){

        List<ProfessionHospital> proList = service.loadProMap();

        for(ProfessionHospital p : proList){
            System.out.println(p);
        }

        return new Gson().toJson(proList);
    }






    // @ExceptionHandler(처리할 예외.class)
    @ExceptionHandler(Exception.class)
    public String exceptionHandler(Exception e, Model model) {

        // Model : 데이터 전달용 객체 (Map형식, request범위)
        model.addAttribute("errorMessage", "회원 관련 서비스 이용중 문제가 발생했습니다.");
        model.addAttribute("e", e);

        return "common/error";
    }

}
