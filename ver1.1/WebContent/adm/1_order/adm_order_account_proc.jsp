<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import = "java.util.*" %>
<%@ page import = "ec.member.*, ec.member_address.*" %>
<%@ page import = "ec.product.*, ec.product_detail.*, ec.product_discount.*" %>    
<%@ page import = "ec.company.*" %>
<%@ page import = "ec.order_cart.*" %>
<%@ page import = "ec.convert.*" %>
<%@ page import = "ec.order.*, ec.order_detail.*" %>
<%@ page import = "ec.date.*" %>



<%   request.setCharacterEncoding("EUC-kr");

   String loginId = (String)session.getAttribute("loginId");
   memberDao mdao = new memberDao();
   memberVo mvo = mdao.selectMember(loginId);
   
   int index_co = Integer.parseInt(request.getParameter("index_co"));      //총 회사 개수
   
   String[] pdd_id = request.getParameterValues("pdd_id");         //상품 전체개수
   String[] opt_count = request.getParameterValues("opt_count");   //수량
   String[] index_pdd_co = request.getParameterValues("index_pdd_co");    //회사 별 상품 개수
   String[] mileage = request.getParameterValues("mileage");
   
   System.out.println(index_co);
   
   int price = 0;      //순수 상품 가격
   int discount = 0;   //상품전체 할인금액
   int delivery = 0;   //상품전체 배송금액
   int price_for_delivery = 0;  //회사별 금액
   int mileage_total = 0;   //마일리지 총 사용금액
   int total = 0;      //총 금액
   int delivery_co[] = new int[index_co];
   int discount_pdd[] = new int[pdd_id.length];
   
   product_detailDao pddao = new product_detailDao();
   productDao pdao = new productDao();
   discountDao disdao = new discountDao();
   companyDao cdao = new companyDao();
   convertDao cvdao = new convertDao();
   dateDao ddao = new dateDao();
   orderDao odao = new orderDao();
   orderVo ovo = new orderVo();
   oddDao oddao = new oddDao();
   oddVo odvo = new oddVo();
   ocDao ocdao = new ocDao();
   
   //////////////////////////////////////////////////////////////////////////////////////////
   member_addressDao madao = new member_addressDao();
   member_addressVo mavo = madao.getMemberInfo(mvo.getMem_id());            //회원 배송지 정보 추출
   //////////////////////////////////////////////////////////////////////////////////////////

   int pdd_index = 0;
    for(int i=0;i<index_pdd_co.length;i++){
       price_for_delivery = 0;
       String co_id = null;
       for(int j=0; j<Integer.parseInt(index_pdd_co[i]);j++){ 
          
         product_detailVo pddvo = pddao.selectByPdd_id(Integer.parseInt(pdd_id[pdd_index]));
         int pd_id = pddvo.getPd_id();
         productVo pdvo = pdao.getProductInfo(pd_id);
         co_id = pdvo.getPd_co_id();
         
         discountVo disvo = disdao.selectDiscount(pd_id);

         price += pdvo.getPd_price() * Integer.parseInt(opt_count[pdd_index]);
         price_for_delivery += pdvo.getPd_price() * Integer.parseInt(opt_count[pdd_index]);
         
         if(disvo.getDis()==0){
            discount = 0;
            discount_pdd[pdd_index] = 0;
         }else{
            if(disvo.getDis_method()==0){
               discount += (int)(pdvo.getPd_price() * disvo.getDis_rate() * 0.01* Integer.parseInt(opt_count[pdd_index]));
               discount_pdd[pdd_index] = (int)(pdvo.getPd_price() * disvo.getDis_rate() * 0.01* Integer.parseInt(opt_count[pdd_index]));
            }else{
               discount += disvo.getDis_value()* Integer.parseInt(opt_count[pdd_index]);
               discount_pdd[pdd_index] = disvo.getDis_value()* Integer.parseInt(opt_count[pdd_index]);
            }
         }
         pdd_index++;
         
       }
       companyVo cvo = cdao.getCompanyInfo(co_id);
       if(cvo.getCo_delivery()==0){
          delivery += 0;
          delivery_co[i] = 0;
       }else{
          if(price_for_delivery>=cvo.getCo_delivery_condition()){
             delivery += 0;
             delivery_co[i] = 0;
          }
          else{
             delivery += cvo.getCo_delivery_base();
             delivery_co[i] = cvo.getCo_delivery_base();
          }
       }
   }
   
   
   for(int i=0; i<mileage.length;i++) mileage_total += Integer.parseInt(mileage[i]);
   
   
   total = price - discount - mileage_total + delivery;
   
   int rst = 1;
   
   ovo.setMem_id(mavo.getMa_mem_id());
   ovo.setMem_name(mavo.getMa_name_recipient());
   ovo.setMem_phone(mavo.getMa_phone_recipient());
   ovo.setMem_zipcode(mavo.getMa_addr_zipcode());
   ovo.setMem_address(mavo.getMa_addr_base());
   ovo.setOr_total_price(price);
   ovo.setOr_total_discount(discount); 
   ovo.setOr_total_delivery_price(delivery);
   ovo.setOr_total_mileage(mileage_total);
   ovo.setOr_account_method(Integer.parseInt(request.getParameter("or_account_method")));
   ovo.setOr_account_value(total);
   
   long or_id = odao.insertOrder(ovo, ddao.now());
   pdd_index=0;
   for(int i=0; i<index_co; i++){
      
      for(int j=0; j<Integer.parseInt(index_pdd_co[i]); j++){
         product_detailVo pddvo = pddao.selectByPdd_id(Integer.parseInt(pdd_id[pdd_index]));
             int pd_id = pddvo.getPd_id();
         productVo pvo = pdao.getProductInfo(pd_id);

         odvo.setPd_id(pd_id);
         odvo.setCo_id(pvo.getPd_co_id());
         odvo.setPdd_id(Integer.parseInt(pdd_id[pdd_index]));
         odvo.setOrd_count(Integer.parseInt(opt_count[pdd_index]));
         odvo.setOrd_price(pvo.getPd_price()*Integer.parseInt(opt_count[pdd_index]));
         odvo.setOrd_discount(discount_pdd[pdd_index] );
         odvo.setOrd_use_mileage(Integer.parseInt(mileage[pdd_index]));
         if(j>0){
        	 odvo.setOrd_delivery_pay(0);
         }else{
         	odvo.setOrd_delivery_pay(delivery_co[i]);
         }
         rst *= oddao.insertOrderDetail(odvo, or_id);
         rst *= ocdao.deleteCart(mvo.getMem_id(), Integer.parseInt(pdd_id[pdd_index]));
         pdd_index++;
      }
   }
   
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