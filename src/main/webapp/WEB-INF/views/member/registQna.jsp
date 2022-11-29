<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="UTF-8">
<title>Qna</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<script src="resources/css/bootstrap/bootstrap.min.js"></script>
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
        <form action="doRegistQna" name="qnaForm" id="qnaForm" method="post" class="bg-white p-5 contact-form">
	          <div class="login-heading">
		      	<span>Q&A작성</span>	                      
		      </div>   
	          <div class="col-lg-12 pl-md-5 ftco-animate">
		      	 <h5>문의타입</h5>
				 <select id="answer_type" name="answer_type" class="form-control">
				 		<option value="" >문의타입을 선택해주세요.</option>
				 	<c:forEach items="${getQnaTypeInfo}" var="list">
				 		<option value="${list.idx}" >${list.typename}</option>
				 	</c:forEach>					
				   			
			     </select>	
	          	 <br>
				 <h5>제목</h5>	
				 <input type="text" id="subject" name="subject" class="form-control">		
				 <br>		
				 <h5>내용</h5>
				 <textarea class="form-textArea" rows="5" id="content" name="content"></textarea>
				 
			  </div>
			  <br>
			  <div class="ftco-animate text-center">
			  	<button type="button" class="btn btn-primary" onclick="location.href='qnaPage?qnaNum=1&answer_flg=2&qnaType=0'">뒤로</button>
		        <button type="button" class="btn btn-primary" onclick="regist();">등록하기</button>
			  </div>
			  
			  <br><br>
			
        </form>      
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


function regist(){
	
	    if (!document.qnaForm.answer_type.value)
	    // login_form 이름을 가진 form 안의 id_val 의 value가 없으면
	    {
	        alert("문의타입을 선택하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    
	    if (!document.qnaForm.subject.value)
	    {
	        alert("문의제목을 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    
	    if (!document.qnaForm.subject.value)
	    {
	        alert("문의내용을 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	   	alert("문의가 등록되었습니다.");
	    document.qnaForm.submit();
	    // 모두 확인 후 submit()
	    
	  
	
}

</script>


</html>

