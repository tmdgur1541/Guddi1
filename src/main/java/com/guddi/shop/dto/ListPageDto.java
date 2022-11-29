package com.guddi.shop.dto;

public class ListPageDto {
	
	
	
	private int MyBatispageNum;
	
	private int MyBatisamount;
	
	
	private int num;
	
	//상품타입
	private int type;
	
	//답변여부
	private int answer_flg;
	
	//가방 타입
	private int bag_type;
	
	//브랜드타입
	private int brand_type;
	
	//가방 종류명
	private String bag_name;
		
	//브랜드명
	private String brand_name;
	
	//페이징 타입
	private String pagingType;
	
	//userid
	private String userId;

	// 게시물 총 갯수
	private int count;

	// 한 페이지에 출력할 게시물 갯수
	private int postNum = 12;

	// 하단 페이징 번호 ([ 게시물 총 갯수 ÷ 한 페이지에 출력할 갯수 ]의 올림)
	private int pageNum;

	// 출력할 게시물
	private int displayPost;

	// 한번에 표시할 페이징 번호의 갯수
	private int pageNumCnt = 12;

	// 표시되는 페이지 번호 중 마지막 번호
	private int endPageNum;

	// 표시되는 페이지 번호 중 첫번째 번호
	private int startPageNum;

	// 다음/이전 표시 여부
	private boolean prev;
	private boolean next;

	private String searchType;
	private String keyword;

	
	
	
	
	
	public void setNum(int num) {
		this.num = num;
	}

	public void setCount(int count) {
		this.count = count;
		dataCalc();
	}

	public int getCount() {
		return count;
	}

	public int getPostNum() {
		return postNum;
	}

	public int getPageNum() {
		return pageNum;
	}

	public int getDisplayPost() {
		return displayPost;
	}

	public int getPageNumCnt() {
		return pageNumCnt;
	}

	public int getEndPageNum() {
		return endPageNum;
	}

	public int getStartPageNum() {
		return startPageNum;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyword() {
		return keyword;
	}

	private void dataCalc() {

		// 마지막 번호
		endPageNum = (int) (Math.ceil((double) num / (double) pageNumCnt) * pageNumCnt);

		// 시작 번호
		startPageNum = endPageNum - (pageNumCnt - 1);

		// 마지막 번호 재계산
		int endPageNum_tmp = (int) (Math.ceil((double) count / (double) pageNumCnt));

		if (endPageNum > endPageNum_tmp) {
			endPageNum = endPageNum_tmp;
		}

		prev = startPageNum == 1 ? false : true;
		next = endPageNum * pageNumCnt >= count ? false : true;

		displayPost = (num - 1) * postNum;

	}

	public String getSearchTypeKeyword() {

		if (searchType.equals("") || keyword.equals("")) {
			return "";
		} else {
			return "&searchType=" + searchType + "&keyword=" + keyword;
		}
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public void setDisplayPost(int displayPost) {
		this.displayPost = displayPost;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public void setPostNum(int postNum) {
		this.postNum = postNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserid(String userId) {
		this.userId = userId;
	}

	public String getPagingType() {
		return pagingType;
	}

	public void setPagingType(String pagingType) {
		this.pagingType = pagingType;
	}

	public int getAnswer_flg() {
		return answer_flg;
	}

	public void setAnswer_flg(int answer_flg) {
		this.answer_flg = answer_flg;
	}

	public int getBag_type() {
		return bag_type;
	}

	public void setBag_type(int bag_type) {
		this.bag_type = bag_type;
	}

	public int getBrand_type() {
		return brand_type;
	}

	public void setBrand_type(int brand_type) {
		this.brand_type = brand_type;
	}

	public String getBag_name() {
		return bag_name;
	}

	public void setBag_name(String bag_name) {
		this.bag_name = bag_name;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	public int getMyBatispageNum() {
		return MyBatispageNum;
	}

	public void setMyBatispageNum(int myBatispageNum) {
		MyBatispageNum = myBatispageNum;
	}

	public int getMyBatisamount() {
		return MyBatisamount;
	}

	public void setMyBatisamount(int myBatisamount) {
		MyBatisamount = myBatisamount;
	}


	
	
	

}
