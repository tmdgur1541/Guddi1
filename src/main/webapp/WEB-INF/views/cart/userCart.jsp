<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="UTF-8">
<title>카트</title>
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
<style>
.input_size_20{
	width:20px;
	height:20px;
}
.all_check_input{
	margin: 18px 0 18px 18px;
}
.all_chcek_span{
	padding-left: 8px;
   	font-size: 20px;
   	font-weight: bold;		
}
</style>
<body>

<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section class="ftco-section contact-section bg-light">
  <div class="container">   
     <div class="col-md-12 ftco-animate text-center">
      <p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>장바구니</span></p>
      <h1 class="mb-0 bread">장바구니</h1>    
     </div>
  </div>
</section>

<!-- 로그인 userCart-->

<c:if test="${sessionScope.userId eq null}">
	<section class="ftco-section ftco-no-pt ftco-no-pb py-5 bg-light">
		<div class="container py-4">
	        <div class="row d-flex justify-content-center py-5">
	          <div class="row justify-content-end">     
     			<div class="col-lg-12 mt-5 cart-wrap ftco-animate">     	
     				<div class="text-center">
     					<h1>로그인을 해주세요.</h1><br><br>
     					<a href="toLogin" class="btn btn-primary py-3 px-4">로그인</a>
     				</div>
     			</div>
    		  </div>
	        </div>
		</div>
	</section>
</c:if>

