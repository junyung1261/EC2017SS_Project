
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "ec.product_detail.*"%>
<%@ page import = "ec.product.*" %>
<%@ page import = "ec.rel.*" %>
<%@ page import = "ec.category_product.*" %>
<%@ page import = "java.util.*"%>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="ec.product.productDao" />
<jsp:useBean id="vo" class="ec.product.productVo" />
<jsp:setProperty property="*" name="vo" />

<jsp:useBean id="disDao" class="ec.discount.discountDao"/>
<jsp:useBean id="disVo" class="ec.discount.discountVo"/>
<jsp:setProperty property="*" name="disVo" />
<%
   product_detailDao pddao = new product_detailDao();
   relDao rdao = new relDao();

   String[] sz_id = request.getParameterValues("sz_id");
   String[] col_id = request.getParameterValues("col_id");
   
   
   int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
   int pd_id = Integer.parseInt((String)request.getParameter("pd_index"));
   int dis_id = Integer.parseInt((String)request.getParameter("dis_index"));
   
   int rst = 0;  //total error
   int rst1 = 0; //insert product error
   int rst2 = 0; //insert product_detail error
   int rst3 = 0; //insert product_company error
   int rst4 = 0; //insert product_category error
   int rst5 = 0; //insert discount error
   int rst6 = 0; //insert product_discount error
   
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product ����");
   rst1 = dao.insertProduct(vo, pd_id); 
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_detail ����");
   for(int i = 0; i< col_id.length; i++ ){
      for(int j = 0; j< sz_id.length; j++){
       rst2 = pddao.insertProductDetail(pd_id, col_id[i], sz_id[j], stk_count);
      }
   }
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_company_rel ����");
   String co_id = (String)request.getParameter("co_id");
   rst3 = rdao.insertPdCoRel(pd_id, co_id);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_category_rel ���� ");
   int cgp_id = Integer.parseInt((String)request.getParameter("cgp_id"));
   rst4 = rdao.insertPdCgpRel(pd_id, cgp_id);
   
   ///////////////////////////////////////////////////////////////////////////
   // Product : Discout = 1 : 1�̾, ���� �и��� �ʿ䰡 ������, ���Ŀ� ���� ������Ʈ�� �����̷���� �� ���Ƽ� ������ �и���.
   // ����, pd_id�� dis_id�� ��� ���� ����. pd_id�� dis_id�� �˰����� �����Ƿ� �� ���� �ٸ��� ����üũ��.
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("discount ����");
   rst5 = disDao.insertDiscount(disVo);
   ///////////////////////////////////////////////////////////////////////////
   System.out.println("product_discount_rel ����");
   rst6 = rdao.insertPdDisRel(pd_id,dis_id);
   ///////////////////////////////////////////////////////////////////////////
   
   rst = rst1 * rst2 * rst3 * rst4 * rst5 * rst6;
   
   if (rst > 0) {
%>
<script type="text/javascript">
   alert("��ǰ �߰� ����");
</script>
<%
   } else {
%>
<script type="text/javascript">
   alert("��ǰ �߰� ����");
   history.go(-1);
</script>
<%
   }
%>