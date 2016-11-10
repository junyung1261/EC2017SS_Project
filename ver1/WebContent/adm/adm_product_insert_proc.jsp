
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

<jsp:useBean id="ddao" class="ec.product_detail.product_detailDao" />
<jsp:useBean id="dvo" class="ec.product_detail.product_detailVo" />
<jsp:setProperty property="*" name="dvo" />

<jsp:useBean id="disDao" class="ec.discount.discountDao"/>
<jsp:useBean id="disVo" class="ec.discount.discountVo"/>
<jsp:setProperty property="*" name="disVo" />

<jsp:useBean id="deDao" class="ec.delivery.deliveryDao"/>
<jsp:useBean id="deVo" class="ec.delivery.deliveryVo"/>
<jsp:setProperty property="*" name="deVo" />

<jsp:useBean id="milDao" class="ec.mileage.mileageDao"/>
<jsp:useBean id="milVo" class="ec.mileage.mileageVo"/>
<jsp:setProperty property="*" name="milVo" />

<%	int pd_id = dao.nextInsertProductId();
	product_detailDao pddao = new product_detailDao();
	relDao rdao = new relDao();
   
	String[] sz_id = request.getParameterValues("sz_id");
	String[] col_id = request.getParameterValues("col_id");
	int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
  
	String co_id = (String)request.getParameter("co_id");
	int cgp_id = Integer.parseInt((String)request.getParameter("cgp_id"));
   
	int rst = 0;  //total error
	int rst1 = 0; //insert product error
	int rst2 = 0; //insert product_detail error
	int rst3 = 0; //insert product_company error
	int rst4 = 0; //insert product_category error
	int rst5 = 0; //insert discount error
	int rst6 = 0; //insert delivery error
	int rst7 = 0; //insert mileage error
   
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product 진입");
	rst1 = dao.insertProduct(vo);  
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_detail 진입");
	for(int i = 0; i< col_id.length; i++ ){
		for(int j = 0; j< sz_id.length; j++){
			rst2 = pddao.insertProductDetail(pd_id, dvo);
		}
	}
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_company_rel 진입");
	rst3 = rdao.insertPdCoRel(pd_id, co_id);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_category_rel 진입 ");
	rst4 = rdao.insertPdCgpRel(pd_id, cgp_id);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("discount 진입");
	rst5 = disDao.insertDiscount(disVo, pd_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("delivery 진입");
	rst6 = deDao.insertDelivery(deVo, pd_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("mileage 진입");
	rst7 = milDao.insertMileage(milVo, pd_id); 
   
	rst = rst1 * rst2 * rst3 * rst4 * rst5 * rst6 * rst7 ;
   
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("제품 추가 성공");
	history.go(-1);
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