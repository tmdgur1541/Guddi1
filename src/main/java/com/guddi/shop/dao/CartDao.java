package com.guddi.shop.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.guddi.shop.dto.CartDto;

public interface CartDao {

	ArrayList<CartDto> getCartInfo(String userId);

	int delCart(CartDto dto);

	int getCart(String userId);
	
	//int cartupdate(int quantity, String product_code, String userId);

	int cartupdate(CartDto dto);

	int chkdelete(String idx);

	int checkout(HashMap<String, Object> resendMap);

	CartDto findInfo(String userId);

	ArrayList<CartDto> getCartInfoImg(String userId);
	
	ArrayList<CartDto> toOrder(String userId, String[] array);

	String getOrderIdx();

	void doOrder(CartDto cartDto);

	void delCartByProductCode(String userId, String product_code);
	
	int HeadergetCart(String userId);

}
