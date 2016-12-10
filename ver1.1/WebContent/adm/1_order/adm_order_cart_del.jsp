<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "ec.member.*" %>
<%@ page import = "ec.order_cart.*" %>
<%
	request.setCharacterEncoding("EUC-kr");
	int pdd_id = Integer.parseInt((String)request.getParameter("pdd"));
	String loginId = (String)session.getAttribute("loginId");
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(loginId);
	
	ocDao ocdao = new ocDao();
	
	int rst = 0;
	
	rst = ocdao.deleteCart(mvo.getMem_id(), pdd_id);

	if (rst > 0) {

	System.out.println(rst);
%>	

	<script type="text/javascript">
	alert("장바구니 삭제 성공");
	location.href="adm_order_cart_list.jsp";

	</script>
<%
	} else {
%>
	<script type="text/javascript">
	alert("장바구니 삭제 실패");
	location.href(-1);
	</script>
<%
   }
%>