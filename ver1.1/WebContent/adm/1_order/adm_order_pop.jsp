<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
<%@ page import = "ec.member.*, ec.member_address.*" %>
  
<%@ page import = "ec.company.*" %>
<%@ page import = "ec.order.*, ec.order_detail.*" %>
<%@ page import = "ec.product.*, ec.product_detail.*" %>
<%@ page import = "ec.convert.*" %>
<%@ page import = "java.util.*" %>
<%   request.setCharacterEncoding("EUC-kr");

	String loginId = (String)session.getAttribute("loginId");
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(loginId);
   
	long or_id = Long.parseLong(request.getParameter("oid"));
    oddDao oddao = new oddDao();
	ArrayList<oddVo> orderList = new ArrayList<oddVo>();
	orderList = oddao.orderPopList(or_id);
	
	productDao pdao = new productDao();
	product_detailDao pddao = new product_detailDao();
	
	companyDao cdao = new companyDao();
	convertDao cvdao = new convertDao();
	
	/// 배송정보 및 결제금액을 위한 객체생성 ////
	orderDao odao = new orderDao();
	orderVo ovo = odao.getOrderInfo(or_id); 
%>    
<!DOCTYPE html>
<html lang="en" >
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>주문정보조회</title>
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
    
	<Style>
	html{
	overflow-x: hidden;
	}
	</Style>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="row">
          <div class="col-sm-12 col-md-12 col-xs-12">
            <div class="x_panel">
              <div class="x_content col-md-12">
                <div class="col-sm-12 col-md-12 col-xs-12">
                <!-- start project list -->
                <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">주문상품정보 :: <%=or_id %></p>
                
                
                <table class="table table-striped projects">
                  <thead>
                    <tr>
                      <th colspan="2">번호</th>
                      <th>상품명</th>
                      <th>색상</th>
                      <th>사이즈</th>
                      <th>수량</th>
                      <th>상품가격</th>
                      <th>마일리지</th>
                    </tr>
                  </thead>
                  <tbody>
                <%	for(oddVo odvo : orderList){ 
                	productVo pvo = pdao.getProductInfo(odvo.getPd_id());
                	product_detailVo pddvo = pddao.selectByPdd_id(odvo.getPdd_id());
                	companyVo cvo = cdao.getCompanyInfo(pvo.getPd_co_id());
                %>
                    <tr>
                      <td><%=odvo.getPd_id() %></td>
                      <td><ul class="list-inline"><li><img src="<%=pvo.getPd_main_img() %>" class="avatar" alt="Avatar"></li></ul></td>
                      <td><a>[ <%=cvo.getCo_name() %> ] <%=pvo.getPd_name() %></a><br /><small>주문일자 : <%=ovo.getOr_account_time() %></small></td>
                      <td><%=pddvo.getCol_id()%></td>
                      <td><%=pddvo.getSz_id() %></td>
                      <td><%=odvo.getOrd_count() %></td>
                      <td><%=cvdao.commify(odvo.getOrd_price()-odvo.getOrd_discount()) %><br /><small>( <%=cvdao.commify(odvo.getOrd_price()) %>  )</small></td>
                      <td><%=cvdao.commify(odvo.getOrd_use_mileage())%></td>
                    </tr>
                <%} %>    
                  </tbody>
                </table>
                
              </div> 
              <div class="col-xs-6">
                <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">배송정보</p>
                <div class="table-responsive">
                  <table class="table">
                    <tbody>
                      <tr>
                        <th style="width:30%">수령인명</th>
                        <td><%=ovo.getMem_name() %></td>
                      </tr>
                      <tr>
                        <th>우편번호</th>
                        <td><%=ovo.getMem_zipcode() %></td>
                      </tr>
                      <tr>
                        <th>주소</th>
                        <td><%=ovo.getMem_address() %></td>
                      </tr>
                      <tr>
                        <th>연락처</th>
                        <td><%=ovo.getMem_phone() %></td>
                      </tr>
                      <tr>
                        <th>요청사항 </th>
                        <td></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="col-xs-6">
                <p class="text-muted well well-sm no-shadow" style="margin-top: 10px;">결제금액</p>
                <div class="table-responsive">
                  <table class="table">
                    <tbody>
                      <tr>
                        <th style="width:50%">상품가격 (A)</th>
                        <td><%=cvdao.commify(ovo.getOr_total_price()) %></td>
                      </tr>
                      <tr>
                        <th>할인금액 (B)</th>
                        <td><%=cvdao.commify(ovo.getOr_total_discount()) %></td>
                      </tr>
                      <tr>
                        <th>배송비 (C)</th>
                        <td><%=cvdao.commify(ovo.getOr_total_delivery_price()) %></td>
                      </tr>
                      <tr>
                        <th>마일리지 사용 (D)</th>
                        <td><%=cvdao.commify(ovo.getOr_total_mileage()) %></td>
                      </tr>
                      <tr>
                        <th>총 결제금액 (A-B+C-D)</th>
                        <td><%=cvdao.commify(ovo.getOr_account_value()) %></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            </div>
          </div>
        </div>
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