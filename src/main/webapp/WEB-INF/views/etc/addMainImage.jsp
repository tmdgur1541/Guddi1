<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="resources/css/style.css">
<script src="https://code.jquery.com/jquery-3.5.0.min.js"></script>
<link rel="icon" type="image/png" href="resources/photo/로고2.png">
</head>
<body>
	<br><br>
	<form action="doAddImage" name="addForm" id="addForm" method="post" enctype="multipart/form-data"> 
		<div style="text-align:center;">
			<input type="hidden" id="idx" name="idx">
			<input type="file" id="file" name="file" value="이미지 추가"><br><br>
			<input class="btn btn-primary" type="button" value="반영하기" onclick="doAddImage()">
			<input class="btn btn-primary" type="button" value="취소하기" onclick="cancel()">
		</div>
	</form>
</body>


<script type="text/javascript">
var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}



function doAddImage() {
	
	if (confirm("이미지를 등록하시겠습니까?")) {		
	
		var file = $("input[type='file']");
		
	    if (parseInt(file.get(0).files.length)!=1){
	        alert("이미지를 등록해주세요!");
	        // 화면 커서 이동
	        return;
	    }	    
	   
	    var form = new FormData();
        form.append( "file", $("#file")[0].files[0] );
              
        $.ajax({
            url : "doAddMainImage",
            type : "POST",
            processData : false,
            contentType : false,
            data : form,
            
           success:function(success) {        	   
        	  
        	alert("성공하였습니다.");                   
            opener.parent.location.reload();
            window.open("about:blank","_self").close();
			          
           },
           error: function (fail) 
           { 
               alert("업로드 실패! 관리자에게 문의해주세요~"); 
           }
       });
	}
}

function cancel() {
	window.close();
}

	
</script>



</html>