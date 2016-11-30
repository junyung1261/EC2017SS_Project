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
	int rst = 0;		//주문 데이터베이스 삽입 검증
	int rst1 = 0;		//주문 시 기존 상품 재고 수량 변경 검증
	int i=0;
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	int pd_id = Integer.parseInt(request.getParameter("pd_id"));
	String col_id = request.getParameter("opt_col");
	String sz_id = request.getParameter("opt_size");
	int opt_count = Integer.parseInt(request.getParameter("opt_count"));	
	
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(pd_id);
	
	product_detailDao pddao = new product_detailDao();
	product_detailVo pdvo = pddao.getPdd_info(pd_id, col_id, sz_id);
	
	cartDao cdao = new cartDao();
	ArrayList<cartVo> my_list = cdao.getCart_List(mvo.getMem_id());
	
	for(cartVo cvo : my_list){
		
		if(pdvo.getPdd_id() == my_list.get(i++).getPdd_id()) {
			rst = cdao.updateCart_List(mvo.getMem_id(), pdvo.getPdd_id(), opt_count);
			break;
			
		}
		
	}
	System.out.println(i +"" +  my_list.size());
	if(i==my_list.size()) rst = cdao.insertCart(pdvo, mvo.getMem_id(), opt_count);
	
	
	
	
	
	if (rst > 0) {
		
	
%>
<script type="text/javascript">
	alert("장바구니 추가 성공");
	location.href="adm_cart.jsp";
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("장바구니 추가 실패");
	location.href="adm_cart.jsp";
</script>
<%
   }
%>