<c:if test="${sessionScope.userId ne null}">
<section class="ftco-section ftco-cart">
  <div class="container">
  	<div class="row">
     	<div class="col-md-12 ftco-animate">
     		<div class="cart-list">
     		<!-- 체크박스 전체 여부 -->

				<div class="all_check_input_div">
				


				<div class="all_check_input_div" style="margin:10px;">
					<!-- <input type="checkbox" id ="all" class="all_check_input input_size_20" checked="checked"><span class="all_chcek_span">전체선택</span> -->
					
					<input type="button" onclick = "del()" class="btn btn-primary" value="체크된 리스트 삭제" style="padding:10px;">

				</div>
  				<table class="table">
  			    <thead class="thead-primary">
  			    
  			      <tr class="text-center">

  			        <th><input type="checkbox" id="cbx_chkAll" class="" checked="checked" /> 전체선택</th>
  			        <th>이미지</th>
  			        <th>제품명</th>
  			        <th>수량</th>
  			        <th>제품가격</th>
  			       	<th>삭제</th>
  			      </tr>
  			     
  			    </thead>
  			    <tbody>
  			      <c:if test="${fn:length(list)==0}">
	  			      <tr class="text-center">
	  			        <td colspan="6">장바구니에 담긴 제품이 없습니다.</td>  			        
	  			      </tr>
  			      </c:if>
  			      
  			      <c:forEach items="${list}" var="list" varStatus="status">
  			      <tr class="text-center">
  			        <td class="cart_info_td">

  			        	<input type="checkbox" class="individual_cart_checkbox" name="chk" checked="checked" value="${list.product_code}"/>
					 	<input type="hidden" class="individual_newFileName_input" value="${list.newFileName}">

  			        	<input type="hidden" class="individual_product_name_input" value="${list.product_name}">
  			        	<input type="hidden" class="individual_product_code_input" value="${list.product_code}">
  			       	 	<input type="hidden" class="individual_quantity_input" value="${list.quantity}">
  			       	 	<input type="hidden" class="individual_price_input" value="${list.price}">
  			        	<input type="hidden" class="individual_totalprice_input" value="${list.quantity*list.price}">
  			        	<input type="hidden" value="${total}" name="checkoutPrice" id="checkoutPrice">
		     			<input type="hidden" value="${sessionScope.userId}" name="userId" id="userId">		     		
  			       	 	<%-- <input type="hidden" class="individual_bookId_input" value="${ci.bookId}"> --%>
  			        </td>
  			        <td class="image-prod"><div class="img" style="background-image:url(resources/photo/${list.newFileName});"></div></td>
  			        <td class="product-name">
  			        	<h3>${list.product_name}</h3>
  			        	<p>상품코드 : ${list.product_code}</p>  			        	  			      
  			        </td>
  			        <td class="quantity">
  		             	<form method="post" action="cartupdate">
  			        		<input type="text" name="quantity" id="quantity${status.index}"class="form-control input-number" 
  		             		value="${list.quantity}" onchange="changeCount(this)" min="1" max="100">  		             	
							<input type="hidden" name="product_name" value="${list.product_name}">
							<input type="hidden" name="product_code" value="${list.product_code}">
							<input type="hidden" name="userId" value="${userId}">							   
							<input type="submit" class="btn btn-primary py-3 px-4 mb-4" value="수량변경" style="margin:10px;">							   
						</form>  		             		
  		          	</td>  			        
  			        <td class="total"><fmt:formatNumber value="${list.quantity*list.price}" pattern="#,### 원" /></td>  			        
  			        <c:set var= "total" value="${list.quantity*list.price}"/>  			        
  			        <td class="product-remove"><a onClick="delCart('${list.product_code}')"><span class="ion-ios-close"></span></a></td>  			        
  			      </tr>
  				  </c:forEach>
  			    
  			    
  			    
  			    
  			    
  			    </tbody>
  			  </table>
  		  </div>
     	</div>
     </div>
     <div class="row col-lg-12 justify-content-end">
     	<c:if test="${fn:length(list)>0}"> 			      
     	<div class="col-lg-12 mt-5 cart-wrap ftco-animate">
     		<div class="cart-total mb-3">
     			<h3></h3>
     			<p class="d-flex">
     				<span>구매가격</span>     				
					<span id="totalPrice" class="totalPrice_span"></span>원
     			</p>
     			<p class="d-flex">
     				<span>배송료</span>
     				<span>언제나 0원!</span>
     			</p>     			
     			<hr>
     			<p class="d-flex total-price">
     				<span>최종구매가격</span>
     				<span id="totalPrice" class="totalPrice_span"></span>원
     			</p>
     		</div>
     		<div class="text-center">

				<div class="order_btn_each" id="checkCallForm">

		     		<input type="hidden" value="${total}" name="checkoutPrice" id="checkoutPrice">
		     		<input type="hidden" value="${sessionScope.userId}" name="userId" id="userId">
		     		<input type="hidden" id="arrayParam" name="arrayParam"/>
		     		<a href="./" class="btn btn-primary py-3 px-4">계속쇼핑하기</a> 

		     		<a href="javascript:void(0);" class="btn btn-primary py-3 px-4"  onclick="checkCall()">결제하기</a>     

				</div>
     		</div>
     	</div>
     	</c:if> 
     	<div class="text-center col-lg-12 ftco-animate">
	  		<c:if test="${fn:length(list)==0}"><br>
	     		<a href="./" class="btn btn-primary py-3 px-4">돌아가기</a>  
	     	</c:if>
     	</div> 
     </div>
  </div>
</section>
</c:if>


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



	
function checkCall() {
	 
	 var totalNum = $("input:checkbox[name=chk]:checked").length;	
	 var array = new Array(totalNum);
	 var userId = '${sessionScope.userId}';
	 
	 for(var i=0; i<totalNum; i++){                          
		 array[i]=$("input:checkbox[name=chk]:checked").eq(i).val();			
		}

	 if(array.length === 0){
	 	alert("선택하신 제품이 없습니다.");
	 	return;
	 }
	
	 /* JQUERY */ 
	 //create element (form) 
	 var newForm = $('<form></form>'); 
	 //set attribute (form) 
	 newForm.attr("name","newForm"); 
	 newForm.attr("method","post"); 
	 newForm.attr("action","toOrder"); 
	 // create element & set attribute (input) 
	 for(var i=0; i<totalNum; i++){                          
		 newForm.append($('<input/>', {type: 'hidden', name: 'arr', value: $("input:checkbox[name=chk]:checked").eq(i).val() }));			
		}
	 newForm.append($('<input/>', {type: 'hidden', name: 'userId', value: userId }));			
	 // append form (to body) 
	 newForm.appendTo('body'); 
	 //submit form 
	 newForm.submit();

	 
}

