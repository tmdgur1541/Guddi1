package com.guddi.shop.controller;


import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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

import com.guddi.shop.dao.CartDao;
import com.guddi.shop.dto.CartDto;
import com.guddi.shop.service.CartService;



@Controller
public class CartController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired CartService service;
	@Autowired CartDao dao;

	
	
	
	
//	@RequestMapping(value = "/cart", method = RequestMethod.GET)
//	public String doRegistQna(Model model, @RequestParam HashMap<String, String> params, HttpSession session) {		
//		
//		logger.info("cart 요청");
//		service.doRegistQna(params, session);
//		return "/cart/userCart";
//	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String cart(Model model , HttpSession session) {
		logger.info("cart 페이지 요청");
		String userId = (String) session.getAttribute("userId");// 로그인 미완성으로 아이디를 session에 그냥 넣어줌 - 실행했는데 아이디가 넘어가지 않는다. 
		logger.info("userId : {}", userId);
		
		if (userId!=null) {
			ArrayList<CartDto> list = service.getCartInfo(userId);
		
			//ArrayList<CartDto> listImg = service.getCartInfoImg(userId);					
			model.addAttribute("list", list);
			//model.addAttribute("listImg", listImg);			
			model.addAttribute("userId", userId);
		}
		return "cart/userCart";
	}

	@RequestMapping(value = "/delCart", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> delCart(@RequestParam String product_code, HttpSession session) {		
		
		logger.info("delCart 요청");
		CartDto dto = new CartDto();		
		String userId = (String) session.getAttribute("userId");
		dto.setUserId(userId);		
		dto.setProduct_code(product_code);
		logger.info("userId : {}", userId);
		logger.info("product_code : {}", product_code);
		int result = service.delCart(dto);		
		HashMap<String, Object> map = new HashMap<String, Object>();
		logger.info("카트 삭제하기 성공 유무 : {}", result);
		if (result>0) {			
			map.put("result", result);		
			int cartCnt = service.getCart(userId);//카트수 가져오기
			logger.info("카트 수 : {}", cartCnt);
			session.setAttribute("cartCnt", cartCnt);
		}else {
			map.put("result", 0);		
		}
				
		return map;
	}
	@RequestMapping(value = "/cartupdate", method = RequestMethod.POST)
	public String cartupdate(Model model , HttpSession session,@RequestParam int quantity,@RequestParam String product_code,@RequestParam String userId) {
		logger.info("cart/update");
		
		CartDto dto = new CartDto();
		logger.info(quantity+"/"+product_code+"/"+userId);
		String userIdsession = (String) session.getAttribute("userId");
		//if(dto.getUserId() == userIdsession) { // 세션에있는 id와 받아온 id가 같으면 서비스실행
			dto.setQuantity(quantity);
			dto.setProduct_code(product_code);
			dto.setUserId(userId);
			int cartCnt = service.cartupdate(dto);
			logger.info("변경여부 : {}", cartCnt);
		//}else {
			logger.info("세션에있는 아이디와 로그인한 아이디가 다름");
		//}
			
		return "redirect:/cart";
	}
	
	@RequestMapping(value = "/completeOrder", method = RequestMethod.GET)
	public String completeOrder(Model model, HttpSession session ) {

		logger.info("주문완료페이지 요청");

		return "cart/completeOrder";
	}
		

	@RequestMapping(value = "/chkdelete", method = RequestMethod.POST)
	@ResponseBody // 컨트롤러에서 요청을 받아와 반환된 값을 jsp에 넘겨줄때 언어가 달라 json라이브러리를 추가했고 @ResponseBody 어노테이션을 사용해 hashMAp데이터 타입으로 뷰에서 읽을수 있게 처리해 줬습니다.
	public HashMap<String,Object> chkdelete(
			@RequestParam (value="delList[]") ArrayList<String> delList 
			,HttpSession session) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		
		logger.info("delList : {}",delList); 
		
		int delCnt = delList.size();// 1. 삭제할 갯수 확인 
		int row = service.chkdelete(delList);	// 2. 삭제 완료된 갯수 확인
		logger.info("chkdelete controller : {}",delList); 
		
		// 3. 1번과 2번이 같으면 완료
		if (row>0) {
			//map.put("msg", (delCnt-1)+"개 요청 중 "+(row)+"개 를 삭제 하였습니다.");
			map.put("msg", "선택하신 상품이 삭제 하였습니다.");
			String userId = (String) session.getAttribute("userId");
			int cartCnt = service.getCart(userId);//카트수 가져오기
			logger.info("카트 수 : {}", cartCnt);
			session.setAttribute("cartCnt", cartCnt);
		}
		if (row==0) {
			map.put("msg", "삭제할 제품이 존재하지 않습니다!");
		}
		
		
		
		return map;
	}
	
	//order 추가 21-01-14


	/*
	@RequestMapping(value = "toOrder", method = RequestMethod.GET)
	public String toOrder(Model model) {
		logger.info("toOrder Click");
		
		
		return "cart/toOrder";
	}
	*/
	@RequestMapping(value = "/checkout", method = RequestMethod.POST)
	public HashMap<String, Object> toOrder(Model model,HashMap<String, Object> checkoutmap,@RequestParam String userId, @RequestParam String checkoutPrice) {
		
		logger.info("checkout");
		String[] arrayInfo = null;
		String code = checkoutmap.get("arrayParam").toString();
		
		arrayInfo = code.split(",");
		int[] results= new int[arrayInfo.length];
        int result=1;

        HashMap<String, Object> resendMap = new HashMap<String, Object>();
        for(int i=0; i < arrayInfo.length; i++){
	         
            resendMap.put("code", arrayInfo[i]);  
            resendMap.put("no", checkoutmap.get("idx")); 
            resendMap.put("date", checkoutmap.get("item"));
	        
            results[i] = dao.checkout(resendMap); 
            result *= results[i];
        }
        CartDto dto = service.findInfo(userId);
		model.addAttribute("info", dto);
		model.addAttribute("checkoutPrice",checkoutPrice);
		
		return resendMap;
	}
	
	
	
	//
	
	
	
	
	@RequestMapping(value = "/test_check", method = RequestMethod.POST)
	@ResponseBody
	public String testCheck(Model model,HttpServletRequest request) {
	   
		

		
	    logger.info("test_check");
	
	    String[] valueArrTest = request.getParameterValues("valueArrTest");
	    
    	
		return "cart/toOrder";
	    
	}
	@RequestMapping(value = "/checkout2", method = RequestMethod.POST)
	public String[] checkout2(HttpServletRequest request) {
		
		logger.info("checkout");
		String[] valueArrTest = request.getParameterValues("valueArrTest");
		for (String c : valueArrTest) {
            logger.info(c);
        }
		
		return valueArrTest;
	}




	

		@RequestMapping(value = "/toOrder", method = RequestMethod.POST)
		public String toOrder(Model model , HttpSession session, @RequestParam String userId, HttpServletRequest request) {
			logger.info("toOrder 컨트롤러 이동 {}", userId);
			
			String[] array = request.getParameterValues("arr");
			for (int i = 0; i < array.length; i++) {
				logger.info("array[i] :{}",array[i]);
			}
					
			ArrayList<CartDto> dto = service.toOrder(userId, array);
			
			model.addAttribute("orderList", dto);
			return "cart/toOrder";
		}

		
		@RequestMapping(value = "/doOrder", method = RequestMethod.POST)
		public String doOrder(Model model , HttpSession session, @RequestParam HashMap<String, String> params, HttpServletRequest request) {
			
			//toOrder에서 가져온 파라미터
			String[] productCodeArray = request.getParameterValues("product_code");
			String[] productNameArray = request.getParameterValues("product_name");
			String[] quantityArray =  request.getParameterValues("quantity");
			String[] priceArray =  request.getParameterValues("price");
			String[] totalPriceArray =  request.getParameterValues("totalPrice");
			String userId = (String) session.getAttribute("userId");		
			String username = params.get("userName");
			String zipcode = params.get("zipcode");
			String address = params.get("address");
			String address_detail = params.get("address_detail");
			String email = params.get("email");
			String phone = params.get("phone");
			
			//주문번호 생성
		    java.util.Date now = new java.util.Date();
		    SimpleDateFormat vans = new SimpleDateFormat("yyyyMMdd");
		    String wdate = vans.format(now);
			String order_num = "S" + wdate + service.getOrderIdx();
			
			
			//tb_order에 insert할 파라미터들을 arrayList에 담음
			CartDto dto = new CartDto();
			for (int i = 0; i < totalPriceArray.length; i++) {
				
				dto.setUserId(userId);
				dto.setUsername(username);
				dto.setZipcode(zipcode);
				dto.setAddress(address);
				dto.setAddress_detail(address_detail);
				dto.setEmail(email);
				dto.setPhone(phone);
				dto.setProduct_code(productCodeArray[i]);
				dto.setProduct_name(productNameArray[i]);
				dto.setQuantity(Integer.parseInt(quantityArray[i]));
				dto.setPrice(priceArray[i]);
				dto.setTotalPrice(Integer.parseInt(totalPriceArray[i]));
				dto.setOrder_num(order_num);
				
				service.doOrder(dto);//order테이블에 추가
				service.delCartByProductCode(userId, productCodeArray[i]);//카트테이블에서 삭제
			}
			
			
			model.addAttribute("order_num", order_num);
			int cartCnt = service.HeadergetCart(userId);//헤더의 장바구니수 조정
			session.setAttribute("cartCnt", cartCnt);
			
			return "cart/completeOrder";
		}
	
}








































































