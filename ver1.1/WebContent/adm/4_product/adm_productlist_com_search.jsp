<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.company_grade.*" %>
<%@ page import="ec.product_discount.*" %>

<%	dateDao ddao = new dateDao();
	String now = ddao.now();
	String co_id = (String)request.getParameter("c");
	
	productDao pdao = new productDao();
	ArrayList<productVo> productList = new ArrayList<productVo>();
	ArrayList<productVo> productListMale = new ArrayList<productVo>();
	ArrayList<productVo> productListFemale = new ArrayList<productVo>();
	ArrayList<productVo> productListUnisex = new ArrayList<productVo>();
	
	//업체에 해당하는 전체 리스트//
	productList = pdao.productList(2, co_id);
	//업체에 해당하는 남성상품 리스트//
	productListMale = pdao.productList(10, co_id);
	productListFemale = pdao.productList(20, co_id);
	productListUnisex = pdao.productList(30, co_id);
	
	companyDao cdao = new companyDao();
	companyVo cvo = cdao.getCompanyInfo(co_id);

	discountDao disDao = new discountDao();
	cgDao cgdao = new cgDao();
	
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>EC Corporation </title>

    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="../adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "../adm_top.jsp" %>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left"><h3>상품관리 <small>EC Corporation의 상품 리스트를 표시합니다.</small></h3></div>
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
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><%=cvo.getCo_name() %> 상품리스트<small><%=now+" 현재" %></small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active">
                        	<a href="#tab_content0" id="total-tab" role="tab" data-toggle="tab" aria-expanded="true">
                        	전체&nbsp;(<%= pdao.productCountByCom(0,co_id)%>)</a>
                        </li>
                        <li role="presentation" class="">
                        	<a href="#tab_content1" id="male-tab" role="tab" data-toggle="tab" aria-expanded="true">
                        	남성&nbsp;(<%= pdao.productCountByCom(10,co_id)%>)</a>
                        </li>
                        <li role="presentation" class="">
                        	<a href="#tab_content2" role="tab" id="female-tab" data-toggle="tab" aria-expanded="false">
                        	여성&nbsp;(<%= pdao.productCountByCom(20,co_id)%>)</a>
                        </li>
                        <li role="presentation" class="">
                        	<a href="#tab_content3" role="tab" id="unisex-tab2" data-toggle="tab" aria-expanded="false">
                        	공용&nbsp;(<%= pdao.productCountByCom(30,co_id)%>)</a>
                        </li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content0" aria-labelledby="total-tab">
                          <%for(productVo pvo : productList){ %>
                          <div class="col-md-3 col-sm-3 col-xs-3">
			               <div class="x_panel">
			                  <div class="x_content">
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <br />
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <img src="<%=pvo.getPd_main_img() %>" width="100%">
			                        </div>
			                      </div>
			                      <br />
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : <%=pvo.getPd_id() %>
			                        	<a href="adm_productdetail_com.jsp?pid=<%=pvo.getPd_id() %>&cid=<%=co_id%>"><button type="button" class="btn btn-warning btn-xs pull-right">상세</button></a>
			                        </li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data">
			                        <li><%=pvo.getPd_name() %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ <%=pvo.getPd_price() %></li>
			                        
			                        
			                    <%  discountVo disvo = disDao.selectDiscount(pvo.getPd_id());     
			                    	cgVo cgvo = cgdao.getGradeInfo(cvo.getCo_grade());
			                        int sale_price = 0;
			                        int mileage = 0;
			                        double mileage_rate = 0;
			                        if(disvo.getDis_method()==1){
				                        sale_price = pvo.getPd_price()-disvo.getDis_value();
			                        }
			                        else{
			                        	sale_price = pvo.getPd_price()-(pvo.getPd_price()*disvo.getDis_rate()/100);
			                        }
			                        
			                        mileage_rate = Double.parseDouble(cgvo.getCg_mil_rate()) / 100;
			                        mileage = (int)Math.floor(sale_price * mileage_rate /10) * 10;
			                    %>
			                        
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 할인가 : ￦  <%=sale_price %></li>
			                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 : ￦ <%=mileage %>
			                        (<%=cgvo.getCg_mil_rate() %>%)
			                        </li>
			                      </ul>
			                    </div>
					          </div>
					        </div>
					      </div>
					      <%} %>
					      
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content1" aria-labelledby="male-tab">
                          <%for(productVo pvo : productListMale){ %>
                          <div class="col-md-3 col-sm-3 col-xs-3">
			               <div class="x_panel">
			                  <div class="x_content">
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <br />
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <img src="<%=pvo.getPd_main_img() %>" width="100%">
			                        </div>
			                      </div>
			                      <br />
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : <%=pvo.getPd_id() %>
			                        	<a href="adm_productdetail_com.jsp?pid=<%=pvo.getPd_id() %>&cid=<%=co_id%>"><button type="button" class="btn btn-warning btn-xs pull-right">상세</button></a>
			                        </li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data">
			                        <li><%=pvo.getPd_name() %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ <%=pvo.getPd_price() %></li>
			                        
			                        
			                    <%  discountVo disvo = disDao.selectDiscount(pvo.getPd_id());     
			                    	cgVo cgvo = cgdao.getGradeInfo(cvo.getCo_grade());
			                        int sale_price = 0;
			                        int mileage = 0;
			                        double mileage_rate = 0;
			                        if(disvo.getDis_method()==1){
				                        sale_price = pvo.getPd_price()-disvo.getDis_value();
			                        }
			                        else{
			                        	sale_price = pvo.getPd_price()-(pvo.getPd_price()*disvo.getDis_rate()/100);
			                        }
			                        
			                        mileage_rate = Double.parseDouble(cgvo.getCg_mil_rate()) / 100;
			                        mileage = (int)Math.floor(sale_price * mileage_rate /10) * 10;
			                    %>
			                        
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 할인가 : ￦  <%=sale_price %></li>
			                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 : ￦ <%=mileage %>
			                        (<%=cgvo.getCg_mil_rate() %>%)
			                        </li>
			                      </ul>
			                    </div>
					          </div>
					        </div>
					      </div>
					      <%} %>
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="female-tab">
                          <%for(productVo pvo : productListFemale){ %>
                          <div class="col-md-3 col-sm-3 col-xs-3">
			               <div class="x_panel">
			                  <div class="x_content">
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <br />
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <img src="<%=pvo.getPd_main_img() %>" width="100%">
			                        </div>
			                      </div>
			                      <br />
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : <%=pvo.getPd_id() %>
			                        	<a href="adm_productdetail_com.jsp?pid=<%=pvo.getPd_id() %>&cid=<%=co_id%>"><button type="button" class="btn btn-warning btn-xs pull-right">상세</button></a>
			                        </li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data">
			                        <li><%=pvo.getPd_name() %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ <%=pvo.getPd_price() %></li>
			                        
			                        
			                    <%  discountVo disvo = disDao.selectDiscount(pvo.getPd_id());     
			                    	cgVo cgvo = cgdao.getGradeInfo(cvo.getCo_grade());
			                        int sale_price = 0;
			                        int mileage = 0;
			                        double mileage_rate = 0;
			                        if(disvo.getDis_method()==1){
				                        sale_price = pvo.getPd_price()-disvo.getDis_value();
			                        }
			                        else{
			                        	sale_price = pvo.getPd_price()-(pvo.getPd_price()*disvo.getDis_rate()/100);
			                        }
			                        
			                        mileage_rate = Double.parseDouble(cgvo.getCg_mil_rate()) / 100;
			                        mileage = (int)Math.floor(sale_price * mileage_rate /10) * 10;
			                    %>
			                        
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 할인가 : ￦  <%=sale_price %></li>
			                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 : ￦ <%=mileage %>
			                        (<%=cgvo.getCg_mil_rate() %>%)
			                        </li>
			                      </ul>
			                    </div>
					          </div>
					        </div>
					      </div>
					      <%} %>
                        
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="unisex-tab">
                          <%for(productVo pvo : productListUnisex){ %>
                          <div class="col-md-3 col-sm-3 col-xs-3">
			               <div class="x_panel">
			                  <div class="x_content">
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <br />
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <img src="<%=pvo.getPd_main_img() %>" width="100%">
			                        </div>
			                      </div>
			                      <br />
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : <%=pvo.getPd_id() %>
			                        	<a href="adm_productdetail_com.jsp?pid=<%=pvo.getPd_id() %>&cid=<%=co_id%>"><button type="button" class="btn btn-warning btn-xs pull-right">상세</button></a>
			                        </li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data">
			                        <li><%=pvo.getPd_name() %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ <%=pvo.getPd_price() %></li>
			                        
			                        
			                    <%  discountVo disvo = disDao.selectDiscount(pvo.getPd_id());     
			                    	cgVo cgvo = cgdao.getGradeInfo(cvo.getCo_grade());
			                        int sale_price = 0;
			                        int mileage = 0;
			                        double mileage_rate = 0;
			                        if(disvo.getDis_method()==1){
				                        sale_price = pvo.getPd_price()-disvo.getDis_value();
			                        }
			                        else{
			                        	sale_price = pvo.getPd_price()-(pvo.getPd_price()*disvo.getDis_rate()/100);
			                        }
			                        
			                        mileage_rate = Double.parseDouble(cgvo.getCg_mil_rate()) / 100;
			                        mileage = (int)Math.floor(sale_price * mileage_rate /10) * 10;
			                    %>
			                        
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 할인가 : ￦  <%=sale_price %></li>
			                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 : ￦ <%=mileage %>
			                        (<%=cgvo.getCg_mil_rate() %>%)
			                        </li>
			                      </ul>
			                    </div>
					          </div>
					        </div>
					      </div>
					      <%} %>
                        
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
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
    

  </body>
</html>