/*test_check 요청 배열에 값 넘기기 test*/

/* $("#toCheckoutButton").click(function(){
	if (confirm("결제화면으로 넘어가시겠습니까?")) {
		document.toCheckout.submit(); 
	}
});
 */

/*
// 결제하기 페이지로 이동 
$("#order_btn").on("click", function(){
	let form_contents ='';
	let orderNumber = 0; // index값 역할을 할 orderNumber 변수 
	$(".cart_info_td").each(function(index, element){ //상품의 데이터가 저장된 <input> 값들을 감싸고 있는 <td> 태그 반복해서 접근하는 메서드 
		// bookId, bookCount변수를 선언하여 접근한 <td>태그 내부에 있는 <input> 태그의 값들로 초기화
		let bookId = $(element).find(".individual_bookId_input").val();
		let bookCount = $(element).find(".individual_bookCount_input").val();
		let bookId_input = "<input name='orders[" + orderNumber + "].bookId' type='hidden' value='" + bookId + "'>";
		form_contents += bookId_input;
		
		let bookCount_input = "<input name='orders[" + orderNumber + "].bookCount' type='hidden' value='" + bookCount + "'>";
		form_contents += bookCount_input;
		orderNumber += 1;
	});
	$(".order_form").html(form_contents);
	$(".order_form").submit();
});

*/

$("#cbx_chkAll").click(function() {
	if($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
	else $("input[name=chk]").prop("checked", false);
});


$("input[name=chk]").click(function() {
	var total = $("input[name=chk]").length;
	var checked = $("input[name=chk]:checked").length;
	
	if(total != checked) $("#cbx_chkAll").prop("checked", false);
	else $("#cbx_chkAll").prop("checked", true); 
});


setTotal();
function setTotal(){
	let totalPrice=0;
	$(".cart_info_td").each(function(index, element){
		
		if($(element).find(".individual_cart_checkbox").is(":checked") == true){	//체크여부
			totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());			
		}
	});
	$(".totalPrice_span").text(totalPrice.toLocaleString());	
	
};

$(".individual_cart_checkbox").on("change", function(){	
	setTotal($(".cart_info_td"));
});

$("#cbx_chkAll").on("change", function(){	
	setTotal($(".cart_info_td"));
});




var delList = [];

function del(){
	
	var confirm_val = confirm("정말 삭제하시겠습니까?");
	
	if(confirm_val){
		
		console.log(delList);
		$('input[type="checkbox"]:checked').each(function (idx,item){
			//console.log(idx,$(this).val());
			
			delList.push($(this).val());
		
				
		});
		
		var checkArr = new Array();
		$.ajax({
			type:'POST',
			url:'chkdelete',
			data:{'delList' : delList},
			dataType: 'JSON',
			success: function (data) {
				console.log(data);
				alert(data.msg);
				//ajax는 페이지를 새로고침 하지 않기 때문에, 적용된 내용을 확인하기 위해서는 리스트를 다시 그려야 한다.
				//listCall();
				//$("tbody").empty();
				delList=[];				
				location.href = "cart";
			},
			error:function(e){
				console.log(e);
			}
			
		});
		
	}
	
	
}



 //삭제 
 
function delCart(product_code){
	
	if (confirm("해당 제품을 카트에서 제외하시겠습니까?")) {
		
		var product_code = product_code;
		
		$.ajax({
			url: "delCart", //호출할 파일명			
			type: "POST",
			dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
			data : {"product_code":product_code},
			success: function(data){
				console.log(data);
				
				if(data.result>0) {
				
					alert("상품을 제외하였습니다.");
					location.href = "cart";
				} else {
					alert("삭제를 실패하였습니다. 관리자에게 문의해주세요.");
				}
				
			},
			error:function(){
				alert("상품번호 생성실패! 관리자에게 문의해주세요.");
			}
		});
		
	}
	
} 




























</script>
</html>