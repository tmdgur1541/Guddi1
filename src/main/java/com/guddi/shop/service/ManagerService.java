package com.guddi.shop.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.guddi.shop.dao.ManagerDao;
import com.guddi.shop.dto.CartDto;
import com.guddi.shop.dto.EtcDto;
import com.guddi.shop.dto.MemberDto;
import com.guddi.shop.dto.ListPageDto;
import com.guddi.shop.dto.PageDto;
import com.guddi.shop.dto.ProductDto;
import com.guddi.shop.dto.ReviewQnaDto;

@Service
public class ManagerService {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired ManagerDao dao;
	@Autowired ServletContext servletContext;
	
	//각종  카테고리 정보를 가져오는 메서드 Start ryujihong 2022.01.11
	public ArrayList<EtcDto> getBrandcategory() {
		// TODO Auto-generated method stub
		return dao.getBrandcategory();
	}

	public ArrayList<EtcDto> getBagtype() {
		// TODO Auto-generated method stub
		return dao.getBagtype();
	}

	public ArrayList<EtcDto> getSellflg() {
		// TODO Auto-generated method stub
		return dao.getSellflg();
	}

	public ArrayList<EtcDto> getAnswertype() {
		// TODO Auto-generated method stub
		return dao.getAnswertype();
	}

	public ArrayList<EtcDto> getNewflg() {
		// TODO Auto-generated method stub
		return dao.getNewflg();
	}	
	//각종  카테고리 정보를 가져오는 메서드 End ryujihong 2022.01.11
	
	//관리자페이지 제품 리스트, 수정 관련 Start ryujihong 2022.01.11
	
	//제품에 대한 정보를 가져오는 함수
	public ProductDto productInfo(int idx) {
		// TODO Auto-generated method stub
		
		return dao.productInfo(idx);
	}
	
	public ArrayList<ProductDto> productImageInfo(int idx) {
		// TODO Auto-generated method stub
		return dao.productImageInfo(idx);
	}

	public String getNewIdx() {
		// TODO Auto-generated method stub
		return dao.getNewIdx();
	}
	
	public int productSearchCount(String keyword, String brand_name, String bag_name) {
		// TODO Auto-generated method stub
		
		PageDto dto = new PageDto();
		 
		dto.setBrand_name(brand_name);
		dto.setBag_name(bag_name);
		dto.setKeyword(keyword);			
		
		return dao.productSearchCount(dto);
		
	}

	public ArrayList<ProductDto> productList(int displayPost, int postNum, String keyword, String brand_name,
			String bag_name) {
		// TODO Auto-generated method stub
		PageDto dto = new PageDto();
		
		dto.setBag_name(bag_name);
		dto.setBrand_name(brand_name);
		logger.info(" dto.getBrand_name() : {}", dto.getBrand_name() );
		logger.info(" dto.getBag_name() : {}", dto.getBag_name()) ;
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(keyword);
					
		logger.info("postNum : {}", postNum);
		
		return dao.productList(dto);
	}
	//관리자페이지 제품 리스트, 수정 관련 End ryujihong 2022.01.11

	//관리자페이지 제품 리스트, 수정 관련 Start ryujihong 2022.01.13
	public void doUpdateProduct(HashMap<String, String> params, HttpSession session, ArrayList<EtcDto> brandtypeInfo
				, ArrayList<EtcDto> bagtypeInfo, int u_idx) {
		// TODO Auto-generated method stub
		
		int brand_type = Integer.parseInt(params.get("brand_type"));
		int bag_type = Integer.parseInt(params.get("bag_type"));
		
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
		
		ProductDto dto = new ProductDto();
		dto.setIdx(Integer.parseInt(params.get("idx")));
		dto.setProduct_name(params.get("product_name"));
		dto.setBrand_name(brand_name);
		dto.setBag_type(bag_name);
		dto.setSell_flg(Integer.parseInt(params.get("sell_flg")));
		dto.setNew_flg(Integer.parseInt(params.get("new_flg")));
		dto.setProduct_code(params.get("product_code"));
		dto.setProduct_content(params.get("content"));
		dto.setPrice(Integer.parseInt(params.get("price")));
		dto.setU_idx(u_idx);
		
		logger.info("업데이트 정보 : {}", dto.getProduct_name()+ dto.getBrand_name()+ dto.getBag_type()+dto.getSell_flg()+dto.getNew_flg()+
				dto.getProduct_code()+ dto.getProduct_content()+dto.getPrice()+dto.getU_idx());
		
		dao.doUpdateProduct(dto);
		
	}
	
