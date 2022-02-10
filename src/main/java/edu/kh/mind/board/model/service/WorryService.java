package edu.kh.mind.board.model.service;

import edu.kh.mind.board.model.vo.Board;
import edu.kh.mind.board.model.vo.WorryCategory;
import edu.kh.mind.member.model.vo.Member;

import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface WorryService {

	/**
	 * 고민상담 게시글
	 * @return list
	 */
	List<Board> selectWorryList(Map<String, String> param);

	/**
	 * 고민상담 카테고리
	 * @return list
	 */
	List<WorryCategory> selectWorryCategory();

	int insertWorryBoard(Board board, List<MultipartFile> images, String webPath, String serverPath);

	/** 회원 차단
	 * @param map
	 * @return result
	 */
	int memberBlock(HashMap<String, Integer> map);

	
}
