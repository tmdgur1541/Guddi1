<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
<title>GUddI Shop</title>
<style>
#Benefits{
	font-size:50;
}
#newreleases{
	font-size:35;
}
.mb-0{
	font-size:20;
	text-align:center;
	font-weight: bold;
}

.img-fluid {
  max-width: 100%;
  height: 269px; 
 }

</style>

<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>

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

<body class="goto-here">
    
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

<section id="home-section" class="hero">
	  <div class="home-slider owl-carousel">
	  <c:if test="${photos.size()<1}">
	  <div class="slider-item" >
      	<div class="overlay"></div>
        <div class="container text-center">
          	<h3>등록된 메인이미지가 존재하지않습니다.</h3>
        </div>
      </div>
	  </c:if>
	  <c:if test="${photos.size()>0}">
	  <c:forEach items="${photos}" var="photo">
	  <div class="slider-item" style="background-image: url(resources/photo/${photo.newFileName});">
      	<div class="overlay"></div>
        <div class="container">
          <div class="row slider-text justify-content-center align-items-center" data-scrollax-parent="true">
          </div>
        </div>
      </div>
	  </c:forEach>
	  
	  </c:if>
	  
    </div>
</section>

<section class="ftco-section">
  <div class="container">
	<h3 id="Benefits" class="ftco-animate text-center">Benefits</h3><br><br>
	<div class="row no-gutters ftco-services text-center" >
      <div class="col-md-4 text-center align-self-stretch ftco-animate">
        <div class="media block-6 services mb-md-0 mb-4">
          <div class="icon bg-color-1 active d-flex justify-content-center align-items-center mb-2">
        		<span class="flaticon-shipped"></span>
          </div>
          <div class="media-body">
            <h3 class="heading">Free Shipping</h3>
            <span>구띠샵은 모든 제품이 무료배송!</span>
          </div>
        </div>      
      </div>
      <div class="col-md-4 text-center align-self-stretch ftco-animate">
        <div class="media block-6 services mb-md-0 mb-4">
          <div class="icon bg-color-3 d-flex justify-content-center align-items-center mb-2">
        		<span class="flaticon-award"></span>
          </div>
          <div class="media-body">
            <h3 class="heading">Superior Quality</h3>
            <span>구띠샵은 모든 상품을 세번 검수하며</br>가품일시 3배를 보상합니다.</span>
          </div>
        </div>      
      </div>
      <div class="col-md-4 text-center align-self-stretch ftco-animate">
        <div class="media block-6 services mb-md-0 mb-4">
          <div class="icon bg-color-4 d-flex justify-content-center align-items-center mb-2">
        		<span class="flaticon-customer-service"></span>
          </div>
          <div class="media-body">
            <h3 class="heading">Support</h3>
            <span>구띠샵은 24시간 고객만족센터를 운영하고</br>AS책임을 보장합니다.</span>
          </div>
        </div>      
      </div>
    </div>
  </div>
</section>

<section class="ftco-section ftco-category ftco-no-pt">
	<div class="container">
		<h3 id="newreleases" class="ftco-animate">NEW Releases</h3><br>
		<div class="row">
			<div class="col-md-12 ftco-animate">
				<div class="row">
				<c:if test="${rankList.size() < 1}">
					<div class="text-center" style="margin:auto;">
					<br>
						<h3>등록된 제품이 존재하지않습니다.</h3>
					</div>					
				</c:if>
				<c:forEach items="${rankList}" var="list">
					<div class="col-md-3">
					<div class="product">
					<c:if test="${reviewNum eq 1}"></c:if>
						<a href="detail?idx=${list.idx}&reviewNum=1" class="img-prod"><img class="img-fluid" src="resources/photo/${list.newFileName}" alt="Colorlib Template"></a>
							<div class="overlay"></div>
						</div>
						</div>
				</c:forEach>
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


<!-- loader -->
<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

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
  
  
<script type="text/javascript">



</script>
  
  
</html>