<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta charset="UTF-8">
<title>제품 내역</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="resources/css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="resources/css/animate.css">
<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/css/magnific-popup.css">
<link rel="stylesheet" href="resources/css/aos.css">
<link rel="stylesheet" href="resources/css/ionicons.min.css">
<link rel="stylesheet" href="resources/css/bootstrap-datepicker.css">
<link rel="stylesheet" href="resources/css/jquery.timepicker.css">
<link rel="stylesheet" href="resources/css/flaticon.css">
<link rel="stylesheet" href="resources/css/icomoon.css">
<link rel="stylesheet" href="resources/css/style.css">

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section class="ftco-section contact-section bg-light">
	<div class="container">    
	      <div class="col-md-12 ftco-animate text-center bg-light">
	      	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>주문내역</span></p>
	        <h1 class="mb-0 bread">주문내역</h1>
	      </div>    
	</div>
</section>


<section class="ftco-section">
  <div class="ftco-animate manager-table table-striped">
	  <form name = "mform" id = "mform" method="post">	                
	      <div>		        
	        <div class="row text-center search-form" id="productList">
			   <div class="col-md-4">
		     		
			   </div>
			   <div class="col-md-4">
			      <div class=" mb-4">	
				   <select id="searchType" name="searchType" class="form-control" >
				   		<option value="all" <c:if test="${searchType eq 'all'}">selected</c:if>>전체</option>	
				   		<option value="orderNum"<c:if test="${searchType eq 'orderNum'}">selected</c:if>>주문번호</option>
				   		<option value="phone"<c:if test="${searchType eq 'phone'}">selected</c:if>>핸드폰번호</option>	
				   		<option value="brand"<c:if test="${searchType eq 'brand'}">selected</c:if>>브랜드명</option>	
				   		<option value="bagType"<c:if test="${searchType eq 'bagType'}">selected</c:if>>가방종류</option>	
				   		<option value="userId"<c:if test="${searchType eq 'userId'}">selected</c:if>>구매자아이디</option>	
				   		<option value="userName"<c:if test="${searchType eq 'userName'}">selected</c:if>>구매자이름</option>					    		
				   </select>		
			     </div>
			   </div>
			   <div class="col-md-4">
			     <div class="mb-4">
			     	<div class="form-group">                
			             <a href="javascript:void(0);" onclick="changeList()" id="searchBtn"><span class="icon ion-ios-search"></span></a>
			             <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword }" placeholder="검색어를 입력해주세요">
			         </div>		
			   	</div>
			   </div>
			 </div>                       
	        <table>	         
	             <tr style="background-color:#212529;color:white;">
	             	<th>주문번호</th>	             	
				 	<th>제품번호</th>	
				 	<th>제품이름</th>           	
				 	<th>브랜드</th>	             	
				 	<th>제품종류</th>	             	
				 	<th>주문날짜</th>	             	
				 	<th>주문수량</th>	             	
				 	<th>구매가격</th>	             	
				 	<th>이름</th>	             	
				 	<th>전화번호</th>	           	           		     
	            </tr>
	            <c:if test="${orderList.size() == 0 }">   
	            <tr>
	             	<td colspan="10">해당하는 주문번호가 존재하지 않습니다.</td>	             	             	           		     
	            </tr>
	            </c:if>
 				<c:forEach items="${orderList}" var="listpagedto">		       	  
			       <tr>		       
			         <th>${listpagedto.order_num}</th>	             	
					 <th>${listpagedto.product_code}</th>
					 <th>${listpagedto.product_name}</th>	             	
					 <th>${listpagedto.brand_name}</th>	             	
					 <th>${listpagedto.bag_type}</th>	             	
					 <th>${listpagedto.regdate}</th>	             	
					 <th>${listpagedto.quantity}</th>	             	
					 <th>₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${listpagedto.totalPrice}"></fmt:formatNumber></th>	             	
					 <th>${listpagedto.username}</th>	             	
					 <th>${listpagedto.phone}</th>               		           		     
			       </tr>			    
		       </c:forEach>             
	        </table>
	        <c:if test="${page.endPageNum > 1}">
	        <div class="col text-center">
		      <div class="block-27">
		          <ul>
			      <c:if test="${page.prev}">
			      <li><a href="orderInfoList?num=${page.startPageNum - 1}&keyword=${keyword}&searchType=${searchType}">&lt;</a></li>
			      </c:if>
			      
			      <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li><a href="orderInfoList?num=${num}&keyword=${keyword}&searchType=${searchType}">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      
			      <c:if test="${page.next}">
			      <li><a href="orderInfoList?num=${page.endPageNum + 1}&keyword=${keyword}&searchType=${searchType}">&gt;</a></li>
			      </c:if>
			    </ul>
		      </div>
       	   </div> 
       	   </c:if>			
	    </div>
 	</form>
	 
  </div>
  
  
</section>
<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
  <div class="container py-4">
    <div class="row d-flex justify-content-center py-5">    
    </div>
  </div>
</section>



<jsp:include page="/WEB-INF/views/include/footer.jsp"/>

<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/jquery-migrate-3.0.1.min.js"></script>
<script src="resources/js/popper.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>
<script src="resources/js/jquery.easing.1.3.js"></script>
<script src="resources/js/jquery.waypoints.min.js"></script>
<script src="resources/js/jquery.stellar.min.js"></script>
<script src="resources/js/owl.carousel.min.js"></script>
<script src="resources/js/jquery.magnific-popup.min.js"></script>
<script src="resources/js/aos.js"></script>
<script src="resources/js/jquery.animateNumber.min.js"></script>
<script src="resources/js/bootstrap-datepicker.js"></script>
<script src="resources/js/scrollax.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="resources/js/google-map.js"></script>
<script src="resources/js/main.js"></script>



</body>
<script>	

var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}


function changeList() {

	var searchType = $('#searchType').val();
	var keyword = $('#keyword').val();
	

	location.href="orderInfoList?num=1&keyword="+keyword+"&searchType="+searchType;
	
}



</script>


</html>