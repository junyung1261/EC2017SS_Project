<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.cart.*" %>
<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="odao" class="ec.order.orderDao" />
<jsp:useBean id="ovo" class="ec.order.orderVo" />
<jsp:setProperty property="*" name="ovo" />


<%	
	int rst = 1;		//주문 데이터베이스 삽입 검증
	int rst1 = 0;		//주문 시 기존 상품 재고 수량 변경 검증
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	
	String[] set = request.getParameterValues("table_records[]");
	System.out.println(set[0]);
	
	
	cartDao cdao = new cartDao();
	
	for(int i=0; i<set.length; i++){
		String[] parse = set[i].split(",");
		
		rst *= cdao.deleteCart_List(Integer.parseInt(parse[0]), Integer.parseInt(parse[1]));
		
		
	}

	
	
	
	
	if (rst > 0) {
		
	
%>
<script type="text/javascript">
	alert("장바구니 삭제 성공");
	location.href="adm_cart.jsp";

</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("장바구니 삭제 실패");
	location.href="adm_cart.jsp";
</script>
<%
   }
%>