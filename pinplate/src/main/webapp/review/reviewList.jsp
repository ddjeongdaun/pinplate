<%@page import="com.member.model.memberService"%>
<%@page import="org.apache.catalina.tribes.MembershipService"%>
<%@page import="com.review.model.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.review.model.ReviewService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="memberService" class="com.member.model.memberService"/>
<jsp:useBean id="memberVo" class="com.member.model.memberVO"/>
<link href="<%=request.getContextPath()%>/css/main2.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">

	$(function(){
		$('#revList > div').hover(function(){
			$(this).find('img').eq(0).addClass('hover');
			$(this).find('img').eq(1).removeClass('hover');
		},function(){
			$(this).find('img').eq(0).removeClass('hover');
			$(this).find('img').eq(1).addClass('hover');
		});
	});
</script>

<%
	//1 요청 파라미터 읽어오기
	String Check_id = (String)session.getAttribute("mem_id");	
	String res_no = request.getParameter("no");
	ReviewService reviewService = new ReviewService();	
	List<ReviewVO> list=null;
	ReviewVO reviewVo=new ReviewVO();
	

	try{
		list=reviewService.selectReview(Integer.parseInt(res_no));
	}catch(SQLException e){
		e.printStackTrace();
	}

%>

<!-- 리뷰 블럭 시작  -->
	<div class="resCmt item2">
		<!-- 리뷰리스트 불러오기 for 시작 -->
		<%if(list!=null && !list.isEmpty()){
			for(int i=0;i<list.size();i++){
				reviewVo=list.get(i);
				memberVo = memberService.selectByNo(reviewVo.getMem_no());%>
				
			<div class="detail_Cmt m-2" id="revList">
			<%if(Check_id!=null && !Check_id.isEmpty()){%>			
				<!-- 삭제버튼 : 작성자 체크 후 작동 -->
				<div class="closeIconGr" id="closeIconGr">
				<a href="<%=request.getContextPath()%>/review/reviewDelete.jsp?rev_no=<%=reviewVo.getRev_no()%>&res_no=<%=res_no%>">
					<img src="<%=request.getContextPath()%>/svg/x-circle.svg"
						class="closeIcon" id="closeIconOff">	
					<img src="<%=request.getContextPath()%>/svg/x-circle-fill.svg"
						class="closeIcon hover" id="closeIconOn">
				</a>
				</div>	
				<!-- 삭제버튼 : 작성자 체크 후 작동 -->
			<%}%>
				<span class="detail_Cmt_name c">
					<%=memberVo.getMem_id()%>
				</span>
				<span class="detail_Cmt_cnt a">
					<%=reviewVo.getRev_content() %>
				</span>
			</div>
			<%}//for%>
		<%}//if %>
		<!-- 리뷰리스트 불러오기 for 종료 -->
	<%
	//1. 로그인정보를 받아옴
	if(Check_id!=null && !Check_id.isEmpty()){%>		
			<!-- 리뷰 작성 태그 / 로그인했을때만 보여야함-->
			<div class="m-3"><hr class="mt-6"></div>
			
	<%@ include file="/review/reviewWrite.jsp"%>
	
	<%}%>
	</div>
	<!-- 리뷰 블럭 끝 -->
