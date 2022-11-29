<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰관리</title>
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
	      	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>리뷰관리</span></p>
	        <h1 class="mb-0 bread">리뷰관리</h1>
	      </div>    
	</div>
</section>

<section class="ftco-section ftco-degree-bg" >
      <div class="ftco-animate col-lg-12">      
          <div class="row search-form col-lg-12" >
            <div class="col-md-3">
            	<select name="brand_type" class="form-control" onchange="changeQnAListByBrand(this.value)">
		    		<c:forEach var="list" items="${brandCategoryList}">
		    			<option value="${list.brand_name}" <c:if test="${brandName eq list.brand_name}">selected</c:if>>${list.brand_name}</option>	
		    		</c:forEach>		
				</select>			   		
		   </div>
		   <div class="col-md-3">
		   	    <select name="bag_type" class="form-control" onchange="changeQnAListByBag(this.value)">
		   			<option value="" >전체</option>	
		    		<c:forEach var="list" items="${bagCategoryList}">
		    			<option value="${list.type_name}" <c:if test="${bagName eq list.type_name}">selected</c:if>>${list.type_name}</option>	
		    		</c:forEach>		
				</select>			   		
		   </div>
		   <div class="col-md-3">		    
		    	<select name="answer_flg" class="form-control" onchange="changeQnAListByFlg(this.value)">
		    		<c:forEach var="list" items="${answerList}">
		    			<option value="${list.idx}" <c:if test="${answer_flg eq list.idx}">selected</c:if>>${list.answername}</option>	
		    		</c:forEach>		
				</select>			  
		   </div>
		   <div class="col-md-3">		     
		     	<div class="form-group">                
		             <a href="javascript:void(0);" onclick="changeQnAListById()" id="searchBtn"><span class="icon ion-ios-search"></span></a>
		             <input type="text" class="form-control" id="keyword" name="keyword" value="${keyword }" placeholder="제품명을 입력해주세요">
		         </div>		   	
		   </div>
		 </div>
		 <div class="manager-table table-striped">		
		   <table>
		        <tr style="background-color:#212529;color:white;">
		        	<th>번호</th>
		        	<th>브랜드</th>
		        	<th>종류</th>
		        	<th>제품명</th>
		        	<th>제목</th>
		        	<th>아이디</th>
		        	<th>작성날짜</th>		
		        	<th>답변여부</th>      	           		     
		       </tr>
		       <c:if test="${reviewList.size() == 0 }">           
		       <tr>
		        	<td colspan="8">해당하는 리뷰가 존재하지 않습니다.</td>		             	             	           		     
		       </tr>
		       </c:if>
		       <c:forEach items="${reviewList}" var="list">		       	  
			       <tr>		       
			        	<th>${list.idx}</th>			        	
			        	<th>${list.brand_name}</th>
			        	<th>${list.bag_type}</th>
			        	<th>${list.product_name}</th>
			        	<th><a href="javascript:void(0);" onclick="toDetail('${list.idx}','${list.product_name}')">${list.subject}</a></th>
			        	<th>${list.userId}</th>	
			        	<th>${list.regdate}</th>
			        	<th>
				        	<c:forEach items="${answerList}" var="answerList">
				        		<c:if test="${list.answer_flg eq answerList.idx}">${answerList.answername}</c:if>
				        	</c:forEach>			        		
			        	</th>	             		           		     
			       </tr>			    
		       </c:forEach>      
		   </table>
		   <div class="col text-center">
		      <div class="block-27">
		          <ul>
			      <c:if test="${reviewPage.prev}">
			      <li><a href="toReviewPage?num=${reviewPage.startPageNum - 1}&answer_flg=${answer_flg}&brandName=${brandName}
			      ">&lt;</a></li>
			      </c:if>
			      <c:forEach begin="${reviewPage.startPageNum}" end="${reviewPage.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li><a href="toReviewPage?num=${num}&answer_flg=${answer_flg}&brandName=${brandName}
			      ">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      <c:if test="${reviewPage.next}">
			      <li><a href="toReviewPage?num=${reviewPage.endPageNum + 1}&answer_flg=${answer_flg}&brandName=${brandName}">&gt;</a></li>
			      </c:if>
			    </ul>
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


var msg = "${msg}";

if(msg != ""){
	alert(msg);
}	


function delReview(idx) {
	
	if (confirm("해당 리뷰를 삭제하시겠습니까?")) {
		location.href='delReview?idx='+idx;
	}
	
};

function changeQnAListByFlg(answer_flg){	
	
	var bagName = '${bagName}';
	var brandName = '${brandName}';
	var answer_flg = answer_flg;
	var keyword = '${keyword}';
	
	location.href="toReviewPage?num=1&answer_flg="+answer_flg+"&keyword="+keyword+"&brandName="+brandName+"&bagName="+bagName;	
	
};

function changeQnAListByBrand(brand_name){	
	
	var bagName = '${bagName}';
	var brandName = brand_name;
	var answer_flg = '${answer_flg}';
	var keyword = '${keyword}';
	
	location.href="toReviewPage?num=1&answer_flg="+answer_flg+"&keyword="+keyword+"&brandName="+brandName+"&bagName="+bagName;		
	
};


function changeQnAListById(){
	
	var bagName = '${bagName}';
	var brandName = '${brandName}';
	var answer_flg = '${answer_flg}';
	var keyword = $('#keyword').val();	
	
	location.href="toReviewPage?num=1&answer_flg="+answer_flg+"&keyword="+keyword+"&brandName="+brandName+"&bagName="+bagName;	
	
};

function changeQnAListByBag(bag_name){	
	
	var bagName = bag_name;
	var brandName = '${brandName}';
	var answer_flg = '${answer_flg}';
	var keyword = '${keyword}';
	
	location.href="toReviewPage?num=1&answer_flg="+answer_flg+"&keyword="+keyword+"&brandName="+brandName+"&bagName="+bagName;	
	
};


function toDetail(idx, product_name) {
		
	location.href="toReviewDetail?idx="+idx+"&product_name="+product_name;
	
}






</script>
</html>