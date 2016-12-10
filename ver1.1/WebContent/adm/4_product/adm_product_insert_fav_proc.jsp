<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.product_favorite.*" %>
    
<%  request.setCharacterEncoding("EUC-kr");
	String user_id = request.getParameter("uid");
	int pd_id = Integer.parseInt(request.getParameter("pid"));
	String now = request.getParameter("now");
	
	int rst = 0;
	pfDao pfdao = new pfDao();
	rst = pfdao.insertProductFavorite(user_id,pd_id,now);
	
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("즐겨찾기 추가 성공");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("즐겨찾기 추가 실패");
	history.go(-1);
</script>
<%
   }
%>	