<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*" %>
<%@ page import="ec.product_detail.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.discount.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.mileage.*" %>

<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	
	String co_id = (String)request.getParameter("co");
	
	productDao pdao = new productDao();
	ArrayList<productVo> productList = new ArrayList<productVo>();
	productList = pdao.productList(2, co_id);
	
	companyDao cdao = new companyDao();
	companyVo cvo = cdao.getCompanyInfo(co_id);
	
	product_detailDao pddao = new product_detailDao();
	ArrayList<product_detailVo> product_detailList = new ArrayList<product_detailVo>();

	discountDao disDao = new discountDao();
	deliveryDao deDao = new deliveryDao();
	mileageDao milDao = new mileageDao();
	
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>EC Corporation </title>

    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">

    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view"><%@include file="adm_sidebar.jsp" %></div>
        </div>
        <%@include file = "adm_top.jsp" %>

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
                    <h2><%=cvo.getCo_name() %> 상품리스트<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
                    <ul class="nav navbar-right panel_toolbox">
                      <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                      </li>
                      <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                        <ul class="dropdown-menu" role="menu">
                          <li><a href="#">Settings 1</a>
                          </li>
                          <li><a href="#">Settings 2</a>
                          </li>
                        </ul>
                      </li>
                      <li><a class="close-link"><i class="fa fa-close"></i></a>
                      </li>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
                      <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                        <li role="presentation" class="active"><a href="#tab_content0" id="total-tab" role="tab" data-toggle="tab" aria-expanded="true">전체</a></li>
                        <li role="presentation" class=""><a href="#tab_content1" id="top-tab" role="tab" data-toggle="tab" aria-expanded="true">상의</a></li>
                        <li role="presentation" class=""><a href="#tab_content2" role="tab" id="bottom-tab" data-toggle="tab" aria-expanded="false">하의</a></li>
                        <li role="presentation" class=""><a href="#tab_content3" role="tab" id="acc-tab2" data-toggle="tab" aria-expanded="false">악세서리</a></li>
                      </ul>
                      <div id="myTabContent" class="tab-content">
                        <div role="tabpanel" class="tab-pane fade active in" id="tab_content0" aria-labelledby="total-tab">
                          <%for(productVo pvo : productList){ %>
                          <div class="col-md-2 col-sm-2 col-xs-2">
			               <div class="x_panel">
			                  <div class="x_title"><h2>상품정보조회 </h2><div class="clearfix"></div></div>
			                  <div class="x_content">
			                    <br />
			                    <div class="col-md-12 col-sm-12 col-xs-12 profile_left">
			                      <div class="profile_img">
			                        <div id="crop-avatar">
			                          <img class="img-responsive avatar-view" src="../images/picture.jpg" alt="Avatar" title="Change the avatar">
			                        </div>
			                      </div>
			                      <br />
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-info-circle user-profile-icon"></i> 상품번호 : <%=pvo.getPd_id() %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data">
			                        <li><i class="fa fa-gift user-profile-icon"></i> 상품명 : <%=pvo.getPd_name() %></li>
			                        <li><i class="fa fa-spinner user-profile-icon"></i> 색상 : 
			                        <%
			                    	product_detailList = pddao.getProductColor(0, pvo.getPd_id());
			                        for(product_detailVo pdvo : product_detailList){ %>
			                        <%=pdvo.getCol_id()%><%} %></li>
			                        <li><i class="fa fa-user user-profile-icon"></i> 사이즈 : 
			                        <%
			                    	product_detailList = pddao.getProductSize(0, pvo.getPd_id());
			                        for(product_detailVo pdvo : product_detailList){ %>
			                        <%=pdvo.getSz_id()%><%} %></li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 판매가 : ￦ <%=pvo.getPd_price() %></li>
			                        <li><i class="fa fa-shopping-cart user-profile-icon"></i> 할인가 : ￦ 
			                    <%  discountVo disvo = disDao.selectDiscount(pvo.getPd_id());     
			                        if(disvo.getDis_method()==1){%><%=pvo.getPd_price()-disvo.getDis_value() %>(￦ <%=disvo.getDis_value() %>)<%} 
			                        else{%><%=pvo.getPd_price()-(pvo.getPd_price()*disvo.getDis_rate()/100) %>
			                        (<%=disvo.getDis_rate() %>% <i class="fa fa-arrow-down user-profile-icon"></i>)	
			                        <%} %>
			                        
			                        </li>
			                    <%	deliveryVo devo = deDao.selectDelivery(pvo.getPd_id()); 
			                        if(devo.getDe_method()==0){ %> 
			                        <li><i class="fa fa-truck user-profile-icon"></i> 배송비 : ￦ <%=devo.getDe_price() %></li>
			                        <li><i class="fa fa-truck user-profile-icon"></i> 도서/산간 : ￦ <%=devo.getDe_price_exception() %></li> 
			                       <%}else if(devo.getDe_method()==1){%>
			                       <li><i class="fa fa-truck user-profile-icon"></i> 배송비 : 무료배송</li>
			                       <%}else{%>
			                        <li><i class="fa fa-truck user-profile-icon"></i> 배송비 : ￦ <%=devo.getDe_price() %></li>
			                        <li><i class="fa fa-truck user-profile-icon"></i> 도서/산간 : ￦ <%=devo.getDe_price_exception() %></li>
			                        <li><i class="fa fa-truck user-profile-icon"></i> 조건부 무료 : ￦ <%=devo.getDe_price_condition()%>
			                        	<i class="fa fa-arrow-up user-profile-icon"></i></li>
			                        <%} %>
			                        
								<%	mileageVo milvo = milDao.selectMileage(pvo.getPd_id()); %>
			                        <li><i class="fa fa-credit-card user-profile-icon"></i> 마일리지 : ￦ <%=pvo.getPd_price()*milvo.getMil_rate()/100 %>
			                        (<%=milvo.getMil_rate() %>%)
			                        </li>
			                      </ul><div class="ln_solid"></div>
			                      <ul class="list-unstyled user_data"> 
			                        <li><i class="fa fa-bar-chart user-profile-icon"></i> 평균평점 : 
			                            <div class="starrr stars-existing" data-rating='4'></div></li>
			                        <li><i class="fa fa-bar-chart user-profile-icon"></i> 평균배송일 : 
			                            <div class="starrr stars-existing" data-rating='4'></div></li> 
			                      </ul>
			                      <br />
			                    </div>
					          </div>
					        </div>
					      </div>
					      <%} %>
					      
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content1" aria-labelledby="top-tab">
                        
                        
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="bottom-tab">
                        
                        
                        </div>
                        <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="acc-tab">
                        
                        
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
        <%@include file = "adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
    </div>

    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
	<!-- bootstrap-progressbar -->
    <script src="../vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
  </body>
</html>