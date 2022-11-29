package com.guddi.shop.service;


import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.guddi.shop.dao.CartDao;
import com.guddi.shop.dto.CartDto;



@Service
public class CartService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired CartDao dao;

	
	public ArrayList<CartDto> getCartInfo(String userId) {
		logger.info("service"+userId);
		return dao.getCartInfo(userId);
	}
	
	public ArrayList<CartDto> getCartInfoImg(String userId) {
		logger.info("service get img"+userId);
		return dao.getCartInfoImg(userId);
	}

	public int delCart(CartDto dto) {
		// TODO Auto-generated method stub
		return dao.delCart(dto);
	}
	
	//카트 수 가져오기 Start yonghyeon 2022.01.11
	public int getCart(String userId) {
		logger.info("카트수 찾기 실행! 아이디 : {}", userId);
		return dao.getCart(userId);
	}		
	
	public int cartupdate(CartDto dto) {
		logger.info("service : "+dto);
		return dao.cartupdate(dto);
	}
	
	public int chkdelete(ArrayList<String> delList) {
		int success = 0;
		
		for(String idx : delList) {
			success += dao.chkdelete(idx);
		}

		logger.info("삭제할 갯수 : {} ", delList.size());
		logger.info("삭제 완료한 갯수 : {} ", success);
		
		return success;
	}

	public CartDto findInfo(String userId) {
		// TODO Auto-generated method stub
		return dao.findInfo(userId);
	}

	public ArrayList<CartDto> toOrder(String userId, String[] array) {
		// TODO Auto-generated method stub
		logger.info("userId:{}", userId);
		return dao.toOrder(userId, array);
	}

	public String getOrderIdx() {
		// TODO Auto-generated method stub
		return dao.getOrderIdx();
	}

	public void doOrder(CartDto dto) {
		// TODO Auto-generated method stub
			dao.doOrder(dto);
		
	}

	public void delCartByProductCode(String userId, String product_code) {
		// TODO Auto-generated method stub
		dao.delCartByProductCode(userId, product_code);
	}

	public int HeadergetCart(String userId) {
		logger.info("카트수 찾기 실행! 아이디 : {}", userId);
		return dao.HeadergetCart(userId);
	}

	

}
