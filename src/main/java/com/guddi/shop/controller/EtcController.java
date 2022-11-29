package com.guddi.shop.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

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

import com.guddi.shop.dao.CartDao;
import com.guddi.shop.dao.EtcDao;
import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;
import com.guddi.shop.service.CartService;
import com.guddi.shop.service.EtcService;

@Controller
public class EtcController {


	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired EtcService service;
	@Autowired ServletContext servletContext;
	

	@RequestMapping(value = "/toNewFlgCategory", method = RequestMethod.GET)
	public String toNewFlgCategory(Model model , HttpSession session) {
		logger.info("toNewFlgCategory 요청");
		
		ArrayList<EtcDto> dto = service.getNewFlgInfo();//신상여부 리스트를 가져옮		
		ArrayList<EtcDto> uDto = service.getUseFlgInfo();//사용여부정보를 가져옮
		
		model.addAttribute("newFlgList", dto);
		model.addAttribute("useFlgList", uDto);
		

		return "etc/newFlgCategory";
	}	
	
	@RequestMapping(value = "/registNewflg", method = RequestMethod.GET)
	public String registNewflg(Model model , HttpSession session) {
		logger.info("registNewflg 요청");
		

		return "etc/registNewflg";
	}
	
	@RequestMapping(value = "/doRegistNewFlg", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doRegistNewFlg(Model model , @RequestParam String newname) {
		logger.info("doRegistNewFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		int result = service.doRegistNewFlg(newname);
		
		if (result>0) {
			map.put("result", result);
		}
		return map;
	}
	
	@RequestMapping(value = "/doUpdateUseFlg", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doUpdateUseFlg(Model model , @RequestParam String idx, @RequestParam String use_flg) {

		
		logger.info("doUpdateUseFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		logger.info("use_flg : {}",use_flg);
		logger.info("idx :  {}",idx);
				
		int result = service.doUpateUseFlg(Integer.parseInt(use_flg) , Integer.parseInt(idx));
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping(value = "/toSellFlgCategory", method = RequestMethod.GET)
	public String toSellFlgCategory(Model model , HttpSession session) {
		logger.info("toSellFlgCategory 요청");
		
		ArrayList<EtcDto> dto = service.getSellFlgInfo();//신상여부 리스트를 가져옮		
		ArrayList<EtcDto> uDto = service.getUseFlgInfo();//사용여부정보를 가져옮
		
		model.addAttribute("sellFlgList", dto);
		model.addAttribute("useFlgList", uDto);
		

		return "etc/sellFlgCategory";
	}
	
	@RequestMapping(value = "/registSellflg", method = RequestMethod.GET)
	public String registSellflg(Model model , HttpSession session) {
		logger.info("registNewflg 요청");
		

		return "etc/registSellflg";
	}
	
	@RequestMapping(value = "/doRegistSellFlg", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doRegistSellFlg(Model model , @RequestParam String sellname) {
		logger.info("doRegistSellFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();		
		int result = service.doRegistSellFlg(sellname);
		
		if (result>0) {
			map.put("result", result);
		}
		return map;
	}
	
	@RequestMapping(value = "/doUpdateSellUseFlg", method = RequestMethod.POST)
	@ResponseBody            
	public HashMap<String, Object> doUpdateSellUseFlg(Model model , @RequestParam String idx, @RequestParam String use_flg) {
		
		logger.info("doUpdateSellUseFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		logger.info("use_flg : {}",use_flg);
		logger.info("idx :  {}",idx);
	
		int result = service.doUpdateSellUseFlg(Integer.parseInt(use_flg) , Integer.parseInt(idx));
		map.put("result", result);
		
		
	
		return map;
	}

	@RequestMapping(value = "/toMainImage", method = RequestMethod.GET)
	public String toMainImage(Model model) {
		logger.info("toMainImage 요청");
		
		ArrayList<EtcDto> dto = service.getMainImageList();//메인이미지정보를 가져오는 함수
		ArrayList<MemberDto> userLists = service.getUserInfo();//유저정보를 가져오는 함수
		ArrayList<EtcDto> uDto = service.getUseFlgInfo();//사용여부정보를 가져옮
		
		model.addAttribute("userLists", userLists);
		model.addAttribute("useFlgList", uDto);		
		model.addAttribute("imageDto", dto);
		
		
		return "etc/mainImageControl";
	}
	
	@RequestMapping(value = "/addMainimage", method = RequestMethod.GET)
	public String addMainimage(Model model, HttpSession session) {
		logger.info("addMainimage 요청");
		
		return "etc/addMainImage";
	}

	@RequestMapping(value = "/doUpdateMemFlg", method = RequestMethod.POST)
	@ResponseBody            
	public HashMap<String, Object> doUpdateMemFlg(Model model , @RequestParam String idx, @RequestParam(value="mem_flg",required=false,defaultValue="") String mem_flg) {
		
		logger.info("doUpdateMemFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		logger.info("use_flg : {}",mem_flg);
		logger.info("idx :  {}",idx);
	
		int result = service.doUpdateMemFlg(Integer.parseInt(mem_flg) , Integer.parseInt(idx));
		map.put("result", result);
		
		

		return map;
	}
	

	
	@RequestMapping(value = "/doAddMainImage", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doAddMainImage(Model model, @RequestParam MultipartFile file, HttpSession session) {	
		logger.info("doAddMainImage 요청");	
		HashMap<String, Object> map = new HashMap<String, Object>();
		int idx = service.getMainImageIdx();
		String userId = (String) session.getAttribute("userId");
		int u_idx = service.getU_idx(userId);
		logger.info("u_idx : {}",u_idx);
		int result = service.doAddMainImage(idx, u_idx, file);
		
		map.put("result", result);
		
		return map;
	}	
	@RequestMapping(value = "/delMainImage", method = RequestMethod.GET)
	public String delMainImage(Model model, @RequestParam int idx, @RequestParam String newFileName) {
		logger.info("delMainImage 요청");
		
		int result = service.delMainImage(idx);
		
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
			ArrayList<EtcDto> dto = service.productMainImageInfo();
			for (int i = 0; i < dto.size(); i++) {
				int newPhotoNum = i+1;
				int oriPhotoNum = dto.get(i).getIdx();
				service.updateMainPhotoNum(newPhotoNum,oriPhotoNum) ;				
			}
		}		
		
		return "redirect:/toMainImage";
	}
	
	@RequestMapping(value = "/doUpdateImageUseFlg", method = RequestMethod.POST)
	@ResponseBody            
	public HashMap<String, Object> doUpdateImageUseFlg(Model model , @RequestParam String idx, @RequestParam String use_flg) {
		
		logger.info("doUpdateImageUseFlg 요청");
		HashMap<String, Object> map = new HashMap<String, Object>();		
		
		logger.info("use_flg : {}",use_flg);
		logger.info("idx :  {}",idx);
	
		int result = service.doUpdateImageUseFlg(Integer.parseInt(use_flg) , Integer.parseInt(idx));
		map.put("result", result);

		return map;
	}
	
	@RequestMapping(value = "/updateMainImageOrder")
	@ResponseBody
	public HashMap<String, Object>  updateMainImageOrder(HttpServletRequest request) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	        
	    String[] newOrder = request.getParameterValues("newOrder");
	    String[] newFileName = request.getParameterValues("newFileName");
	    
	    for (int i = 0; i < newFileName.length; i++) {
	    	logger.info("newOrder:{}", newOrder[i]);
		}
	    
	    int result = service.updateImageOrder(newOrder,newFileName);
	    if (result>0) {
	    	String resultMsg = "순서변경 성공!";
	  	    map.put("result", resultMsg);
	  	    System.out.println("Controller에서 보낸 MSG : "+ resultMsg);
		}	  
	        
	    return map;
	}
	
	@RequestMapping(value = "/toBrandCategory", method = RequestMethod.GET)
	public String toBrandCategory(Model model , HttpSession session) {
		logger.info("toBrandCategory 이동요청");
		
		ArrayList<EtcDto> dto = service.getBrand();
		ArrayList<EtcDto> udto = service.getUseFlgInfo();
		
		model.addAttribute("brandList", dto);
		model.addAttribute("useFlgList", udto);
		
		return "etc/brandCategory";
	}
	
	@RequestMapping(value = "/doRegistBrand", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doRegistBrand(Model model 
			, @RequestParam String name, @RequestParam String code) {
		logger.info("doRegistBrand 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = service.doRegistBrand(name,code);
		
		if(result>0) {
			map.put("result", result);
		}
		
		return map;
	}
	
	@RequestMapping(value = "/doUpdateBrandUse", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doUpdateBrandUse(Model model 
			, @RequestParam String brand_idx, @RequestParam String use_flgName) {
		logger.info("doUpdateBrandUse 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int useflg = 100;
		ArrayList<EtcDto> uDto = service.getUseFlgInfo();
		
		for (int i = 0; i < uDto.size(); i++) {
			if(uDto.get(i).getUseFlg_name().equals(use_flgName)) {
				useflg = uDto.get(i).getIdx();
			}
		}
		
		if(useflg != 100) {
			int result = service.doUpdateBrandUse(useflg, Integer.parseInt(brand_idx));
			map.put("result", result);
		}
	
		
		return map;
	}
	
	@RequestMapping(value = "/tobagTypeCategory", method = RequestMethod.GET)
	public String tobagTypeCategory(Model model , HttpSession session) {
		logger.info("tobagTypeCategory 페이지 이동");
		
		ArrayList<EtcDto> dto = service.getType();
		ArrayList<EtcDto> udto = service.getUseFlgInfo();
		
		model.addAttribute("typeList", dto);
		model.addAttribute("useFlgList", udto);
		
		
		return "etc/bagTypeCategory";
	}
	
	@RequestMapping(value = "/doRegistType", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doRegistType(Model model 
			, @RequestParam String name, @RequestParam String code) {
		logger.info("doRegistType 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int result = service.doRegistType(name,code);
		
		if(result>0) {
			map.put("result", result);
		}
		
		return map;
	}
	
	@RequestMapping(value = "/doUpdateTypeUse", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> doUpdateTypeUse(Model model 
			, @RequestParam String type_idx, @RequestParam String use_flgName) {
		logger.info("doUpdateTypeUse 요청");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int useflg = 100;
		ArrayList<EtcDto> uDto = service.getUseFlgInfo();
		
		for (int i = 0; i < uDto.size(); i++) {
			if(uDto.get(i).getUseFlg_name().equals(use_flgName)) {
				useflg = uDto.get(i).getIdx();
			}
		}
		
		if(useflg != 100) {
			int result = service.doUpdateTypeUse(useflg, Integer.parseInt(type_idx));
			map.put("result", result);
		}
	
		
		return map;
	}
	
		@RequestMapping(value = "/toUpdateQnaCategory", method = RequestMethod.GET)
		public String toUpdateQnaCategory(Model model, HttpSession session, @RequestParam String userIdx) {
			logger.info("userIdx {}", userIdx);
			logger.info("toUpdateQnaCategory 이동");		
			ArrayList<EtcDto> qnaList = service.toUpdateQnaCategory();
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("userIdx", userIdx);
			for(EtcDto dto : qnaList) {
				logger.info("타입명 : {}",dto.getTypename());
				//logger.info("타입명 : {}",dto.getType_name());
			}
			return "etc/toUpdateQnaCategory";
		}
		
		@RequestMapping(value = "/addQna", method = RequestMethod.GET)
		@ResponseBody
		public HashMap<String, Object> addQna(@RequestParam String userIdx, @RequestParam String keyword, @RequestParam String idxCount) {
			logger.info("keyword : {}", keyword);
			logger.info("userIdx : {}", userIdx);
			logger.info("keyword : {}", idxCount);
			int userIdxInt = Integer.parseInt(userIdx);
			int idxCountInt = Integer.parseInt(idxCount);
			logger.info("userIdxInt : {}", userIdxInt);
			logger.info("idxCountInt : {}", idxCountInt);
			service.addQna(userIdxInt, keyword, idxCountInt);
			HashMap<String, Object> map = new HashMap<String, Object>();
			ArrayList<EtcDto> qnaList = service.toUpdateQnaCategory();
			logger.info("qnaList 사이즈 {}", qnaList.size());
			map.put("qnaList", qnaList);
			return map;
		}
		
		@RequestMapping(value = "/changUseFlg", method = RequestMethod.GET)
		@ResponseBody
		public HashMap<String, Object> changUseFlg(@RequestParam String changUseFlg, @RequestParam String typename, @RequestParam String userIdx) {
			logger.info("changUseFlg : {}", changUseFlg);
			logger.info("typename : {}", typename);
			logger.info("userIdx : {}", userIdx);
			int changUseFlgInt = Integer.parseInt(changUseFlg);
			int userIdxInt = Integer.parseInt(userIdx);
			logger.info("userIdxInt : {}", userIdxInt);
			logger.info("userIdxInt : {}", changUseFlgInt);
			service.changUseFlg(changUseFlgInt, typename, userIdxInt);
			HashMap<String, Object> map = new HashMap<String, Object>();
			ArrayList<EtcDto> qnaList = service.toUpdateQnaCategory();
			logger.info("qnaList 사이즈 {}", qnaList.size());
			map.put("qnaList", qnaList);
			return map;
		}

		//승혁님 문의타입 카테고리 제어관련 End
	
	
}
