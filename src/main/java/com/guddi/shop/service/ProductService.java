package com.guddi.shop.service;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.guddi.shop.dao.ProductDao;
import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;

@Service
public class ProductService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired ProductDao dao;
		
	
	public int searchCount(int brand_idx, String bag_name, String keyword) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		  
		dto.setBrand_type(brand_idx);
		dto.setKeyword(keyword);
		dto.setBag_name(bag_name);
		
		return dao.searchCount(dto);
	}

	public ArrayList<ProductDto> listPageSearch(int displayPost, int postNum, 
			String keyword, int brand_idx, String bag_name) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		
		dto.setBag_name(bag_name);
		dto.setBrand_type(brand_idx);
		logger.info("displayPost : {}", displayPost);
		logger.info("postNum : {}", postNum);
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(keyword);		
		
		return dao.listPageSearch(dto);
	}

		public ArrayList<ProductDto> detail(String idx) {			
			return dao.detail(idx);
		}
		public ArrayList<ProductDto> productimage(String idx) {
			return dao.productimage(idx);
		}
		public int doCartUpdate(CartDto dto) {
			return dao.doCartUpdate(dto);
		}
		

		public int reviewupdate(ReviewQnaDto dto) {
			return dao.reviewupdate(dto);
		}

		public int reviewdelete(int idx) {
			return dao.reviewdelete(idx);
		}
	//상세페이지 관련 충구형님 2022.01.17 End

		public int searchReviewCount(String idx) {
			// TODO Auto-generated method stub
			return dao.searchReviewCount(idx);
		}

		public ArrayList<ReviewQnaDto> reviewlist(String idx, int displayPost, int postNum) {
			// TODO Auto-generated method stub
			PageDto dto = new PageDto();
			dto.setDisplayPost(displayPost);
			dto.setPostNum(postNum);
			dto.setIdx(Integer.parseInt(idx));
			return dao.reviewlist(dto);
		}

		public int checkOrder(String product_code, String userId) {
			// TODO Auto-generated method stub
			return dao.checkOrder(product_code,userId);
		}

		public ArrayList<ReviewQnaDto> answerLsit(String idx) {
			// TODO Auto-generated method stub
			return dao.answerLsit(idx);
		}
		
		public int reviewdelete(String idx) {
			logger.info("리뷰 삭제 dao요청");
			return dao.reviewdelete(idx);
		}

		public int getCart(String userId) {
			logger.info("카트수 찾기 실행! 아이디 : {}", userId);
			return dao.getCart(userId);

		}


}
