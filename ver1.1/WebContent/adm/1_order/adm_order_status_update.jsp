<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.order.*, ec.order_detail.*" %>    

<%	request.setCharacterEncoding("euc-kr"); 
	dateDao ddao = new dateDao();
	
	long or_id = Long.parseLong((String)request.getParameter("oid"));
	int or_status = Integer.parseInt((String)request.getParameter("os"));
	

	int[] rst = new int[2];
	String location = null;
	
	orderDao odao = new orderDao();
	oddDao oddao = new oddDao();
	
	switch(or_status){
	case 1:
		rst[0] = odao.updateOrderStatus(or_id, or_status);
		rst[1] = oddao.updateOrderDetailStatus(or_id, 0, or_status,0,"","");
		location = "/ver1.1/adm/1_order/adm_order_pre.jsp";
		break;
		
	case 2:
		int ord_id = Integer.parseInt((String)request.getParameter("odid"));
		int odc = Integer.parseInt((String)request.getParameter("odc"));
		String odn = (String)request.getParameter("odn");
		String ost = (String)request.getParameter("ost");
		rst[0] = 1;
		rst[1] = oddao.updateOrderDetailStatus(or_id, ord_id, or_status,odc,odn,ddao.now());
		location = "/ver1.1/adm/1_order/adm_order_send.jsp";
	}
	

	if (rst[0]*rst[1] > 0) {
%>
		<script type="text/javascript">
			alert("정상적으로 처리되었습니다.");
			location.href="<%=location%>";
		</script>
<%
	} else {
%>
		<script type="text/javascript">
			alert("처리 중 오류가 발생하였습니다.");
			history.go(-1);
		</script>
<%
	}

%>    
    
    
