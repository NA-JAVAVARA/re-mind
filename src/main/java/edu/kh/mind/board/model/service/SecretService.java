package edu.kh.mind.board.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import edu.kh.mind.board.model.vo.Board;
import edu.kh.mind.board.model.vo.WorryCategory;

public interface SecretService {

	List<Board> selectSecretList(Map<String, String> param);

	int updateBoard(Board board, List<MultipartFile> images, String webPath, String serverPath, String deleteImages);

	Board selectBoard(int boardNo, int memberNo);

	int insertSecretBoard(Board board, List<MultipartFile> images, String webPath, String serverPath);

	Board selectBoard(int boardNo);

	int deleteBoard(int boardNo);
	

}
