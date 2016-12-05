
<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.product_detail.*"%>
<%@ page import = "ec.product.*" %>
<%@ page import = "ec.delivery.*" %>
<%@ page import = "ec.rel.*" %>
<%@ page import = "ec.category_product.*" %>
<%@ page import = "java.sql.*" %>


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

<jsp:useBean id="milDao" class="ec.mileage.mileageDao"/>
<jsp:useBean id="milVo" class="ec.mileage.mileageVo"/>
<jsp:setProperty property="*" name="milVo" />



<%	int pd_id = dao.nextInsertProductId();
	product_detailDao pddao = new product_detailDao();
	relDao rdao = new relDao();
   
	String[] sz_id = request.getParameterValues("sz_id");
	String[] col_id = request.getParameterValues("col_id");
	System.out.println(sz_id);
	System.out.println(col_id);
	int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
  
	String co_id = (String)request.getParameter("co_id");
	int cat1 = Integer.parseInt((String)request.getParameter("cg_cat1"));
	int cat2 = Integer.parseInt((String)request.getParameter("cg_cat2"));
	int cat3 = Integer.parseInt((String)request.getParameter("cg_cat3"));
	ArrayList<Integer> cg_List = new ArrayList<Integer>();
	cg_List.add(cat1);
	cg_List.add(cat2);
	cg_List.add(cat3);
	

	
	int rst = 0;  //total error
	int rst1 = 0; //insert product error
	int rst2 = 1; //insert product_detail error
	int rst3 = 0; //insert product_company error
	int rst4 = 1; //insert product_category error
	int rst5 = 0; //insert discount error
	int rst6 = 0; //insert delivery error
	int rst7 = 0; //insert mileage error
   
	
	
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product ����");
	rst1 = dao.insertProduct(vo);  
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_detail ����");
	product_detailDao ddao = new product_detailDao();
	for(int i = 0; i< col_id.length; i++ ){
		for(int j = 0; j< sz_id.length; j++){
			rst2 *= ddao.insertProductDetail(pd_id, col_id[i], sz_id[j], stk_count);
		}
	}
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_company_rel ����");
	rst3 = rdao.insertPdCoRel(pd_id, co_id);
	///////////////////////////////////////////////////////////////////////////
	System.out.println("product_category_rel ���� ");
	for(int i=0;i<3; i++)
	rst4 *= rdao.insertPdCgpRel(pd_id, cg_List.get(i));
	///////////////////////////////////////////////////////////////////////////
	System.out.println("discount ����");
	rst5 = disDao.insertDiscount(disVo, pd_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("delivery ����");
	rst6 = deDao.insertDelivery(deVo, pd_id); 
	///////////////////////////////////////////////////////////////////////////
	System.out.println("mileage ����");
	rst7 = 1 ;//milDao.insertMileage(milVo, pd_id); 
   
	rst = rst1 * rst2 * rst3 * rst4 * rst5 * rst6 * rst7 ;
   
	
	
	if (rst > 0) {
%>
<script type="text/javascript">
	alert("��ǰ �߰� ����");
	history.go(-1);
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