<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.convert.*" %>
<%@ page import="ec.product.*,ec.product_detail.*, ec.product_discount.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.company_grade.*" %>
<%@ page import="ec.product_discount.*" %>

<%	
	int pd_id = Integer.parseInt(request.getParameter("pid"));
	String co_id = (String)request.getParameter("cid");
	String uid = (String)session.getAttribute("loginId");
	
	dateDao ddao = new dateDao();
	String now = ddao.now();
	
	convertDao cvdao = new convertDao();
	
	productDao pdao = new productDao();
	productVo pvo = pdao.getProductInfo(pd_id);
	
	product_detailDao pddao = new product_detailDao();
	ArrayList<product_detailVo> colorList = new ArrayList<product_detailVo>(); 
	ArrayList<product_detailVo> sizeList = new ArrayList<product_detailVo>(); 
	colorList = pddao.getProductColor(pd_id);
	sizeList = pddao.getProductSize(pd_id);
	
	discountDao disdao = new discountDao();
	discountVo disvo = disdao.selectDiscount(pd_id);
	
	companyDao cdao = new companyDao();
	companyVo cvo = cdao.getCompanyInfo(co_id);
	
%>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
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
    <!-- iCheck -->
    <link href="../../vendors/iCheck/skins/flat/green.css" rel="stylesheet">
	<!-- Select2 -->
    <link href="../../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
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
              <div class="title_left">
                <h3>상품관리</h3>
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
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><%=cvo.getCo_name() %> 상품리스트<small><%=now+" 현재" %></small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
					<br/>
                    <div class="col-md-5 col-sm-5 col-xs-12">
                      <br/>
                      <div class="product-image" style="text-align:center;"><img src="<%=pvo.getPd_detail_main_img() %>" width="100%"/></div>
                    </div>
                    
                    <div class="col-md-7 col-sm-7 col-xs-12" style="border:0px solid #e5e5e5;">
                      <h3 class="prod_title">[ <%=pvo.getPd_id() %> ] <%=pvo.getPd_name() %></h3>
                      <p><%=pvo.getPd_summary() %></p>
                      <br />
                      <div class="row">
	                      <div class="col-md-6 col-sm-6 col-xs-12">
	                        <div class="product_price">
	                          <h1 class="price">
		                          <%
		                          int result_price = 0; // 할인율, 할인액 적용된 가격
		                          if(disvo.getDis_method()==0){ 
		                          	result_price = pvo.getPd_price()*(1-(disvo.getDis_rate()/100));
		                          %>
		                          	<%=cvdao.commify(result_price)  %>
		                          <%}else{ 
		                            result_price = pvo.getPd_price()-disvo.getDis_value();
		                          %>
		                          	<%=cvdao.commify(result_price) %>
		                          <%} %>
	                          </h1>
	                          <span class="price-tax">판매가 : <%=cvdao.commify(pvo.getPd_price()) %></span>
	                          <br>
	                        </div>
	                      </div>
	                  </div>
                      <br />
                      
                      <div class="row">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <h2>색상 선택</h2>
	                        <select id="col_id" name="col_id" class="select2_group form-control">
	                          <option>옵션을 선택하세요.</option>
		                      <%for(product_detailVo pddvo : colorList){ %>
		                      <option value="<%=pddvo.getCol_id() %>"><%=pddvo.getCol_id() %> </option>
		                      <%}%>
	                        </select>
	                      </div>
					  </div>
					  <br />
					  <div class="row">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <h2>사이즈 선택</h2>
	                        <select id="sz_id" name="sz_id" class="select2_group form-control" onChange="setOption(this);">
	                          <option>옵션을 선택하세요.</option>
		                      <%for(product_detailVo pddvo : sizeList){ %>
		                      <option value="<%=pddvo.getSz_id() %>"><%=pddvo.getSz_id() %> </option>
		                      <%}%>
	                        </select>
	                      </div>
	                      
                      </div>
                      <br />
                      
                      <form action="../1_order/adm_order_cart_proc.jsp" method="post">
                      <div class="row">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <h2>선택 옵션</h2>
	                        <input type="hidden" id="idx" name="idx" value="0">
		                    <div class="option_container"></div>
	                      </div>
	                  </div>
	                  <br/>

                      <div class="row">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <input type="hidden" name="co_id" value="<%=co_id %>">
                          <input type="hidden" name="pd_id" value="<%=pd_id %>">
                          <button type="button" class="btn btn-default btn-primary pull-right">바로 구매</button>
                          <input type="submit" class="btn btn-default btn-danger pull-right" value="장바구니 추가">
                          <a href="adm_product_insert_fav_proc.jsp?uid=<%=uid %>&pid=<%=pvo.getPd_id() %>&now=<%=now%>">
                            <button type="button" class="btn btn-default btn-warning pull-right">즐겨찾기 추가</button>
                          </a> 
                        </div> 
                      </div>
                      </form>
                    </div>
					

                    <div class="col-md-12">

                      <div class="" role="tabpanel" data-example-id="togglable-tabs">
                        <ul id="myTab" class="nav nav-tabs bar_tabs" role="tablist">
                          <li role="presentation" class="active"><a href="#tab_content1" id="home-tab" role="tab" data-toggle="tab" aria-expanded="true">상품 상세정보</a>
                          </li>
                          <li role="presentation" class=""><a href="#tab_content2" role="tab" id="profile-tab" data-toggle="tab" aria-expanded="false">상품 배송정보</a>
                          </li>
                          <li role="presentation" class=""><a href="#tab_content3" role="tab" id="profile-tab2" data-toggle="tab" aria-expanded="false">상품 구매후기</a>
                          </li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                          <div role="tabpanel" class="tab-pane fade active in" id="tab_content1" aria-labelledby="home-tab">
                            <p><img src="<%=pvo.getPd_detail_img()%>" width="100%"></p>
                          </div>
                          <div role="tabpanel" class="tab-pane fade" id="tab_content2" aria-labelledby="profile-tab">
                            <p>Food truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui photo
                              booth letterpress, commodo enim craft beer mlkshk aliquip</p>
                          </div>
                          <div role="tabpanel" class="tab-pane fade" id="tab_content3" aria-labelledby="profile-tab">
                            <p>xxFood truck fixie locavore, accusamus mcsweeney's marfa nulla single-origin coffee squid. Exercitation +1 labore velit, blog sartorial PBR leggings next level wes anderson artisan four loko farm-to-table craft beer twee. Qui
                              photo booth letterpress, commodo enim craft beer mlkshk </p>
                          </div>
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
	<!-- Select2 -->
    <script src="../../vendors/select2/dist/js/select2.full.min.js"></script>
     <!-- jQuery Tags Input -->
    <script src="../../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    
    <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "Select a state",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 3,
          placeholder: "항목을 선택하세요",
          allowClear: true
        });
      });
    </script>
    <!-- /Select2 -->
     <!-- jQuery Tags Input -->
    <script>
      function onAddTag(tag) {
        alert("Added a tag: " + tag);
      }

      function onRemoveTag(tag) {
        alert("Removed a tag: " + tag);
      }

      function onChangeTag(input, tag) {
        alert("Changed a tag: " + tag);
      }

      $(document).ready(function() {
        $('#options').tagsInput({
          width: 'auto'
        });
      });
    </script>
    <!-- /jQuery Tags Input -->
    <!-- setOption -->
    <script>
      function setOption(o){ 
    	var target = document.getElementById("idx");
    	var idx = parseInt(target.value);
    	
        var color = document.getElementById("col_id").value;
        var size = o.options[o.selectedIndex].value
	    var btn = 
        "<div class='btn-group'style='padding-bottom:10px;'>"+
        "<button class='btn btn-default' type='button'><%=pvo.getPd_name()%>  "+color+" "+size+"</button></div>&nbsp;&nbsp;&nbsp;"+
        "<div class='btn-group'style='padding-bottom:10px;'>"+
        "<input type='hidden' id='opt_color' name='opt_color' value='"+color+"'>"+
	    "<input type='hidden' id='opt_size' name='opt_size' value='"+size+"'>"+
	    "<input type='hidden' id='opt_count' name='opt_count' value='1'>"+
	    "<input type='button' id='plus' name='plus' class='btn btn-default' value='+' onClick='plusF("+idx+")'>"+
	    "<input type='button' class='btn btn-default' id='count' name='count' value='1'>"+
        "<input type='button' class='btn btn-default' id='minus' name='minus' value='-' onClick='minusF("+idx+")'>"+
        "</div>&nbsp;&nbsp;&nbsp;"+
        "<div class='btn-group'style='padding-bottom:10px;'>"+
        "<input type='button' class='btn btn-default' value='￦'>"+
        "<input type='button' class='btn btn-default' id='price' name='price' value='<%=result_price%>'>"+
        "</div><br/>";
     
        
        if(parseInt(target.value)==0){
        	$(".option_container").append(btn);
            target.value = parseInt(target.value) + 1;
        }
        else{
        	var exist_color = document.getElementsByName('opt_color');
        	var exist_size = document.getElementsByName('opt_size');
        	
        	var flag = 0;
       	  	for(var i=0;i<exist_color.length;i++){
       			if(exist_color[i].value==color && exist_size[i].value==size){
       				flag++;
       				plusF(i);
       			}
       	  	}
       	  	if(flag==0){
       	  		$(".option_container").append(btn);
            	target.value = parseInt(target.value) + 1;
       	  	}
        }
      }

      function plusF(idx){
    	  
    	  var target_count = document.getElementsByName('count')[idx];
    	  var target_opt_count = document.getElementsByName('opt_count')[idx];
    	  var target_price = document.getElementsByName('price')[idx];
    	  
    	  target_count.value = parseInt(target_count.value) + 1;
    	  target_opt_count.value = target_count.value;
    	  target_price.value = parseInt(target_count.value) * <%=result_price%>;
      }
      
      function minusF(idx){
    	  alert("진입");
    	  var target_count = document.getElementsByName('count')[idx];
    	  var target_opt_count = document.getElementsByName('opt_count')[idx];
    	  var target_price = document.getElementsByName('price')[idx];
    	  if(parseInt(target_count.value) == 1){
    	  	target_count.value = 1;
    	  }
    	  else{
    		  target_count.value = parseInt(target_count.value) - 1;  
    	  }
    	  target_opt_count.value = target_count.value;
    	  target_price.value = parseInt(target_count.value) * <%=result_price%>;
      }
      

     
      
      </script>
  </body>
</html>