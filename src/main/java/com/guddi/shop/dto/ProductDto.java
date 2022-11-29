package com.guddi.shop.dto;

import java.sql.Date;

public class ProductDto {
	
//	idx int(100) auto_increment primary key 게시물 번호
//	brand_name varchar(30) 브랜드 카테고리명
//	bag_type varchar(30) 가방 카테고리명
//	product_name varchar(40)  상품명
//	product_code varchar(20)  제품코드
//	product_content varchar(2000)  상세정보
//	price int(20) 가격
//	regdate date  제품등록일
//	new_flg int(2) 신상 유무 1 = 신상 0 = 시즌오프
//	u_idx int(100) 회원번호
//	sell_flg int(2) 판매여부 1 = 판매 0 = 미판매
	
//	p_idx  int(100) auto_increment primary key 사진 번호
//	b_idx int(100) 게시물 번호
//	u_idx int(100) 회원번호
//	orifilename varchar(50) 저장시 본래 파일 이름
//	newfilename varchar(50) 파일 이름
//	photo_num 이미지 순서
	
	private int idx;
	private String brand_name;
	private String bag_type;
	private String product_name;
	private String product_code;
	private String product_content;
	private int price;
	private Date regdate;
	private int new_flg;
	private int u_idx;
	private int sell_flg;
	private int p_idx;
	private int b_idx;
	private String oriFileName;
	private String newFileName;
	private int brand_idx;
	private int photo_num;
	
	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getBrand_name() {
		return brand_name;
	}
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
	public String getBag_type() {
		return bag_type;
	}
	public void setBag_type(String bag_type) {
		this.bag_type = bag_type;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	public String getProduct_content() {
		return product_content;
	}
	public void setProduct_content(String product_content) {
		this.product_content = product_content;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getNew_flg() {
		return new_flg;
	}
	public void setNew_flg(int new_flg) {
		this.new_flg = new_flg;
	}
	public int getU_idx() {
		return u_idx;
	}
	public void setU_idx(int u_idx) {
		this.u_idx = u_idx;
	}
	public int getSell_flg() {
		return sell_flg;
	}
	public void setSell_flg(int sell_flg) {
		this.sell_flg = sell_flg;
	}
	public int getP_idx() {
		return p_idx;
	}
	public void setP_idx(int p_idx) {
		this.p_idx = p_idx;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getNewFileName() {
		return newFileName;
	}
	public void setNewFileName(String newFileName) {
		this.newFileName = newFileName;
	}

	public int getBrand_idx() {
		return brand_idx;
	}
	public void setBrand_idx(int brand_idx) {
		this.brand_idx = brand_idx;
	}
	public int getPhoto_num() {
		return photo_num;
	}
	public void setPhoto_num(int photo_num) {
		this.photo_num = photo_num;
	}
	
 
	
	
}
