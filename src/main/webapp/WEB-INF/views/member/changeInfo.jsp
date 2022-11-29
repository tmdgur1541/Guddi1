<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta charset="UTF-8">
<title>정보 수정</title>
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
	       <p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>정보수정</span></p>
	       <h1 class="mb-0 bread">정보수정</h1>
	    </div>    
	</div>
</section>

<section class="ftco-section ftco-degree-bg">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 ftco-animate">
		  <form action="doChangeInfo" name="changeInfoForm" id="changeInfoForm" method="post">	                
		      <div class="myPage-table table-striped ">		        
		        <b><font size="3" color="BLACK">정보변경하기</font></b>        
		        <br><br>		                       
		        <table>
		          <colgroup>
   				    <col width="20%" />
    				<col width="80%" />	    	
  				  </colgroup>
  				  	<tr>
		            	<td id="title">성함</td>
		             	<td><input type="text" class="form-control" id="inputName" name="username" value="${info.username}" placeholder="성함을 작성해 주세요."></td>			  			             
					   
		            </tr>   
		            <tr>
		             	<td id="title">아이디</td>
		           		<td><input type="text" class="form-control" id="inputUserId" name="userId" value="${info.userId}" readonly placeholder="아이디를 작성해 주세요."></td>           
		            </tr>
		            <tr>
		            	<td id="title">새 비밀번호</td>
		             	<td>
		             		<input type="password" class="form-control" id="inputPassword" name="password" placeholder="새 비밀번호를 작성해 주세요.">
		             		<font name="pwdlengthcheck" size="2" color="red"></font> 
		             	</td>			  			             					   	
		            </tr>  
		            <tr>
		            	<td id="title">새 비밀번호확인</td>
		             	<td>
		             		<input type="password" class="form-control" id="inputPasswordCheck" name="passwordcheck" placeholder="비밀번호를 확인해 주세요.">		             	
		             		<font name="check" size="2" color="red"></font> 
		             	</td>			  			             
					   
		            </tr>
		            <tr> 
						<td><input type = "button" id ="btnZipcode" class="btn btn-primary py-3 px-5" onclick="goPostcode()" value = "우편번호검색" /></td>
		           		<td><input type="text"  readonly class="form-control"
			     	   id ="inputZipcode" name="zipcode"  placeholder="우편번호를 입력해 주세요" value="${info.zipcode}"></td>				             
		            </tr>
		            <tr>
		            	<td id="title">주소</td>          
					 	<td><input type="text" class="form-control" readonly id="inputAddress"  name="address" placeholder="주소를 입력해 주세요" value="${info.address}"></td> 
		            </tr> 
		            <tr>
		            	<td id="title">상세주소</td>          
					 	<td><input type="text" class="form-control" id="inputAddress_detail" name = "address_detail"  placeholder="상세주소를 입력해 주세요" value="${info.address_detail}"></td> 
		            </tr> 
		             <tr>
		            	<td id="title">이메일주소</td>
		           		<td><input type="email" class="form-control" id="inputEmail" name="email" value="${info.email}" placeholder="이메일을 작성해 주세요."></td>			  			             
					
					</tr>
					<tr> 
						<td id="title">핸드폰번호</td>
		           		<td><input type="text" class="form-control" id="inputMobile" name="phone"  value="${info.phone}" placeholder="핸드폰번호를 작성해 주세요."></td>	  			             
					</tr>
					<tr>
					    <td id="title">생년월일</td>
					    <td>
					    <input type="text" class="form-control" id="inputBirthday" name="birthday"  value="${info.birthday}" placeholder="ex)20201101" readonly="readonly">					   
					    
					</tr>   
					<tr>
					    <td id="title">성별</td>
					    <td>
					    	<c:if test="${info.gender  eq '남'}">
						    <input type="radio" id="inputMan" name="gender" value="남성" checked onClick="return false;">  남성 &nbsp&nbsp
						    <input type="radio" id="inputMan" name="gender" value="여성" onClick="return false;">  여성
						    </c:if>
						    <c:if test="${info.gender  eq '여'}">	
						    <input type="radio" id="inputMan" name="gender" value="남성" onClick="return false;">  남성 &nbsp&nbsp
						    <input type="radio" id="inputMan" name="gender" value="여성" checked  onClick="return false;">  여성	
						    </c:if>
					    </td>				    		    
			  		</tr>                   
		            <tr>
		            	<td id="title">가입일</td>          
					 	<td><input type="text" class="form-control" value="${info.regdate}" readonly placeholder="가입일을 입력해주세요."></td> 
		            </tr> 
		            <tr>		           
		            <tr>
		            	<td id="title">개인정보이용동의</td>
		           		<td>
		           			<input type="checkbox" id ="checkbox" name="checkbox" value="1" class="mr-2" checked onClick="return false;"> 동의합니다.
          		  		</td>
					</tr>
					<tr>
		            	<td id="title">마케팅정보수신동의</td>
		           		<td>
		           			<c:if test="${info.marketing_flg  eq 1}">
		           			<input type="checkbox" id ="checkbox2" name="checkbox2" value="1" class="mr-2" checked> 동의합니다.
		           			</c:if>
		           			<c:if test="${info.marketing_flg  eq 0}">
		           			<input type="checkbox" id ="checkbox2" name="checkbox2" value="1" class="mr-2" > 동의합니다.
		           			</c:if>		           			
          		  		</td>
					</tr> 
					          
		        </table>
				
		        <button type="button" class="btn btn-primary" onclick="location.href='myPage?orderNum=1&reviewNum=1'">취소</button>
		        <button type="button" class="btn btn-primary" onclick="check_input()">수정하기</button>
		      	<button type="button" class="btn btn-primary" onclick="deleteUser('${info.userId}')">탈퇴하기</button>
		    	
		    </div>
   		</form>         
      </div> <!-- .col-md-8 -->
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

