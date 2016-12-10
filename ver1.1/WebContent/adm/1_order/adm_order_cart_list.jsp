<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*" %>
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.member.*" %>
<%@ page import = "ec.product.*, ec.product_detail.*, ec.product_discount.*" %>
<%@ page import = "ec.company.*" %>
<%@ page import = "ec.order_cart.*" %>

<%	
	request.setCharacterEncoding("EUC-kr");

	String loginId = (String)session.getAttribute("loginId");
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(loginId);
	
	ocDao ocdao = new ocDao();
	ArrayList<ocVo> cartList = new ArrayList<ocVo>();

	ArrayList<ocVo> companyList = new ArrayList<ocVo>();
	companyList = ocdao.getCartCompany(mvo.getMem_id()); 
	
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	
	discountDao disdao = new discountDao();
	companyDao cdao = new companyDao();
	
%>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>회원 장바구니 리스트</title>
    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../../build/css/custom.min.css" rel="stylesheet">
    
    <style>
    .count {
    	border:none;
    	background:transparent; 
    	width:25px; 
    	text-align:center; 
    }
    .price_each{
    	border:none;
    	width:80px;
    	background:transparent; 
    }
    .color, .size{
    	border:none;
    	width:50px;
    	background:transparent;
    }
    </style>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="../adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "../adm_top.jsp" %>

        <!-- page content -->
        <form name="cart_all" method="post">
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>주문관리 <small>주문정보 및 해당 상품의 정보를 표기합니다.</small></h3>
              </div>
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="검색어 입력">
                    <span class="input-group-btn">
                      <button class="btn btn-default" type="button">Go!</button>
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>장바구니</h2>
                    <button class="btn btn-primary pull-right" onClick="submit_all()"><i class="fa fa-credit-card"></i>&nbsp;&nbsp;&nbsp;결제하기</button>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <!-- start  list -->
                    <%  
                    	int index_co = 0;        //장바구니 내 회사 종류 카운트
                    	int index_pdd = 0;       //전체 카운트
                    	for(ocVo cvo : companyList){ 
                    		companyVo cvo2 = cdao.getCompanyInfo(cvo.getOc_co_id());
                    %>
                    <div class="row">
                      <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;"><%=cvo2.getCo_name() %></p>
                      <div class="col-md-8">
                      <table class="table table-striped projects">
                        <thead>
                          <tr>
                            <th colspan="2">상품번호</th>
                            <th>상품명</th>
                            <th>색상</th>
                            <th>사이즈</th>
                            <th>수량</th>
                            <th>가격</th>
                            <th></th>
                          </tr>
                        </thead>
                        <tbody>
                     <%
	                		int price_each = 0; 	//한 회사 내에서의 상폼 각각의 가격
	                		int count_co = 0;  		//한 회사 내에서의 상품 총 주문 수량
	                		int price_co = 0;		//한 회사 내에서 상품 총 주문금액
	                		int discount_co = 0;	//한 회사 내에서 상품 총 할인금액
	                		int index_pdd_co = 0;	//한 회사 내의 상품 개수 카운트
                    		cartList = ocdao.getCartList(mvo.getMem_id(), cvo.getOc_co_id()); 
	                    	for(ocVo ocvo : cartList){ 
								////////////////////////////////////////////////////////////////////
								int pdd_id = ocvo.getOc_pdd_id();
	                    		product_detailVo pddvo = pddao.selectByPdd_id(pdd_id);
	                    		int pd_id = pddvo.getPd_id();
	                    		productVo pdvo = pdao.getProductInfo(pd_id);
	                    		int pd_price = pdvo.getPd_price();
	                    		discountVo disvo = disdao.selectDiscount(pd_id);
	                    		////////////////////////////////////////////////////////////////////
	                    		if(disvo.getDis()==1){
		                    		if(disvo.getDis_method()==0){ 
		                    			price_each = pd_price-(int)(pd_price*disvo.getDis_rate()*0.01);
		                    			discount_co += (int)(pd_price*disvo.getDis_rate()*0.01) * ocvo.getOc_opt_count();
		                    		}
		                    		else{ 
			                        	price_each = pdvo.getPd_price()-disvo.getDis_value();
			                        	discount_co += disvo.getDis_value()* ocvo.getOc_opt_count();
		                    		}
	                    		}
								////////////////////////////////////////////////////////////////////
								count_co +=ocvo.getOc_opt_count();
								price_co +=ocvo.getOc_opt_count()*pdvo.getPd_price();
	               	 %>
                        <tr>
                          <td><%=pdvo.getPd_id() %></td>
                          <td><ul class="list-inline"><li><img src="<%=pdvo.getPd_main_img() %>" class="avatar" alt="Avatar"></li></ul></td>
                          <td><a><%=pdvo.getPd_name() %></a><br /><small>장바구니 <%=ocvo.getOc_reg() %> 추가</small></td>
                          <td><input type="text" name="opt_color" class="color" value="<%=pddvo.getCol_id() %>" readonly></td>
                          <td><input type="text" name="opt_size" class="size" value="<%=pddvo.getSz_id() %>" readonly></td>
                          <td>
                          <i class="fa fa-plus-square-o" onClick="plusF(<%=index_pdd%>,<%=pdvo.getPd_price()%>,<%=price_each%>,<%=index_co%>,<%=cvo2.getCo_delivery()%>,<%=cvo2.getCo_delivery_base()%>,<%=cvo2.getCo_delivery_condition()%>)"></i>&nbsp;&nbsp;
                          <input type="text" name="opt_count" class="count" value="<%=ocvo.getOc_opt_count() %>" readonly>&nbsp;&nbsp;
                          <i class="fa fa-minus-square-o" onClick="minusF(<%=index_pdd%>, <%=pdvo.getPd_price()%>,<%=price_each%>,<%=index_co%>,<%=cvo2.getCo_delivery()%>,<%=cvo2.getCo_delivery_base()%>,<%=cvo2.getCo_delivery_condition()%>)"></i></td>
                          <td>￦ <input type="text" name="price" class="price_each" value="<%=ocvo.getOc_opt_count()*price_each %>" ></td>
                          <td><a href="adm_order_cart_del.jsp?pdd=<%=pdd_id%>"><i class="fa fa-trash-o"></i></a>
                          <!-- 전송용 정보 (결제용) -->
                              <input type="hidden" name="pdd_id" value="<%=pdd_id %>">
                          <!-- 전송용 정보 (결제용) -->
                          </td>
                        </tr>
                    <%		
                    	index_pdd_co++;
                    	index_pdd++;	//회사 상관없이 상품의 개수에 따라 input 배열 번호를 정하는 변수
	                    }
	                %>
                        <tr>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                          <td></td>
                        </tr>
                      </tbody>
                    </table>
                    <%
                          int delivery = 0;
                    	  if(cvo2.getCo_delivery()==0){
                    		  delivery = 0;
                    	  }
                    	  else{
                    		  if(count_co * price_each >= cvo2.getCo_delivery_condition()){
                    			  delivery = 0;
                    		  }
                    		  else{
                    			  delivery = cvo2.getCo_delivery_base();
                    		  }
                    	  }  
                    %>
                  </div>  
                  <div class="col-xs-4">
                    <p class="lead">예상결제금액</p>
                    <div class="table-responsive">
                      <table class="table">
                        <tbody>
                          <tr>
                            <th style="width:50%">상품가격 (A)</th>
                            <td>￦ <input type="text" name="price_co" class="price_each" value="<%=price_co %>" readonly></td>
                          </tr>
                          <tr>
                            <th>할인금액 (B)</th>
                            <td>￦ <input type="text" name="discount_co" class="price_each" value="<%=discount_co %>" readonly></td>
                          </tr>
                          <tr>
                            <th>배송비 (C)</th>
                            <td>￦ <input type="text" name="total_delivery" class="price_each" value="<%=delivery %>" readonly></td>
                          </tr>
                          <tr>
                            <th>총 결제금액 (A-B+C)</th>
                            <td>￦ <input type="text" name="total_co" class="price_each" value="<%=price_co - discount_co + delivery %>" readonly></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
                    <input type="hidden" name="index_co" value="<%=index_co %>">
                    <input type="hidden" name="index_pdd_co" value="<%=index_pdd_co %>">
                    <%index_co++; %>
                  </div>
                  </div>
                  
                  <%} %>
                    <!-- end project list -->
                </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        </form>
        <!-- /page content -->

        <!-- footer content -->
        <%@include file = "../adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../../vendors/nprogress/nprogress.js"></script>
    <!-- bootstrap-progressbar -->
    <script src="../../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    
    <script>
    
    function plusF(idx, price_base, price_each,co_idx,delivery,base,condition){
  	  
  	  var target_opt_count = document.getElementsByName('opt_count')[idx];
  	  var target_price = document.getElementsByName('price')[idx];
  	  var target_price_co = document.getElementsByName('price_co')[co_idx];
  	  var target_discount_co = document.getElementsByName('discount_co')[co_idx];
  	  var target_total_co = document.getElementsByName('total_co')[co_idx];
  	  var target_total_delivery = document.getElementsByName('total_delivery')[co_idx];
  	  
  	  target_opt_count.value = parseInt(target_opt_count.value) + 1;
  	  target_price.value = parseInt(target_opt_count.value) * parseInt(price_each);
  	  target_price_co.value = parseInt(target_price_co.value) + parseInt(price_base);
      target_discount_co.value = parseInt(target_discount_co.value) + parseInt(price_base) - parseInt(price_each);
  	  
  	  if(parseInt(delivery)==0){
  		  target_total_delivery.value = 0;
  	  }else{
  		  if(parseInt(target_price_co.value) - parseInt(target_discount_co.value) >= parseInt(condition)){
  			  target_total_delivery.value = 0;
  		  }
  		  else{
  			  target_total_delivery.value = parseInt(base);
  		  }
  	  }
  	target_total_co.value = parseInt(target_price_co.value) - parseInt(target_discount_co.value) + parseInt(target_total_delivery.value);
    }
    
    function minusF(idx, price_base, price_each,co_idx,delivery,base,condition){
    	
  	  var target_opt_count = document.getElementsByName('opt_count')[idx];
  	  var target_price = document.getElementsByName('price')[idx];
  	  var target_price_co = document.getElementsByName('price_co')[co_idx];
  	  var target_discount_co = document.getElementsByName('discount_co')[co_idx];
  	  var target_total_co = document.getElementsByName('total_co')[co_idx];
	  var target_total_delivery = document.getElementsByName('total_delivery')[co_idx];
  	  
  	  if(parseInt(target_opt_count.value) == 1){
  	  	target_count.value = 1;
  	  }
  	  else{
  		  target_opt_count.value = parseInt(target_opt_count.value) - 1;  
  	  }
  	  
  	  target_price.value = parseInt(target_opt_count.value) * parseInt(price_each);
  	  target_price_co.value = parseInt(target_price_co.value) - parseInt(price_base);
  	  target_discount_co.value = parseInt(target_discount_co.value) - parseInt(price_base) + parseInt(price_each);
  	  
  	  if(parseInt(delivery)==0){
		  target_total_delivery.value = 0;
  	  }
  	  else{
		  if(parseInt(target_price_co.value) - parseInt(target_discount_co.value) >= parseInt(condition)){
			  target_total_delivery.value = 0;
		  }
		  else{
			  target_total_delivery.value = parseInt(base);
		  }
	  }
  	  target_total_co.value = parseInt(target_price_co.value) - parseInt(target_discount_co.value) + parseInt(target_total_delivery.value);
    }
    
    </script>
    
    <script>

    function submit_all(){
    	var target_form = document.cart_all;
    	target_form.action = "adm_order_account_all.jsp";
    	target_form.submit();
    }
    </script>
  </body>
</html>