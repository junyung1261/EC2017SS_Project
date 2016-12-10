<%@ page language="java" contentType="text/html; charset=EUC-KR"
   pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*"%>
<%@ page import = "ec.product_detail.*"%>
<%@ page import = "ec.rel.*" %>
<%@ page import = "ec.category_product.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="ec.product.productDao" />
<jsp:useBean id="vo" class="ec.product.productVo" />
<jsp:setProperty property="*" name="vo" />

<jsp:useBean id="disDao" class="ec.product_discount.discountDao"/>
<jsp:useBean id="disVo" class="ec.product_discount.discountVo"/>
<jsp:setProperty property="*" name="disVo" />



<%	int pd_id = dao.nextInsertProductId();
	product_detailDao pddao = new product_detailDao();
	relDao rdao = new relDao();
   
	String[] sz_id = request.getParameterValues("sz_id");
	String[] col_id = request.getParameterValues("col_id");
	int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
  
	int cat1 = Integer.parseInt((String)request.getParameter("cg_cat1"));
	int cat2 = Integer.parseInt((String)request.getParameter("cg_cat2"));
	int cat3 = Integer.parseInt((String)request.getParameter("cg_cat3"));
	ArrayList<Integer> cg_List = new ArrayList<Integer>();
	cg_List.add(cat1);
	cg_List.add(cat2);
	cg_List.add(cat3);
	
	int[] rst = new int[5];
	
	rst[0] = 0;  //total error
	rst[1] = 0;
	rst[2] = 1;
	rst[3] = 1;
	rst[4] = 0;
	//////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("product 진입");
	rst[1] = dao.insertProduct(vo, cat1);  											//insert product error		
	//////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("product_detail 진입");
	product_detailDao ddao = new product_detailDao();
	for(int i = 0; i< col_id.length; i++ ){
		for(int j = 0; j< sz_id.length; j++){
			rst[2] *= ddao.insertProductDetail(pd_id, col_id[i], sz_id[j], stk_count);
		}
	}																			//product_detail error
	//////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("product_category_rel 진입 ");
	for(int i=0;i<3; i++)
	rst[3] *= rdao.insertPdCgpRel(pd_id, cg_List.get(i));					  //product_category error
	//////////////////////////////////////////////////////////////////////////////////////////////////
	System.out.println("product_discount 진입");
	rst[4] = disDao.insertDiscount(disVo, pd_id); 							  //product_discount error
	//////////////////////////////////////////////////////////////////////////////////////////////////

	rst[0] = rst[1] * rst[2] * rst[3] * rst[4] ;
    System.out.println(rst[1]);
    System.out.println(rst[2]);
    System.out.println(rst[3]);
    System.out.println(rst[4]);
    
	if (rst[0] > 0) {
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