	public int delImage(int photoNum, int idx) {
		// TODO Auto-generated method stub
		return dao.delImage(photoNum, idx);
	}
	

	public int doAddImage(int idx, MultipartFile file, String userId) {
		// TODO Auto-generated method stub
		
		//U_idx 추출
		int u_idx = dao.getU_idx(userId);
		//photo_num가져오기
		int photo_num = dao.getPhoto_num(idx);
		int result =0;
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
					
			ProductDto pdto = new ProductDto();
			
			pdto.setNewFileName(newFileName);
			pdto.setOriFileName(oriFileName);
			pdto.setB_idx(idx);
			pdto.setU_idx(u_idx);
			pdto.setPhoto_num(photo_num+1);		
			
			//이미지 DB에 등록
			result = dao.doRegistPhoto(pdto);
						
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

	
	//관리자페이지 제품 리스트, 수정 관련 End ryujihong 2022.01.13
	
	//관리자페이지 제품등록 Start ryujihong 2022.01.14
	public int doRegistProduct(HashMap<String, String> params, MultipartFile[] files, String userId, String brand_name, String bag_name) {
		// TODO Auto-generated method stub
		
		//U_idx 추출
		int u_idx = dao.getU_idx(userId);
		
		//이미지 정보 DTO에 저장
		ProductDto dto = new ProductDto();
		dto.setProduct_content(params.get("content"));
		dto.setProduct_name(params.get("product_name"));
		dto.setPrice(Integer.parseInt(params.get("price")));
		dto.setBag_type(bag_name);
		dto.setBrand_idx(Integer.parseInt(params.get("brand_type")));
		dto.setBrand_name(brand_name);
		dto.setProduct_code(params.get("product_code"));
		dto.setSell_flg(Integer.parseInt(params.get("sell_flg")));
		dto.setNew_flg(Integer.parseInt(params.get("new_flg")));
		dto.setU_idx(u_idx);
		
		//제품 등록
		dao.doRegistProduct(dto);
		
		//제품 idx 저장
		int idx = dto.getIdx();
		
		logger.info("idx: {}", idx);
		
		//이미지 저장 경로 설정
		String realPath = servletContext.getRealPath("/resources/photo");
		int photo_num =1;
		
		//상품이미지 저장
		for (MultipartFile multipartFile : files) {
			String oriFileName = multipartFile.getOriginalFilename();
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
						
				ProductDto pdto = new ProductDto();
				
				pdto.setNewFileName(newFileName);
				pdto.setOriFileName(oriFileName);
				pdto.setB_idx(idx);
				pdto.setU_idx(u_idx);
				pdto.setPhoto_num(photo_num);		
				
				//이미지 DB에 등록
				int result = dao.doRegistPhoto(pdto);
				photo_num +=  1;
				
				
				if (result>0) {
					
					try {
						byte[] bytes = multipartFile.getBytes();
						Path path = Paths.get(realPath +"/"+ newFileName);
						Files.write(path, bytes);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}				
			}		
		}		
		
		
		return idx;
	}
	//관리자페이지 제품등록 End ryujihong 2022.01.14

	public void updatePhotoNum(int newPhotoNum, int oriPhotoNum) {
		// TODO Auto-generated method stub
		dao.updatePhotoNum(newPhotoNum, oriPhotoNum);
		
	}

	//관리자페이지 제품 리스트, 수정 관련 End ryujihong 2022.01.14
	public int updateImageOrder(String[] newOrder, String[] newFileName) {
		// TODO Auto-generated method stub
	
		int success = 0;
		for (int i = 0; i < newOrder.length; i++) {
			dao.updateImageOrder(Integer.parseInt(newOrder[i]), newFileName[i]);
			success++;
		}
		
		return success;
	}
	//관리자페이지 제품 리스트, 수정 관련 End ryujihong 2022.01.14
	
	//2022.01.15 유지홍 제품 삭제, 관리자 Qna 관련 소스 Start
	public int delProductInfo(String idx) {
		// TODO Auto-generated method stub
		return dao.delProductInfo(idx);
	}

	public int registQnaAnswer(int idx, String answer, String userId) {
		// TODO Auto-generated method stub
		return dao.registQnaAnswer(idx, answer, userId);
	}

	public void updateAnswerFlg(int idx , String flg) {
		// TODO Auto-generated method stub
		dao.updateAnswerFlg(flg ,idx);
	}

	public void doUpdateAnswer(String content, String userId,int q_idx) {
		dao.doUpdateAnswer(content, userId, q_idx);
	}

	public int doDelAnswer(String userId, int a_idx) {
		return dao.doDelAnswer(userId, a_idx);
	}


	public ArrayList<com.guddi.shop.dto.MemberDto> memberList(int displayPost, int postNum, String keyword, String memFlg_name, int mem_flg) {
		PageDto dto = new PageDto();
		
		dto.setMemFlg_name(memFlg_name);
		logger.info(" dto.getMemFlg_name() : {}", dto.getMemFlg_name() );
		dto.setPostNum(postNum);
		dto.setDisplayPost(displayPost);
		dto.setKeyword(keyword);
		dto.setMem_flg(String.valueOf(mem_flg));
					
		logger.info("postNum : {}", postNum);
		return dao.memberList(dto);
	}

	public ArrayList<EtcDto> memFlgList() {
		
		return dao.memFlgList();
	}

	public ArrayList<EtcDto> marketingFlgList() {
		
		return dao.marketingFlgList();
	}

	public int memberSearchCount(String keyword, String phone, int mem_flg) {
		
		PageDto dto = new PageDto();
		dto.setPhone(phone);
		dto.setMem_flg(String.valueOf(mem_flg));
		dto.setKeyword(keyword);
		
		return dao.memberSearchCount(dto);
	}


	

	

	


	//2022.01.15 유지홍 제품 삭제, 관리자 Qna 관련 소스 End
	
	
	
	
	// 주문정보내역 리스트 orderInfoList yuSeonhwa 2022.01.17 START
//	
//	public ArrayList<CartDto> orderInfoList(int displayPost, int postNum) {
//		logger.info("Mybatispage service");
//		PageDto dto = new PageDto();
//		dto.setPostNum(postNum);
//		dto.setDisplayPost(displayPost);
//		return dao.orderInfoList(dto);
//	}
//
//	public int Mybatiscount() {
//		return dao.Mybatiscount();
//	}
//
//	@RequestMapping(value = "/orderInfoList", method = RequestMethod.GET)
//	public String orderInfoList(Model model,@RequestParam("num") int num) {	
//		logger.info("orderInfoList 요청");		
//		CartDto cartDto = new CartDto(); 
//		ListPageDto listPageDto = new ListPageDto(); 
//		
//		ArrayList<CartDto> orderInfoList = service.orderInfoList();
//		model.addAttribute("orderInfoList", orderInfoList);
//		
//		//listPageDto.setMyBatispageNum(10);
//		
//		//페이지 번호를 추가 하면 
//		logger.info("Mybatispage Controller : "+listPageDto);
//		
//		logger.info("Mybatispage Controller getMyBatisamount : "+listPageDto.getMyBatispageNum());
//		// 페이지의 전체 갯수 총 갯수 
//		int Mybatiscount = service.Mybatiscount();
//		model.addAttribute("Mybatiscount", Mybatiscount);   
//		logger.info("Mybatispage Controller Mybatiscount: "+Mybatiscount);
//		// 한페이지에 출력할 갯수 
//	
//		int amount = 10;
//		//하단 페이징 번호 ([게시물 총 갯수 / 한페이지에 출력할 갯수]) 의 올림 
//		int endPage = (int)(Math.ceil((double)Mybatiscount/amount));
//		
//		//출력할 게시물
//		int MyBatispageNum =((num) -1) * amount;
//		
//		
//		listPageDto.setMyBatispageNum(MyBatispageNum);
//		listPageDto.setMyBatisamount(10);
//		ArrayList<CartDto> listpagedto = service.Mybatispage(listPageDto); // 넘겨 
//		
//		
//		List<CartDto> list = service.listPaging(MyBatispageNum, endPage);
//		 
//		 
//		model.addAttribute("listpagedto", listpagedto);
//		model.addAttribute("endPage", endPage);
//		
//		
//		return "manager/orderInfoList";
//	}
//
//
	// 주문정보내역 리스트 orderInfoList yuSeonhwa 2022.01.17 END
	// 리뷰 관련 Ryujihong 2022.01.17 Start
	public int reviewSearchCount(String keyword, int answer_flg, String brandName, String bagName) {
		// TODO Auto-generated method stub
		EtcDto dto = new EtcDto();
		dto.setKeyword(keyword);
		dto.setAnswer_flg(answer_flg);
		dto.setBrand_name(brandName);
		dto.setType_name(bagName);
		
		return dao.reviewSearchCount(dto);
	}

	public ArrayList<ReviewQnaDto> reviewInfo(int displayPost, int postNum, String keyword, int answer_flg,
			String brandName, String bagName) {
		// TODO Auto-generated method stub
		PageDto dto = new PageDto();
		dto.setDisplayPost(displayPost);
		dto.setPostNum(postNum);
		dto.setKeyword(keyword);
		dto.setAnswer_flg(answer_flg);
		dto.setBrand_name(brandName);
		dto.setBag_name(bagName);
		return dao.reviewInfo(dto);
	}

	public ArrayList<EtcDto> getbagCategoryList() {
		// TODO Auto-generated method stub
		return dao.getbagCategoryList();
	}

	public ArrayList<EtcDto> getbrandCategoryList() {
		// TODO Auto-generated method stub
		return dao.getbrandCategoryList();
	}

	public ArrayList<EtcDto> getanswerList() {
		// TODO Auto-generated method stub
		return dao.getanswerList();
	}

	public ReviewQnaDto getReviewDetail(int idx) {
		// TODO Auto-generated method stub
		return dao.getReviewDetail(idx);
	}

	public ReviewQnaDto getReviewAnswer(int idx) {
		// TODO Auto-generated method stub
		return dao.getReviewAnswer(idx);
	}

	public int doReviewAnswer(ReviewQnaDto dto) {
		// TODO Auto-generated method stub
		return dao.doReviewAnswer(dto);
	}

	public void doDelReviewAnswer(int a_idx) {
		// TODO Auto-generated method stub
		dao.doDelReviewAnswer(a_idx);
	}

	public void doUpdateReviewAnswer(ReviewQnaDto dto) {
		// TODO Auto-generated method stub
		dao.doUpdateReviewAnswer(dto);
	}
	// 리뷰 관련 Ryujihong 2022.01.17 End

	// 주문정보내역 리스트 orderInfoList 유지홍 2022.01.18 START
	public int orderListSearchCount(PageDto Page) {
		// TODO Auto-generated method stub
		return dao.orderListSearchCount(Page);
	}

	public ArrayList<CartDto> orderList(int displayPost, int postNum, String keyword, String searchType) {
		// TODO Auto-generated method stub
		PageDto dto = new PageDto();
		dto.setDisplayPost(displayPost);
		dto.setPostNum(postNum);
		dto.setKeyword(keyword);
		dto.setSearchType(searchType);
		
		return dao.orderList(dto);
	}

	public void updateReviewFlg(int flg, int idx) {
		// TODO Auto-generated method stub
		dao.updateReviewFlg(flg, idx);
	}

	public int countQnaAnswer(int idx) {
		// TODO Auto-generated method stub
		return dao.countQnaAnswer(idx);
	}

	public int countReviewAnswer(String idx) {
		// TODO Auto-generated method stub
		return dao.countReviewAnswer(idx);
	}
	
	
	// 주문정보내역 리스트 orderInfoList 유지홍 2022.01.18 End
	
	


}
