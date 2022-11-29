package com.guddi.shop.controller;


import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.service.HomeService;




@Controller
public class HomeController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired HomeService service;

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, HttpSession session ) {

		logger.info("메인이미지 요청");
		
		ArrayList<EtcDto> brandList = service.brandList();
		session.setAttribute("brandList", brandList);
		
		ArrayList<ProductDto> dto = service.rankList();
		model.addAttribute("rankList",dto);
		//logger.info("dto.get(0).getNewFileName() : {}",dto.get(0).getNewFileName());
		
		ArrayList<EtcDto> photos = service.photoList();
		//logger.info("사진 수 :{}",photos.get(0).getNewFileName());
		model.addAttribute("photos",photos);
		
		


		
		return "index";
	}

}
