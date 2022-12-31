<%@ page language="java" pageEncoding="UTF-8"%>

<%
	//로그인, 권한 확인후 사이드바처리하는 구문 시작
	String mem_auth = (String)session.getAttribute("mem_auth");	
	boolean islogin = false, isAdmin = false;
	
	if(mem_auth!=null && !mem_auth.isEmpty()){
		islogin = true;
		if(Integer.parseInt(mem_auth)==1){
			isAdmin = true;
		}
	}

	if(islogin){%> <!-- 로그인체크 true : 로그인상태 -->
	<% if(isAdmin){%> <!-- 권한체크 true : 관리자로그인상태 -->
		<%@ include file="AsideForAdmin.jsp"%>
	<% }else{%> <!-- 권한체크 false : 유저로그인상태 -->
	    <%@ include file="AsideForUser.jsp"%>
	<% } %>
	<% }else{%> <!-- 로그인체크 false : 비로그인상태 -->
			<%@ include file="Aside.jsp"%>
	<% }%>
	
	<footer class="footer">
		&copy PinPlate co., Ltd. All rights reserved.
	</footer>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>