<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.product.*,ec.product_detail.*" %>
<%@ page import="ec.order.*" %>
<%@ page import="ec.color.*" %>
<%@ page import="ec.member.*" %>
<%	
	request.setCharacterEncoding("euc-kr"); 
	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	int pd_id = Integer.parseInt((String)request.getParameter("pid"));
	
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(1);
	
	
	productDao pdao = new productDao();	
	productVo pvo = pdao.getProductInfo(pd_id);
	product_detailDao pddao = new product_detailDao();
	
	
	ArrayList<product_detailVo> col_list = pddao.getProductColor(pd_id);
	ArrayList<product_detailVo> size_list = new ArrayList<product_detailVo>();
	
	
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
                  <form name="form_order_insert"  class="form-horizontal form-label-left">
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
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">색상</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <select id="opt_col" name="opt_col" class="select2_single form-control" onchange="changes()" required = "required">
                          <option></option>
                          <%for(product_detailVo pdvo1 : col_list){ %>
                         
                          <option value="<%=pdvo1.getCol_id()%>"><%=pdvo1.getCol_id()%></option>
                         <%} %>
                        
                        </select>
                      </div>
                    </div> 
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">사이즈</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <select id="opt_size" name="opt_size" class="select2_single form-control"  required = "required">
                          <option></option>
                        </select>
                      </div>
                    </div> 
                    
                    <div class="form-group">
                      <label class="control-label col-md-2 col-sm-2 col-xs-12">수량</label>
                      <div class="col-md-10 col-sm-10 col-xs-12">
                        <input name="opt_count" class="form-control" required = "required">
                          
                         
                      </div>
                    </div> 
                    <div class="ln_solid"></div>
                    <div class="form-group">
                      <div class="col-md-6 col-sm-12 col-xs-12" >
                       
                     <input type="button" class="btn btn-primary pull-right" value="바로구매" onClick="getPost('01')">
                     <input type="button" class="btn btn-primary pull-right" value="장바구니" onClick="getPost('02')">
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
    
    <script type="text/javascript">
    function changes(){
    	
    	var objSel = document.getElementById("opt_size");
    	
    		
    
    	
    	for(i=objSel.length; i>=0; i--){
    		objSel.options[i]=null;
    		
    	}

    	var sel = document.getElementById("opt_col").value;
    	
    	
    	<%
    	colorDao cdao = new colorDao();
    	ArrayList<colorVo> colorlist = new ArrayList<colorVo>();
    	colorlist = cdao.colorList();
    	
    	for(colorVo cvo : colorlist){%>
    		if(sel=="<%=cvo.getCol_name()%>"){
    		<%
    		size_list=pddao.getProductSize(pd_id, cvo.getCol_name());
			for(product_detailVo vo : size_list){%>
    		
    			var objOption = document.createElement("option");
    			objOption.text = "<%=vo.getSz_id()%>";
    			objOption.value = "<%=vo.getSz_id()%>";
    			objSel.options.add(objOption);
    		<%}%>
    		}
    	
    	<%}%>
    	
    }
    
    
    function getPost(mode){
    	var theForm = document.form_order_insert;
    	if(mode=="01"){
    		theForm.method ="post";
    		
    		theForm.action ="adm_order_account_pop.jsp";
    		
    	}
    	else if(mode=="02"){
    		
    		theForm.method ="post";
    		
    		theForm.action ="adm_cart_insert_proc.jsp";
    	}
    	
    	
    	theForm.submit();
    }
    
    </script>
  </body>
</html>