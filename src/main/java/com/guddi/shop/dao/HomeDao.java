package com.guddi.shop.dao;

import java.util.ArrayList;

import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.ProductDto;

public interface HomeDao {

	ArrayList<EtcDto> photoList();

	ArrayList<ProductDto> rankList();

	ArrayList<EtcDto> brandList();

	

}
