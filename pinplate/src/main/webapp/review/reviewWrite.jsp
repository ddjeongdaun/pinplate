<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.6.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('#frm_rev').submit(function(){
			if($('#WriteRev').val()<1){
				alert('리뷰를 작성하세요.');
				$('#WriteRev').focus();
				event.preventDefault();
			}
		});
	});
</script>

<form id="frm_rev" name="frm_rev" action="<%=request.getContextPath() %>/review/reviewWrite_ok.jsp">
<input type="hidden" id="resNo" name="resNo" value="<%=res_no%>">
<textarea class="WriteRev p-3" id="WriteRev" name="WriteRev" placeholder="내용을 입력하세요"></textarea>
	<div class="btn_group">
		<input type="submit" id="revWriteBt" name="revWriteBt"
			class="btn btn-sm btn-block revWriteBt" value="완료">
	</div>
</form>
