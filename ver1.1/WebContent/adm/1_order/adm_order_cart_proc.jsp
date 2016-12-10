<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.member.*" %>
<%@ page import = "ec.product_detail.*" %>
<%@ page import = "ec.order_cart.*" %>

<% request.setCharacterEncoding("euc-kr"); %>


<%	String loginId = (String)session.getAttribute("loginId");
	
	int pd_id = Integer.parseInt((String)request.getParameter("pd_id"));	
	String co_id = (String)request.getParameter("co_id");
	String[] color = request.getParameterValues("opt_color");
	String[] size = request.getParameterValues("opt_size");
	String[] count = request.getParameterValues("opt_count");

	dateDao ddao = new dateDao();
	String now = ddao.now();
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(loginId);
	
	product_detailDao pddao = new product_detailDao();
	ocDao ocdao = new ocDao();
	
	int rst = 1;
	int cnt = 0;
	
	for(int i=0; i<color.length;i++){
		product_detailVo pdvo = pddao.getPdd_info(pd_id, color[i], size[i]);
		cnt = ocdao.existCartCount(mvo.getMem_id(), pdvo.getPdd_id());
		if(cnt == 0){
			rst *= ocdao.insertCart(mvo.getMem_id(), co_id, pdvo.getPdd_id(), Integer.parseInt(count[i]), now);
		}else{

			rst *= ocdao.updateCart(mvo.getMem_id(), pdvo.getPdd_id(), Integer.parseInt(count[i]), now); 
		}
	}
	
	if (rst > 0) {
%>
	<script type="text/javascript">
		alert("장바구니 추가 성공");
		location.href('adm_order_cart_list.jsp');
	</script>
<%
	} else {
%>
	<script type="text/javascript">
		alert("장바구니 추가 실패");
		location.href(-1);
	</script>
<%
	}
%>
