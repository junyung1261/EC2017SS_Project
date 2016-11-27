<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String order_id = (String)request.getParameter("oid");
	String company_id = (String)request.getParameter("cid");
	
	// 정산제외 (교환승인, 환불승인)의 경우 무조건 정산금액이 0원이어야 하므로, 그 상태를 order_id로 vo.getOrderState()해와서, 아래 form에 if먹여야함//
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Bootstrap -->
    <link href="../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../vendors/nprogress/nprogress.css" rel="stylesheet">
    <!-- Custom Theme Style -->
    <link href="../build/css/custom.min.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- iCheck -->
    <link href="../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
  </head>

  <body class="" style="overflow-x:hidden; overflow-y:hidden">
    <div class="container body">
      <div class="main_container">
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="row">
              <div class="col-md-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>정산 처리 - <%=company_id %></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                  <form class="form-horizontal form-label-left">
                    <div class="form-group">
                      <label class="control-label col-md-12 col-sm-12 col-xs-12">
                      <button type="button" class="btn btn-warning btn-xs">정산완료</button>버튼을 누르면</label>
                      <label class="control-label col-md-12 col-sm-12 col-xs-12">협력업체의 상품 판매에 대한 정산을 완료합니다.</label>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">주문 번호</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" value="<%=order_id %>" readonly>
                      </div> 
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">전용은행</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
	                    <select id="delivery_com" name="delivery_com" class="select2_single form-control" tabindex="1">
	                      <option></option>
                          <option value="nh">농협은행</option>
                          <option value="sh" selected>신한은행</option>
                          <option value="keb">기업은행</option>
                          <option value="wr">우리은행</option>
                        </select>
                      </div>
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">계좌 번호</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control">
                      </div> 
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">정산금액 (A=B-C)</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" readonly>
                      </div> 
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">총 주문금액 (B)</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" readonly>
                      </div> 
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">판매자 제공 마일리지 (C)</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" class="form-control" readonly>
                      </div> 
                    </div>
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-12 col-sm-12 col-xs-12" >
                        <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
                        <input type="button" class="btn btn-warning pull-right" value="정산완료">
                      </div>
                    </div>
	              </form>
		          </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->

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
    <!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- iCheck -->
    <script src="../vendors/iCheck/icheck.min.js"></script>
	<!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "항목을 선택하세요.",
          allowClear: true
        });
      });
    </script>
    <!-- /Select2 -->
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
   
  </body>
</html>