<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import = "ec.product_detail.*"%>
<%@ page import = "ec.product.*" %>
<%@ page import = "ec.category_product.*" %>
<%@ page import = "java.util.*"%>

<% request.setCharacterEncoding("euc-kr"); %>
<jsp:useBean id="dao" class="ec.product.productDao" />
<jsp:useBean id="vo" class="ec.product.productVo" />
<jsp:setProperty property="*" name="vo" />
<%
	product_detailDao pddao = new product_detailDao();
	
	
	String co_id = (String)request.getParameter("co_id");
	String sz_id = (String)request.getParameter("sz_id");
	String col_id = (String)request.getParameter("col_id");
	
	int cgp_id = Integer.parseInt((String)request.getParameter("cgp_id"));
	int stk_count = Integer.parseInt((String)request.getParameter("stk_count"));
	
	
	int rst = 0;
	int rst1 = 0;
	int rst2 = 0;
	int max = 0;
	
	rst1 = dao.insertProduct(vo, co_id, cgp_id);
	
	max = dao.getProductIdMax();
	StringTokenizer str = new StringTokenizer(col_id, ",");
	///////////////////////////////////////////////////////////////////////////
	while (str.hasMoreTokens()) {
	      //���� �Ľ��� ��ū�� �� �ִ��� ���θ� Ȯ���Ѵ�
	         String col1 = str.nextToken();
	         System.out.println(col1);
	         StringTokenizer str2 = new StringTokenizer(sz_id, ",");
	         while(str2.hasMoreTokens()){
	            String col2 = str2.nextToken();
	            rst2 = pddao.insertProductDetail(1, col_id, sz_id, stk_count);
	         }
	         //�Ľ��ؼ� ���� ������ū�� ��ȯ�Ѵ�.
	      }
	
	rst = rst1 * rst2;
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
