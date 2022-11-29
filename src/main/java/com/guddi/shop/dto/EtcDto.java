package com.guddi.shop.dto;

import java.sql.Date;


//각종 카테고리 관련 Dto
public class EtcDto {
	
	
//	brand_idx int(20) 브랜드번호
//	use_flg int(3) 사용여부
//	regdate date default current_date 등록일
//	brand_name varchar(30) 브랜드명
//	type_idx int(20) 종류번호
//	type_name varchar(30) 종류명
//	brand_code varchar(10) 브랜드 코드 :  제품코드 생성을 위해 필요
//	type_code varchar(10) 가방 코드 : 제품코드 생성을 위해 필요
//  use_flg
//  useFlg_name
	

	private int brand_idx;
	private int use_flg;
	private Date regdate;
	private String brand_name;
	
	private int type_idx;
	private String type_name;
	private String answername;
	private int idx;
	private String sellname;
	private String newname;
	private String brand_code;
	private String type_code;
	private String newFileName;
	private String memFlg_name;
	private String marketingFlg_name;
	private String mam_flg;
	private String oriFileName;
	private String useFlg_name;
	private int u_idx;
	private String userId;
	private String keyword;
	private int answer_flg;
	private String  typename;
	
	
	public String getMam_flg() {
		return mam_flg;
	}
	public void setMam_flg(String mam_flg) {
		this.mam_flg = mam_flg;
	}
	public String getMarketingFlg_name() {
		return marketingFlg_name;
	}
	public void setMarketingFlg_name(String marketingFlg_name) {
		this.marketingFlg_name = marketingFlg_name;
	}
	public String getMemFlg_name() {
		return memFlg_name;
	}
	public void setMemFlg_name(String memFlg_name) {
		this.memFlg_name = memFlg_name;
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

	public int getUse_flg() {
		return use_flg;
	}
	public void setUse_flg(int use_flg) {
		this.use_flg = use_flg;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public String getBrand_name() {
		return brand_name;
	}
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
	public int getType_idx() {
		return type_idx;
	}
	public void setType_idx(int type_idx) {
		this.type_idx = type_idx;
	}
	public String getType_name() {
		return type_name;
	}
	public void setType_name(String type_name) {
		this.type_name = type_name;
	}
	public String getAnswername() {
		return answername;
	}
	public void setAnswername(String answername) {
		this.answername = answername;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getSellname() {
		return sellname;
	}
	public void setSellname(String sellname) {
		this.sellname = sellname;
	}
	public String getOriFileName() {
		return oriFileName;
	}
	public void setOriFileName(String oriFileName) {
		this.oriFileName = oriFileName;
	}
	public String getNewname() {
		return newname;
	}
	public void setNewname(String newname) {
		this.newname = newname;
	}
	public String getBrand_code() {
		return brand_code;
	}
	public void setBrand_code(String brand_code) {
		this.brand_code = brand_code;
	}
	public String getType_code() {
		return type_code;
	}
	public void setType_code(String type_code) {
		this.type_code = type_code;
	}
	public String getUseFlg_name() {
		return useFlg_name;
	}
	public void setUseFlg_name(String useFlg_name) {
		this.useFlg_name = useFlg_name;
	}
	public int getU_idx() {
		return u_idx;
	}
	public void setU_idx(int u_idx) {
		this.u_idx = u_idx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getAnswer_flg() {
		return answer_flg;
	}
	public void setAnswer_flg(int answer_flg) {
		this.answer_flg = answer_flg;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	
	


	//메인 베너 이미지 등록
}
