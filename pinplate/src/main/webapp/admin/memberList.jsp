<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.member.model.memberVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>
<%@ include file="checkAdmin.jsp" %>
<jsp:useBean id="memberService" class="com.member.model.memberService" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");

	List<memberVO> list = new ArrayList<>();
	
	try{
		list=memberService.selectAll();
	}catch(SQLException e){
		e.printStackTrace();
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

<main class="mainDiv">
	<div class="mainDivGr7 center">
		<div class="center">
			<p class="p c">회원 관리 페이지</p>
			<p class="subP">회원정보를 수정하려면 회원이름을 클릭하세요.</p>
				<table class="box2">
					<colgroup>
							<col style="width:5%;"/>
							<col style="width:10%;"/>
							<col style="width:10%;"/>
							<col style="width:15%;"/>	
							<col style="width:30%;"/>	
							<col style="width:15%;"/>		
							<col style="width:15%;"/>	
							<col style="width:20%;"/>		
					</colgroup>
					<thead>
						<tr style="font-size:12px;">
							<th>번호</th>
							<th>이름</th>
							<th>아이디</th>
							<th>주민번호</th>
							<th>주소</th>
							<th>휴대폰</th>
							<th>이메일</th>
							<th>가입일자</th>
						</tr>
					</thead>
					<tbody>
						<% if(list==null || list.isEmpty()){ %>
						<tr>
							<td>조회되는 회원이 없습니다.</td>
						</tr>
						<% }else{ 
							for(int i=0; i<list.size(); i++){
								memberVO vo = new memberVO();
								vo=list.get(i);
						%>
						<tr style="text-align:center;font-size: 12px">
							<td class="td1"><%=vo.getMem_no()%></td>
							<td class="td1">
							<a href="<%=request.getContextPath() %>/admin/memberDetail.jsp?no=<%=vo.getMem_no()%>">
								<%=vo.getMem_name() %>
							</a></td>
							<td class="td1"><%=vo.getMem_id() %></td>
							<td><%=vo.getMem_ssn() %></td>
							<td><%=vo.getMem_addr() %></td>
							<td><%=vo.getMem_tel() %></td>
							<%
								String mem_email=" ";
								if(vo.getMem_email()==null || vo.getMem_email().isEmpty()){
									mem_email=" ";
								}else{
									mem_email=vo.getMem_email();
								}
							%>
							<td><%=mem_email %></td>
							<td><%=sdf.format(vo.getMem_regdate()) %></td>
						</tr>
						<% }
						} %>
					</tbody>
				</table>				
			</div>
		</div>
	</main>
<%@ include file="/inc/Bottom.jsp"%>