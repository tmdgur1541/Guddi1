<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
<meta charset="UTF-8">
<title>메인이미지제어</title>
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
<!-- ckeditor -->
<script src="resources/ckeditor/ckeditor.js"></script>	

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
      <p class="breadcrumbs"><span class="mr-2"><a href="./">홈</a></span>/<span>메인이미지제어</span></p>
      <h1 class="mb-0 bread">메인이미지제어</h1>    
     </div>
  </div>
</section>


<section class="ftco-section ftco-degree-bg">
  <div class="container">
    <div class="row">
      <div class="col-lg-12 ftco-animate">		                 
		     <div class="">		        
		        <button type="button" class="btn btn-primary" onclick="addImage()" id="addButton">이미지 추가하기</button>		        
		       
		        <button type="button" class="btn btn-primary" onclick="orderChange()" id="orderButton">순서변경하기</button>		        
		        <br>
		        <font id="warn" size="2" color="red"></font>
		        <br>                       
		        <form method="post" action="doUpdateImage" name="updateForm" id="updateForm" enctype="multipart/form-data">					
					<div class="col-md-12 ftco-animate">
			     		<div class="cart-list">
			  				<table class="table">
			  			    <thead class="thead-primary">
			  			      <tr class="text-center">
			  			        <th>이미지명</th>
			  			        <th>이미지</th>
			  			        <th>순서</th>
			  			        <th>등록일</th>
			  			        <th>등록자</th>
			  			        <th>사용여부</th>
			  			        <th>삭제</th>
			  			      </tr>			  			     
			  			    </thead>
			  			    <tbody>
			  			      <c:if test="${fn:length(imageDto)==0}">
			  			      <tr class="text-center">
			  			        <td colspan="7">등록된 이미지가 없습니다.</td>  			        
			  			      </tr>
			  			      </c:if>
			  			      <c:forEach items="${imageDto}" var="imageList" varStatus="status">
			  			      	  <input type="hidden" name="newFileName" value="${imageList.newFileName}">			  			      	  
				  			      <tr class="text-center">			  			      
				  			        <td class="product-name"><h3 id="imageName">${imageList.oriFileName}</h3></td>  
				  			        <td class="image-prod"><div class="img" id="image" style="background-image:url(resources/photo/${imageList.newFileName});"></div></td>	
				  			        <td><input type="text" id="idx" name="idx" value="${imageList.idx}"></td>	
				  			        <td>${imageList.regdate}</td>				
				  			        <td>
										<c:forEach items="${userLists}" var="userLists">
						        				<c:if test="${imageList.u_idx eq userLists.idx}">${userLists.userId}</c:if>
						        		</c:forEach>
									</td>
				  			        <td>
									<select name="useFlg" id="useFlg" class="form-control" onchange="changeUseNewflg('${imageList.idx}',this.value)">
					        			<c:forEach items="${useFlgList}" var="useFlgList">
					        				<option value="${useFlgList.idx}" <c:if test="${imageList.use_flg eq useFlgList.idx}">selected</c:if>>${useFlgList.useFlg_name}</option>
					        			</c:forEach>
			        				</select>
									</td>					  			        		          			        		        
				  			        <td class="product-remove"><a href="javascript:void(0);" onclick="delImage('${imageList.idx}','${imageList.newFileName}')"><span class="ion-ios-close"></span></a></td>			  			       
				  			      </tr>
			  				  </c:forEach>	
			  			    </tbody>
			  			  </table>
			  		  </div>
			     	</div>
				</form>	        		      	
		    </div>   		       
      </div> <!-- .col-md-8 -->
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


</body>



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


<script>

var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}


//이미지 삭제관련
function delImage(idx, newFileName) {

	 if (confirm("해당 이미지를 삭제하시겠습니까?")) {	
		 alert("해당 이미지를 삭제하였습니다.");		 
		 location.href = "delMainImage?idx="+idx+"&newFileName="+newFileName;
	}
};
 
//이미지 추가창 출력
function addImage() {	 
	var win = window.open("addMainimage", "PopupWin", "width=500,height=200");
};
 
//순서 변경 버튼 클릭시 실행되는 함수
function orderChange(){
	
	if (confirm("순서를 변경하시겠습니까?")) {
		
		var totalNum = $("input[name=idx]").length;		
		var newOrder = new Array(totalNum);
		var dupYn;
		for(var i=0; i<totalNum; i++){                          
			newOrder[i] = $("input[name=idx]").eq(i).val();			
		}
		//중복된 순서가 있는지 파악, 중복값이 있으면 경고창 반환 후 함수 종료
		for(let i = 0; i < newOrder.length; i++) {
		  const currElem = newOrder[i];
		  
		  for(let j = i+1; j < newOrder.length; j++) {
		    if(currElem === newOrder[j]) {
		      dupYn = true;
		      break;
		    }
		  }
		  
		  if(dupYn)  {
			alert("순서가 중복됩니다! 확인해주세요.");
			dupYn = false;
		    return;
		  }
		}
		var newFileName = new Array(totalNum);
		for(var i=0; i<totalNum; i++){                          
			newFileName[i] = $("input[name=newFileName]").eq(i).val();
		}
		$.ajax({
			url: "updateMainImageOrder", //호출할 파일명
			traditional : true,
			data:{'newOrder': newOrder,
				  'newFileName': newFileName
				},
			method: "POST",
			dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
			
			success: function(data){
				alert(data.result); 			
				location.href="toMainImage";
			},
			error:function(error){
				alert("순서 변경 실패! 관리자에게 문의해주세요."); 
			}
		});
		
	}
	
};

function changeUseNewflg(idx, use_flg){	
	
	if (confirm("해당 Flg를 변경하시겠습니까?")) {
		
		$.ajax({
			url: "doUpdateImageUseFlg", //호출할 파일명			
			method: "POST",
			data:{'idx':idx,
				  'use_flg':use_flg
				},
			dataType: "json", //내가 받아야할 결과 형태가 text, html, xml, json
			
			success: function(data){	
							
				if (data.result>0) {
					alert('해당 사항을 변경하였습니다!');
					location.href="toMainImage";
				}else {
					alert("수정에 실패하였습니다.");
				}		
	
									
			},
			error:function(){
				alert("수정에 실패하였습니다.");
			}
		});
		
		
	}	
	
};
 

</script>
</html>