<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
	<meta charset="UTF-8">
	<title>${detail[0].product_name}</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
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
<link rel="stylesheet" href="resources/css/detailstyle.css">



<style>
	.product-quantity{
		text-align: center;
	}
	
	.prd_info .photo li img{
		width: 268.99px;
	}
</style>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section class="ftco-section contact-section bg-light">
	<div class="container">    
	      <div class="col-md-12 ftco-animate text-center bg-light">
	      	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>${detail[0].brand_name}</span>/<span>${detail[0].product_name}</span></p>
	        <h1 class="mb-0 bread">${detail[0].product_name}</h1>
	      </div>    
	</div>
</section>


<div class="container">
	<section>
		<div class="prd_info">
			<ul class="photo text-center">
				<c:forEach items="${productimage}" var="productimage">
					<li><img src="resources/photo/${productimage.newFileName}" /></li>
				</c:forEach>
			</ul>
			<div class="info">
				<form action="cartupdate" method="post" class="formcart">
				<input type="hidden" name="userId" class="userId" value="${SessionScope.userId}"/>
				<input type="hidden" class="brand_name" value="${detail[0].brand_name}"/>
				<input type="hidden" class="product_name" value="${detail[0].product_name}"/>
				<input type="hidden" class="product_code detail_product_code" value="${detail[0].product_code}"/>
				<input type="hidden" class="price" value="${detail[0].price}"/>


				<h3 class="brand_name">${detail[0].brand_name}</h3>
				<ul class="brand_info">
					<li class="product_name"><span class="tit">상 품 명 : </span>${detail[0].product_name}</li>
					<li class="product_code"><span class="tit">상품코드 : </span>${detail[0].product_code}</li>
					<li class="product_content"><span class="tit">상품설명 : </span>${detail[0].product_content}</li>
					<li class="price"><span class="tit">상품금액 : </span>
					<span class="num">
					₩ <fmt:formatNumber type="number" maxFractionDigits="3" value="${detail[0].price}" />
					</span></li>
					<li class="btn_area">
						<span class="tit">상품수량 : </span>
						<span class="btn-minus" >-</span>
						<input class="product-quantity" type="tel" value="1" readonly />
						<span class="btn-plus">+</span>
					</li>
				</ul>

				<br/>

				<input type="button" class="cart-btn" value="장바구니"/>
				</form>
			</div>
		</div>
	</section>
	<section class="review_wrap">
		<div class="title">REVIEW</div>
		
		<!-- 리뷰 리스트 예시 start -->
		
		<ul class="review_list">
			<c:if test="${reviewlist.size() eq 0}">
				<li><div class="text-center">등록된 리뷰가 없습니다.</div></li>
			</c:if>
			<c:forEach items="${reviewlist}" var="review">
				<li>
					<div class="writer"> 작성자 : <span class="reviewuser">${review.userId}</span> </div>
					<div class="subject">
						${review.subject}<br>
						내용 : ${review.content}
						<span class="date">${review.regdate}</span>
					</div>
					<c:forEach items="${answerList}" var="answer">
						<c:if test="${answer.r_idx eq review.idx}">
						<div class="con">
							  ㄴ 관리자 : ${answer.content}
						</div>
						</c:if>
					</c:forEach>
				</li>
			<div style="text-align:right;padding:1%;">
			<input type="button" class="btn btn-primary" onclick="detailreviewdelete('${review.idx}','${review.userId}')" value="삭제하기" />
			</div>
			<!--  onclick="location.href='reviewdelete?idx=${review.idx}'"-->
			</c:forEach>
		</ul>
		<ul class="paging">
			
			<c:if test="${page.prev}">
			<li class="prev disabled" ><a href="detail?reviewNum=${page.endPageNum - 1}&idx=${idx}">&lt;</a></li>
			</c:if>
			 <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="now"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li class="num"><a href="detail?reviewNum=${num}&idx=${idx}">${num}</a></li>			     
			      </c:if>    		
			</c:forEach>
			<c:if test="${page.next}">
			      <li><a href="detail?reviewNum=${page.endPageNum + 1}&idx=${idx}">&gt;</a></li>
			</c:if>
		</ul>
		<!-- 리뷰 리스트 예시 end -->
	</section>
	
	
	<section class="review_wrap">
	<c:if test="${sessionScope.userId ne null}">
		<div class="title">REVIEW WRITE</div>
		<ul class="reviewupdateForm">
			<li class="reviewuesrId">작성자 : ${sessionScope.userId}</li>
			<li>제 &nbsp; 목 : <input type="text" class="reviewsubject" maxlength="50"/>${review.regdate}</li>
			<li class="con">
				내 &nbsp; 용 : <textarea class="reviewcontent"></textarea>
				<input type="button" class="reviewupdate" onclick="reviewupdate('${idx}','${sessionScope.userId}')" value="등록"/>
			</li>
		</ul> 
	</c:if>
	<c:if test="${sessionScope.userId eq null}">
		
		<ul class="reviewupdateForm text-center">
			<li class="reviewuesrId">로그인 후 리뷰작성이 가능합니다.</li>
		</ul> 
	</c:if>
	</section>
	
