<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
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
	<style></style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"/>
	<section class="ftco-section contact-section bg-light">
		<div class="bg-white" style="width: 500px; height:400px; margin-left: 500px;">
			<h3 style="text-align: center; padding-top: 50px;">아이디 찾기 결과</h3>
			<c:if test="${memberId.size() > 0 }">
				<c:forEach items="${memberId}" var="memberId">
					<p style="font-size: large; text-align: center; margin-top: 30px;">아이디 : ${memberId.userId }</p>			
				</c:forEach>
			<input id="login" type="button" value="로그인" class="btn btn-primary py-3 px-5" style="margin-top: 90px; margin-left: 190px;"/>
			</c:if>
			<c:if test="${memberId.size() == 0 }">
				<p style="font-size: large; text-align: center; margin-top: 30px;">가입하신 아이디가 없습니다</p>	
			<input id="memberWrite" type="button" value="회원가입" class="btn btn-primary py-3 px-5" style="margin-top: 90px; margin-left: 170px;"/>
			</c:if>
		</div>
	</section>
	
	<br><br>
	
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
	$('#login').click(function () {
		location.href='toLogin';
	})
	$('#memberWrite').click(function () {
		location.href='memberWrite';
	})
</script>
</html>