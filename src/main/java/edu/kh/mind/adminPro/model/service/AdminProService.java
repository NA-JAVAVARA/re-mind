package edu.kh.mind.adminPro.model.service;

import edu.kh.mind.member.model.vo.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface AdminProService {

	
	/**아이디 중복검사 
	 * @param inputId
	 * @return
	 */
	int idChk(String inputId);
	
	/** 상담사 등록
	 * @param loginPro
	 * @return int reuslt
	 * @throws Exception 
	 */
	void proRegister(Profession profession) throws Exception;


	int chkAuth(Profession profession);

	Profession selectProfession(Profession profession);

	/** 병원정보 등록
	 * @param proHospital
	 * @return
	 */
	int insertProHospital(ProfessionHospital proHospital);

	/**
	 * @param proInfo
	 * @param serverPath 
	 * @param webPath 
	 * @param image 
	 * @return
	 */
	int insertProInfo(ProfessionInformation proInfo, MultipartFile certification, String webPath, String serverPath);


	/**
	 * 로그인
	 * @param profession
	 * @return loginPro
	 */
    Profession proLogin(Profession profession);

	/**
	 * 채팅방 입장
	 * @param chat
	 * @return
	 */
	List<ChatMessage> joinChat(ChatJoin chat);
}
