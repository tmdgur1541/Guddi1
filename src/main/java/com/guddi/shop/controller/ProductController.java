package com.guddi.shop.controller;


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

import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.ListPageDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;
import com.guddi.shop.service.ManagerService;
import com.guddi.shop.service.ProductService;

@Controller
public class ProductController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired ProductService service;
	@Autowired ManagerService managerService;
	
	//2022.01.13 유지홍 제품 리스트 관련 소스 Start
	@RequestMapping(value = "/productPage", method = RequestMethod.GET)
	public String getListPageSearch(Model model, @RequestParam("num") int num, @RequestParam("brand_idx") int brand_idx,
			HttpSession session, @RequestParam(value="bag_type",required=false,defaultValue="") int bag_type, 						
			@RequestParam(value="keyword",required=false,defaultValue="") String keyword) throws Exception {
		
		getCategory(session);		
		ArrayList<EtcDto> bagcategory =(ArrayList<EtcDto>) session.getAttribute("bagtype");
		String bag_name = null;
		for (int i = 0; i < bagcategory.size(); i++) {
			if (bagcategory.get(i).getType_idx()==bag_type) {
				bag_name = bagcategory.get(i).getType_name();
			}
		}
		ArrayList<EtcDto> brandcategory =(ArrayList<EtcDto>) session.getAttribute("brandcategory");
		String brand_name = null;
		for (int i = 0; i < brandcategory.size(); i++) {
			if (brandcategory.get(i).getBrand_idx()==brand_idx) {
				brand_name = brandcategory.get(i).getBrand_name();
			}
		}	
		logger.info("bag_type : {}" ,bag_type);
		logger.info("bag_name : {}" ,bag_name);
		
		logger.info("페이지 정보 : {}" ,num +" : "+ brand_idx +" : "+ bag_type +" : "+ keyword);
		//페이징 처리를 위한 작업
		ListPageDto page = new ListPageDto();
	  
		page.setNum(num);
		page.setCount(service.searchCount(brand_idx, bag_name, keyword));
		logger.info("page.getCount() : {}",page.getCount());
		//검색타입과 검색어	 
		page.setKeyword(keyword);		
	  
		ArrayList<ProductDto> list = service.listPageSearch(page.getDisplayPost(),page.getPostNum(),keyword, brand_idx, bag_name);

		logger.info("list.size()  : {}", list.size());  	
	  
		model.addAttribute("list", list); //리스트 보내기
		model.addAttribute("page", page); //페이징처리
		model.addAttribute("select", num);//페이징처리	  
		model.addAttribute("keyword", keyword); //검색어	  
		model.addAttribute("bag_type", bag_type);//가방종류인덱스
		model.addAttribute("brand_idx", brand_idx);  //브랜드인덱스
		model.addAttribute("brand_name", brand_name);  //브랜드명
	  
		return "product/productPage";
	  
	 }	
	
	public void getCategory(HttpSession session){
		
		//각종 카테고리를 가져와 세션에 저장
		ArrayList<EtcDto> brandcategory = managerService.getBrandcategory();
		ArrayList<EtcDto> bagtype = managerService.getBagtype();
		ArrayList<EtcDto> sellflg = managerService.getSellflg();
		ArrayList<EtcDto> answertype = managerService.getAnswertype();
		ArrayList<EtcDto> newflg = managerService.getNewflg();
				
		session.setAttribute("newflg", newflg);
		session.setAttribute("brandcategory", brandcategory);
		session.setAttribute("bagtype", bagtype);
		session.setAttribute("sellflg", sellflg);
		session.setAttribute("answertype", answertype);	
		
	}
	
	
	
	
	
	
	/**
	 * @param model
	 * @param session
	 * @param idx
	 * @param reviewNum
	 * @return
	 */
	
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Model model,HttpSession session,@RequestParam String idx/*제품idx*/ 
			,@RequestParam int reviewNum) {
		//Integer.parseInt() <- string 에서 int로 형변환 할때 사용
		logger.info("상품정보 요청");

		/*session.setAttribute("userId","liujihong");
		String userId = (String) session.getAttribute("userId");
		model.addAttribute("userId",userId);
		logger.info((String) userId); */
		logger.info("idx : "+idx);
	
		ArrayList<ProductDto>detail = service.detail(idx);//제품 호출
		logger.info("detail : {}",detail);
		model.addAttribute("detail",detail);
	
		ArrayList<ProductDto>productimage = service.productimage(idx);//이미지호출
		model.addAttribute("productimage", productimage);
	
		PageDto reviewPage = new PageDto();
	  
		reviewPage.setNum(reviewNum);
		reviewPage.setCount(service.searchReviewCount(idx));		
	
		ArrayList<ReviewQnaDto>reviewlist = service.reviewlist(idx, reviewPage.getDisplayPost(),reviewPage.getPostNum());//리뷰호출
		logger.info("reviewlist : "+reviewlist);
		
		ArrayList<ReviewQnaDto> answerList = service.answerLsit(idx);
		
		for (int i = 0; i < answerList.size(); i++) {
			logger.info("answerList : " +answerList.get(i).getContent());
		}
		model.addAttribute("answerList", answerList);
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("select", reviewNum);
		model.addAttribute("num", reviewNum);
		model.addAttribute("page", reviewPage);
		model.addAttribute("idx", idx);
	
		return "product/detailproduct";
	}
		
		@RequestMapping(value = "/doCartUpdate", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> doCartUpdate(HttpSession session,@RequestParam String product_name
				,@RequestParam String product_code,@RequestParam int price,@RequestParam int quantity) {
			
			String userId = (String) session.getAttribute("userId");
			logger.info("userId : {}", userId);
			CartDto dto = new CartDto();
			
			dto.setProduct_name(product_name);
			dto.setUserId(userId);
			dto.setProduct_code(product_code);
			dto.setPrice(String.valueOf(price));
			dto.setQuantity(quantity);
					
			int result = service.doCartUpdate(dto);
			HashMap<String, Object> map = new HashMap<String, Object>();
			logger.info("장바구니 담기 유무 : {}",result);
			int cartCnt = service.getCart(userId);//카트수 가져오기
			logger.info("카트 수 : {}", cartCnt);
			session.setAttribute("cartCnt", cartCnt);
			map.put("success", result);
			    
			return map;
		}
		
		@RequestMapping(value = "/reviewupdate", method = RequestMethod.POST)
		@ResponseBody
		public HashMap<String, Object> reviewupdate(HttpSession session,
				@RequestParam String reviewsubject,@RequestParam String reviewcontent,
				@RequestParam String product_code) {
			
			String userId = (String) session.getAttribute("userId");
			logger.info(userId,reviewsubject,reviewcontent);
			ReviewQnaDto dto = new ReviewQnaDto();
			dto.setSubject(reviewsubject);
			dto.setContent(reviewcontent);
			dto.setProduct_code(product_code);
			dto.setUserId(userId);
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			int orderCount= service.checkOrder(product_code, userId);
			logger.info("orderCount : {}", orderCount);
			map.put("success", orderCount);
			
			if (orderCount>0) {
				int result = service.reviewupdate(dto);
				map.put("success", result);
			}
			
			
			return map;
		}
		
		@RequestMapping(value = "/reviewdelete", method = RequestMethod.GET)
		@ResponseBody
		public HashMap<String,Object> reviewdelete(Model model,@RequestParam String idx) {
		//Integer.parseInt() <- string 에서 int로 형변환 할때 사용
			logger.info("리뷰 삭제요청 idx : "+idx);
			HashMap<String,Object>map = new HashMap<String,Object>();
			int result = service.reviewdelete(idx);
			logger.info("result : {}"+result);
			if (result > 0) {
				map.put("success",result);
			}else {
				map.put("success","0");
			}
			return map;
		}
		
	

}













