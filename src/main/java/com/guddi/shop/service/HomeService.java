package com.guddi.shop.service;


import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.guddi.shop.dao.HomeDao;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.ProductDto;

@Service
public class HomeService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired HomeDao dao;
	
	public ArrayList<EtcDto> photoList() {
		
		return dao.photoList();
	}



	public ArrayList<ProductDto> rankList() {
		
		return dao.rankList();
	}



	public ArrayList<EtcDto> brandList() {
		// TODO Auto-generated method stub
		return dao.brandList();
	}


	

}
