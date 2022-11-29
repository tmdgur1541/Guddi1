<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
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
	      	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>마이페이지</span></p>
	        <h1 class="mb-0 bread">마이페이지</h1>	     
	      </div>    
	</div>
</section>


<section class="ftco-section ftco-degree-bg">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 ftco-animate">
		  <form name = "mform" id = "mform" method="post">	                
		      <div class="myPage-table table-striped">		        
		        <b><font size="3" color="BLACK">${info.username}</font>님의 회원 정보</b>        
		        <br><br>		                       
		        <table>
		          <colgroup>
   				    <col width="20%" />
    				<col width="80%" />	    	
  				  </colgroup>
		            <tr>
		             	<td id="title">아이디</td>
		           		<td>${info.userId}</td>           
		            </tr>               
		            <tr>
		            	<td id="title">성함</td>
		             	<td>${info.username}</td>
		            </tr>   
		            <tr>
		            	<td id="title">핸드폰번호</td>
		           		<td>${info.phone}</td>		
		            </tr>   
		            <tr>
		            	<td id="title">이메일주소</td>
		           		<td>${info.email}</td>		
					</tr>   
		            <tr> 
						<td id="title">주소</td>
		           		<td>${info.address} ${info.address_detail}</td>	
		            </tr>                               
		            <tr>
		            	<td id="title">가입일</td>          
					 	<td>${info.regdate}</td> 
		            </tr> 
		            <tr>
		            <td id="title">회원등급</td>
		            	<c:if test="${info.mem_flg  eq 1}"><td>일반회원</td></c:if> 
						<c:if test="${info.mem_flg  eq 2}"><td>관리자</td></c:if>
		            </tr>		           
		        </table>
				
		        <button type="button" class="btn btn-primary" onclick="location.href='./'">뒤로</button>
		        <button type="button" class="btn btn-primary" onclick="location.href='checkPassword?userId=${info.userId}'">정보수정하기</button>
		        <%-- <button type="button" id="btnUpdate" class="btn btn-primary">정보수정하기</button> --%>	    	
		    </div>
   		</form>         
      </div>

      <div class="col-lg-12 ftco-animate"  id="orderList">		                 
		 <div class="myPage-table table-striped">		        
			 <b><font size="3" color="BLACK">${info.username}</font>님의 주문내역</b>        
			 <br><br>
			 <div class="row text-center search-form">
			   <div class="col-md-4">		        			      
			   </div>
			   <div class="col-md-4">			  
			   </div>
			   <div class="col-md-4">
			     <div>
			     	<div class="form-group">			     	          
			             <a href="javascript:void(0);" onclick="changeOrderList();" id="searchBtn"><span class="icon ion-ios-search"></span></a>
			             <input type="text" class="form-control" value="${orderKeyword}"id="orderKeyword" 
			             	name="orderKeyword" placeholder="제품명을 입력해주세요">		            
			         </div>		
			   	</div>
			   </div>
			 </div>	
			 <p id="totalPrice"></p>		                       
			 <table id="tb_orderList">
			     <tr style="background-color:#212529;color:white;">
			     	<th>주문번호</th>
			      	<th>주문날짜</th>
			      	<th>제품명</th>
			      	<th>가격</th>
			      	<th>수량</th>	
			      	<th>총가격</th>	             		           		     
			     </tr>    
			     <c:if test="${orderList.size() == 0 }">           
			     <tr>
			      	<td colspan="6">주문하신 상품이 존재하지 않습니다.</td>		             	             	           		     
			     </tr>
			     </c:if>
			     <c:forEach items="${orderList}" var="list">
			     <tr>
			     	<th>${list.order_num }</th>
			      	<th>${list.regdate}</th>
			      	<th>${list.product_name}</th>
			      	<th><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.price}" />원</th>
			      	<th>${list.quantity}</th>	
			      	<th><fmt:formatNumber type="number" maxFractionDigits="3" value="${list.totalPrice}" />원</th>	             		           		     
			     </tr>  
			     </c:forEach>        
			 </table>
			 <div class="col text-center">
			    <div class="block-27">
				   <ul>
				      <c:if test="${orderPage.prev}">
				      <li><a href="myPage?orderNum=${orderPage.startPageNum - 1}
				      &reviewNum=${reviewSelect}#orderList">&lt;</a></li>
				      </c:if>
				      <c:forEach begin="${orderPage.startPageNum}" end="${orderPage.endPageNum}" var="num">
				      <c:if test="${orderSelect == num}">
				      <li class="active"><span>${num}</span></li>
				      </c:if>
				      <c:if test="${orderSelect != num}">
				      <li><a href="myPage?orderNum=${num}
				      &reviewNum=${reviewSelect}#orderList">${num}</a></li>			     
				      </c:if>    		
				      </c:forEach>
				      <c:if test="${orderPage.next}">
				      <li><a href="myPage?orderNum=${orderPage.endPageNum + 1}
				      &reviewNum=${reviewSelect}#orderList">&gt;</a></li>
				      </c:if>
				   </ul>
				</div>
		    </div>		
		 </div>
      </div>
 	 
      <div class="col-lg-12 ftco-animate" style="padding-top:15px;">		                  
		 <div class="myPage-table table-striped" id="reviewList">		        
		   <b><font size="3" color="BLACK">${info.username}</font>님이 작성하신 리뷰내역</b>        
		   <br><br>		  
		   <div class="row text-center search-form">
			  <div class="col-md-4">			  				    
			  </div>
			  <div class="col-md-4">
			     <div class="mb-4">
			   	<select name="reviewSearchType" id="reviewSearchType" class="form-control">			   		
			   			<option value="product_name" <c:if test="${reviewSearchType eq 'product_name'}">selected</c:if>>제품명</option>	
			   			<option value="subject"  <c:if test="${reviewSearchType eq 'subject'}">selected</c:if>>리뷰제목</option>	
				</select>		
			    </div>
			  </div>
			  <div class="col-md-4">
			    <div class="mb-4">
			    	<div class="form-group">                
			            <a href="javascript:void(0);" onclick="changeReviewList()" id="searchBtn"><span class="icon ion-ios-search"></span></a>
			            <input type="text" class="form-control" id="reviewKeyword" name="reviewKeyword" placeholder="검색어를 입력해주세요">
			        </div>		
			  	</div>
			  </div>
		   </div>                        
		   <table>
		        <tr style="background-color:#212529;color:white;">
		        	<th>작성일자</th>
		        	<th>리뷰 제목</th>
		        	<th>제품명</th>
		        	<th>리뷰번호</th>
		        	<th>삭제하기</th>			             	           		     
		       </tr>
		       <c:if test="${reviewList.size() == 0 }">           
		       <tr>
		        	<td colspan="5">작성하신 리뷰가 존재하지 않습니다.</td>		             	             	           		     
		       </tr>
		       </c:if>
		       <c:forEach items="${reviewList}" var="list">
		       <tr>		       
		        	<th>${list.regdate}</th>
		        	<th>
		        		<c:if test="${list.del_flg ne 1}">
		        		<a href="reviewDetail?idx=${list.idx}">${list.subject}</a>
		        		</c:if>
		        		<c:if test="${list.del_flg ne 0}">
		        		이미 삭제된 리뷰입니다.
		        		</c:if>
		        	</th>
		        	<th>${list.product_name}</th>
		        	<th>${list.idx}</th>	
		        	<th>
		        		<c:if test="${list.del_flg ne 1}">
		        		<button class="btn btn-primary" onclick="delReview(${list.idx})">삭제</button>
		        		</c:if>
		        	</th>	             		           		     
		       </tr>  
		       </c:forEach>      
		   </table>
		   <div class="col text-center">
		      <div class="block-27">
		          <ul>
			      <c:if test="${reviewPage.prev}">
			      <li><a href="myPage?orderNum=${orderSelect}&reviewNum=${reviewPage.startPageNum - 1}#reviewList">&lt;</a></li>
			      </c:if>
			      <c:forEach begin="${reviewPage.startPageNum}" end="${reviewPage.endPageNum}" var="num">
			      <c:if test="${reviewSelect == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${reviewSelect != num}">
			      <li><a href="myPage?orderNum=${orderSelect}&reviewNum=${num}#reviewList">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      <c:if test="${reviewPage.next}">
			      <li><a href="myPage?orderNum=${orderSelect}&reviewNum=${reviewPage.endPageNum + 1}#reviewList">&gt;</a></li>
			      </c:if>
			    </ul>
		      </div>
       	   </div>			
		 </div>   		     
      </div>
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



function delReview(idx) {
	
	if (confirm("해당 리뷰를 삭제하시겠습니까?")) {
		location.href='delReview?idx='+idx;
	}
	
}

//총가격표시
var totalPrice = ${totalPrice};

totalPrice = totalPrice.toLocaleString();
console.log(totalPrice);
$("#totalPrice").html("${info.username}님 총 구매가격 : ₩" + totalPrice);


function changeOrderList(){
	
	var keyword = $("#orderKeyword").val();
	location.href="myPage?orderNum=1&reviewNum=1&orderKeyword="+keyword+"#orderList";
	
}

function changeReviewList(){
	
	var keyword = $("#reviewKeyword").val();
	var searchType = $("#reviewSearchType").val();
	
	location.href="myPage?orderNum=1&reviewNum=1&reviewKeyword="+keyword+"&reviewSearchType="+searchType+"#reviewList";
	
}

</script>
</html>