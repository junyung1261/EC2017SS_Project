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
	int rst = 0;		//�ֹ� �����ͺ��̽� ���� ����
	int rst1 = 0;		//�ֹ� �� ���� ��ǰ ��� ���� ���� ����
	
	String[] ord1 = request.getParameterValues("ord_opt_color");
	String[] ord2 = request.getParameterValues("ord_opt_size");
	String[] ord3 = request.getParameterValues("ord_opt_count");
	
	int ord_status = 0;
	String ord_status_msg = null;
	int pd_id = Integer.parseInt(request.getParameter("ord_pd_id"));
	//��ǰ ���ݰ� ��ۺ� ������ ���� �ҷ��� //
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(pd_id);
	
	deliveryDao dedao = new deliveryDao();
	deliveryVo devo = dedao.selectDelivery(pd_id);
	
	product_detailDao pddao = new product_detailDao();
	
	int totalPrice = 0; 					//����ڰ� �����ؾ� �ϴ� ��
	int[] eachPrice = new int[ord3.length];
	int[] eachDelivery = new int[ord3.length];
	int[] eachMileage = new int[ord3.length];						//���ϸ���	
	
	/* ����ڰ� �����ؾ� �ϴ� �� */
	for(int i=0;i<ord3.length;i++){			//��ǰ ���� �� ���ݵ��� ��� ���� ��		
		eachPrice[i] = Integer.parseInt(ord3[i])*pvo.getPd_price();
		totalPrice = totalPrice + (Integer.parseInt(ord3[i])*pvo.getPd_price());
	}
	
	if(devo.getDe_method()==0){									//�⺻����� ��쿡
		if(ovo.getOrd_delivery_pay_method()==0){				//�������� ��쿡
			totalPrice += devo.getDe_price();					//�⺻ ��ۺ� ���Ѵ�.
			eachPrice[ord3.length-1] += devo.getDe_price();
			eachDelivery[ord3.length-1] = devo.getDe_price();
		}
	}else if(devo.getDe_method()==1){							//�������� ��쿡�� ��ۺ� ������ �ʴ´�.
		
	}else{
		if(totalPrice<devo.getDe_price_condition()){			//������ ���� �ݾ׺��� ���� ���
			if(ovo.getOrd_delivery_pay_method()==0){			//�������� ��쿡
				totalPrice += devo.getDe_price();				//�⺻ ��ۺ� ���Ѵ�.
				eachPrice[ord3.length-1] += devo.getDe_price();
				eachDelivery[ord3.length-1] = devo.getDe_price();
			}
		}
	}
	
	if(ovo.getOrd_mileage()==1){								//���ϸ��� ����� ��쿡
		totalPrice -= ovo.getOrd_mileage_value();				//����Ϸ��� ���� �޾ƿ´�.
		eachPrice[ord3.length-1] -= ovo.getOrd_mileage_value();
		eachMileage[ord3.length-1] = ovo.getOrd_mileage_value();
		//*����ó�� (�������ִ� ���ϸ������� �� ���� ���ϸ��� ����� ����Ǿ��� ���)*//
	}
	
	if(ovo.getOrd_account_method()==4){
		ord_status = 0;	//�������
		ord_status_msg = "";
	}else{
		ord_status = 1;	//����غ�
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
	alert("�ֹ� �߰� ����");
	history.go(-1);
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("�ֹ� �߰� ����");
	history.go(-1);
</script>
<%
   }
%>