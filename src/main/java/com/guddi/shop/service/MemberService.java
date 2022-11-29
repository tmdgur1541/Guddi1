package com.guddi.shop.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestParam;

import com.guddi.shop.dao.MemberDao;
import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ReviewQnaDto;

@Service
public class MemberService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired MemberDao dao;
	
	//Q&A Start ryujihong 2022.01.10
	public int qnaSearchCount(String keyword, int answer_flg) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		 
		dto.setAnswer_flg(answer_flg);
		dto.setKeyword(keyword);			
		
		return dao.qnaSearchCount(dto);
	}

	public ArrayList<ReviewQnaDto> qnaInfo(int displayPost, int postNum, String keyword, int answer_flg, int qnaType) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		
		dto.setAnswer_flg(answer_flg);
		dto.setQnaType(qnaType);
		logger.info("getAnswer_flg : {}", dto.getAnswer_flg());
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(keyword);
		logger.info("displayPost : {}", displayPost);	
		logger.info("postNum : {}", postNum);
		return dao.qnaInfo(dto);		
	}

	public int doRegistQna(HashMap<String, String> params, HttpSession session) {
		// TODO Auto-generated method stub
		
		ReviewQnaDto dto = new ReviewQnaDto();		
		MemberDto udto = dao.findInfo((String)session.getAttribute("userId"));
		
		dto.setSubject(params.get("subject"));
		dto.setContent(params.get("content"));
		dto.setAnswer_type(params.get("answer_type"));
		dto.setUserId((String)session.getAttribute("userId"));
		dto.setU_idx(udto.getIdx());
		
		return dao.doRegistQna(dto);
	}

	public ReviewQnaDto getQnaDetail(String idx) {
		// TODO Auto-generated method stub
		return dao.getQnaDetail(idx);
	}

	public ReviewQnaDto getQnaAnswerDetail(String idx) {
		// TODO Auto-generated method stub
		return  dao.getQnaAnswerDetail(idx);
	}

	public ArrayList<ReviewQnaDto> getQnaType() {
		// TODO Auto-generated method stub
		return dao.getQnaType();
	}

	public ArrayList<ReviewQnaDto> getAnswerType() {
		// TODO Auto-generated method stub
		return dao.getAnswerType();
	}

	public int deleteQna(String idx) {
		// TODO Auto-generated method stub
		return dao.deleteQna(idx);
	}

	public int checkAnswer(String idx) {
		// TODO Auto-generated method stub
		return dao.checkAnswer(idx);
	}

	public int doUpdateQna(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		ReviewQnaDto dto = new ReviewQnaDto();
		dto.setContent(params.get("content"));
		dto.setIdx(Integer.parseInt(params.get("idx")));
		dto.setSubject(params.get("subject"));
		
		return dao.doUpdateQna(dto);
	}
	//Q&A Start ryujihong 2022.01.10
	//고객정보수정,탈퇴관련, 마이페이지내 리뷰관련 Start ryujihong 2022.01.10
	public MemberDto findInfo(String userId) {
		// TODO Auto-generated method stub
		return dao.findInfo(userId);
	}
	
	public HashMap<String, Object> doPwCheck(String userId, String password) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String result = dao.doPwCheck(userId, password);	
		
		boolean check =result == null? false:true;
		map.put("result", check);
		
		return map;
		// TODO Auto-generated method stub
	}

	public void updateInfo(HashMap<String, String> params) {
		
		MemberDto dto = new MemberDto();
		dto.setUserId(params.get("userId"));
		dto.setPassword(params.get("password"));
		dto.setUsername(params.get("username"));
		dto.setPhone(params.get("phone"));
		dto.setEmail(params.get("email"));
		dto.setZipcode(params.get("zipcode"));
		dto.setAddress(params.get("address"));
		dto.setAddress_detail(params.get("address_detail"));
		
		dto.setBirthday(params.get("birthday"));
		dto.setGender(params.get("gender"));
		
		logger.info("마케팅 : " + params.get("checkbox2"));
		
		if (params.get("checkbox2")==null){
			dto.setMarketing_flg(0);
		} else if(params.get("checkbox2").equals("1")) {
			dto.setMarketing_flg(1);
		}
		
		dto.setPersonInfo_flg(1);
		dto.setMem_flg(1);
		
		logger.info("마케팅2 : " + dto.getMarketing_flg());
			
		logger.info("회원가입 정보:{}",params.get("userId")+params.get("password")+params.get("username")+params.get("phone")
		+params.get("email")+params.get("zipcode")+params.get("address")+params.get("address_detail"));
		
		dao.updateInfo(dto);
		
	}
	
	public int delete(String userId) {
		// TODO Auto-generated method stub
		
		return dao.delete(userId);
	}

	public int orderSearchCount(String orderSearchType, String orderKeyword, String userId) {
		// TODO Auto-generated method stub
		PageDto dto = new PageDto();
		  
		dto.setUserid(userId);
		dto.setKeyword(orderKeyword);
		dto.setSearchType(orderSearchType);			
		
		return dao.orderSearchCount(dto);
	}
	
	public int reviewSearchCount(String searchType, String keyword, String userId) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		  
		dto.setUserid(userId);
		dto.setKeyword(keyword);
		dto.setSearchType(searchType);
		
		return dao.reviewSearchCount(dto);
	}

	public ArrayList<CartDto> myPageOrderInfo(int displayPost, int postNum, String orderSearchType, String orderKeyword,
			String userId) {
		// TODO Auto-generated method stub
		PageDto dto = new PageDto();
		
		dto.setUserid(userId);
		logger.info("type : {}", dto.getType());
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(orderKeyword);
		dto.setSearchType(orderSearchType);				
		logger.info("postNum : {}", postNum);
		return dao.myPageOrderInfo(dto);
	
	}


	public ArrayList<ReviewQnaDto> myPageReviewInfo(int displayPost, int postNum, String orderSearchType,
			String orderKeyword, String userId) {

		PageDto dto = new PageDto();
		
		dto.setUserid(userId);
		logger.info("type : {}", dto.getType());
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(orderKeyword);
		dto.setSearchType(orderSearchType);				
		logger.info("postNum : {}", postNum);
		return dao.myPageReviewInfo(dto);
	}

	public ReviewQnaDto getReviewDetail(String idx) {
		// TODO Auto-generated method stub
		return dao.getReviewDetail(idx);
	}

	public ReviewQnaDto getReviewAnswerDetail(String idx) {
		// TODO Auto-generated method stub
		return dao.getReviewAnswerDetail(idx);
	}

	public void delReview(String idx) {
		// TODO Auto-generated method stub
		dao.delReview(idx);
	}

	
	//고객정보수정,탈퇴관련, 마이페이지내 리뷰관련 End ryujihong 2022.01.10
	
	//로그인 Start yonghyeon 2022.01.11
	public MemberDto login(HashMap<String, String> params) {
		
		logger.info("아이디/비밀번호 : {}",params.get("userId")+"/"+params.get("password"));
		MemberDto sdto = new MemberDto();
		sdto.setUserId(params.get("userId"));
		sdto.setPassword(params.get("password"));
		
		MemberDto dto = dao.toLogin(sdto);
		return dto;
	}
	//로그인 end yonghyeon 2022.01.11
	
	
	
	

	//카트 수 가져오기 Start yonghyeon 2022.01.11
	/*public int getCart(String userId) {
		logger.info("카트수 찾기 실행! 아이디 : {}", userId);
		return dao.getCart(userId);
	}*/



	//카트 수 가져오기 end yonghyeon 2022.01.11

