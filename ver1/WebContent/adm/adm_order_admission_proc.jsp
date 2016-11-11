<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.order.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.delivery.*" %>

<%	request.setCharacterEncoding("euc-kr"); %>

<jsp:useBean id="odao" class="ec.order.orderDao" />
<jsp:useBean id="ovo" class="ec.order.orderVo" />
<jsp:setProperty property="*" name="ovo" />

<%	
	int rst = 0;		//주문 데이터베이스 삽입 검증
	int rst1 = 0;		//주문 시 기존 상품 재고 수량 변경 검증
	
	String[] ord1 = request.getParameterValues("ord_opt_color");
	String[] ord2 = request.getParameterValues("ord_opt_size");
	String[] ord3 = request.getParameterValues("ord_opt_count");
	
	int ord_status = 0;
	String ord_status_msg = null;
	int pd_id = Integer.parseInt(request.getParameter("ord_pd_id"));
	//상품 가격과 배송비 정보를 위해 불러옴 //
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(pd_id);
	
	deliveryDao dedao = new deliveryDao();
	deliveryVo devo = dedao.selectDelivery(pd_id);
	
	product_detailDao pddao = new product_detailDao();
	
	int totalPrice = 0; 					//사용자가 지불해야 하는 돈
	int[] eachPrice = new int[ord3.length];
	int[] eachDelivery = new int[ord3.length];
	int[] eachMileage = new int[ord3.length];						//마일리지	
	
	/* 사용자가 지불해야 하는 돈 */
	for(int i=0;i<ord3.length;i++){			//상품 수량 별 가격들을 모두 더한 뒤		
		eachPrice[i] = Integer.parseInt(ord3[i])*pvo.getPd_price();
		totalPrice = totalPrice + (Integer.parseInt(ord3[i])*pvo.getPd_price());
	}
	
	if(devo.getDe_method()==0){									//기본배송인 경우에
		if(ovo.getOrd_delivery_pay_method()==0){				//선결제인 경우에
			totalPrice += devo.getDe_price();					//기본 배송비를 더한다.
			eachPrice[ord3.length-1] += devo.getDe_price();
			eachDelivery[ord3.length-1] = devo.getDe_price();
		}
	}else if(devo.getDe_method()==1){							//무료배송일 경우에는 배송비를 더하지 않는다.
		
	}else{
		if(totalPrice<devo.getDe_price_condition()){			//무료배송 조건 금액보다 작을 경우
			if(ovo.getOrd_delivery_pay_method()==0){			//선결제인 경우에
				totalPrice += devo.getDe_price();				//기본 배송비를 더한다.
				eachPrice[ord3.length-1] += devo.getDe_price();
				eachDelivery[ord3.length-1] = devo.getDe_price();
			}
		}
	}
	
	if(ovo.getOrd_mileage()==1){								//마일리지 사용인 경우에
		totalPrice -= ovo.getOrd_mileage_value();				//사용하려는 값을 받아온다.
		eachPrice[ord3.length-1] -= ovo.getOrd_mileage_value();
		eachMileage[ord3.length-1] = ovo.getOrd_mileage_value();
		//*오류처리 (가지고있는 마일리지보다 더 많은 마일리지 사용이 검출되었을 경우)*//
	}
	
	if(ovo.getOrd_account_method()==4){
		ord_status = 0;	//결제대기
		ord_status_msg = "";
	}else{
		ord_status = 1;	//배송준비
		ord_status_msg = "";
	}
	
	for(int i=0; i<ord1.length;i++){
		rst = odao.orderInitialize(ovo, ord1[i], ord2[i],ord3[i],eachPrice[i],eachDelivery[i],eachMileage[i], ord_status, ord_status_msg);
	}
	

	
	if (rst > 0) {
		for(int i=0; i<ord1.length;i++){
			rst1 = pddao.updateProductStock(pd_id, ord1[i], ord2[i]);
		}
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