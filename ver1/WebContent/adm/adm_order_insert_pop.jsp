<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%	
	request.setCharacterEncoding("euc-kr"); 
	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	int product_id = Integer.parseInt((String)request.getParameter("pid"));
	
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(product_id);
	
	product_detailDao pddao = new product_detailDao();
	ArrayList<product_detailVo> availableColorList = pddao.getProductColor(product_id);
	ArrayList<product_detailVo> availableSizeList = pddao.getProductSize(product_id);
	int availableStock = 0;
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
	<!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
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
                    <h2>상품주문 </h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                  <form action="adm_order_count_pop.jsp" method="post" class="form-horizontal form-label-left">
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">상품번호</label>
                      <div class="col-md-4 col-sm-4 col-xs-12">
                        <input type="text" name="pd_id" class="form-control" value="<%=pvo.getPd_id()%>"readonly>
                      </div>
                    </div>
                    <div class="form-group">   
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">상품명</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input type="text" name="pd_name" class="form-control" value="<%=pvo.getPd_name()%>" readonly>
                      </div> 
                    </div>
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">상품옵션</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <select name="opt" class="select2_multiple form-control" multiple="multiple" required = "required">
                          <option></option>
                          <%for(product_detailVo pdvo1 : availableColorList){ %>
                          <optgroup label="<%=pdvo1.getCol_id()%>">
                         	<%for(product_detailVo pdvo2 : availableSizeList){ 
                         	availableStock = pddao.getProductStock(pvo.getPd_id(),pdvo1.getCol_id(),pdvo2.getSz_id());%>
                          <option value="<%=pdvo1.getCol_id()%>,<%=pdvo2.getSz_id()%>,<%=availableStock %>"><%=pdvo1.getCol_id() %>[<%=pdvo2.getSz_id() %>][재고수량:<%=availableStock %>개]</option>
                         <%} %>
                         </optgroup>
                         <%} %>
                        </select>
                      </div>
                    </div> 
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-12 col-sm-12 col-xs-12" >
                        <input type="submit" class="btn btn-primary pull-right" value="다음단계로">
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
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
   
   <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "항목을 선택하세요",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 6,
          placeholder: "항목을 선택하세요",
          allowClear: true
        });
      });
    </script>
    <!-- /Select2 -->
  </body>
</html>