<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
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
	    <div class="col-md-12 ftco-animate text-center">	    	
	    	<p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>회원 리스트 확인</span></p>
	     	<h1 class="mb-0 bread">회원 리스트 확인</h1>      
	    </div>
	</div>
</section>

<section class="ftco-section">
  <div class="container"> 
      <div class="form-group text-center">      	
	     	
	  </div>	 
  </div>
  <div class="ftco-animate manager-table table-striped">
  	      	
	  <form name = "mform" id = "mform" method="get">	                
	      <div>		        
	        <h3>회원 리스트</h3>
	        <br><br>		
	        <div class="row text-center search-form" id="memberList">
			   <div class="col-md-4">
			       <div class="mb-4">	
				   <select name="mem_flg" class="form-control" onchange="changeListByMember(this.value)">
				   		<option value="3">전체</option>	
				   		<c:forEach var="list" items="${memFlgList}">
				    		<option value="${list.idx}" <c:if test="${mem_flg eq list.idx}">selected</c:if>>${list.memFlg_name}</option>	
				   		</c:forEach>
				   </select>	
			     </div>
			   </div>
			   <div class="col-md-4">
			     <div class="mb-4">
			     	<div class="form-group">                
			             <a href="javascript:void(0);" onclick="changeListByPhone()" id="searchBtn"><span class="icon ion-ios-search"></span></a>
			             <input onkeyup="enterkey()" type="text" class="form-control" id="keyword" name="keyword" value="${keyword}" placeholder="휴대폰 번호">
			         </div>
			   	</div>
			   </div>
			 </div>
			                        
	        <table>	         
	             <tr style="background-color:#212529;color:white;">
	             	<th>회원번호</th>	             	
	             	<th>아이디</th>
	             	<th>이름</th>
	             	<th>주소</th>
	             	<th>이메일</th>
	             	<th>휴대폰 번호</th>
	             	<th>생년월일</th>
	             	<th>성별</th>
	             	<th>회원구분</th>
	             	<th>마케팅 이용 동의</th>
	             	<th>탈퇴 일자</th>
	             	            	           		     
	            </tr>
	            <c:if test="${memberList.size() == 0}"> 
	            <tr>
	             	<td colspan="12">등록된 회원이 없습니다.</td>	             	             	           		     
	            </tr>
	            </c:if>
 				 
 				<c:forEach items="${memberList}" var="list">		       	  
			       <tr>		       
			        	<th>${list.idx}</th>
			        	<th>${list.userId}</th>
			        	<th>${list.username}</th>
			        	<th>${list.address}</th>
			        	<th>${list.email}</th>
			        	<th>${list.phone}</th>
			        	<th>${list.birthday}</th>
			        	<th>${list.gender}</th>
						<th><c:if test="${list.mem_flg eq 0}">탈퇴회원</c:if>
						<c:if test="${list.mem_flg ne 0}">
						<select name="memFlg" id="memFlg" onchange="changeUseMemFlg('${list.idx}',this.value)" >
						<c:forEach items="${memFlgList}" var="memFlgList">
						<option value="${memFlgList.idx}" <c:if test="${list.mem_flg eq memFlgList.idx}">selected</c:if>>${memFlgList.memFlg_name}</option>
						<c:if test="${memFlgList.idx eq list.mem_flg}">${memFlgList.memFlg_name}</c:if>							
						</c:forEach>
						</select>
						</c:if>
						</th>
						<th><c:forEach items="${marketingFlgList}" var="marketingFlgList">
						<c:if test="${marketingFlgList.idx eq list.marketing_flg}">${marketingFlgList.marketingFlg_name}</c:if>							
						</c:forEach></th>
						<th>
						<c:if test="${list.delete_date eq null }">null</c:if>${list.delete_date}
						</th>  		           		     
			       </tr>			    
		       </c:forEach>   
		                
	        </table>
	        <c:if test="${page.endPageNum > 1}">
	        <div class="col text-center">
		      <div class="block-27">
		          <ul>
			      <c:if test="${page.prev}">
			      <li><a href="memberList?num=${page.startPageNum - 1}&mem_flg=${mem_flg}&phone=${phone}
			      &keyword=${keyword}#memberList">&lt;</a></li>
			      </c:if>
			      <c:forEach begin="${page.startPageNum}" end="${page.endPageNum}" var="num">
			      <c:if test="${select == num}">
			      <li class="active"><span>${num}</span></li>
			      </c:if>
			      <c:if test="${select != num}">
			      <li><a href="memberList?num=${num}&mem_flg=${mem_flg}&phone=${phone}
			      &keyword=${keyword}#memberList">${num}</a></li>			     
			      </c:if>    		
			      </c:forEach>
			      <c:if test="${page.next}">
			      <li><a href="memberList?num=${page.endPageNum + 1}&mem_flg=${mem_flg}&phone=${phone}
			      &keyword=${keyword}#memberList">&gt;</a></li>
			      </c:if>
			    </ul>
		      </div>
       	   </div> 
       	   </c:if>
			
	    </div>
 	</form>
 
  </div>
  
  
</section>

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
<script type="text/javascript">

var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}


$("#memFlg option[value='0']").remove();


function enterkey() {	
    if (window.event.keyCode == 13) {
         // 엔터키가 눌렸을 때 실행할 내용
         DoSearch();
    }
};
function DoSearch() {
	 
	  let keyword = $("#keyword").val();
	  let phone = $("#phone").val();
	  let mem_flg = $("#mem_flg").val();
	  
	  console.log(keyword);
	  console.log(phone);
	  console.log(mem_flg);
	  
	  location.href = "memberList?num=1&phone=" + phone + "&mem_flg" + mem_flg + "&keyword=" + keyword;

};


function changeListByMember(mem_flg){	
	
	var mem_flg = mem_flg;
	var keyword = $('#keyword').val();	
	
	location.href = "memberList?num=1&mem_flg=" + mem_flg +  
	  "&keyword=" +  keyword ;
	
}


function changeListByPhone(){
	
	var mem_flg = "${mem_flg}";
	var phone = "${phone}";
	var keyword = $('#keyword').val();
	
	
	location.href = "memberList?num=1&phone=" + phone +  "&mem_flg=" + mem_flg +
	  "&keyword=" + keyword +"#memberList";
	

};

function changeUseMemFlg(idx, mem_flg){
	if (confirm("회원 구분을 변경 하시겠습니까?")){
		
	$.ajax({
		type:'POST',	//method
		url:'doUpdateMemFlg',		//action
		data:{'idx':idx,
			'mem_flg':mem_flg
			},		//parameter
		dataType:'JSON',	//JSON, XML, TEXT, HTML, JSONP
		success:function(data){
			
			if (data.result>0) {
				alert('변경 완료 되었습니다.!');
				location.href="memberList?num=1&mem_flg=3";
			}else {
				alert("수정에 실패하였습니다!");
			}
		},	//성공 했을때 해야 할 일(성공 했을때 서버에서 보낸 데이터를 매개변수로 받는다.)
		error:function(e){
			alert("수정에 실패하였습니다.");
		}	//에러났을때 해야 할 일(에러가 났을때 서버에서 보낸 데이터를 매개변수로 받는다.)
	});
		
	}
	
}

/*
*/

</script>
</html>