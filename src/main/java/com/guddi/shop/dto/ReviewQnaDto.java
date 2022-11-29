package com.guddi.shop.dto;

import java.sql.Date;

public class ReviewQnaDto {
	
//	리뷰
//	idx int(100)  auto_increment primary key 리뷰인덱스
//	b_idx int(100) 게시물 번호
//	u_idx int(100) 회원번호
//	subject varchar(200) 리뷰제목
//	content varchar(1000) 리뷰 내용
//	userId varchar(20) 작성자(구매자)
//	regdate date  default current_date 작성일
//	del_flg int(2) 삭제여부
//  managerId varchar(20)  관리자
	
//	문의
//	idx int(100)  auto_increment primary key 문의 인덱스
//	answer_type varchar(100) 문의타입
//	subject varchar(200) 문의제목
//	content varchar(1000) 문의내용
//	userId varchar(20) 문의자
//	regdate date  default current_date 작성일
//	u_idx int(100) 회원번호
//	del_flg int(2) 삭제여부
//	answer_flg(2) 답변여부
	
	
	private int idx;
	private int b_idx;
	private int u_idx;
	private int r_idx;
	private String subject;
	private String content;
	private String userId;
	private Date regdate;
	private int del_flg;
	private String product_name;
	private String managerId;
	private String answer_type;
	private String answer_flg;
	private String typename;
	private int use_flg;
	private String answername;
	private String brand_name;
	private String bag_type;
	private String product_code;
	

	public String getManagerId() {
		return managerId;
	}
	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getB_idx() {
		return b_idx;
	}
	public void setB_idx(int b_idx) {
		this.b_idx = b_idx;
	}
	public int getU_idx() {
		return u_idx;
	}
	public void setU_idx(int u_idx) {
		this.u_idx = u_idx;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getDel_flg() {
		return del_flg;
	}
	public void setDel_flg(int del_flg) {
		this.del_flg = del_flg;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getAnswer_type() {
		return answer_type;
	}
	public void setAnswer_type(String answer_type) {
		this.answer_type = answer_type;
	}
	public String getAnswer_flg() {
		return answer_flg;
	}
	public void setAnswer_flg(String answer_flg) {
		this.answer_flg = answer_flg;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
	public int getUse_flg() {
		return use_flg;
	}
	public void setUse_flg(int use_flg) {
		this.use_flg = use_flg;
	}
	public String getAnswername() {
		return answername;
	}
	public void setAnswername(String answername) {
		this.answername = answername;
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
	public int getR_idx() {
		return r_idx;
	}
	public void setR_idx(int r_idx) {
		this.r_idx = r_idx;
	}
	public String getProduct_code() {
		return product_code;
	}
	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}
	
	
	
	
	

}
