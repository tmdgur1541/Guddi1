<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>결제하기</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap"rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap"rel="stylesheet">
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
				<h1 class="mb-0 bread">주문하기</h1>
			</div>
		</div>
	</section>

	<section class="ftco-section ftco-degree-bg" id="qnaList">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 ftco-animate">
				<form action="doOrder" method="post" class="order_form" id="doOrderForm"name="toCheckout">
					<div class="myPage-table table-striped">
						<table>
							<tr style="background-color: #212529; color: white;">
								<th>제품이미지</th>
								<th>제품명</th>
								<th>가격</th>
								<th>수량</th>
								<th>총가격</th>
							</tr>
							<c:forEach items="${orderList}" var="orderInfo">
								<tr>
									<th><img src='resources/photo/${orderInfo.newFileName }'style="width: 200px; height: 200px;" /></th>
									<th class="productName">
										<input type="hidden" name="product_code" value="${orderInfo.product_code}">
										<input type="hidden" name="product_name" value="${orderInfo.product_name}">
										<input type="hidden" name="quantity" value="${orderInfo.quantity}">
										<input type="hidden" name="totalPrice" value="${orderInfo.price*orderInfo.quantity}">
										<input type="hidden" name="price" value="${orderInfo.price}">
										<h5>${orderInfo.product_name}</h5>
  			        					<p>상품코드 : ${orderInfo.product_code}</p>  	
									</th>
									<th>₩ <fmt:formatNumber value="${orderInfo.price}" pattern="#,###.##"/></th>
									<th class="quantity">${orderInfo.quantity}</th>
									<th class="totalPrice">₩ <fmt:formatNumber value="${orderInfo.price*orderInfo.quantity}" pattern="#,###.##"/></th>
								</tr>
								<input type="hidden" class="getTotalPrice" value="${orderInfo.price*orderInfo.quantity}">
							</c:forEach>
						</table>
					</div>
					<div class="col-lg-6" style="margin-top: 70px;  float: left;">
						<h2>결제하기</h2>
						<div class="form-group" style="text-align: left;">
							<label for="inputtelNO">성함</label>
							<input type="text"value="${orderList[0].username }" class="form-control"id="userName" name="userName"> <br>
							<div class="form-group" style="text-align: left;">
								<label for="inputtelNO">우편번호</label>
								<input type="text"value="${orderList[0].zipcode }" class="form-control"id="inputZipcode" name="zipcode" placeholder="우편번호 찾기를 해주세요.">
							</div>
							<div class="form-group" style="text-align: left;">
								<label for="inputtelNO">주소</label>
								<input type="text"value="${orderList[0].address }" class="form-control" readonly id="inputAddress" name="address" placeholder="주소를 입력해 주세요">
							</div>
							<div class="form-group" style="text-align: left;">
								<label for="inputtelNO">상세 주소</label>
								<input type="text"value="${orderList[0].address_detail }" class="form-control"id="inputAddress_detail" name="address_detail"placeholder="상세주소를 입력해 주세요">
							</div>
							<div class="form-group" style="text-align: left;">
								<label for="InputEmail">이메일 주소</label>
								<input type="email"value="${orderList[0].email }" class="form-control"id="inputEmail" name="email" placeholder="이메일 주소를 입력해주세요">
							</div>
							<div class="form-group" style="text-align: left;">
								<label for="inputMobile">휴대폰번호</label>
								<input type="tel"value="${orderList[0].phone }" class="form-control"id="inputMobile" name="phone" placeholder="ex)01012345678">
							</div>
						</div>
						<div class="text-center">
							<input type="button" id="btnZipcode"class="btn btn-primary py-3 px-5" onclick="goPostcode()"value="우편번호 검색" />
						</div>
					</div>
					<div class="col-lg-5" style="height: 300px; width: 500px; margin-left: 645px; margin-top: 70px;">
						<h4 style="padding-bottom: -300px;">카트</h4>		      
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
				     				<input type="hidden" name="totalPriceFinal" id="totalPriceFinal"/>
				     				<input type="hidden" name="quantityFinal" id="quantityFinal"/>
				     				<input type="hidden" name="productNameFinal" id="productNameFinal"/>
				     			</p>
				     			
				     		</div>
				     	</div>
					</div>
					<div class="col-lg-5" style="height: 300px; width: 500px; margin-left: 645px; margin-top: 70px;">
						<h4 style="margin-bottom: 40px;">결재방법</h4>
				     	<input type="radio" name="approvalChoice" value="계좌이체" style="margin-left: 20px;" /><span> 계좌이체</span><br/>
				     	<input type="radio" name="approvalChoice" value="신용카드" style="margin-left: 20px;"/><span> 신용카드</span><br/>
				     	<input type="radio" name="approvalChoice" value="네이버페이" style="margin-left: 20px;"/><span> 네이버페이</span>
					</div>
				    <div class="text-center">
				    <!-- <form action="/checkout" method="post" class="order_form" name="toCheckout"> -->
						<div class="order_btn_each">
						     <input type="hidden" value="${total}" name="checkoutPrice" id="checkoutPrice">
						     <input type="hidden" value="${sessionScope.userId}" name="userId" id="userId">
						     <input type="hidden" id="arrayParam" name="arrayParam"/>	     		
						     <!-- <a href="" id="order_btn" onclick="goOrder()" class="btn btn-primary py-3 px-4">결제하기</a> -->
						    <!--<button type="submit" id="order_btn" onclick="goOrder()" class="btn btn-primary py-3 px-4">결제하기</button>  -->
						    <!--  onclick="location.href='toOrder?userId=${sessionScope.userId }'"-->
						    <%-- <a type="button" href="toOrder?userId=${sessionScope.userId }" id="toCheckoutButton" class="btn btn-primary py-3 px-4">결제하기</a> --%> 
						    <input type="button"value="결제하기" class="btn btn-primary py-3 px-4" id="toCheckoutButton"/>
						</div>
				     </div>
				</form>
				</div>
			</div>
		</div>
	</section>


	<jsp:include page="/WEB-INF/views/include/footer.jsp" />

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
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="resources/js/google-map.js"></script>
	<script src="resources/js/main.js"></script>

	<!-- 우편번호 찾기 라이브러리 -->
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</body>
<script>
	//var a = $(".totalPrice").length();
	//console.log($('p').length);
	var totalPrice = 0;
	var totalQuantity = 0;
	var totalProductName = 0;
	console.log($('.getTotalPrice').length);
	console.log($('.getTotalPrice').eq(0).val());
	console.log("갯수",$('.quantity').length);
	setTotal();
	setQuantity();
	serProductNames();
	function setTotal() {
		for(var i = 0; i<$('.getTotalPrice').length; i++){
			totalPrice += parseInt($('.getTotalPrice').eq(i).val());
			console.log(totalPrice);
		}
		$(".totalPrice_span").text(totalPrice.toLocaleString());
	}
	function setQuantity() {
		for(var i = 0; i<$('.quantity').length; i++){
			totalQuantity += parseInt($('.quantity').eq(i).html());
			console.log(totalQuantity);
		}
	}
	function serProductNames() {
		for(var i = 0; i<$('.productName').length; i++){
			totalProductName += $('.productName').eq(i).html();
			console.log(totalProductName);
		}
	}
	$("#quantityFinal").val(totalQuantity);
	$("#totalPriceFinal").val(totalPrice);
	$("#productNameFinal").val(totalProductName);
	console.log($(".totalPrice_span").html());
	//우편번호 찾기
	function goPostcode() {
		console.log("우편번호 검색");
		$("#inputAddress_detail").val(null);
		$("#inputAddress").val(null);
		$("#inputZipcode").val(null);

		new daum.Postcode({
			oncomplete : function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

				// 각 주소의 노출 규칙에 따라 주소를 조합한다.
				// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
				var addr = ''; // 주소 변수
				var extraAddr = ''; // 참고항목 변수

				//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
				if (data.userSelectedType === 'R') {
					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraAddr += (extraAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraAddr !== '') {
						extraAddr = ' (' + extraAddr + ')';
					}
					// 조합된 참고항목을 해당 필드에 넣는다.
					document.getElementById("inputAddress").value = extraAddr;

				} else {
					document.getElementById("inputAddress").value = '';
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.getElementById('inputZipcode').value = data.zonecode;
				document.getElementById("inputAddress").value = addr;
				// 커서를 상세주소 필드로 이동한다.
				document.getElementById("inputAddress_detail").focus();
			}
		}).open();
	};
	
	

	
	$("#toCheckoutButton").click(function () {
		
		var userName = $('input[name=userName]').val();
		var zipcode = $('input[name=zipcode]').val();
		var address = $('input[name=address]').val();
		var address_detail = $('input[name=address_detail]').val();
		var email = $('input[name=email]').val();
		var phone = $('input[name=phone]').val();
		var approvalChoice = $('input:radio[name="approvalChoice"]:checked').val();
		
		console.log("#toCheckoutButton 동작 확인");
		console.log(userName, zipcode, address, address_detail, email, phone, approvalChoice);
		if(userName.length == 0){
            alert('성함을 입력해 주세요');
            $('input[name=userName]').focus();
        } else if(zipcode.length == 0){
            alert("우편번호를 입력해 주세요");
            $('input[name=zipcode]').focus();
        } else if(address.length == 0){
            alert("주소를 입력해 주세요");
            $('input[name=address]').focus();
        } else if(address_detail.length == 0){
            alert("상세주소를 입력해 주세요");
            $('input[name=address_detail]').focus();
        } else if(email.length == 0){
            alert("이메일을 입력해 주세요");
            $('input[name=email]').focus();
        } else if(phone.length == 0){
            alert("핸드폰 번호를 입력해 주세요");
            $('input[name=phone]').focus();
        } else if(approvalChoice == null){
            alert("결제방식을 입력해 주세요");
            return;
        }
		if (confirm('결제하시겠습니까?')) {
			$('#doOrderForm').submit();
		}
		
	});
</script>
</html>








































































