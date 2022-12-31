<%@ page language="java" pageEncoding="UTF-8"%>

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

    <aside class="sidebar">
		<!-- 로그인그룹 폼 -->
		<form name="frm" method="post" action="<%=request.getContextPath() %>/login/login_ok.jsp"> 
			<div class="loginGroup">
				<input type="text" id="mem_id" name="mem_id" class="form-control inputbox"
					value="<%=ck_id %>" placeholder="아이디를 입력하세요.">
				<input type="password" id="mem_pwd" name="mem_pwd" class="form-control inputbox mt-1"
					placeholder="비밀번호를 입력하세요.">
				<input type="submit" id="login" name="login"
					class="btn btn-sm btn-block loginBt mt-1" value="로그인">
				<input type="button" id="loginBt" name="loginBt"
					class="btn btn-sm btn-block regist mt-2" value="회원가입"
						onclick="location.href='<%=request.getContextPath() %>/join/join.jsp'">
				<div class="findGroup mt-2">
					<a href="<%=request.getContextPath() %>/login/findId.jsp">
						<span>아이디 찾기</span>
					</a> | 
					<a href="<%=request.getContextPath() %>/login/findPw.jsp">
						<span>비밀번호 찾기</span>
					</a> |
					<label for="chkSave">아이디 저장</label><input type="checkbox" name="chkSave" id="chkSave"
						<% if(ck_id!=null && !ck_id.isEmpty()){ %>
							checked="checked"
						<% } %> > 
				</div>
			</div>
		</form>
	</aside>