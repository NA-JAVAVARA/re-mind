package edu.kh.mind.pro.model.service;

import edu.kh.mind.member.model.vo.Profession;
import edu.kh.mind.member.model.vo.ProfessionPrice;
import edu.kh.mind.member.model.vo.Review;
import edu.kh.mind.pro.model.vo.Payment;
import edu.kh.mind.pro.model.vo.Reservation;
import edu.kh.mind.pro.model.vo.ReservationPayMent;

import java.util.List;

public interface ProService {

    List<Profession> selectProfession(List<String> worryCtCd);

    List<Profession> selectAllProfession();

    // 총 가격 insert
    int priceInsert(ProfessionPrice pfp, ReservationPayMent rv);
    
    // 총가격 select
	int priceSelect(int payNo); 
	
	// reservation insert, paymant update
	int reservationUpdate(Payment payment, Reservation reservation);
	
	
	// 취소 버튼 눌렀을 경우
	int paymentDelete(int payNo);


    Profession selectPro(int professionNo);

    List<Profession> selectMemberProfession(int professionNo);
    
    // 후기 가지고 오기
	List<Review> reviewListSelect(int professionNo);
	
	// 별점 가지고오기
	List<Review> starPointSelect(int professionNo);
	
	// 상담사별 별점 평균
	int starPointAverage(int professionNo);
}
