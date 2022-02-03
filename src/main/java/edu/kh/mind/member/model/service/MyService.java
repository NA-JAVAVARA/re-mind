package edu.kh.mind.member.model.service;

import edu.kh.mind.member.model.vo.EmotionCategory;
import edu.kh.mind.member.model.vo.ProfessionHospital;

import java.util.List;


public interface MyService {

    List<ProfessionHospital> loadProMap();

	/**
	 * 스트레스 증상 목록
	 * @return emotionCategoryList
	 */
	List<EmotionCategory> emotionCategory();
}
