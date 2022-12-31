<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String ck_id ="";
	Cookie[] ckArr = request.getCookies();
	if(ckArr!=null){
		for(int i=0; i<ckArr.length; i++){
			if(ckArr[i].getName().equals("mem_id")){
				ck_id=ckArr[i].getValue();
				break;
			}
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>login페이지</title>
<script type="text/javascript" src="../js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#mem_id').focus();
		
		$('#login').click(function(){
			if($('#mem_id').val().length<1){
				alert('아이디를 입력해야합니다.');
				$('#mem_id').focus();
				event.preventDefault();
				event.preventDefault();
			}else if($('#mem_pwd').val().length<1){
				alert('비밀번호를 입력해야합니다.');
				$('#mem_pwd').focus();
				event.preventDefault();
			}
			
		});//login.click
	});
</script>

</head>
<body>
	<form name="frm" method="post" action="<%=request.getContextPath() %>/login/login_ok.jsp">
		<label>아이디</label> <input type="text" id="mem_id" name="mem_id"
		value="<%=ck_id %>"
		><br>
		<label>패스워드</label> <input type="password" id="mem_pwd" name="mem_pwd"><br>
		<input type="checkbox" name="chkSave" id="chkSave"
			<% if(ck_id!=null && !ck_id.isEmpty()){ %>
			checked="checked"
		<% } %> > 
		<label for="chkSave">아이디 저장하기</label><br> 
		<input type="submit" value="로그인" id="login"><br>
		<input type="button" value="회원가입" onclick="location.href='<%=request.getContextPath() %>/join/join.jsp'"><br>
	</form>
</body>
</html>