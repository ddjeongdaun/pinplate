<%@page import="com.review.model.ReviewVO"%>
<%@page import="com.review.model.ReviewService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewWrite_ok.jsp</title>
</head>
<body>
<%
	//1. 요청 파라미터값 가져오기
	request.setCharacterEncoding("utf-8");

	int mem_no = (Integer)session.getAttribute("mem_no");
	String rev_content = request.getParameter("WriteRev");
	String res_no = request.getParameter("resNo");
	
	//2
	ReviewService reviewService = new ReviewService();
	ReviewVO reviewVo = new ReviewVO();
	
	reviewVo.setMem_no(mem_no);
	reviewVo.setRes_no(Integer.parseInt(res_no));
	reviewVo.setRev_content(rev_content);
	
	int cnt = reviewService.insertRev(reviewVo);
	
	//3
	if(cnt>0){ %>
	<script type="text/javascript">
		alert('리뷰가 등록되었습니다');
		location.href="<%=request.getContextPath()%>/detail/detail.jsp?no=<%=res_no%>";
	</script>
	<%}else{%>
		<script type="text/javascript">
			alert('리뷰 등록 실패!');
			history.back();
		</script>
	<%}	
	
%>
</body>
</html>