package com.guddi.shop.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletContext;
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
import org.springframework.web.multipart.MultipartFile;

import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;
import com.guddi.shop.service.ManagerService;
import com.guddi.shop.service.MemberService;

@Controller
public class ManagerController {	
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired ManagerService service;
	@Autowired MemberService memService;
	@Autowired ServletContext servletContext;
	
	
	@RequestMapping(value = "/productMain", method = RequestMethod.GET)
	public String productMain(Model model, HttpSession session, @RequestParam("num") int num,  
			@RequestParam(value="brand_type",required=false,defaultValue = "0") int brand_type, 
			@RequestParam(value="bag_type",required=false,defaultValue = "0") int bag_type, 
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword) {	
		
		logger.info("productMain 요청");	
		
		getCategory(session);
		ArrayList<EtcDto> brandtypeInfo = (ArrayList<EtcDto>) session.getAttribute("brandcategory");
		ArrayList<EtcDto> bagtypeInfo = (ArrayList<EtcDto>) session.getAttribute("bagtype");
		String brand_name = null;
		String bag_name = null;
		
		if (brand_type!=0) {
			for (int i = 0; i < brandtypeInfo.size(); i++) {
				if (brandtypeInfo.get(i).getBrand_idx()==brand_type) {
					brand_name = brandtypeInfo.get(i).getBrand_name();
				}
			}			
		}
		if (bag_type!=0) {
			for (int i = 0; i < bagtypeInfo.size(); i++) {
				if (bagtypeInfo.get(i).getType_idx()==bag_type) {
					bag_name = bagtypeInfo.get(i).getType_name();
				}
			}			
		}	

		PageDto Page = new PageDto();
		
		Page.setNum(num);
		Page.setCount(service.productSearchCount(keyword, brand_name,bag_name));				
		Page.setKeyword(keyword);
		
		logger.info("Page.getCount() : {}",Page.getCount());
		
		ArrayList<ProductDto> productList = 
				service.productList(Page.getDisplayPost(), Page.getPostNum(), keyword, brand_name, bag_name);
				
		model.addAttribute("productList", productList); //리스트 보내기
		model.addAttribute("page", Page); //페이징처리
		model.addAttribute("select", num);//페이징처리		  
		model.addAttribute("keyword", keyword); //검색어
		model.addAttribute("bag_type", bag_type); 
		model.addAttribute("brand_type", brand_type); //검색어		
		
		return "manager/productMain";
	}
	
	@RequestMapping(value = "/registProduct", method = RequestMethod.GET)
	public String registProduct(Model model, HttpSession session) {	
		logger.info("registProduct 요청");
		
		getCategory(session);
		
		return "manager/registProduct";
	}
	
	@RequestMapping(value = "/updateProduct", method = RequestMethod.GET)
	public String updateProduct(Model model, HttpSession session, @RequestParam int idx) {	
		logger.info("updateProduct 요청");
		
		getCategory(session);
		//제품에 대한 정보를 가져오는 함수
		ProductDto dto = service.productInfo(idx);
		//제품 이미지 정보를 가져오는 함수
		ArrayList<ProductDto> imageDto = service.productImageInfo(idx);
		
		model.addAttribute("dto", dto);
		model.addAttribute("imageDto", imageDto);
		
		return "manager/updateProduct";
	}
	
	@RequestMapping(value = "/updateProductImage", method = RequestMethod.GET)
	public String updateProductImage(Model model, @RequestParam int idx) {	
		logger.info("updateProductImage 요청");
				
		//제품 이미지 정보를 가져오는 함수
		ArrayList<ProductDto> imageDto = service.productImageInfo(idx);		
		
		model.addAttribute("imageDto", imageDto);
		model.addAttribute("idx", idx);
		
		return "manager/updateProductImage";
	}
	
