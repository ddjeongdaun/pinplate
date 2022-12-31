<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/Top.jsp"%>
<script type="text/javascript">
$(function(){
	$('#btnAddr').click(function(){
		
	 	open('../map/openMap.jsp','map',
	 		'width=550,height=600,left=1000,top=50,location=yes,resizable=yes');	
	});
	
	$('#btnSub').click(function(){
		
		if($('#resName').val()==""){
			alert("음식점이름을입력하세요");
			$('#resName').focus();
			return false;
		}
		if($('#resTel').val()==""){
			alert("음식점 전화번호를 입력하세요");
			$('#resTel').focus();
			return false;
		}
		if($('#hiddenAddr').val()==""){
			alert("음식점 주소를 검색을 하셔야합니다.");
			open('../map/openMap.jsp','map',
	 		'width=550,height=600,left=1000,top=50,location=yes,resizable=yes');	
			
			return false;
		}
		if($('#resType').val()==""){
			alert("음식점 종류를 입력하세요");
			$('#resType').focus();
			return false;
		}
		if($('#resImg').val()==""){
			alert("음식점사진은 필수입니다.");
			$('#resImg').focus();
			return false;
		}
		$('#resfrm').submit();
	});
});
</script>



<main class="mainDiv">
	<div class="mainDivGr5 center">
		<%
		String name=(String)session.getAttribute("mem_name");
		String auth=(String)session.getAttribute("mem_auth");
		int no=(int)session.getAttribute("mem_no");
		if(auth==null){%>
			<script type="text/javascript">
				alert('회원 가입후 사용해주세요');
			location.href='<%=request.getContextPath()%>/index.jsp';
			</script>
		<%}else if(auth.equals("1")){%>
			<!-- <script type="text/javascript">
				alert('관리자님 어서오세요');
			</script> -->
			<p class="p c">음식점 등록 페이지</p>
		<%}else{%>
			<%-- <script type="text/javascript">
				alert('<%=name%>어서오세요');
			</script> --%>
			<p class="p c">음식점 등록 신청 페이지</p>
		<%}%>
		<form name="frm" id="resfrm" method="post" action="resRegister_ok.jsp" enctype="multipart/form-data" >
			
			<input type="text" id="resName" name="resName" placeholder="음식점명을 입력하세요"
					class="form-control inputbox2">
			<input type="text" id="resTel" name="resTel" placeholder="음식점 전화번호를 입력하세요"
					class="form-control inputbox2">
			
			<input type="text" id="resType" name="resType" placeholder="음식점 업종을 입력하세요"
					class="form-control inputbox2">
    
			<input type="text" id="resAddr" name="resAddr" disabled="disabled" placeholder="음식점 주소를 검색하세요"
					class="form-control inputbox2" style="margin-top:30px;">
			
	        <input type="button" id="btnAddr" value="주소 검색" 
	        	class="btn btn-sm btn-block loginBt mt-1"><br>
	        
	        <br>
	        <hr>
	        <p class="p c">음식점 이미지를 첨부하세요</p> 
	        <input type="file" name="resImg" id="resImg" size="30" accept="image/*"><br><br>
	            
      		<input type="hidden" id="resContent" name="resContent" value=".1"/>
            <input type="hidden" id="resX" name="resX" />
            <input type="hidden" id="resY" name="resY" />
            <input type="hidden" id="hiddenAddr" name="hiddenAddr">
	            
			<input type="submit" id="btnSub" value="등록"
				class="btn btn-sm btn-block loginBt mt-1">
			<input type="button" value="메인페이지로 이동"
				onClick="location.href='<%=request.getContextPath()%>/index.jsp'"
				class="btn btn-sm btn-block regist mt-2">	
		</form>
	</div>
</main>

<%@ include file="/inc/Bottom.jsp"%>

