<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="UTF-8">
<title>제품수정</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<!-- ckeditor -->
<script src="resources/ckeditor/ckeditor.js"></script>	
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
      <p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>제품수정</span></p>
      <h1 class="mb-0 bread">제품수정</h1>    
     </div>
  </div>
</section>


<section class="ftco-section ftco-degree-bg">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 ftco-animate">		                 
		      <div class="">		        
		        <b><font size="3" color="BLACK">제품수정</font></b>   
		        <br><br>
		        <form method="post" action="doUpdateProduct" name="updateForm" id="updateForm" enctype="multipart/form-data">
		        	<input type="hidden" value="${dto.idx}" name="idx" id="idx">
					<label>제품명</label><br/>
					<input class="form-control" type="text" name="product_name" id="product_name" 
									placeholder="제품명을 입력해주세요." value="${dto.product_name }"/><br/>
					
					<label>브랜드</label><br/>
					<select name="brand_type" id="brand_type" class="form-control"  >
						<option value="" >브랜드를 선택해주세요.</option>
				   		  <c:forEach items="${sessionScope.brandcategory}" var="list">
				   		  	<c:if test="${list.brand_idx ne 0}">
								<option value="${list.brand_idx }" 
								<c:if test="${list.brand_name eq dto.brand_name}">selected</c:if>>${list.brand_name }</option>
							</c:if>
						  </c:forEach>
			   		</select><br/>					
					
					<label>종류</label><br/>
					<select name="bag_type" id="bag_type" class="form-control" >
						<option value="" >제품타입을 선택해주세요.</option>
				   		<c:forEach items="${sessionScope.bagtype}" var="list">
				   		  	<c:if test="${list.type_idx ne 0}">
								<option value="${list.type_idx }" 
								<c:if test="${list.type_name eq dto.bag_type}">selected</c:if>>${list.type_name }</option>
							</c:if>
						</c:forEach>
			   		</select><br/>
			   		
			   		<label>신상품 체크</label><br/>
					<select name="new_flg" id="new_flg" class="form-control" >
						<option value="" >신상품여부를 선택하세요.</option>	
						<c:forEach items="${sessionScope.newflg}" var="list">
							<option value="${list.idx}" 
							<c:if test="${list.idx eq dto.new_flg}">selected</c:if>>${list.newname}</option>
						</c:forEach>			   					   	
			   		</select><br/>
		
					<label>판매여부</label><br/>
					<select name="sell_flg" id="sell_flg" class="form-control" >
						<option value="" >판매여부를 선택하세요.</option>
						<c:forEach items="${sessionScope.sellflg}" var="list">				   		  
							<option value="${list.idx }" 
							<c:if test="${list.idx eq dto.sell_flg}">selected</c:if>>${list.sellname}</option>
						</c:forEach>				   	
			   		</select><br/>
			   		
					<label>가격 : 단위 원, 원제외 등록</label><br/>
					<input type="text" class="form-control" value="${dto.price }" name="price" id="price" placeholder="정가를 입력해주세요."/><br/>
										
					<label>제품코드</label>	
					<button type="button" class="btn btn-primary" onclick="makeProductCode()">제품번호발행</button>							
					<br/>
					<input type="text" class="form-control" value="${dto.product_code }" name="product_code" id="product_code" readonly placeholder="상품번호를 생성해주세요."/><br/>
						
					<label>제품 상세설명</label><br/>
					<textarea class="form-control" name="content" id="content" rows="10" placeholder="상세설명을 입력해주세요.">${dto.product_content }</textarea><br/>
															
					<br><br>
					<div style="text-align:center;">
					<button type="button" class="btn btn-primary" onclick="location.href='./'">취소</button>
		       		<button type="button" class="btn btn-primary" onclick="check_input()">수정</button>			
					</div>
				</form>	        		      	
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


</body>



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


<script>

CKEDITOR.replace("content");

var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}


//제품코드 생성 함수
function makeProductCode(){
	
	if ($("#brand_type").val()=='0') {
		alert("브랜드를 선택해주세요");
		return;
	}
	
	if ($("#product_type").val()=='0') {
		alert("제품타입을 선택해주세요");
		return;
	}
	
	if (confirm("상품번호를 생성하시겠습니까?")) {	

		$.ajax({
			url: "makeProductCode", //호출할 파일명			
			method: "POST",
			dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
			
			success: function(data){				
				
				if(data.newIdx!=null) {
					
					let today = new Date();  
					let brandCode;
					let bagCode;
					
					//제품코드에 브랜드 코드 반영
					for (var i = 0; i < data.brandType.length; i++) {						
						if ($("#brand_type").val() == data.brandType[i].brand_idx) {
							brandCode = data.brandType[i].brand_code;							
						}
					}
					
					//제품코드에 가방종류 코드 반영
					for (var i = 0; i < data.bagType.length; i++) {
						if ($("#bag_type").val() == data.bagType[i].type_idx) {
							bagCode = data.bagType[i].type_code;
						}						
					}					
					
					//제품코드에 새 idx 반영
					var idx = data.newIdx;
					var month = today.getMonth() + 1;  // 제품코드에  월 반영
					var date = today.getDate();  // 제품코드에  날짜 반영						
					//제품코드 생성!
					var product_code = brandCode + bagCode + month + date + idx;
					$("#product_code").val(product_code);				
					alert("상품번호 생성 성공!");
				} 					
			},
			error:function(){
				alert("상품번호 생성실패! 관리자에게 문의해주세요.");
			}
		});
	}	
}

function check_input() { 
 	
    if (!document.updateForm.product_name.value){// login_form 이름을 가진 form 안의 id_val 의 value가 없으면
        alert("상품명 입력하세요!");
        document.updateForm.product_name.focus();
        // 화면 커서 이동
        return;
    }  	
    if (document.updateForm.brand_type.value==''){
        alert("브랜드타입을 선택하세요!");
        // 화면 커서 이동
        return;
    } 
    if (document.updateForm.bag_type.value==''){
        alert("종류타입을 선택하세요!");
        // 화면 커서 이동
        return;
    } 
    if (!document.updateForm.price.value){
        alert("정가를 입력하세요!");
        // 화면 커서 이동
        return;
    }  
    if (document.updateForm.new_flg.value==''){
        alert("신상품 여부를 선택하세요!");
        // 화면 커서 이동
        return;
    }  
    if (document.updateForm.sell_flg.value==''){
        alert("판매 여부를 선택하세요!");
        // 화면 커서 이동
        return;
    } 
  
    if (!document.updateForm.product_code.value){
        alert("상품코드를 만들어주세요!");
        // 화면 커서 이동
        return;
    }
    
    if (!document.updateForm.content.value){
        alert("상세설명을 작성해주세요!");
        // 화면 커서 이동
        return;
    }
    
    document.updateForm.submit();
    // 모두 확인 후 submit()
 }
 
 

</script>
</html>