	@RequestMapping(value = "/makeProductCode", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> makeProductCode() {		
		
		logger.info("makeProductCode 요청");;

		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<EtcDto> brandType = service.getBrandcategory();
		ArrayList<EtcDto> bagType = service.getBagtype();
		String idx = service.getNewIdx();
		if (idx==null) {
			idx="0";
		} 
		int newIdx = Integer.parseInt(idx)+1;
		
		map.put("brandType", brandType);
		map.put("bagType", bagType);
		map.put("newIdx", newIdx);
		
		return map;
	}
	
	@RequestMapping(value = "/addimage", method = RequestMethod.GET)
	public String addimage(Model model) {	
		logger.info("addimage 요청");		
		
		return "manager/addImage";
	}	
	
	
	@RequestMapping(value = "/doUpdateProduct", method = RequestMethod.POST)
	public String doUpdateProduct(Model model,  @RequestParam HashMap<String, String> params, HttpSession session) {	
		logger.info("doUpdateProduct 요청");		
		getCategory(session);
		ArrayList<EtcDto> brandtypeInfo = (ArrayList<EtcDto>) session.getAttribute("brandcategory");
		ArrayList<EtcDto> bagtypeInfo = (ArrayList<EtcDto>) session.getAttribute("bagtype");
		int u_idx =(int) session.getAttribute("u_idx");
		service.doUpdateProduct(params, session, brandtypeInfo, bagtypeInfo, u_idx);
		
		
		return "redirect:/productMain?num=1&brand_idx=0";
	}
	
	//이미지 삭제처리
	@RequestMapping(value = "/delImage", method = RequestMethod.GET)
	public String delImage(Model model,  @RequestParam int photoNum, @RequestParam int idx, @RequestParam String newFileName) {	
		logger.info("delImage 요청");	
		//Db에서 이미지정보삭제처리
		int result = service.delImage(photoNum, idx);
		
		//실제 저장된 이미지 삭제처리
		if (result>0) {			
			String realPath = servletContext.getRealPath("/resources/photo");
			
			try {				
				Path path = Paths.get(realPath +"/"+ newFileName);
				logger.info("실제 경로 : {}",path);
				Files.delete(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			//photo_num재설정
			ArrayList<ProductDto> dto = service.productImageInfo(idx);
			for (int i = 0; i < dto.size(); i++) {
				int newPhotoNum = i+1;
				int oriPhotoNum = dto.get(i).getPhoto_num();
				service.updatePhotoNum(newPhotoNum,oriPhotoNum) ;				
			}
		}		
		return "redirect:/updateProductImage?idx="+idx;
	}
		
	@RequestMapping(value = "/doAddImage", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doAddImage(Model model, @RequestParam int idx, 
			@RequestParam MultipartFile file, HttpSession session) {	
		logger.info("doAddImage 요청");	
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		String userId = (String) session.getAttribute("userId");
		int result = service.doAddImage(idx, file, userId);
		
		map.put("result", result);
		
		return map;
		
	}	
	
	@RequestMapping(value = "/updateImageOrder")
	@ResponseBody
	public HashMap<String, Object>  updateImageOrder(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	        
	    String[] newOrder = request.getParameterValues("newOrder");
	    String[] newFileName = request.getParameterValues("newFileName");
	    
	    int result = service.updateImageOrder(newOrder,newFileName);
	    if (result>0) {
	    	String resultMsg = "순서변경 성공!";
	  	    map.put("result", resultMsg);
	  	    System.out.println("Controller에서 보낸 MSG : "+ resultMsg);
		}	  
	        
	    return map;
	}
	
	
	@RequestMapping(value = "/doRegistProduct", method = RequestMethod.POST)
	public String doRegistProduct(Model model, @RequestParam HashMap<String, String> params
			,@RequestParam MultipartFile[] files, HttpSession session) {
		
		getCategory(session);
		ArrayList<EtcDto> brandtypeInfo = (ArrayList<EtcDto>) session.getAttribute("brandcategory");
		ArrayList<EtcDto> bagtypeInfo = (ArrayList<EtcDto>) session.getAttribute("bagtype");
		String userId = (String) session.getAttribute("userId");
		int brand_idx = Integer.parseInt(params.get("brand_type"));
		int bag_type = Integer.parseInt(params.get("bag_type"));
		String brand_name = null;
		String bag_name = null;
		
		
			for (int i = 0; i < brandtypeInfo.size(); i++) {
				if (brandtypeInfo.get(i).getBrand_idx()==brand_idx) {
					brand_name = brandtypeInfo.get(i).getBrand_name();
				}
			}				
			for (int i = 0; i < bagtypeInfo.size(); i++) {
				if (bagtypeInfo.get(i).getType_idx()==bag_type) {
					bag_name = bagtypeInfo.get(i).getType_name();
				}
			}		
		
		int idx = service.doRegistProduct(params, files, userId, brand_name, bag_name);		
	
		return "redirect:/productMain?num=1&brand_idx=0";
	}
	
	@RequestMapping(value = "/delProduct")
	@ResponseBody
	public HashMap<String, Object>  delProduct(@RequestParam String idx) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	
		//제품 이미지 정보 삭제 처리 
		//1. 이미지 정보 추출
		ArrayList<ProductDto> imageInfo = service.productImageInfo(Integer.parseInt(idx));
			
		//Db의 이미지 정보와 실제 저장된 이미지 파일 삭제 처리
		for (int i = 0; i < imageInfo.size(); i++) {
				
			service.delImage(imageInfo.get(i).getPhoto_num(),imageInfo.get(i).getB_idx());
			logger.info("이미지 삭제 imageInfo.get(i).getNewFileName() : {}",imageInfo.get(i).getNewFileName());
			String realPath = servletContext.getRealPath("/resources/photo");			
			try {				
				Path path = Paths.get(realPath +"/"+ imageInfo.get(i).getNewFileName());
				logger.info("실제 저장되었던 경로 : {}", path);
				Files.delete(path);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
		//제품 정보 삭제(이미지 제외)
		int result = service.delProductInfo(idx);		
	
		map.put("result", result);
	        
	    return map;
	}
	
	
	@RequestMapping(value = "/doAnswer", method = RequestMethod.POST)
	public String doAnswer(Model model,  @RequestParam HashMap<String, String> params, HttpSession session) {	
		logger.info("doAnswer 요청");		

		int idx = Integer.parseInt(params.get("idx"));
		String answer = params.get("answer");
		String userId = (String) session.getAttribute("userId");
		String flg = "1";


		int answerCount = service.countQnaAnswer(idx);
		if (answerCount==0) {
			int success = service.registQnaAnswer(idx, answer, userId);
			if (success>0) {
				service.updateAnswerFlg(idx,flg);			
			}
		}
		
		
		return "redirect:/qnaDetail?idx="+idx;
	}
	
	@RequestMapping(value = "/updateAnswer", method = RequestMethod.GET)
	public String updateAnswer(Model model,  @RequestParam String a_idx, @RequestParam String q_idx) {	
		
		logger.info("updateAnswer 요청");		
		logger.info("a_idx : {}",a_idx);
		logger.info("q_idx : {}",q_idx);
		
		ReviewQnaDto dto = memService.getQnaDetail(q_idx);
		ReviewQnaDto aDto = memService.getQnaAnswerDetail(q_idx);
		
		logger.info("aDto.getContent() :{}", aDto.getContent());
		
		//문의타입 한글화
		ArrayList<ReviewQnaDto> getQnaTypeInfo = memService.getQnaType();
		
		//숫자를 글자로 변경. ex) 1--->상품
		int type = Integer.parseInt(dto.getAnswer_type());
		for (int i = 0; i < getQnaTypeInfo.size(); i++) {
			if (getQnaTypeInfo.get(i).getIdx()==type) {
				dto.setAnswer_type(getQnaTypeInfo.get(i).getTypename());
			}
		}		
		model.addAttribute("dto", dto);
		model.addAttribute("qDto", aDto);
		model.addAttribute("a_idx", a_idx);
		model.addAttribute("q_idx", q_idx);		
		
		return "manager/updateAnswer";		

		
	}
	
	@RequestMapping(value = "/doUpdateAnswer", method = RequestMethod.POST)
	public String doUpdateAnswer(Model model,  @RequestParam HashMap<String, String> params, HttpSession session) {	
		logger.info("doAnswer 요청");		

		int idx = Integer.parseInt(params.get("idx"));
		int q_idx = Integer.parseInt(params.get("q_idx"));
		String content = params.get("content");
		String userId = (String) session.getAttribute("userId");
		
		logger.info("idx 요청 :{}",idx);		
		logger.info("q_idx 요청 :{}",q_idx);		
		logger.info("content 요청 :{}",content);		
		logger.info("userId 요청 :{}",userId);	
		
		service.doUpdateAnswer(content, userId, idx);
		
		
		return "redirect:/qnaDetail?idx="+idx;
	}
	
	@RequestMapping(value = "/doDelAnswer", method = RequestMethod.GET)
	public String doDelAnswer(Model model, @RequestParam String q_idx, @RequestParam String a_idx, HttpSession session) {	
		logger.info("doDelAnswer 요청");		


		String userId = (String) session.getAttribute("userId");
		String flg = "0";
	
		logger.info("q_idx 요청 :{}",q_idx);		
		logger.info("userId 요청 :{}",userId);	
		
		int success = service.doDelAnswer(userId, Integer.parseInt(a_idx));
		if (success>0) {
			service.updateAnswerFlg(Integer.parseInt(q_idx), flg);			
		}
		
		return "redirect:/qnaDetail?idx="+q_idx;
	}
	
	
	public void getCategory(HttpSession session){
		
		//각종 카테고리를 가져와 세션에 저장
		ArrayList<EtcDto> brandcategory = service.getBrandcategory();
		ArrayList<EtcDto> bagtype = service.getBagtype();
		ArrayList<EtcDto> sellflg = service.getSellflg();
		ArrayList<EtcDto> answertype = service.getAnswertype();
		ArrayList<EtcDto> newflg = service.getNewflg();
		
		session.setAttribute("newflg", newflg);
		session.setAttribute("brandcategory", brandcategory);
		session.setAttribute("bagtype", bagtype);
		session.setAttribute("sellflg", sellflg);
		session.setAttribute("answertype", answertype);	
		
	}
	
	
	@RequestMapping(value = "/memberList", method = RequestMethod.GET)
	public String memberList(Model model, HttpSession session, @RequestParam("num") int num,
			@RequestParam(value="mem_flg",required=false,defaultValue = "0")int mem_flg,
			@RequestParam(value="phone", required=false,defaultValue = "0")String phone
			,@RequestParam(value="keyword",required=false,defaultValue = "")String keyword){	
		logger.info("memberList 요청");
		
		getCategory(session);
		ArrayList<EtcDto> memflgInfo = (ArrayList<EtcDto>) session.getAttribute("membercategory");
		//String phone = null;
		
		/*
		if (mem_flg!=0) {
			for (int i = 0; i < memflgInfo.size(); i++) {
				if (memflgInfo.get(i).getIdx()==mem_flg) {
					phone = memflgInfo.get(i).getMemFlg_name();
				}
			}			
		}
		*/
	
		
		PageDto Page = new PageDto();
		Page.setNum(num);
		Page.setCount(service.memberSearchCount(keyword, phone, mem_flg));				
		Page.setKeyword(keyword);
		
		logger.info("Page.getCount() : {}",Page.getCount());
		
		logger.info("page.getkeyword() : {}",Page.getKeyword());
		
		ArrayList<MemberDto> memberList = 
				service.memberList(Page.getDisplayPost(), Page.getPostNum(), keyword, phone, mem_flg);
		
		model.addAttribute("memberList", memberList); //리스트 보내기
		model.addAttribute("page", Page); //페이징처리
		model.addAttribute("select", num);//페이징처리		  
		model.addAttribute("keyword", keyword); //검색어
		model.addAttribute("mem_flg", mem_flg); 

		
		/*
		ArrayList<MemberDto> memberList = service.memberList(keyword);
		logger.info("가져온 리스트 수 : {}",memberList.get(0).getMem_flg());	
		model.addAttribute("memberList",memberList);
		model.addAttribute("keyword", keyword);
		*/
		
		ArrayList<EtcDto> memFlgList = service.memFlgList();
		logger.info("가져온 요청자 : {}",memFlgList.get(0).getMemFlg_name());
		model.addAttribute("memFlgList",memFlgList);
		
		ArrayList<EtcDto> marketingFlgList = service.marketingFlgList();
		logger.info("가져온 요청자 : {}",marketingFlgList.get(0).getMarketingFlg_name());
		model.addAttribute("marketingFlgList",marketingFlgList);
		


		return "manager/memberList";
	}

	
	
	@RequestMapping(value = "/orderInfoList", method = RequestMethod.GET)
	public String orderInfoList(Model model, HttpSession session, @RequestParam("num") int num,  
			@RequestParam(value="searchType",required=false,defaultValue = "0") String searchType,
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword) {	
		
		
		PageDto Page = new PageDto();
		
		Page.setNum(num);
		Page.setKeyword(keyword);
		Page.setSearchType(searchType);
		
		Page.setCount(service.orderListSearchCount(Page));	
		
		logger.info("Page.getCount() : {}",Page.getCount());
		
		ArrayList<CartDto> orderList = 
				service.orderList(Page.getDisplayPost(), Page.getPostNum(), keyword, searchType);
				
		model.addAttribute("orderList", orderList); //리스트 보내기
		model.addAttribute("page", Page); //페이징처리
		model.addAttribute("select", num);//페이징처리		  
		model.addAttribute("keyword", keyword); 
		model.addAttribute("searchType", searchType); 
		
		
		return "manager/orderInfoList";
	}
	
	
	
	@RequestMapping(value = "/toReviewPage", method = RequestMethod.GET)
	public String toReviewPage(Model model, @RequestParam("num") int num, @RequestParam("answer_flg") int answer_flg, 
			@RequestParam(value="brandName",required=false,defaultValue = "") String brandName, 
			@RequestParam(value="bagName",required=false,defaultValue = "") String bagName, 
			@RequestParam(value="keyword",required=false,defaultValue="")String keyword) {
		
		logger.info("qnaPage 요청");		
		PageDto reviewPage = new PageDto();
		
		reviewPage.setNum(num);
		reviewPage.setCount(service.reviewSearchCount(keyword, answer_flg, brandName, bagName));				
		reviewPage.setKeyword(keyword);
		
		logger.info("review.getCount() : {}",reviewPage.getCount());
		
		ArrayList<ReviewQnaDto> reviewList = 
				service.reviewInfo(reviewPage.getDisplayPost(), reviewPage.getPostNum(), keyword, answer_flg, brandName, bagName);
		ArrayList<EtcDto> brandCategoryList = service.getbrandCategoryList();
		ArrayList<EtcDto> answerList = service.getanswerList();
		ArrayList<EtcDto> bagCategoryList = service.getbagCategoryList();
	
		model.addAttribute("reviewList", reviewList); //리스트 보내기
		model.addAttribute("reviewPage", reviewPage); //페이징처리
		model.addAttribute("select", num);//페이징처리		  
		model.addAttribute("keyword", keyword); //검색어
		model.addAttribute("answer_flg", answer_flg); //검색어
		model.addAttribute("brandName", brandName); //검색어
		model.addAttribute("bagName", bagName); //검색어
		model.addAttribute("answerList", answerList); //답변여부정보
		model.addAttribute("bagCategoryList", bagCategoryList); 
		model.addAttribute("brandCategoryList", brandCategoryList); 
	
		return "manager/reviewPage";
	}
	
	@RequestMapping(value = "/toReviewDetail", method = RequestMethod.GET)
	public String toReviewDetail(Model model, @RequestParam int idx, @RequestParam String product_name) {
		logger.info("toReviewDetail 요청");
		
		ReviewQnaDto dto = service.getReviewDetail(idx);
		ReviewQnaDto answer = service.getReviewAnswer(idx);
		
		model.addAttribute("product_name", product_name);
		model.addAttribute("review", dto);
		model.addAttribute("answer", answer);
		
		return "manager/managerReviewDetail";
	}
	@RequestMapping(value = "/doReviewAnswer", method = RequestMethod.POST)
	public String doReviewAnswer(Model model, HttpSession session,
			@RequestParam String idx, @RequestParam String answer, @RequestParam String product_name) {
		logger.info("toReviewDetail 요청");
		
		String managerId = (String) session.getAttribute("userId");
		ReviewQnaDto dto = new ReviewQnaDto();
		dto.setR_idx(Integer.parseInt(idx));
		dto.setContent(answer);
		dto.setManagerId(managerId);
		
		int count =  service.countReviewAnswer(idx);
		if (count ==0) {
			int result = service.doReviewAnswer(dto);
			logger.info("idx :{}",idx);
			int flg = 1;
			service.updateReviewFlg(flg,Integer.parseInt(idx));
		}
		
			
		ReviewQnaDto review = service.getReviewDetail(Integer.parseInt(idx));
		ReviewQnaDto reviewAnswer = service.getReviewAnswer(Integer.parseInt(idx));
			
		model.addAttribute("product_name", product_name);
		model.addAttribute("review", review);
		model.addAttribute("answer", reviewAnswer);		
		
		return "manager/managerReviewDetail";
	}
	

	@RequestMapping(value = "/doDelReviewAnswer", method = RequestMethod.GET)
	public String doDelReviewAnswer(Model model, @RequestParam int a_idx, @RequestParam int r_idx,@RequestParam String product_name) {
		logger.info("doDelReviewAnswer 요청");
		
		service.doDelReviewAnswer(a_idx);
		logger.info("r_idx,a_idx :{}",r_idx+a_idx);
		int flg = 0;
		service.updateReviewFlg(flg, r_idx);
		
		ReviewQnaDto review = service.getReviewDetail(r_idx);
		ReviewQnaDto reviewAnswer = service.getReviewAnswer(r_idx);
			
		model.addAttribute("product_name", product_name);
		model.addAttribute("review", review);
		model.addAttribute("answer", reviewAnswer);	
		
		
		return "manager/managerReviewDetail";
	}
	@RequestMapping(value = "/updateReviewAnswer", method = RequestMethod.GET)
	public String updateReviewAnswer(Model model, @RequestParam int r_idx, 
			@RequestParam int a_idx, @RequestParam String product_name) {
		logger.info("updateReviewAnswer 요청");
		
		ReviewQnaDto review = service.getReviewDetail(r_idx);
		ReviewQnaDto reviewAnswer = service.getReviewAnswer(r_idx);
			
		model.addAttribute("product_name", product_name);
		model.addAttribute("review", review);
		model.addAttribute("answer", reviewAnswer);
		
		return "manager/updateReviewAnswer";
	}
	
	@RequestMapping(value = "/doUpdateReviewAnswer", method = RequestMethod.POST)
	public String doUpdateReviewAnswer(Model model, HttpSession session,
			@RequestParam int idx, @RequestParam int a_idx, @RequestParam String answer, @RequestParam String product_name) {
		logger.info("doUpdateReviewAnswer 요청");
	
		ReviewQnaDto dto = new ReviewQnaDto();
		dto.setIdx(a_idx);
		dto.setContent(answer);
		
		logger.info("dto.getContent():{}", dto.getContent());
		logger.info("dto.getIdx():{}", dto.getIdx());
			
		service.doUpdateReviewAnswer(dto);
		
		ReviewQnaDto review = service.getReviewDetail(idx);
		ReviewQnaDto reviewAnswer = service.getReviewAnswer(idx);
			
		model.addAttribute("product_name", product_name);
		model.addAttribute("review", review);
		model.addAttribute("answer", reviewAnswer);		
		
		return "manager/managerReviewDetail";
	}
	
	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


}