</div>

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
var sessionuserId = "${sessionScope.userId}";

function detailreviewdelete(reviewidx,writer){
	
	var idx = reviewidx;
	console.log(idx,writer);
	
	if (sessionuserId == writer) {
		
		if (confirm("해당 리뷰를 삭제하시겠습니까?")) {
			$.ajax({
				type:'GET',
				url:'reviewdelete',
				data:{'idx':idx},
				datatype:'JSON',
				success:function(data){
					console.log(data);
					if (data.success == 1) {
						alert('삭제가 완료되었습니다.');
						window.location.reload();
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 생겼습니다.고객센터에 문의해주세요.');
				}
			});
		}
		
		
	}else if(sessionuserId != writer){
		alert('작성한 사람만 삭제할수 있습니다. ');
	}
}	

function reviewupdate(idx, userId){
	
	var product_code = $('.detail_product_code').val();
	var reviewsubject = $('.reviewsubject').val();
	var reviewcontent = $('.reviewcontent').val();
	
	console.log(product_code);
	
	if(reviewsubject=='') {
		alert('리뷰 제목을 입력해주세요');
	}else if(reviewcontent=='') {
		alert('리뷰 내용을 입력해 주세요.');
	}else{
			
		if (confirm('리뷰를 작성하시겠습니까?')) {
			$.ajax({
				type:'POST',
				url:'reviewupdate',
				data:{'reviewsubject':$('.reviewsubject').val(),
					  'reviewcontent':$('.reviewcontent').val(),
					  'product_code':$('.detail_product_code').val()				 
					  },
				datatype:'JSON',
				success:function(data){
					console.log(data);
					
					if (data.success > 0) {
						alert('리뷰등록이 완료되었습니다.');				
					}
					if(data.success < 1){
						alert('구매회원만 리뷰등록이 가능합니다.');	
					}
				},
				error:function(e){
					console.log(e);
					alert('서버에 문제가 생겼습니다. 고객센터에 문의해주세요.');
				}
			});
		}
		
	window.location.reload();
	
	}
	
};


$(".btn-minus").click(function(){
	var num = $(".product-quantity").val();
	if (num==1) {
		alert("1개이상부터 구매 가능합니다.");
		
	}else{
		num--;
		$('.product-quantity').val(num);
	}
});
$(".btn-plus").click(function(){
	var num = $('.product-quantity').val();
	num++;
	$('.product-quantity').val(num);
});

$(".cart-btn").click(function(){
		
		if(confirm("제품을 카트에 담으시겠습니까?")){
			var userId = $(".userId").val();
			var product_name = $(".product_name").val();
			var product_code = $(".product_code").val();
			var quantity = $(".product-quantity").val();
			var price = $(".price").val();
			console.log(userId);
			
			if (sessionuserId=='') {
				alert('장바구니는 회원만 이용가능합니다. 로그인해주시기 바랍니다.');
				location.href='toLogin';
				return;
			}
			
			$.ajax({
				url:"doCartUpdate",
				data:{
					'userId':userId,
					'product_name':product_name,
					'product_code':product_code,
					'price':price,
					'quantity':quantity
				},
				method: "POST",
				dataType: "JSON",
				success: function(data){
					if (data.success == 1) {
						if (confirm("장바구니로 이동하시겠습니까?")) {
							location.href="cart";
						}else{
							window.location.reload();
						}
					}
				
				},
				error:function(e){
					console.log("장바구니 실패");
				}
			});
		}else{
			window.location.reload();
		}
});


// 리뷰 리스트 - 제목 클릭 시 내용이 보이도록
$('.review_list li').click(function(){
	$(this).find('.con').slideToggle('fast');
	$(this).siblings().find('.con').slideUp('fast');
});



</script>
</html>