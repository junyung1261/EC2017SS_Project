<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String order_id = (String)request.getParameter("oid");
	System.out.println(order_id);
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
                    <h2>업체정보조회 </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
			          <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
			            <li role="presentation" class="active"><a href="#order_content1" id="base-tab" role="tab" data-toggle="tab" aria-expanded="true">기본정보</a></li>
			           </ul>
			          <div id="myTabContent2" class="tab-content">
			            <div role="tabpanel" class="tab-pane fade active in" id="order_content1" aria-labelledby="base-tab">
		                  <form class="form-horizontal form-label-left">
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">업체 ID</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" value=""readonly>
		                      </div> 
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">업체명</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">대표자</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">담당자 연락처</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">사업장 연락처</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">사업장 FAX</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">사업장 소재지</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">E-mail</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">주거래 배송사</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">업체 등급</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div> 
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">최초계약일</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div>
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">계약만료일</label>
		                      <div class="col-md-4 col-sm-4 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div>  
		                    </div>
		                    <div class="ln_solid"></div>
		                    <div class="form-group">
		                      <div class="col-md-12 col-sm-12 col-xs-12" >
		                        <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
		                      </div>
		                    </div>
		                  </form>
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

    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
   
  </body>
</html>