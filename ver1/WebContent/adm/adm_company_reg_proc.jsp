<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String company_id = (String)request.getParameter("cid");
	
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
                    <h2>계약정보조회 </h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
			          <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
			            <li role="presentation" class="active"><a href="#account_content1" id="base-tab" role="tab" data-toggle="tab" aria-expanded="true">기본정보</a></li>
			            <li role="presentation" class=""><a href="#account_content3" role="tab" id="history-tab" data-toggle="tab" aria-expanded="false">계약이력</a></li>
			          </ul>
			          
			          <div id="myTabContent2" class="tab-content">
			            <div role="tabpanel" class="tab-pane fade active in" id="account_content1" aria-labelledby="base-tab">
			              
		                  <form class="form-horizontal form-label-left">
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">업체 ID</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
		                        <input type="text" class="form-control" value="<%=company_id%>" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">업체명</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
		                        <input type="text" class="form-control" readonly>
		                      </div> 
		                    </div>
		                    <div class="ln_solid"></div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">계약상태</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
		                        <input type="text" class="form-control" value="서비스중" readonly>
		                      </div> 
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">담당자</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
		                        <input type="text" class="form-control" value="David Lee" readonly>
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
		                
		                <div role="tabpanel" class="tab-pane fade" id="account_content3" aria-labelledby="history-tab">
		                  <form class="form-horizontal form-label-left">
		                    <div class="form-group">
			                  <label class="control-label col-md-10 col-sm-10 col-xs-12"> 
			                  <button type="button" class="btn btn-danger btn-xs">최근 5건</button>의 계약 이력을 출력합니다.</label>
			                </div>
		                    <table class="table table-bordered">
		                      <thead>
		                        <tr>
		                          <th>일자</th>
		                          <th>계약내용</th>
		                          <th>서비스만료일</th>
		                          <th>서비스결제</th>
		                        </tr>
		                      </thead>
		                      <tbody>
		                        <tr>
		                          <td>2016-09-01</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >최초계약</button></td>
		                          <td>2016-09-30</td>
		                          <td><button type="button" class="btn btn-warning btn-xs">자동이체</button></td>
		                        </tr>
		                        <tr>
		                          <td>2016-09-30</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >계약연장</button></td>
		                          <td>2016-10-30</td>
		                          <td><button type="button" class="btn btn-warning btn-xs">자동이체</button></td>
		                        </tr>
		                        <tr>
		                          <td>2016-10-30</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >계약연장</button></td>
		                          <td>2016-11-30</td>
		                          <td></td> 
		                        </tr>
		                        <tr>
		                          <td>2016-10-30</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >계약연장</button></td>
		                          <td>2016-11-30</td>
		                          <td></td> 
		                        </tr>
		                        <tr>
		                          <td>2016-10-30</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >계약연장</button></td>
		                          <td>2016-11-30</td>
		                          <td></td> 
		                        </tr>
		                        <tr>
		                          <td>2016-10-30</td>
		                          <td><button type="button" class="btn btn-info btn-xs" >계약연장</button></td>
		                          <td>2016-11-30</td>
		                          <td></td> 
		                        </tr>
		                      </tbody>
		                    </table>
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