//	public void cartupdate(int quantity, String product_code, String userId) {
//		dao.cartupdate(quantity,product_code,userId);
//		logger.info("service : "+quantity+product_code+userId);
//		
//	}



	//회원가입 도연 start 2022.01.10
	public HashMap<String, Object> idCheck(String userId) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String result = dao.idCheck(userId);
		boolean check = result == null? false:true;
		map.put("result", check);
		
		return map;
	}


	public void write(HashMap<String, String> params) {
		logger.info("회원가입 서비스 요청");
		
		MemberDto dto = new MemberDto();
		dto.setUserId(params.get("userId"));
		dto.setPassword(params.get("password"));
		dto.setUsername(params.get("username"));
		dto.setPhone(params.get("phone"));
		dto.setEmail(params.get("email"));
		dto.setZipcode(params.get("zipcode"));
		dto.setAddress(params.get("address"));
		dto.setAddress_detail(params.get("address_detail"));
		dto.setBirthday(params.get("birthday"));
		dto.setGender(params.get("gender"));
		dto.setPersonInfo_flg(Integer.parseInt(params.get("personInfo_flg")));
		if (params.get("marketing_flg")!=null) {
			dto.setMarketing_flg(Integer.parseInt(params.get("marketing_flg")));
		}		
		dto.setMem_flg(1);
		
		logger.info("회원가입 정보 : {}"
				, params.get("userId")+"/"+params.get("password")+"/"+params.get("username")+"/"+params.get("email")
				+"/"+params.get("zipcode")+"/"+params.get("address")+"/"+params.get("address_detail")
				+"/"+params.get("birthday")+"/"+params.get("gender")+"/"+params.get("personInfo_flg")+"/"+params.get("marketing_flg"));
			
		dao.write(dto);
		
	}
//회원가입  도연 end 2022.01.12


	public ArrayList<MemberDto> doFindMemberId(String name, String email) {
		logger.info("아이디 찾기 서비스 이동");
		return dao.doFindMemberId(name, email);
	}

	public String temppasslogin(String userId, String email) {
		logger.info(userId+"/"+email+" // dao");
		
		String loginId = null;
		loginId=dao.temppasslogin(userId,email);
		
		return loginId;
	}

	public void temppassloginPw(String userId, String temppw) {
		logger.info(userId+"/"+temppw+"dao");
		dao.temppassloginPw(userId,temppw);
		
	}

	public String tempPass(String userpass) {
		// TODO Auto-generated method stub
		return dao.tempPass(userpass);
	}

	public  ArrayList<CartDto> getTotalPrice(String userId) {
		// TODO Auto-generated method stub
		return dao.getTotalPrice(userId);
	}
	//카트 수 가져오기 Start yonghyeon 2022.01.14
	public int HeadergetCart(String userId) {
		logger.info("카트수 찾기 실행! 아이디 : {}", userId);
		return dao.HeadergetCart(userId);
	}

	//카트 수 가져오기 End yonghyeon 2022.01.14




}