<!-- 다음이 서비스하는 우편번호를 이용하기 위한 자바스크립트 라이브러리 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> 
</body>
<script>
var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}



//비밀번호 길이체크 함수.
//비밀번호 길이,영어,특수문자체크 함수.
$(function(){	

	$('#inputPassword').keyup(function(){
		
		var pw = $('#inputPassword').val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		
 		$('font[name=pwdlengthcheck]').text('');		
 		
 		if(pw.length<8){
 			$('font[name=pwdlengthcheck]').text('');
 			$('font[name=pwdlengthcheck]').html("비밀번호가 너무 짧습니다. 8자이상으로 만들어주세요.");
 		}else if(pw.search(/\s/) != -1){
 			$('font[name=pwdlengthcheck]').html("비밀번호는 공백없이 입력해주세요.");
 		}else if(num < 0 || eng < 0 || spe < 0 ){
	 		$('font[name=pwdlengthcheck]').text('');
	   		$('font[name=pwdlengthcheck]').html("비밀번호는 영문,숫자,특수문자 조합으로 입력해주세요.");
	   } else {
	  	 	$('font[name=pwdlengthcheck]').text('');
	    	$('font[name=pwdlengthcheck]').html("이 비밀번호는 사용가능합니다.");
	   }   
	}); //#user_pass.keyup
});


//비밀번호 중복체크 함수.
$(function(){
	
	$('#inputPassword').keyup(function(){
	 	$('font[name=check]').text('');
	}); //#user_pass.keyup

	$('#inputPasswordCheck').keyup(function(){
	 	if($('#inputPassword').val()!=$('#inputPasswordCheck').val()){
	  		$('font[name=check]').text('');
	  		$('font[name=check]').html("비밀번호가 서로 일치하지않습니다.");
		}else{
	  		$('font[name=check]').text('');
	  		$('font[name=check]').html("비밀번호가 일치합니다.");
	 	}
	}); //#chpass.keyup
	
});


