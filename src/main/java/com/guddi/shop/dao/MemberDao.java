package com.guddi.shop.dao;

import java.util.ArrayList;

import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ReviewQnaDto;


public interface MemberDao {
	
	
	int qnaSearchCount(PageDto dto);	

	ArrayList<ReviewQnaDto> qnaInfo(PageDto dto);

	int doRegistQna(ReviewQnaDto dto);

	ReviewQnaDto getQnaDetail(String idx);

	ReviewQnaDto getQnaAnswerDetail(String idx);

	ArrayList<ReviewQnaDto> getQnaType();

	ArrayList<ReviewQnaDto> getAnswerType();

	int deleteQna(String idx);

	int doUpdateQna(ReviewQnaDto dto);	

	int checkAnswer(String idx);

	MemberDto findInfo(String userId);

	String doPwCheck(String userId, String password);

	void updateInfo(MemberDto dto);	

	int delete(String userId);
	
	int orderSearchCount(PageDto dto);	

	int reviewSearchCount(PageDto dto);

	ArrayList<CartDto> myPageOrderInfo(PageDto dto);

	ArrayList<ReviewQnaDto> myPageReviewInfo(PageDto dto);

	ReviewQnaDto getReviewDetail(String idx);

	ReviewQnaDto getReviewAnswerDetail(String idx);

	void delReview(String idx);	
	
	MemberDto toLogin(MemberDto sdto);
	
	
	void write(MemberDto dto);

	String idCheck(String param);


	ArrayList<MemberDto> doFindMemberId(String name, String email);

	String temppasslogin(String userId, String email);

	void temppassloginPw(String userId, String temppw);

	

	String tempPass(String userpass);

	int HeadergetCart(String userId);

	ArrayList<CartDto> getTotalPrice(String userId);


}
