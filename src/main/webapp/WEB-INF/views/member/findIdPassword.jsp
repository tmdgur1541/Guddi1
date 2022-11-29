<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
    <div class="row block-9">
      <div class="login-form col-md-8 d-flex">
        <form action="doLogin" name="loginForm" id="loginForm" method="post" class="bg-white p-5 contact-form">
	         <div class="login-heading">
		         <span>아이디찾기</span>	                      
		      </div>
	          <div class="form-group">
	            <label>성함</label>
	            <input type="text" class="form-control" placeholder="성함을 입력해주세요" id="name" name="name">
	          </div>
	          <div class="form-group">
	            <label>이메일</label>
	            <input type="text" onkeyup="enterkey();"  class="form-control" name="password" placeholder="이메일을 입력해주세요." id="email" name="email">
	          </div>	        
	          <div class="form-group text-center">
	            <input type="button" value="아이디 찾기" class="btn btn-primary py-3 px-5" id="findId">
	          </div>
        </form>
        <form action="temppass" name="temppass" id="temppass" method="post" class="bg-white p-5 contact-form">
	         <div class="login-heading">
		         <span>임시 비밀번호발급</span>	                      
		      </div>
	          <div class="form-group">
	            <label>아이디</label>
	            <input type="text" class="form-control" name="userId" placeholder="아이디를 입력해주세요.">
	          </div>
	          <div class="form-group">
	            <label>이메일</label>
	            <input type="text" onkeyup="enterkey();"  class="form-control" name="email" placeholder="이메일을 입력해주세요.">
	          </div>	          
	          <div class="form-group text-center">
	            <input type="button" value="임시비밀번호 발급하기" class="btn btn-primary py-3 px-5" onclick="check_input()">
	          </div>
	    </form>        
      </div>      
    </div>
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


var msg = "${msg}";

if(msg != ""){
	alert(msg);
}	




function check_input() {
	
    if (!document.temppass.userId.value)
    // login_form 이름을 가진 form 안의 id_val 의 value가 없으면
    {
        alert("아이디를 입력하세요!");
        // 화면 커서 이동
        return;
    }
    
    if (!document.temppass.email.value)
    {
        alert("이메일을 입력하세요!");
        // 화면 커서 이동
        return;
    }
    
    document.temppass.submit();
    // 모두 확인 후 submit()
 }
 
function enterkey() {	
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
    	check_input();
    }
}





nameNull = "성함";
emailNull = "이메일";

$('#findId').click(function () {
	var name = $('#name').val();
	var email = $('#email').val();
	
	if(name == ''){
		alert(nameNull + '을 입력해 주세요');
	}else if(email == ''){
		alert(emailNull + "을 입력해 주세요");
	} else if(name != '' && email != ''){
		location.href='doFindMemberId?name='+name+'&email='+email;
	}
})


</script>
</html>