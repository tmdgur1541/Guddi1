package com.guddi.shop.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.guddi.shop.dao.EtcDao;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;


@Service
public class EtcService {

	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired EtcDao dao;
	@Autowired ServletContext servletContext;
	
	// 신상여부 카테고리 관련  유지홍 2022.01.17 Start
	public ArrayList<EtcDto> getNewFlgInfo() {
		// TODO Auto-generated method stub
		return dao.getNewFlgInfo();
	}

	public int doRegistNewFlg(String newname) {
		// TODO Auto-generated method stub
		int idx = dao.getNewFlgIdx();
		int newIdx = idx+1;
		return dao.doRegistNewFlg(newIdx ,newname);
	}

	public int doUpateUseFlg(int use_flg, int idx) {
		// TODO Auto-generated method stub
		return dao.doUpateUseFlg(use_flg,idx);
	}

	public ArrayList<EtcDto> getUseFlgInfo() {
		// TODO Auto-generated method stub
		return dao.getUseFlgInfo();
	}

	// 신상여부 카테고리 관련  유지홍 2022.01.17 End
	


	public ArrayList<EtcDto> getSellFlgInfo() {
		// TODO Auto-generated method stub
		return dao.getSellFlgInfo();
	}

	public int doRegistSellFlg(String sellname) {
		// TODO Auto-generated method stub
		int idx = dao.getSellFlgIdx();
		int newIdx = idx+1;
		return dao.doRegistSellFlg(newIdx, sellname);
	}

	public int doUpdateSellUseFlg(int use_flg, int idx) {
		// TODO Auto-generated method stub
		return dao.doUpdateSellUseFlg(use_flg, idx);
	}

	public int doUpdateMemFlg(int mem_flg, int idx) {
		// TODO Auto-generated method stub
		return dao.doUpdateMemFlg(mem_flg, idx);
	}
	
	// 신상여부 카테고리 관련  유지홍 2022.01.17 End
	
	
	// 메인이미지 제어  유지홍 2022.01.18 Start
	public ArrayList<EtcDto> getMainImageList() {
		// TODO Auto-generated method stub
		return dao.getMainImageList();
	}

	public ArrayList<MemberDto> getUserInfo() {
		// TODO Auto-generated method stub
		return dao.getUserInfo();
	}

	public int getMainImageIdx() {
		// TODO Auto-generated method stub
		return dao.getMainImageIdx();
	}

	public int doAddMainImage(int idx, int u_idx, MultipartFile file) {
		// TODO Auto-generated method stub
		
		int result = 0;
		//저장 경로
		String realPath = servletContext.getRealPath("/resources/photo");
				
		String oriFileName = file.getOriginalFilename();
		if (oriFileName.lastIndexOf(".")>0) {
			String ext = oriFileName.substring(oriFileName.lastIndexOf("."));
			String newFileName = System.currentTimeMillis() + ext;
			logger.info(oriFileName +" >>>> "+ newFileName);
			try {
				Thread.sleep(1);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
					
			EtcDto pdto = new EtcDto();
			
			pdto.setNewFileName(newFileName);
			pdto.setOriFileName(oriFileName);
			pdto.setIdx((idx+1));
			pdto.setU_idx(u_idx);
			
			
			//이미지 DB에 등록
			result = dao.doRegistMainImage(pdto);
						
			if (result>0) {
				
				try {
					byte[] bytes = file.getBytes();
					Path path = Paths.get(realPath +"/"+ newFileName);
					Files.write(path, bytes);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}					
			}	
		}
		
		return result;
		
	}

	public int getU_idx(String userId) {
		// TODO Auto-generated method stub
		return dao.getU_idx(userId);
	}

	public int delMainImage(int idx) {
		// TODO Auto-generated method stub
		return dao.delMainImage(idx);
	}

	public int doUpdateImageUseFlg(int use_flg, int idx) {
		// TODO Auto-generated method stub
		return dao.doUpdateImageUseFlg(use_flg,idx);
	}

	public int updateImageOrder(String[] newOrder, String[] newFileName) {
		// TODO Auto-generated method stub
		int success = 0;
		for (int i = 0; i < newOrder.length; i++) {
			dao.updateImageOrder(Integer.parseInt(newOrder[i]), newFileName[i]);
			success++;
		}
		
		return success;
	}	
	// 메인이미지 제어  유지홍 2022.01.18 End
	
	
	//브랜드 카테고리 김도연 start 2022.01.17
	public int doRegistBrand(String name, String code) {
		logger.info("브랜드 추가하기 서비스");
		int idx = dao.getBrandIdx();
		int newidx = idx+1;
		logger.info("브랜드 인덱스 : "+idx+" -> "+newidx);
		
		return dao.doRegistBrand(newidx,name, code);
	}

	public int doUpdateBrandUse(int useflg, int brand_idx) {
		logger.info("브랜드 사용여부 서비스");
		return dao.doUpdateBrandUse(useflg,brand_idx);
	}
	
	public ArrayList<EtcDto> getBrand() {
		// TODO Auto-generated method stub
		return dao.getBrand();
	}
	//브랜드 카테고리 김도연 End 2022.01.17

	//가방종류 카테고리 김도연 start 2022.01.19
	public ArrayList<EtcDto> getType() {
		// TODO Auto-generated method stub
		return dao.getType();
	}

	public int doRegistType(String name, String code) {
		logger.info("종류 추가하기 서비스");
		int idx = dao.getTypeIdx();
		int newidx = idx+1;
		logger.info("브랜드 인덱스 : "+idx+" -> "+newidx);
		return dao.doRegistType(newidx,name,code);
	}

	public int doUpdateTypeUse(int useflg, int type_idx) {
		logger.info("종류카테고리 사용여부 서비스");
		return dao.doUpdateTypeUse(useflg,type_idx);
	}
	//종류 카테고리 김도연 end 2022.01.19
	//승혁님 문의타입 카테고리 제어관련 Start
	public ArrayList<EtcDto> toUpdateQnaCategory() {
	      // TODO Auto-generated method stub
	      logger.info("toUpdateQnaCategory 이동");
	      return dao.toUpdateQnaCategory();
	   }

	   public void addQna(int userIdxInt, String keyword, int idxCountInt) {
	      logger.info("addQna 서비스 이동 userIdxInt {}", userIdxInt);
	      logger.info("addQna 서비스 이동 keyword {}", keyword);
	      logger.info("addQna 서비스 이동 idxCountInt {}", idxCountInt);
	      dao.addQna(userIdxInt, keyword, idxCountInt);
	      
	   }

	   public void changUseFlg(int changUseFlgInt, String typename, int userIdxInt) {
	      // TODO Auto-generated method stub
	      dao.changUseFlg(changUseFlgInt, typename, userIdxInt);
	   }

	public ArrayList<EtcDto> productMainImageInfo() {
		// TODO Auto-generated method stub
		return dao.productMainImageInfo();
	}

	public void updateMainPhotoNum(int newPhotoNum, int oriPhotoNum) {
		// TODO Auto-generated method stub
		dao.updateMainPhotoNum(newPhotoNum,oriPhotoNum);
		
	}

	
	//승혁님 문의타입 카테고리 제어관련 End
	
	
}
