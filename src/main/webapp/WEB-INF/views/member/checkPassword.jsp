<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
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
	       <p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>비밀번호확인</span></p>
	       <h1 class="mb-0 bread">비밀번호확인</h1>
	    </div>    
	</div>
</section>

<section class="ftco-section ftco-degree-bg">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 ftco-animate">
		  <form name="checkform" id="checkform" method="post">	                
		      <div class="myPage-table table-striped ">		        
		        <b><font size="3" color="BLACK">${info.username}</font>님의 정보를 변경을 위하여 비밀번호를 입력해주세요.</b>        
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
		            	<td id="title">비밀번호</td>
		             	<td><input type="password" class="form-control" id="inputPassword" name="password"  placeholder="비밀번호를 입력해주세요."></td>			  			             
					   
		            </tr>   
		           
		        </table>
				
		        <button type="button" class="btn btn-primary" onclick="location.href='myPage?userId=${info.userId}'">취소</button>
		        <button type="button" class="btn btn-primary" onclick="goPasswordCheck()">확인</button>
		    </div>
   		</form>         
      </div>
    </div>
  </div>
</section> <!-- .section -->



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



function goPasswordCheck(){
	
	
	var frm = document.checkform;	
	var userId = "${info.userId}";
	var password = $("#inputPassword").val();	
	
	console.log("userId:" + userId);
	console.log("password:" + password);
	
	if(frm.password.value.length<1) {
		alert("비밀번호를 입력해주세요.");
		frm.idCheck.focus(); //포커스 이동
		return false;		
	} 
		
	$.ajax({
		url: "doPwCheck", //호출할 파일명
		data:{'userId': userId,
			  'password': password
			},
		method: "POST",
		dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
		
		success: function(data){
			console.log(data);
			
			if (data.result==true) {
				location.href="changeInfo?userId=${info.userId}";
			} else {
				alert("비밀번호를 확인해주세요.");		
			}		
			
		},
		error:function(){
			console.log("데이터 로딩 실패");
		}
	});
}

</script>
</html>