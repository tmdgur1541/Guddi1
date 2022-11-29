package com.guddi.shop.dto;

import java.sql.Date;

public class MemberDto {
	
	
//	idx int(100) auto_increment primary key 회원번호
//	userId  varchar(20) 아이디
//	password varchar(200) 비밀번호
//	username varchar(10) 이름
//	phone varchar(20) 전화번호
//	email varchar(50) 이메일
//	zipcode varchar(20) 우편번호
//	address varchar(30) 주소
//	address_detail varchar(30) 상세주소
//	birthday date 생년월일
//	gender varchar(10) 성별
//	personInfo_flg int(2) 개인정보 이용동의 여부 1= 동의
//	marketing_flg int(2) 마케팅이용동의 여부 1=동의 0=비동의
//	delete_date date 탈퇴일자
//	regdate date  가입일
//	mem_flg int(3) 회원구분(0 = 탈퇴회원, 1= 회원, 2 = 관리자, 3=블랙리스트)
	
	private int idx;
	private String userId;
	private String password;
	private String username;
	private String phone;
	private String email;
	private String zipcode;
	private String address;
	private String address_detail;
	private String birthday;
	private String gender;
	private int personInfo_flg;
	private int marketing_flg;
	private Date delete_date;
	private Date regdate;
	private int mem_flg;

	
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}	
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress_detail() {
		return address_detail;
	}
	public void setAddress_detail(String address_detail) {
		this.address_detail = address_detail;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getMem_flg() {
		return mem_flg;
	}
	public void setMem_flg(int mem_flg) {
		this.mem_flg = mem_flg;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getPersonInfo_flg() {
		return personInfo_flg;
	}
	public void setPersonInfo_flg(int personInfo_flg) {
		this.personInfo_flg = personInfo_flg;
	}
	public int getMarketing_flg() {
		return marketing_flg;
	}
	public void setMarketing_flg(int marketing_flg) {
		this.marketing_flg = marketing_flg;
	}
	public Date getDelete_date() {
		return delete_date;
	}
	public void setDelete_date(Date delete_date) {
		this.delete_date = delete_date;
	}
	
	
	
	
	
	
	
	

}
