<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
</head>
<body>
<h1>회원- 메인 페이지</h1>
<input type="button" value="로그아웃" onclick="location.href='<%=request.getContextPath() %>/login/logout.jsp'">
<input type="button" value="회원정보" onclick="location.href='<%=request.getContextPath() %>/member/memberInfo.jsp'">
<input type="button" value="회원정보 수정하기" onclick="location.href='<%=request.getContextPath() %>/member/memberEdit.jsp'">

</body>
</html>