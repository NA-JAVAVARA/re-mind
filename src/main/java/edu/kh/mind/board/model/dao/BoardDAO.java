package edu.kh.mind.board.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import edu.kh.mind.board.model.vo.Board;
import edu.kh.mind.board.model.vo.Image;
import edu.kh.mind.board.model.vo.Scrap;

@Repository
public class BoardDAO {
	
	@Autowired //의존성 주입
	private SqlSessionTemplate sqlSession;

	public List<Board> selectBoardList(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardMapper.selectFreeList",param);
	}

	public int insertFreeBoard(Board board) {
		int result = sqlSession.insert("boardMapper.insertFreeboard", board);
		int boardNo=0;
		
		if(result > 0) {
			boardNo =  board.getBoardNo();
		}
		
		return boardNo;
	}

	public int insertImgList(Image image) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertImgList", image);
	}

	public Board selectBoard(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}

	public int increaseReadCount(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.increaseReadCount",boardNo);
	}

	public int deleteBoard(int boardNo) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.deleteBoard", boardNo);
	}

	public int updateBoard(Board board) {
		// TODO Auto-generated method stub
		return sqlSession.update("boardMapper.updateBoard",board);
	}

	public Scrap selectScrap(Scrap scrap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.selectScrap",scrap);
	}

	public int insertScrap(Scrap scrap) {
		// TODO Auto-generated method stub
		return sqlSession.insert("boardMapper.insertScrap", scrap);
	}

	public int deleteScrap(Scrap scrap) {
		// TODO Auto-generated method stub
		return sqlSession.delete("boardMapper.deleteScrap",scrap);
	}

	public int countFreeList() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.countSecretList");
	}

	public String selectMuteMember(Map<String, String> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.selectMuteMember", param);
	}

}
