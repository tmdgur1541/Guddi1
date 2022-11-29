<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html>
<head>
<meta charset="UTF-8">
<title>${brand_name }</title>
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

<style>

.img-fluid {
  max-width: 100%;
  height: 269px; 
 }
 
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section class="ftco-section contact-section bg-light">
	<div class="container">    
	    <div class="col-md-12 ftco-animate text-center">	    	
	    	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>${brand_name }</span></p>
	     	<h1 class="mb-0 bread">${brand_name }</h1>	      
	    </div>
	</div>
</section>


<section class="ftco-section"  id="productList">
  <div class="container">        
        <div class="row mb-5 text-center search-form">
		   <div class="col-md-4">
		     <div class="mb-4">
				<select name="brand_type" class="form-control" id="brandList">
			   		<c:forEach var="list" items="${sessionScope.brandcategory}">
			   			<option value="${list.brand_idx}" <c:if test="${brand_idx eq list.brand_idx}">selected</c:if>>${list.brand_name}</option>	
			   		</c:forEach>		
			   </select>		
		     </div>
		   </div>
		   <div class="col-md-4">
		      <div class=" mb-4">
		    	<select name="bag_type" class="form-control" id="bagList" onchange="changeListByBag(this.value)">
				   	<option value="0">전체</option>	
				   	<c:forEach var="list" items="${sessionScope.bagtype}">
				    <option value="${list.type_idx}" <c:if test="${list.type_idx eq bag_type }">selected</c:if>>${list.type_name}</option>	
				   	</c:forEach>		
				   </select>			
		     </div>
		   </div>
		   <div class="col-md-4">
		     <div class="mb-4">
		     	<div class="form-group">                
		             <a href="javascript:void(0);" id="searchBtn" onclick="changeListByProductName()"><span class="icon ion-ios-search"></span></a>
		             <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword}" placeholder="제품명을 입력해주세요">
		         </div>		
		   	</div>
		   </div>
		</div>
        
		<div class="row col-md-12" >
		<c:if test="${list.size() == 0}">
			<div class="marginAuto" >
				<h5>해당하는 제품이 존재하지 않습니다.</h5>
			</div>			
		</c:if>			
		<c:forEach items="${list}" var="list">
		   <div class="col-md-3 ftco-animate">
				<div class="product">					
					<a href="detail?idx=${list.idx}&reviewNum=1" class="img-prod"><img class="img-fluid" src="resources/photo/${list.newFileName}" alt="Colorlib Template">

					</a>
					<div class="text py-3 pb-4 px-3 text-center">
						<h3><a href="detail?idx=${list.idx}&reviewNum=1">${list.product_name}</a></h3>
						<div class="d-flex">
							<div class="pricing">
	    						<p class="price">
	    							<span class="price-sale">₩ 
	    								<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />
									</span>
								</p>
	    					</div>
    					</div>
    					<div class="bottom-area d-flex px-3">
    						<div class="m-auto d-flex">    							
    							 							
							</div>
						</div>
					</div>
				</div>
			</div>	
		</c:forEach>								
	  </div>
	  <br>
	  <div class="row mt-5">
		  <div class="col text-center">
			<div class="block-27">
			   <ul>
			      <c:if test="${page.prev}">
			      <li><a href="productPage?num=${page.endPageNum - 1}&bag_type=${bag_type}
			      &brand_idx=${brand_idx}&keyword=${keyword}">&lt;</a></li>
			      </c:if>
			      <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li><a href="productPage?num=${num}&bag_type=${bag_type}
			      &brand_idx=${brand_idx}&keyword=${keyword}">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      <c:if test="${page.next}">
			      <li><a href="productPage?num=${page.endPageNum + 1}&bag_type=${bag_type}
			      &brand_idx=${brand_idx}&keyword=${keyword}">&gt;</a></li>
			      </c:if>
			   </ul>
			 </div>
		  </div>
	  </div>	  	  
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

<script type="text/javascript">


function enterkey() {	
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
         DoSearch();
    }
}

function DoSearch() {    
	 
	  let keyword = $("#keyword").val();
	  let bag_type =  $("#bagList").val();
	  let brand_idx =  $("#brandList").val();
	  
	  console.log(keyword);
	  console.log(bag_type);	 
	  console.log(brand_type);	
	  
	  location.href = "productPage?num=1&bag_type=" + bag_type + "&brand_idx=" + brand_idx + 
	  "&keyword=" +  keyword +"#productList";

};



$("#brandList").change(function(){
	
	var bag_type = "${bag_type}";
	var keyword = $("#keyword").val();
	var brand_idx = $("#brandList").val();

	location.href = "productPage?num=1&bag_type=" + bag_type + "&brand_idx=" + brand_idx + 
	  "&keyword=" +  keyword +"#productList";

});

function changeListByBag(type_idx){	
	
	var bag_type = type_idx;
	var brand_idx = "${brand_idx}";
	var keyword = $('#keyword').val();	
	
	location.href = "productPage?num=1&bag_type=" + bag_type + "&brand_idx=" + brand_idx + 
	  "&keyword=" +  keyword +"#productList";
	
}

function changeListByProductName(){
	
	var bag_type = "${bag_type}"; 
	var brand_idx = "${brand_idx}";
	var keyword = $('#keyword').val();	
	
	location.href =  "productPage?num=1&bag_type=" + bag_type + "&brand_idx=" + brand_idx + 
	  "&keyword=" +  keyword +"#productList";
	
}


</script>

	
	



</body>



</html>