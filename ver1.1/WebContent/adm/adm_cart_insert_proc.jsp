<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.member.*" %>
<%@ page import="ec.cart.*" %>
<%@ page import="ec.preorder.*" %>
<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="povo" class="ec.preorder.poVo" />
<jsp:setProperty property="*" name="povo" />

<%	
	int rst = 0;		//주문 데이터베이스 삽입 검증
	int rst1 = 0;		//주문 시 기존 상품 재고 수량 변경 검증
	int i=0;
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	//String loginId = (String)session.getAttribute("loginId");

	product_detailDao pddao = new product_detailDao();
	product_detailVo pdvo = pddao.getPdd_info(povo.getPd_id(), povo.getOpt_col(), povo.getOpt_size());
	
	cartDao cdao = new cartDao();
	ArrayList<cartVo> my_list = cdao.getCart_List(mvo.getMem_id());
	
	for(cartVo cvo : my_list){
		if(pdvo.getPdd_id() == my_list.get(i).getPdd_id()) {
			rst = cdao.updateCart_List(mvo.getMem_id(), pdvo.getPdd_id(), povo.getOpt_count());
			break;
		}
		i++;
	}
	
	if(i==my_list.size()) rst = cdao.insertCart(pdvo, mvo.getMem_id(), povo.getOpt_count());

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