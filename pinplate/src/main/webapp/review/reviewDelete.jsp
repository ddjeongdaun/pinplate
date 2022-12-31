<%@page import="com.review.model.ReviewService"%>
<%@page import="com.review.model.ReviewVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reviewDelete.jsp</title>
</head>
<body>
<%
	//1 요청 파라미터값 읽어오기
	String rev_no = request.getParameter("rev_no");
	String res_no = request.getParameter("res_no");
	int mem_no = (Integer)session.getAttribute("mem_no");
	String mem_auth = (String)session.getAttribute("mem_auth");
	ReviewVO reviewVo = new ReviewVO();
	
	reviewVo.setMem_no(mem_no);
	reviewVo.setRev_no(Integer.parseInt(rev_no));
	
	//2
	ReviewService reviewService = new ReviewService();
	int cnt = reviewService.deleteRev(reviewVo, mem_auth);
	
	//3
	if(cnt>0){ %>
	<script type="text/javascript">
		alert('리뷰가 삭제되었습니다.');
		location.href="<%=request.getContextPath()%>/detail/detail.jsp?no=<%=res_no%>";
	</script>
	<%}else{%>
		<script type="text/javascript">
			alert('내가 작성한 리뷰만 삭제할 수 있습니다.');
			history.back();
		</script>
	<%}	
%>
</body>
</html>