package com.guddi.shop.dao;

import java.util.ArrayList;

import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;

public interface EtcDao {
	
	// 신상여부 카테고리 관련  유지홍 2022.01.17 Start

	ArrayList<EtcDto> getNewFlgInfo();

	int doRegistNewFlg(int idx, String newname);

	int getNewFlgIdx();

	int doUpateUseFlg(int use_flg, int idx);

	ArrayList<EtcDto> getUseFlgInfo();
	
	ArrayList<EtcDto> getBrand();
	
	ArrayList<EtcDto> getSellFlgInfo();

	int doRegistSellFlg(int newIdx, String sellname);

	int getSellFlgIdx();

	int doUpdateSellUseFlg(int use_flg, int idx);


	int doUpdateMemFlg(int mem_flg, int idx);
	
	
	
	
	

	// 신상여부 카테고리 관련  유지홍 2022.01.17 End

	// 메인이미지 제어  유지홍 2022.01.18 Start
	ArrayList<EtcDto> getMainImageList();

	ArrayList<MemberDto> getUserInfo();

	int getMainImageIdx();

	int doRegistMainImage(EtcDto pdto);

	int getU_idx(String userId);

	int delMainImage(int idx);

	int doUpdateImageUseFlg(int use_flg, int idx);

	void updateImageOrder(int idx, String string);
	// 메인이미지 제어  유지홍 2022.01.18 End
	//브랜드 카테고리 김도연 start 2022.01.17	
	int getBrandIdx();

	int doRegistBrand(int newidx, String name, String code);

	int doUpdateBrandUse(int useflg, int brand_idx);
	//브랜드 카테고리 김도연 End 2022.01.17	
	//종류 카테고리 김도연 start 2022.01.19
	ArrayList<EtcDto> getType();

	int getTypeIdx();

	int doUpdateTypeUse(int useflg, int type_idx);

	int doRegistType(int newidx, String name, String code);
	//종류 카테고리 김도연 end 2022.01.19
	//승혁님 문의타입 카테고리 제어관련 Start
	ArrayList<EtcDto> toUpdateQnaCategory();

	void addQna(int userIdxInt, String keyword, int idxCountInt);

	void changUseFlg(int changUseFlgInt, String typename, int userIdxInt);
	//승혁님 문의타입 카테고리 제어관련 End

	ArrayList<EtcDto> productMainImageInfo();

	void updateMainPhotoNum(int newPhotoNum, int oriPhotoNum);
	
}
