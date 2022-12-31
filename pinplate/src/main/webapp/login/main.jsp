<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>비회원 메인페이지</h1>
<input type="button" value="로그인" onclick="location.href='<%=request.getContextPath() %>/login/login.jsp'">
<input type="button" value="회원가입" onclick="location.href='<%=request.getContextPath() %>/join/join.jsp'">
<input type="button" value="아이디 찾기" onclick="location.href='<%=request.getContextPath() %>/login/findId.jsp'">
<input type="button" value="비밀번호 찾기" onclick="location.href='<%=request.getContextPath() %>/login/findPw.jsp'">

</body>
</html>