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
	    <div class="col-md-12 ftco-animate text-center">	    	
	    	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>제품내역관리</span></p>
	     	<h1 class="mb-0 bread">제품내역관리</h1>      
	    </div>
	</div>
</section>


<section class="ftco-section">
  <div class="container"> 
      <div class="form-group text-center">      	
	     	
	  </div>	 
  </div>
  <div class="ftco-animate manager-table table-striped">
  	      	
	  <form name = "mform" id = "mform" method="post">	                
	      <div>		        
	        <div class="row text-center search-form" id="productList">
			   <div class="col-md-4">
		     		<select name="brand_type" class="form-control" onchange="changeListByBrand(this.value)">
			    		<c:forEach var="list" items="${sessionScope.brandcategory}">
			    			<option value="${list.brand_idx}" <c:if test="${brand_type eq list.brand_idx}">selected</c:if>>${list.brand_name}</option>	
			    		</c:forEach>		
			   		</select>
			   </div>
			   <div class="col-md-4">
			      <div class=" mb-4">	
				   <select name="bag_type" class="form-control" onchange="changeListByBag(this.value)">
				   		<option value="">전체</option>	
				   		<c:forEach var="list" items="${sessionScope.bagtype}">
				    		<option value="${list.type_idx}" <c:if test="${bag_type eq list.type_idx}">selected</c:if>>${list.type_name}</option>	
				   		</c:forEach>		
				   </select>		
			     </div>
			   </div>
			   <div class="col-md-4">
			     <div class="mb-4">
			     	<div class="form-group">                
			             <a href="javascript:void(0);" onclick="changeListByProductName()" id="searchBtn"><span class="icon ion-ios-search"></span></a>
			             <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword }" placeholder="제품명 입력해주세요">
			         </div>		
			   	</div>
			   </div>
			 </div>                       
	        <table>	         
	             <tr style="background-color:#212529;color:white;">
	             	<th>번호</th>	             	
	             	<th>브랜드</th>
	             	<th>종류</th>
	             	<th>제품명</th>
	             	<th>제품코드</th>
	             	<th>가격</th>
	             	<th>신상여부</th>
	             	<th>판매여부</th>
	             	<th>등록일</th>
	             	<th>정보수정</th>
	             	<th>이미지수정</th>
	             	<th>삭제</th>	             	           		     
	            </tr>
	            <c:if test="${productList.size() == 0 }">   
	            <tr>
	             	<td colspan="12">등록된 제품이 없습니다.</td>	             	             	           		     
	            </tr>
	            </c:if>
 				<c:forEach items="${productList}" var="list">		       	  
			       <tr>		       
			        	<th>${list.idx}</th>
			        	<th>${list.brand_name}</th>
			        	<th>${list.bag_type}</th>
			        	<th>${list.product_name}</th>
			        	<th>${list.product_code}</th>
			        	<th>₩<fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" /></th>
						<c:forEach items="${sessionScope.newflg}" var="newFlgList">
							<c:if test="${newFlgList.idx eq list.new_flg}"><th>${newFlgList.newname}</th></c:if>
							<c:if test="${list.new_flg eq null}"><th>null</th></c:if>						
						</c:forEach>
			        	<c:forEach items="${sessionScope.sellflg}" var="sellFlgList">
							<c:if test="${sellFlgList.idx eq list.sell_flg}"><th>${sellFlgList.sellname}</th></c:if>
							<c:if test="${list.sell_flg eq null}"><th>null</th></c:if>								
						</c:forEach>
			        	<th>${list.regdate}</th>
			        	<th><a href="updateProduct?idx=${list.idx}">수정하기</a></th>
			        	<th><a href="updateProductImage?idx=${list.idx}">수정하기</a></th> 
			        	<th><a href="javascript:void(0);" onclick="delProduct('${list.idx}');">삭제</a></th>            		           		     
			       </tr>			    
		       </c:forEach>             
	        </table>
	        <c:if test="${page.endPageNum > 1}">
	        <div class="col text-center">
		      <div class="block-27">
		          <ul>
			      <c:if test="${page.prev}">
			      <li><a href="productMain?num=${page.startPageNum - 1}&brand_type=${brand_type}&bag_type=${bag_type}
			      &keyword=${keyword}#productList">&lt;</a></li>
			      </c:if>
			      
			      <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li><a href="productMain?num=${num}&brand_type=${brand_type}&bag_type=${bag_type}
			      &keyword=${keyword}#productList">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      
			      
			      <c:if test="${page.next}">
			      <li><a href="productMain?num=${page.endPageNum + 1}&brand_type=${brand_type}&bag_type=${bag_type}
			      &keyword=${keyword}#productList">&gt;</a></li>
			      </c:if>
			    </ul>
		      </div>
       	   </div> 
       	   </c:if>			
	    </div>
 	</form>

      <br>
      <input type="button" value="제품등록하기" class="btn btn-primary py-3 px-5" onclick="location.href='registProduct'">	 
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

	
	function enterkey() {	
	    if (window.event.keyCode == 13) {
	         // 엔터키가 눌렸을 때 실행할 내용
	         DoSearch();
	    }
	}
	
	function DoSearch() {    
		 
		  let keyword = $("#keyword").val();
		  let bag_type =  $("#bag_type").val();
		  let brand_type =  $("#brand_type").val();
		  
		  console.log(keyword);
		  console.log(bag_type);	 
		  console.log(brand_type);	
		  
		  location.href = "productMain?num=1&bag_type=" + bag_type + "&brand_type=" + brand_type + 
		  "&keyword=" +  keyword;
	
	};
	

	function delProduct(idx) {
		
		if (confirm("해당 제품을 삭제하시겠습니까?")) {
			location.href='delProduct?idx='+idx;
		}
		
	}


	function changeListByBrand(brand_idx){	
			
		var brand_type = brand_idx;
		var bag_type = "${bag_type}"; 
		var keyword = $('#keyword').val();	
		
		location.href = "productMain?num=1&bag_type=" + bag_type + "&brand_type=" + brand_type + 
		  "&keyword=" +  keyword +"#productList";
		
	}
	
	function changeListByBag(type_idx){	
		
		var bag_type = type_idx;
		var brand_type = "${brand_type}";
		var keyword = $('#keyword').val();	
		
		location.href = "productMain?num=1&bag_type=" + bag_type + "&brand_type=" + brand_type + 
		  "&keyword=" +  keyword +"#productList";
		
	}


	function changeListByProductName(){
		
		var bag_type = "${bag_type}"; 
		var brand_type = "${brand_type}";
		var keyword = $('#keyword').val();	
		
		location.href = "productMain?num=1&bag_type=" + bag_type + "&brand_type=" + brand_type + 
		  "&keyword=" +  keyword +"#productList";
		
	}
	
	function delProduct(idx) {
		
		if (confirm("해당 제품을 삭제하시겠습니까?")) {
			
			$.ajax({
				url: "delProduct", //호출할 파일명			
				method: "POST",
				data:{'idx':idx},
				dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
				
				success: function(data){	
								
					if (data.result>0) {
						alert('제품 삭제를 성공하였습니다!');
						location.href="productMain?num=1&brand_idx=0";
					}else {
						alert("DB상 제품정보와 이미지정보가 삭제되었으나, 실제파일이 삭제되지 않았습니다.");
					}
					
		
										
				},
				error:function(){
					alert("제품삭제 실패! 관리자에게 문의해주세요.");
				}
			});
			
		}
		
	}
	
	
</script>
</html>