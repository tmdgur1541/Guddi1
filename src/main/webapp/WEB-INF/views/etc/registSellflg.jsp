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
		<div style="text-align:center;">	
			<p>Flg 추가</p>		
			<input type="text" id="sellname" name="sellname" placeholder="Flg명을 입력해주세요."><br><br>
			<input class="btn btn-primary" type="button" value="추가하기" onclick="doRegist()">
			<input class="btn btn-primary" type="button" value="취소하기" onclick="cancel()">
		</div>

</body>


<script type="text/javascript">

var userId = "${sessionScope.userId}";

if (userId=="") {
	location.href="logout";
}


function doRegist() {
	
	if (confirm("flg를 등록하시겠습니까?")) {			
		
		var sellname = $("#sellname").val();
		
	    if ($("#sellname").val().length==0){
	        alert("flg명을 입력해주세요");
	        // 화면 커서 이동
	        return;
	    }	    	   
	   
        $.ajax({
            url : "doRegistSellFlg",
            type : "POST",           
            data : {"sellname":sellname},
            
           success:function(success) {        	   
        	  if (success.result>0) {
        		alert("해당 Flg를 추가하였습니다.");                   
                opener.parent.location.reload();
                window.open("about:blank","_self").close();
			} else {
				alert("업로드 실패! 관리자에게 문의요망!");
			}
        
			          
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