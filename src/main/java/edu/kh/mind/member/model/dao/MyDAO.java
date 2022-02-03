package edu.kh.mind.member.model.dao;

import edu.kh.mind.member.model.vo.EmotionCategory;
import edu.kh.mind.member.model.vo.EmotionDiary;
import edu.kh.mind.member.model.vo.ProfessionHospital;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MyDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<ProfessionHospital> loadProMap() {
        return sqlSession.selectList("professionMapper.loadProMap");
    }

	public List<EmotionCategory> emotionCategory() {
		return sqlSession.selectList("emotionMapper.emotionCategory");
	}

	public int insertEmotionDiary(EmotionDiary emotionDiary) {
		return sqlSession.insert("emotionMapper.insertEmotionDiary", emotionDiary);
	}
}
