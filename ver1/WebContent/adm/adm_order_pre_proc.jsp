<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ec.date.*" %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String order_id = (String)request.getParameter("oid");
	int order_deivery_method = Integer.parseInt((String)request.getParameter("odm"));
	//odm = 0 ; �ù� 
	//odm = 1 ; �湮����
	String delivery_com = (String)request.getParameter("dc");
	//0 = ��������ù��� ����
	//order_delivery_method �� selectOrder(oid) ����, vo.getOrderDeliveryMethod ���� ���������� �ؾ���.
	//delivery_com �� oid -cid ���̺��� cid���� �� cid�� �ְŷ���ۻ縦 �����;���.
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
                    <h2>����غ� ó�� </h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <div class="" role="tabpanel" data-example-id="togglable-tabs">
			          <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
			            <li role="presentation" class="active"><a href="#order_content1" id="base-tab" role="tab" data-toggle="tab" aria-expanded="true">�߼�ó��</a></li>
			            <li role="presentation" class=""><a href="#order_content3" role="tab" id="delivery-tab" data-toggle="tab" aria-expanded="false">�ֹ����</a></li>
			          </ul>
			          
			          <div id="myTabContent2" class="tab-content">
			            <div role="tabpanel" class="tab-pane fade active in" id="order_content1" aria-labelledby="base-tab">
			              <%if(order_deivery_method==0){ %>
		                  <form class="form-horizontal form-label-left">
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">��� ��ü</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
			                    <select id="delivery_com" name="delivery_com" class="select2_single form-control" tabindex="1">
			                      <option></option>
		                          <option value="hd">�����ù�</option>
		                          <option value="dh" selected>��������ù�</option>
		                          <option value="hj">�����ù�</option>
		                          <option value="lg">�����ù�</option>
		                        </select>
		                      </div>
		                    </div>
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">���� ��ȣ</label>
		                      <div class="col-md-10 col-sm-10 col-xs-12">
		                        <input type="text" class="form-control">
		                      </div> 
		                    </div>
		                    <div class="ln_solid"></div>
		                    <div class="form-group">
		                      <div class="col-md-12 col-sm-12 col-xs-12" >
		                        <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
		                        <input type="button" class="btn btn-warning pull-right" value="�߼�ó��">
		                      </div>
		                    </div>
			              </form>
			              <%}else{ %>
			              <form class="form-horizontal form-label-left">
			                <div class="form-group">
			                  <label class="control-label col-md-10 col-sm-10 col-xs-12">
			                  <button type="button" class="btn btn-success btn-xs">�湮����</button> �ֹ� ���Դϴ�.</label>
			                </div>
			                <div class="form-group">
			                  <label class="control-label col-md-10 col-sm-10 col-xs-12">��ǰ ���� �� 
			                  <button type="button" class="btn btn-warning btn-xs">����Ȯ��/��������</button> ��ư�� �����ø�</label>
			                </div>  
			                <div class="form-group">
			                  <label class="control-label col-md-10 col-sm-10 col-xs-12">�ֹ� ó���� �Ϸ�˴ϴ�.</label> 
			                </div>
			                <div class="ln_solid"></div>
			                <div class="form-group">
			                  <div class="col-md-12 col-sm-12 col-xs-12" >
			                    <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
			                    <input type="button" class="btn btn-warning pull-right" value="����Ȯ��/��������">
			                  </div>
			                </div>
			              </form>
			              <%} %>
		                </div>
		                
		                <div role="tabpanel" class="tab-pane fade" id="order_content3" aria-labelledby="delivery-tab">
		                  <form class="form-horizontal form-label-left">
		                    <div class="form-group">
		                      <label class="control-label col-md-2 col-sm-2 col-xs-12">
		                      <button type="button" class="btn btn-danger btn-xs">�ֹ����</button>�� ������ �ش� �ֹ��� ����մϴ�.</label>
		                    </div>
		                    <div class="form-group">
		                      <div class="col-md-10 col-sm-10 col-xs-12">
			                     <label><input type="radio" class="flat" checked name="iCheck"> ��ǰǰ��</label>
		                      </div>
		                    </div>
		                    <div class="form-group">
		                      <div class="col-md-10 col-sm-10 col-xs-12">
			                     <label><input type="radio" class="flat" checked name="iCheck"> �ɼǺ���</label>
		                      </div>
		                    </div>
		                    <div class="form-group">  
		                      <div class="col-md-10 col-sm-10 col-xs-12">
			                     <label><input type="radio" class="flat" checked name="iCheck"> ��Ÿ����</label>
		                      </div>
		                    </div>
		                    
		                    <div class="ln_solid"></div>
		                    <div class="form-group">
		                      <div class="col-md-12 col-sm-12 col-xs-12" >
		                        <input type="button" class="btn btn-primary pull-right" value="Close" onClick="javascript:window.close();">
		                        <input type="button" class="btn btn-danger pull-right" value="�ֹ����">
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
          placeholder: "�׸��� �����ϼ���.",
          allowClear: true
        });
      });
    </script>
    <!-- /Select2 -->
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
   
  </body>
</html>