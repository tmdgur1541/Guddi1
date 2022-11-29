<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
<title>GUddI Shop</title>

<style>
#mainLogo{
	width:190;
	hight:110;
	cursor:default;
}
</style>



</head>
<body>



<div class="py-1 bg-primary">
	<div class="container">
		<div class="row no-gutters d-flex align-items-start align-items-center px-md-0">
    		<div class="col-lg-12 d-block">
	    		<div class="row d-flex">
	    			<div class="col-md pr-4 d-flex topper align-items-center">
				    	<div class="icon mr-2 d-flex justify-content-center align-items-center"><span class="icon-phone2"></span></div>
					    <span class="text">02-2108-5900</span>
				    </div>
				    <div class="col-md pr-4 d-flex topper align-items-center">    	
				    </div>
				    <div class="col-md-5 pr-4 d-flex topper align-items-center text-lg-right">
				    	<c:if test="${sessionScope.userId ne null}">				    	
				        	<span class="text"> 
				        		${sessionScope.username} 님 환영합니다. <a class="text" href="#" onclick="logout()"> 로그아웃</a> 
				        	</span>
				        				       	
				        </c:if>	         
				    </div>				   
				 </div>
			 </div>
		 </div>
	 </div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">
    <a href="./"><img id="mainLogo" src="resources/photo/logo1.png"  alt="GUddI Shop"></a>
      <!-- <a class="navbar-brand" href="./">GUddI Shop</a> -->
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="oi oi-menu"></span> 카테고리
      </button>

      <div class="collapse navbar-collapse" id="ftco-nav">
        <ul class="navbar-nav ml-auto">
        
          <c:if test="${sessionScope.mem_flg ne 2}">          
          <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="javascript:void(0);" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">카테고리</a>
	          <div class="dropdown-menu" aria-labelledby="dropdown04">
	          	<c:forEach items="${sessionScope.brandList}" var="brandList">
	          		<a class="dropdown-item" href="productPage?num=1&brand_idx=${brandList.brand_idx}&bag_type=0">${brandList.brand_name}</a>
	          	</c:forEach>
	          </div>
          </li>
          </c:if>         
          
          <c:if test="${sessionScope.userId eq null}">
          	<li class="nav-item"><a href="toLogin" class="nav-link">로그인</a></li>
          	<li class="nav-item"><a href="memberWrite" class="nav-link">회원가입</a></li>
          </c:if>            

          <c:if test="${sessionScope.userId ne null && sessionScope.mem_flg ne 2}">				    	
			<li class="nav-item"><a href="cart" class="nav-link"><span class="icon-shopping_cart"></span>[${sessionScope.cartCnt}]</a></li>			
		  </c:if>		 
		
		  <c:if test="${sessionScope.mem_flg eq 2}">
			<li class="nav-item"><a href="productMain?num=1&brand_idx=0" class="nav-link">제품내역</a></li>
			<li class="nav-item"><a href="qnaPage?qnaNum=1&answer_flg=2&qnaType=0" class="nav-link">Q&A내역</a></li>
			<li class="nav-item"><a href="toReviewPage?num=1&answer_flg=2" class="nav-link">리뷰내역</a></li>
            <li class="nav-item"><a href="orderInfoList?num=1" class="nav-link">주문정보</a></li>
			<li class="nav-item"><a href="memberList?num=1&mem_flg=3" class="nav-link">회원목록</a></li>
			<li class="nav-item dropdown">
		      <a class="nav-link dropdown-toggle" href="javascript:void(0);" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">기타</a>
	          <div class="dropdown-menu" aria-labelledby="dropdown04">	         
	          	<a class="dropdown-item" href="toMainImage">배너이미지관리</a>
	          	<a class="dropdown-item" href="toUpdateQnaCategory?userIdx=${sessionScope.u_idx}">문의타입카테고리관리</a>
	            <a class="dropdown-item" href="toBrandCategory">브랜드카테고리관리</a>
	            <a class="dropdown-item" href="tobagTypeCategory">가방종류카테고리관리</a>
	            <a class="dropdown-item" href="toSellFlgCategory">판매여부카테고리관리</a>  
	            <a class="dropdown-item" href="toNewFlgCategory">신상여부카테고리관리</a>           
	          </div>
			</li>
		  </c:if>	
          
          <c:if test="${sessionScope.userId ne null && sessionScope.mem_flg ne 2}">	
          <li class="nav-item"><a href="myPage?orderNum=1&reviewNum=1" class="nav-link">마이페이지</a></li>   
          </c:if>

          <c:if test="${sessionScope.mem_flg ne 2}">
          <li class="nav-item"><a href="javascript:void(0);" onclick="toQna('${sessionScope.userId}');" class="nav-link">Q&A</a></li> 
          </c:if>
        </ul>
      </div>
    </div>
</nav>
<!-- END nav -->


</body>

<script>
console.log("가져온 카트 수 : '${sessionScope.cartCnt}'");


function logout(){	
	 
	if (confirm("로그아웃 하시겠습니까?")) {
	
		location.href="logout";

    } else {
        return;
    }
	
}

function toQna(userid){
	
	if (userid==null) {
		
		alert("로그인을 해주세요");
		location.href = "toLogin";
		
	} else {
		
		location.href = "qnaPage?qnaNum=1&answer_flg=2&qnaType=0";
	}
	
	
}

</script>
</html>