function goPasswordCheck(){	
	
	var frm = document.changeInfoForm;	
	var userId = "${info.userId}";
	var password = $("#inputPassword").val();	
	
	console.log("userId:" + userId);
	console.log("password:" + password);
			
	$.ajax({
		url: "doPwCheck", //호출할 파일명
		data:{'userId': userId,
			  'password': password
			},
		method: "POST",
		dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
		
		success: function(data){
			console.log(data);
			
			if (data.result==false) {
				if (confirm("정보를 수정하시겠습니까?")) {
					alert("정보변경에 성공하였습니다.");
					document.getElementById('changeInfoForm').submit();
				}else{
					return;
				}
				
			} else {
				alert("기존과 같은 비밀번호는 사용할 수 없습니다.");		
			}		
			
		},
		error:function(){
			console.log("데이터 로딩 실패");
		}
	});
}


//우편번호를 위한 함수	
function goPostcode() {

	console.log("우편번호검색");
	
  new daum.Postcode({
  	oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
          // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var roadAddr = data.roadAddress; // 도로명 주소 변수
          var extraRoadAddr = ''; // 참고 항목 변수

          // 법정동명이 있을 경우 추가한다. (법정리는 제외)
          // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
          if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
              extraRoadAddr += data.bname;
          }
          // 건물명이 있고, 공동주택일 경우 추가한다.
          if(data.buildingName !== '' && data.apartment === 'Y'){
             extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
          }
          // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
          if(extraRoadAddr !== ''){
              extraRoadAddr = ' (' + extraRoadAddr + ')';
          }
          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('inputZipcode').value = data.zonecode;
          document.getElementById('inputAddress').value = roadAddr;                

      }
  }).open();
       
}

 function check_input() {
	 
		//비밀번호 조건
		var pw = $('#inputPassword').val();
	    var num = pw.search(/[0-9]/g);
	    var eng = pw.search(/[a-z]/ig);
	    var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
	 
	 	var password =  document.changeInfoForm.password.value;
	 	var passwordcheck = document.changeInfoForm.passwordcheck.value;
	 
	 	
	    if (!document.changeInfoForm.userId.value)
	    // login_form 이름을 가진 form 안의 id_val 의 value가 없으면
	    {
	        alert("아이디를 입력하세요!");
	        document.changeInfoForm.userId.focus();
	        // 화면 커서 이동
	        return;
	    }			   
	    if (!document.changeInfoForm.password.value)
	    {
	        alert("비밀번호를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.passwordcheck.value)
	    {
	        alert("비밀번호를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (password != passwordcheck)
	    {
	        alert("비밀번호가 일치하지않습니다.확인해주세요.");
	        // 화면 커서 이동
	        return;
	    }
	    if(password == num < 0 || eng < 0 || spe < 0 || password.length<8)
	    {
			alert("비밀번호는 숫자,영문,특수문자 포함 8자 이상으로 입력해주세요.");
			//document.MemberWriteForm.passwordcheck.focus();
			return;
		}
	    if (!document.changeInfoForm.username.value)
	    {
	        alert("성명을 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.email.value)
	    {
	        alert("이메일을 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.password.value)
	    {
	        alert("비밀번호를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.passwordcheck.value)
	    {
	        alert("비밀번호를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	  
	    if (!document.changeInfoForm.phone.value)
	    {
	        alert("휴대폰번호를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.address.value)
	    {
	        alert("주소를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }
	    if (!document.changeInfoForm.address_detail.value)
	    {
	        alert("상세주소를 입력하세요!");
	        // 화면 커서 이동
	        return;
	    }		   
	    
	    
	    goPasswordCheck();
	    // 모두 확인 후 goPasswordCheck()함수 실행
	 }
 
 function deleteUser(userId){
	 
	 if (confirm("탈퇴하시겠습니까?")) {
		
		 $.ajax({
				url: "deleteUser", //호출할 파일명
				data:{'userId': userId					  
					},
				type: "POST",
				dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
				
				success: function(data){
					console.log(data);			
					alert("회원탈퇴에 성공하였습니다.");
					location.href='logout';
					
				},
				error:function(){
					alert("회원탈퇴에 실패하였습니다.");
				}
			});
		 
		 
	}
	 
	 
	 
 }

</script>
</html>