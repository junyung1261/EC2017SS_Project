
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.product_detail.*"%>
<%@ page import = "ec.product.*" %>
<%@ page import = "ec.delivery.*" %>
<%@ page import = "ec.rel.*" %>
<%@ page import = "ec.category_product.*" %>


<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="ec.product.productDao" />
<jsp:useBean id="vo" class="ec.product.productVo" />
<jsp:setProperty property="*" name="vo" />

<jsp:useBean id="disDao" class="ec.discount.discountDao"/>
<jsp:useBean id="disVo" class="ec.discount.discountVo"/>
<jsp:setProperty property="*" name="disVo" />

<jsp:useBean id="deDao" class="ec.delivery.deliveryDao"/>
<jsp:useBean id="deVo" class="ec.delivery.deliveryVo"/>
<jsp:setProperty property="*" name="deVo" />

<%
   product_detailDao pddao = new product_detailDao();
   relDao rdao = new relDao();

   String[] sz_id = request.getParameterValues("sz_id");
   String[] col_id = request.getParameterValues("col_id");
   String co_id = (String)request.getParameter("co_id");
   int cgp_id = Integer.parseInt((String)request.getParameter("cgp_id"));
   int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
   int pd_id = Integer.parseInt((String)request.getParameter("pd_index"));
   int dis_id = Integer.parseInt((String)request.getParameter("dis_index"));
   int de_id = Integer.parseInt((String)request.getParameter("de_index"));
   
   int rst = 0;  //total error
   int rst1 = 0; //insert product error
   int rst2 = 0; //insert product_detail error
   int rst3 = 0; //insert product_company error
   int rst4 = 0; //insert product_category error
   int rst5 = 0; //insert discount error
   int rst6 = 0; //insert product_discount error
   int rst7 = 0; //insert delivery error
   int rst8 = 0; //insert product_delivery error
   
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product 진입");
   rst1 = dao.insertProduct(vo, pd_id); 
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_detail 진입");
   for(int i = 0; i< col_id.length; i++ ){
      for(int j = 0; j< sz_id.length; j++){
       rst2 = pddao.insertProductDetail(pd_id, col_id[i], sz_id[j], stk_count);
      }
   }
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_company_rel 진입");
   rst3 = rdao.insertPdCoRel(pd_id, co_id);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_category_rel 진입 ");
   rst4 = rdao.insertPdCgpRel(pd_id, cgp_id);
   ///////////////////////////////////////////////////////////////////////////
   // Product : Discout = 1 : 1이어서, 구지 분리할 필요가 없지만, 추후에 할인 업데이트가 자주이루어질 것 같아서 별도로 분리함.
   // 따라서, pd_id와 dis_id는 사실 같은 값임. pd_id와 dis_id의 알고리즘이 같으므로 두 값이 다르면 오류체크됨.
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("discount 진입");
   rst5 = disDao.insertDiscount(disVo);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_discount_rel 진입");
   rst6 = rdao.insertPdDisRel(pd_id,dis_id);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("delivery 진입");
   rst7 = deDao.insertDelivery(deVo);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_delivery_rel 진입");
   rst8 = rdao.insertPdDeRel(pd_id, de_id);
   
   rst = rst1 * rst2 * rst3 * rst4 * rst5 * rst6 * rst7 * rst8;
   
   if (rst > 0) {
%>
<script type="text/javascript">
   alert("제품 추가 성공");
</script>
<%
   } else {
%>
<script type="text/javascript">
   alert("제품 추가 실패");
   history.go(-1);
</script>
<%
   }
%>