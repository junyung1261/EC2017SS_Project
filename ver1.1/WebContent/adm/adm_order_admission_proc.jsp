<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.rel.*" %>

<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="odao" class="ec.order.orderDao" />
<jsp:useBean id="ovo" class="ec.order.orderVo" />
<jsp:setProperty property="*" name="ovo" />


<%	
	int rst = 1;		//주문 데이터베이스 삽입 검증
	int rst1 = 0;		//주문 시 기존 상품 재고 수량 변경 검증
	
	ovo.setMem_id(1);
	ArrayList<orderVo> order_list = new ArrayList<orderVo>();
	
	String[] pd_id_list = request.getParameterValues("pd_id");
	String[] pdd_id_list = request.getParameterValues("pdd_id");
	String[] co_id_list = request.getParameterValues("co_id");
	String[] ord_count_list = request.getParameterValues("ord_count");
	String[] ord_total_price = request.getParameterValues("ord_total_price");
	String[] ord_use_mileage = request.getParameterValues("ord_use_mileage");
	int index = Integer.parseInt(request.getParameter("index"));
	
	
	long or_id = odao.order_insert(ovo);
	
	for(int i=0; i<index; i++){
		
		
		ovo.setPd_id(Integer.parseInt(pd_id_list[i]));
		ovo.setCo_id(co_id_list[i]);
		ovo.setPdd_id(Integer.parseInt(pdd_id_list[i]));
		ovo.setOrd_count(Integer.parseInt(ord_count_list[i]));
		ovo.setOrd_price(Integer.parseInt(ord_total_price[i]));
		ovo.setOrd_use_mileage(Integer.parseInt(ord_use_mileage[i]));
		
		rst *= odao.order_detail_insert(ovo, or_id);
	}
	
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();

	deliveryDao dedao = new deliveryDao();
	relDao rdao = new relDao();
	
	
	
	
	
	if (rst > 0) {
		
%>
<script type="text/javascript">
	alert("주문 추가 성공");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("주문 추가 실패");
	history.go(-1);
</script>
<%
   }
%>