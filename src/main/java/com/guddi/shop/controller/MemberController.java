package com.guddi.shop.controller;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ReviewQnaDto;
import com.guddi.shop.service.MemberService;



@Controller
public class MemberController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired MemberService service;
	
	
	@RequestMapping(value = "/qnaPage", method = RequestMethod.GET)
	public String qnaPage(Model model, @RequestParam("qnaNum") int qnaNum, @RequestParam("answer_flg") int answer_flg,
			@RequestParam("qnaType") int qnaType, @RequestParam(value="keyword",required=false,defaultValue="")String keyword ) {		
		
		logger.info("qnaPage 요청");		
		PageDto qnaPage = new PageDto();
		
		qnaPage.setNum(qnaNum);
		qnaPage.setCount(service.qnaSearchCount(keyword, answer_flg));				
		qnaPage.setKeyword(keyword);
		
		logger.info("qnaPage.getCount() : {}",qnaPage.getCount());
		
		ArrayList<ReviewQnaDto> qnaList = 
				service.qnaInfo(qnaPage.getDisplayPost(), qnaPage.getPostNum(), keyword, answer_flg, qnaType);
		
		//문의타입 한글화
		ArrayList<ReviewQnaDto> getQnaTypeInfo = service.getQnaType();
		
		//숫자를 글자로 변경. ex) 1--->상품
		for (int i = 0; i < qnaList.size(); i++) {
			int type = Integer.parseInt(qnaList.get(i).getAnswer_type());
			for (int j = 0; j < getQnaTypeInfo.size(); j++) {
				if (getQnaTypeInfo.get(j).getIdx()==type) {
					qnaList.get(i).setAnswer_type(getQnaTypeInfo.get(j).getTypename());
				}
			}
		}
		
		//답변여부 한글화
		ArrayList<ReviewQnaDto> getAnswerTypeInfo = service.getAnswerType();
						
		//숫자를 글자로 변경. ex) 1--->답변
		for (int i = 0; i < qnaList.size(); i++) {
			int type = Integer.parseInt(qnaList.get(i).getAnswer_flg());
			for (int j = 0; j < getAnswerTypeInfo.size(); j++) {
				if (getAnswerTypeInfo.get(j).getIdx()==type) {
					qnaList.get(i).setAnswer_flg(getAnswerTypeInfo.get(j).getAnswername());
				}
			}	
		}		
		
		
		model.addAttribute("qnaList", qnaList); //리스트 보내기
		model.addAttribute("qnaPage", qnaPage); //페이징처리
		model.addAttribute("qnaSelect", qnaNum);//페이징처리		  
		model.addAttribute("qnaKeyword", keyword); //검색어
		model.addAttribute("qnaAnswer_flg", answer_flg); //검색어
		model.addAttribute("getAnswerTypeInfo", getAnswerTypeInfo); //답변여부정보
		//Q&A페이지 관리자 기능 추가 Start ryujihong 2022.01.15
		model.addAttribute("getQnaTypeInfo", getQnaTypeInfo); //문의타입 카테고리
		model.addAttribute("qnaType", qnaType); //문의타입 
		//Q&A페이지 관리자 기능 추가 End ryujihong 2022.01.15
			
		return "member/qnaPage";
	}
	
	@RequestMapping(value = "/registQna", method = RequestMethod.GET)
	public String registQna(Model model) {		
		
		logger.info("registQna 요청");
		//문의타입 리스트
		ArrayList<ReviewQnaDto> getQnaTypeInfo = service.getQnaType();
		
		model.addAttribute("getQnaTypeInfo", getQnaTypeInfo); //답변여부정보
		
		return "member/registQna";
	}
	
	@RequestMapping(value = "/doRegistQna", method = RequestMethod.POST)
	public String doRegistQna(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {		
		
		logger.info("doRegistQna 요청");
		
		service.doRegistQna(params, session);		
		
		return "redirect:/qnaPage?qnaNum=1&answer_flg=2&qnaType=0";
	}
	
	@RequestMapping(value = "/qnaDetail", method = RequestMethod.GET)
	public String qnaDetail(Model model, @RequestParam String idx) {		
		
		logger.info("qnaDetail 요청 idx : {}",idx);
		
		ReviewQnaDto dto = service.getQnaDetail(idx);
		ReviewQnaDto aDto = service.getQnaAnswerDetail(idx);
		
		//문의타입 한글화
		ArrayList<ReviewQnaDto> getQnaTypeInfo = service.getQnaType();
		
		//숫자를 글자로 변경. ex) 1--->상품
		int type = Integer.parseInt(dto.getAnswer_type());
		for (int i = 0; i < getQnaTypeInfo.size(); i++) {
			if (getQnaTypeInfo.get(i).getIdx()==type) {
				dto.setAnswer_type(getQnaTypeInfo.get(i).getTypename());
			}
		}		
		model.addAttribute("dto", dto);
		model.addAttribute("qDto", aDto);
		
		return "member/qnaDetail";
	}
	
	@RequestMapping(value = "/deleteQna", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> deleteQna(@RequestParam String idx) {		
		
		logger.info("deleteQna 요청");
		logger.info("idx 요청 :{}",idx);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = service.deleteQna(idx);
		if (result>0) {
			map.put("result", result);		
		}else {
			map.put("result", 0);		
		}		
		return map;
	}
	
	@RequestMapping(value = "/updateQna", method = RequestMethod.GET)
	public String updateQna(Model model, @RequestParam String idx) {		
		
		logger.info("updateQna 요청 idx : {}",idx);
		
		ReviewQnaDto dto = service.getQnaDetail(idx);
		ReviewQnaDto aDto = service.getQnaAnswerDetail(idx);
		
		//문의타입 한글화
		ArrayList<ReviewQnaDto> getQnaTypeInfo = service.getQnaType();
		
		//숫자를 글자로 변경. ex) 1--->상품
		int type = Integer.parseInt(dto.getAnswer_type());
		for (int i = 0; i < getQnaTypeInfo.size(); i++) {
			if (getQnaTypeInfo.get(i).getIdx()==type) {
				dto.setAnswer_type(getQnaTypeInfo.get(i).getTypename());
			}
		}		
		model.addAttribute("dto", dto);
		model.addAttribute("qDto", aDto);
		
		return "member/updateQna";
	}
	
	@RequestMapping(value = "/checkAnswer", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> checkAnswer(@RequestParam String idx) {		
		
		logger.info("checkAnswer 요청");;

		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = service.checkAnswer(idx);
		
		map.put("result", result);		
		
		return map;
	}
	
	@RequestMapping(value = "/doUpdateQna", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doUpdateQna(@RequestParam HashMap<String, String> params) {		
		
		logger.info("checkAnswer 요청");

		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = service.doUpdateQna(params);
		
		map.put("result", result);		
		
		return map;
	}
	
		@RequestMapping(value = "/myPage", method = RequestMethod.GET)
		public String myPage(Model model, HttpSession session, 
				@RequestParam(value="orderNum") int orderNum, @RequestParam(value="reviewNum") int reviewNum,
				@RequestParam(value="orderSearchType",required=false) String orderSearchType,
				@RequestParam(value="orderKeyword",required=false) String orderKeyword,
				@RequestParam(value="reviewSearchType",required=false) String reviewSearchType,
				@RequestParam(value="reviewKeyword",required=false) String reviewKeyword			
				) {
			
			logger.info("myPage 요청");
			logger.info("reviewNum : {}",reviewNum);
			logger.info("orderKeyword : {}",orderKeyword);
			String userId = (String) session.getAttribute("userId");
			
							
			//마이페이지 내정보 관련
			MemberDto dto = service.findInfo(userId);		
			model.addAttribute("info", dto);
			
			//마이페이지 주문정보 관련
			PageDto orderPage = new PageDto();		
			orderPage.setNum(orderNum);
			orderPage.setCount(service.orderSearchCount(orderSearchType, orderKeyword, userId));		
			orderPage.setSearchType(orderSearchType);
			orderPage.setKeyword(orderKeyword);
			
			ArrayList<CartDto> orderList = 
					service.myPageOrderInfo(orderPage.getDisplayPost(), orderPage.getPostNum(), orderSearchType, orderKeyword, userId);
			
			//총가격 계산
			int totalPrice = 0;
			ArrayList<CartDto> getTotalPrice = service.getTotalPrice(userId);
			for (int i = 0; i < getTotalPrice.size(); i++) {			
				int price = Integer.parseInt(getTotalPrice.get(i).getPrice());
				int quantity = getTotalPrice.get(i).getQuantity();			
				totalPrice += price*quantity;
			}				
			
			model.addAttribute("totalPrice", totalPrice); //총가격
			model.addAttribute("orderList", orderList); //리스트 보내기
			model.addAttribute("orderPage", orderPage); //페이징처리
			model.addAttribute("orderSelect", orderNum);//페이징처리		  
			model.addAttribute("orderKeyword", orderKeyword); //검색어
			
			//마이페이지 리뷰정보관련
			PageDto reviewPage = new PageDto();
			reviewPage.setNum(reviewNum);
			reviewPage.setCount(service.reviewSearchCount(reviewSearchType, reviewKeyword, userId));		
			reviewPage.setSearchType(orderSearchType);
			reviewPage.setKeyword(orderKeyword);
			
			ArrayList<ReviewQnaDto> reviewList = 
					service.myPageReviewInfo(reviewPage.getDisplayPost(), reviewPage.getPostNum(), reviewSearchType, reviewKeyword, userId);
					
			model.addAttribute("reviewList", reviewList); //리스트 보내기
			model.addAttribute("reviewPage", reviewPage); //페이징처리
			model.addAttribute("reviewSelect", reviewNum);//페이징처리		  
			model.addAttribute("reviewKeyword", reviewKeyword); //검색어
			model.addAttribute("reviewSearchType", reviewSearchType); //검색타입
			
			return "member/myPage";
		}
		
		@RequestMapping(value = "/checkPassword", method = RequestMethod.GET)
		public String checkPassword(Model model, @RequestParam String userId) {		
			
			logger.info("checkPassword 요청");		
			MemberDto dto = service.findInfo(userId);
			model.addAttribute("info", dto);
			
			return "member/checkPassword";
		}
		
		@RequestMapping(value = "/doPwCheck", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> doPwCheck(Model model, @RequestParam String userId, String password) {		
			
			logger.info("doPwCheck 요청");
			
			return service.doPwCheck(userId, password);
		}
			
		@RequestMapping(value = "/changeInfo", method = RequestMethod.GET)
		public String changeInfo(Model model,@RequestParam String userId ) {		
			
			logger.info("changeInfo 요청");

			MemberDto dto = service.findInfo(userId);
			model.addAttribute("info", dto);
			
			return "member/changeInfo";
		}
		
		@RequestMapping(value = "/doChangeInfo", method = RequestMethod.POST)
		public String doChangeInfo(Model model, @RequestParam HashMap<String, String> params) {		
			
			logger.info("doMemberWrite 요청");
			
			service.updateInfo(params);
			
			return "redirect:/myPage?userId="+params.get("userId")+"&orderNum=1&reviewNum=1";
		}
			
		@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> deleteUser(Model model, @RequestParam String userId) {
		
			HashMap<String, Object> map = new HashMap<String, Object>();
			logger.info("회원탈퇴 요청");
			int result = service.delete(userId);
			
			boolean check = result > 0? true:false;
			map.put("result", check);
			
			return map;
		}	
		
		@RequestMapping(value = "/reviewDetail", method = RequestMethod.GET)
		public String reviewDetail(Model model, @RequestParam String idx) {		
			
			logger.info("reviewDetail 요청");
			
			ReviewQnaDto dto = service.getReviewDetail(idx);
			ReviewQnaDto aDto = service.getReviewAnswerDetail(idx);
			
			model.addAttribute("dto", dto);
			model.addAttribute("aDto", aDto);
			
			return "member/reviewDetail";
		}
		
		@RequestMapping(value = "/delReview", method = RequestMethod.GET)
		public String delReview(Model model, @RequestParam String idx, HttpSession session) {		
			
			logger.info("reviewDetail 요청");
			
			service.delReview(idx);		
			
			return "redirect:/myPage?userId="+session.getAttribute("userId")+"&orderNum=1&reviewNum=1";
		}	
		//고객정보수정,탈퇴관련, 마이페이지내 리뷰관련 End ryujihong 2022.01.10
		
		
		
		@RequestMapping(value = "/toLogin", method = RequestMethod.GET)
		public String toLogin(Model model) {
			logger.info("로그인 페이지 요청");
				
			return "member/toLogin";
		}
		
		
		
		@RequestMapping(value = "/doLogin", method = RequestMethod.POST)
		public String doLogin(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {
			logger.info("doLogin 요청");
			logger.info("아이디/비밀번호 : {}",params.get("userId")+"/"+params.get("password"));
			
			String page = "member/toLogin";
			String msg = "아이디와 비밀번호를 확인해주세요.";
			MemberDto dto = service.login(params);
			
			try {
				logger.info("아이디 : {}" , dto.getUserId());
				int cartCnt = service.HeadergetCart(params.get("userId"));
				logger.info("cartCnt : {}",cartCnt);
				/*if(cartCnt == 0);{
					cartCnt = 0;
					logger.info("if문 실행");
				}*/
				if(dto.getMem_flg()==0) {
					msg = "탈퇴 회원입니다.";
				}else if(dto.getUserId()!=null&&dto.getMem_flg()==1) {
					page = "redirect:/";			
					msg="";
					//용현님 아래 코드 수정하셔야되요~

						//int cartCnt = 0;
						session.setAttribute("cartCnt", cartCnt);
						logger.info("session1 실행");
						session.setAttribute("userId", dto.getUserId());
						logger.info("session2 실행");
						session.setAttribute("username", dto.getUsername());
						logger.info("session3 실행");
						session.setAttribute("mem_flg", dto.getMem_flg());
						logger.info("session에서 mem_flg가져오기");
						session.setAttribute("u_idx", dto.getIdx());
					
					//logger.info("cartCnt 반환");

				}else if(dto.getUserId()!=null&&dto.getMem_flg()==2) {
					page = "redirect:/";			
					msg="";
					session.setAttribute("userId", dto.getUserId());
					logger.info("session2 실행");
					session.setAttribute("username", dto.getUsername());
					logger.info("session3 실행");
					session.setAttribute("mem_flg", dto.getMem_flg());
					logger.info("session에서 mem_flg가져오기");
					session.setAttribute("u_idx", dto.getIdx());
					
				}
				
			}catch(Exception e){
				logger.info("에러 발생");
			}
			model.addAttribute("msg",msg);
				
			return page;
		}
		
		
		
		
		@RequestMapping(value = "/findIdPassword", method = RequestMethod.GET)
		public String findidPassword(Model model) {		
			
			logger.info("findidPassword 페이지 요청");
			
			return "member/findIdPassword";
		}

		@RequestMapping(value = "/doFindMemberId", method = RequestMethod.GET)
		public String doFindMemberId(Model model, @RequestParam String name, @RequestParam String email) {
			logger.info("아이디 찾기 기능");
			String msg = "";
			String url = "member/findIdPassword";
			ArrayList<MemberDto> memberId = service.doFindMemberId(name, email);
			if(memberId.size() > 0) {
				msg = "아이디 찾기 성공";
		
				model.addAttribute("memberId", memberId);
				model.addAttribute("msg", msg);
				url = "member/getFindMemberId";
			}
			if(memberId.size() == 0) {
				msg = "가입하신 아이디가 없습니다.";
				model.addAttribute("msg", msg);
			}
			return url;
		}
		
		@RequestMapping(value = "/temppass", method = RequestMethod.POST)
		public String temppass(Model model,@RequestParam String userId,@RequestParam String email,HttpSession session) {
			logger.info("temppass click!!!");
			logger.info("로그인 요청"); 
			logger.info(userId+"/"+email); 
			String loginId = service.temppasslogin(userId,email);
			logger.info("로그인 아이디 여부 : " +loginId);
			logger.info("이메일 아이디 여부 : " +email);
			String page = "redirect:/member/tempPass";
			

			String msg = "아이디와 이메일을 확인해 주세요";
			try {
				if(loginId != null && email != null) { // 로그인이 되면 서비스에서 temppw로 업데이트 한 결과를 보낸다. 
					String temppw = getRamdomPassword(10);
					msg = "임시비밀번호로 변경 하시겠습니까?";
					logger.info(temppw+"<--임시비번"); 
					
					service.temppassloginPw(userId,temppw);
					
					// 여기서임시비밀번호를 뿌려주는 페이지로 이동한다. 
					
					model.addAttribute("temppw", temppw);
					session.setAttribute("loginId", loginId);
					page = "member/tempPass";
					
				}else {
					
					page = "member/findIdPassword";
				}
				

			}
			catch (Exception e){
				logger.info("에러 발생");		
					
			}
			
			model.addAttribute("msg", msg);
			
			return page;
		}
		
		public String getRamdomPassword(int size) {
			char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
			StringBuffer sb = new StringBuffer();
			SecureRandom sr = new SecureRandom();
			sr.setSeed(new Date().getTime());
			int idx = 0; int len = charSet.length; for (int i=0; i<size; i++) { 
				// idx = (int) (len * Math.random()); idx = sr.nextInt(len); // 강력한 난수를 발생시키기 위해 SecureRandom을 사용한다. sb.append(charSet[idx]); } return sb.toString(); }
				idx = sr.nextInt(len);
				sb.append(charSet[idx]);
			}
			return sb.toString();
		}

		
		
		@RequestMapping(value = "/logout", method = RequestMethod.GET)
		public String logout(Model model,HttpSession session) {
			logger.info("로그아웃 요청");
			
			session.setAttribute("userId", null);
			session.setAttribute("username", null);
			session.setAttribute("cartCnt", null);
			session.setAttribute("mem_flg", null);
			session.setAttribute("u_idx", null);
			return "redirect:/";
		}
		
		
		@RequestMapping(value = "/memberWrite", method = RequestMethod.GET)
		public String memberWrite(Model model) {		
			
			logger.info("회원가입 페이지 요청");
			
			return "member/memberWrite";
		}
		
		@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> idCheck(Model model, @RequestParam String userId) {		
			
			logger.info("idCheck 요청");
			
			return service.idCheck(userId);
		}
		
		@RequestMapping(value = "/doMemberWrite", method = RequestMethod.POST)
		public String doMemberWrite(Model model, @RequestParam HashMap<String, String> params) {		
			
			logger.info("doMemberWrite 요청");
			
			service.write(params);
			
			return "member/toLogin";
		}	
		
		
		
		
		
}
