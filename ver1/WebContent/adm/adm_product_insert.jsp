<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.product.*" %>
<%@ page import="ec.discount.*" %>
<%@ page import="ec.delivery.*" %>
<%@ page import="ec.color.*" %>
<%@ page import="ec.size.*" %>
<%@ page import="ec.category_product.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
	String today = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear();
	
	companyDao codao = new companyDao();
	ArrayList<companyVo> companyList = new ArrayList<companyVo>();
	companyList = codao.companyList();
	
	/*색상 리스트*/
	colorDao  coldao = new colorDao();
	ArrayList<colorVo> colorList = new ArrayList<colorVo>();
	colorList = coldao.colorList();
	
	/*Size 리스트*/
	sizeDao szdao = new sizeDao();
	ArrayList<sizeVo> sizeList = new ArrayList<sizeVo>();
	sizeList = szdao.sizeList();
	
	/*대분류 리스트*/
	category_productDao cgpDao = new category_productDao();
	ArrayList<String> cat1_list = new ArrayList<String>();
	cat1_list = cgpDao.getCgpCat1();
	
	/*중,소분류 리스트*/
	ArrayList<category_productVo> cat2_cat3_list = new ArrayList<category_productVo>();
	
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
    <!-- bootstrap-daterangepicker -->
    <link href="../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
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
              <div class="title_left"><h3>상품관리 <small>EC Corporation의 상품 정보를 표시합니다.</small></h3></div>
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
                    <h2>상품 개별등록<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
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
                    <br />
                    <form id="productInfo" name="productInfo" method="post" action="adm_product_insert_proc.jsp" data-parsley-validate class="form-horizontal form-label-left">
                    <div class="row">
                      <div class="col-md-12">
                        <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">업체선택<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="co_id" name="co_id" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option>
	                          <%for(companyVo cvo : companyList){ %>
	                          <option value="<%=cvo.getCo_id()%>"><%=cvo.getCo_name() %></option>
	                          <%} %>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">제품명 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_name" name="pd_name" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">판매상태<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="pd_status" name="pd_status" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option>
	                          <option value="0">판매대기</option>
	                          <option value="1">판매중</option>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">간략설명 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_summary" name="pd_summary" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="row">
	                  <div class="col-md-12">
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">대표이미지 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_main_img" name="pd_main_img" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">상세이미지 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_detail_img" name="pd_detail_img" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">등록일자 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_reg_date" name="pd_reg_date" class="form-control col-md-12 col-xs-12" value="<%=today %>" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">최종업데이트 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_modify_date" name="pd_modify_date" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                 </div>
	               </div>
	               <div class="ln_solid"></div>
	               <div class="row"> 
	                 <div class="col-md-12">
	                   <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">대분류<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="cgp_cat1" name="cgp_cat1" onchange = "changes()" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">            
	                          <option></option>
	                          <%for(String c1_list : cat1_list){ %>
	                          <option value="<%=c1_list%>"><%=c1_list%></option>
	                          <%} %>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">중/소분류<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="cgp_id" name="cgp_id" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option> 
	                        </select>
	                      </div>
	                    </div>
	                   <div class="form-group">
	                     <label class="control-label col-md-2 col-sm-2 col-xs-12">사이즈옵션</label>
                         <div class="col-md-4 col-sm-4 col-xs-12">
                           <select class="select2_multiple form-control" id="sz_id" name="sz_id" multiple="multiple">
                             <%for(sizeVo svo : sizeList){ %>
                             <option value="<%=svo.getSz_size()%>"><%=svo.getSz_size()%></option>
                             <%} %>
                           </select>
                         </div>
	                   </div>
	                   <div class="form-group">
	                     <label class="control-label col-md-2 col-sm-2 col-xs-12">색상옵션</label>
                         <div class="col-md-4 col-sm-4 col-xs-12">
                           <select class="select2_multiple form-control" id="col_id" name="col_id" multiple="multiple">
                             <%for(colorVo cvo : colorList){ %>
                             <option value="<%=cvo.getCol_name()%>"><%=cvo.getCol_name()%> (<%=cvo.getCol_eng()+", "+cvo.getCol_eng_short() %>)</option>
                             <%} %>
                           </select>
                         </div>
	                   </div>
	                   <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">옵션 별 기본수량 </label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="stk_count" name="stk_count" class="form-control col-md-12 col-xs-12" value="0">
	                      </div>
	                    </div>
	                   <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">등록일자 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_reg_date" name="pd_reg_date" class="form-control col-md-12 col-xs-12" value="<%=today %>" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12">키워드<span class="required">*</span></label>
	                        <div class="col-md-4 col-sm-4 col-xs-12">
	                          <input type="text" id="pd_keyword" name="pd_keyword" class="tags form-control" value="여성복, 스커트, 청바지" />
	                          <div id="suggestions-container" style="position: relative; float: left; width: 250px; margin: 10px;"></div>
	                        </div>
                        </div>
                      </div> 
                    </div>
                   <div class="ln_solid"></div>
	               <div class="row"> 
	                 <div class="col-md-12">     
	                 	<div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name"  >기본판매가 (￦)<span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                        <input type="text" id="pd_price" name="pd_price" required="required" class="form-control col-md-12 col-xs-12" placeholder="수치만 기입">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">할인여부 <span class="required">*</span></label>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                      	<div class="radio">
	                      	<label><input type="radio" value="0" id="dis" name="dis" onclick = 'dis_radio(this)' checked>미할인&nbsp;&nbsp;</label>
                            <label><input type="radio" value="1" id="dis" name="dis" onclick = 'dis_radio(this)'>할인</label>
                          	</div>
                          </div>
	                    </div>
	                    <div id = dis_div1 class="form-group" style="display:none">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12"> 할인방법<span class="required">*</span></label>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                      	<div class="radio">
	                      	<label><input type="radio" value="0" id="dis_method" name="dis_method" onclick = 'dis_method_radio(this)' checked>정률&nbsp;&nbsp;&nbsp;</label>
                            <label><input type="radio" value="1" id="dis_method" name="dis_method" onclick = 'dis_method_radio(this)' >정액&nbsp;&nbsp;</label>
                          	</div>
                          </div>
	                    </div>
	                    <div id = dis_div2 class="form-group" style="display:none">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">할인금액(￦)<span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                        <input type="text" id="dis_value" name="dis_value" class="form-control col-md-12 col-xs-12" value="0"  >
	                      </div>
	                    </div>
	                    <div id = dis_div3 class="form-group" style="display:none">  
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">할인비율(%)<span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                        <input type="text" id="dis_rate" name="dis_rate" class="form-control col-md-12 col-xs-12" value="0" >
	                      </div>
	                    </div>
	                    <div class="form-group">  
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">마일리지<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <div class="radio">
	                      	<label><input type="radio" value="0" id="mil" name="mil" onclick = 'mil_radio(this)' checked>미제공&nbsp;&nbsp;</label>
                            <label><input type="radio" value="1" id="mil" name="mil" onclick = 'mil_radio(this)' >제공&nbsp;&nbsp;</label>
                          	</div>
	                      </div>
	                    </div>
	                    <div id = "mil_div1" class="form-group" style="display:none">  
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">적립비율(%)<span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                        <input type="text" id="mil_rate" name="mil_rate" class="form-control col-md-12 col-xs-12" value="0" >
	                      </div>
	                    </div>
	                 </div>
	               </div>
	               <div class="ln_solid"></div>
	                 <div class="row">
	                 	<div class="col-md-12"> 
	                 	  <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">배송방법 <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                      	<div class="radio">
	                      	<label><input type="radio" value="0" id="de_method" name="de_method" onclick='de_radio(this)' checked>&nbsp;기본배송비&nbsp;&nbsp;&nbsp;</label>
                            <label><input type="radio" value="1" id="de_method" name="de_method" onclick='de_radio(this)'>&nbsp;무료배송&nbsp;</label>
                            <label><input type="radio" value="2" id="de_method" name="de_method" onclick='de_radio(this)'>&nbsp;조건부 무료배송&nbsp;</label>
                          	</div>
                          </div>
                          </div>
                          <div id="de_div1" class="form-group">
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">기본배송비</label>
	                        <div class="col-md-1 col-sm-1 col-xs-12">
	                          <input type="text" id="de_price" name="de_price" class="form-control col-md-12 col-xs-12" value="0">
	                        </div>
	                        <label class="control-label col-md-1 col-sm-1 col-xs-12" for="first-name">도서/산간</label>
	                        <div class="col-md-1 col-sm-1 col-xs-12">
	                          <input type="text" id="de_price_exception" name="de_price_exception" class="form-control col-md-12 col-xs-12" value="0" >
	                        </div>
	                      </div>
	                      <div id="de_div2" class="form-group" style="display:none">
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">조건부 무료배송</label>
	                        <div class="col-md-3 col-sm-3 col-xs-12">
	                          <input type="text" id="de_price_condition" name="de_price_condition" class="form-control col-md-12 col-xs-12" value="0" >
	                        </div>
	                      </div>
	                    </div>
	                 	</div>
	                 
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                   <div class="col-md-12">
	                     <div class="form-group">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <button type="submit" class="btn btn-primary pull-right">작성완료</button>
	                        <button type="button" class="btn btn-danger pull-right">작성취소</button>	                        
	                      </div> 
	                    </div>
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
        <!-- /page content -->

        <!-- footer content -->
        <%@include file = "adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
 
    <!-- jQuery -->
    <script src="../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../vendors/nprogress/nprogress.js"></script>
    <!-- validator -->
    <script src="../vendors/validator/validator.js"></script>
	<!-- jquery.inputmask -->
    <script src="../vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
     <!-- Select2 -->
    <script src="../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="../vendors/moment/min/moment.min.js"></script>
    <script src="../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../build/js/custom.min.js"></script>
    <!-- jQuery Tags Input -->
    <script src="../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    
    <Script language="javascript">
    function account_price(){
    	var sale_price = document.getElementById('pd_price').value;
    	var discount_rate = document.getElementById('dis_rate').value;
    	var discount_value = document.getElementById('dis_value').value;
    	var mil_rate = document.getElementById('mil_rate').value;
    	var delivery_base = document.getElementById('de_price').value;

    	var total = sale_price-((sale_price*discount_rate)/100)+discount_value+delivery_base ;
    	var account = sale_price-((sale_price*discount_rate)/100)-discount_value-((sale_price*mil_rate)/100); 
    	
    	document.getElementById('total').value = total ;
    	document.getElementById('account').value = account;
    	
    }
    </script>
    <script language="javascript">
    
    function dis_radio(e){
    	var fm = document.productInfo;
    	if(fm.dis[0].checked==true){
    		dis_div1.style.display = "none";
    		dis_div2.style.display = "none";
    		dis_div3.style.display = "none";
    		document.getElementById('dis_rate').value=0;
    		document.getElementById('dis_value').value=0;
    	}
    	else if(fm.dis[1].checked==true){
    		dis_div1.style.display = "block";
    		dis_div2.style.display = "none";
    		dis_div3.style.display = "block";
    	}
    }

    function dis_method_radio(e){
    	var fm = document.productInfo;
    	if(fm.dis_method[0].checked==true){
    		dis_div2.style.display = "none";
    		dis_div3.style.display = "block";
    		document.getElementById('dis_value').value=0;
    		
    	}
    	else if(fm.dis_method[1].checked==true){
    		dis_div2.style.display = "block";
    		dis_div3.style.display = "none";
    		document.getElementById('dis_rate').value=0;
    	}
    }
    
    function de_radio(e){
    	var fm = document.productInfo;
    	if(fm.de_method[0].checked==true){
    		de_div1.style.display = "block";
    		de_div2.style.display = "none"; 
    	}
    	else if(fm.de_method[1].checked==true){
    		de_div1.style.display = "none";
    		de_div2.style.display = "none";
    		document.getElementById('de_price').value=0;
    		document.getElementById('de_price_exception').value=0;
    	}
    	else if(fm.de_method[2].checked==true){
    		de_div1.style.display = "block";
    		de_div2.style.display = "block";
    	}
    }
    
    function mil_radio(e){
    	var fm = document.productInfo;
    	if(fm.mil[0].checked==true){
    		mil_div1.style.display = "none";
    		document.getElementById('mil_rate').value=0;
    	}
    	else if(mil[1].checked==true){
    		mil_div1.style.display = "block";
    	}
    }
    </script>
    
    <script type="text/javascript">
	function changes() {
		var objSel = document.getElementById("cgp_id");
		for(i=objSel.length;i>=0;i--){
			objSel.options[i] = null;
		}
		var cgpName1 = document.getElementById("cgp_cat1").value;
		
		if(cgpName1=="남성"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("남성");
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}
		else if(cgpName1=="여성"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("여성");
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}
		else if(cgpName1=="공용"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("공용");
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}
		else{
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("유아");
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			<%}%>
		}
	}
	</script>
    
	<!-- bootstrap-daterangepicker -->
    <script>
      $(document).ready(function() {
        $('#co_reg_date').daterangepicker({
          singleDatePicker: true,
          calender_style: "picker_4"
        }, function(start, end, label) {
          console.log(start.toISOString(), end.toISOString(), label);
        });
        $('#co_inv_date').daterangepicker({
            singleDatePicker: true,
            calender_style: "picker_4"
          }, function(start, end, label) {
            console.log(start.toISOString(), end.toISOString(), label);
          });
      });
    </script>
    <!-- /bootstrap-daterangepicker -->
    
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
        $('#pd_keyword').tagsInput({
          width: 'auto'
        });
      });
    </script>
    <!-- /jQuery Tags Input -->
    
    <!-- Select2 -->
    <script>
      $(document).ready(function() {
        $(".select2_single").select2({
          placeholder: "항목을 선택하세요.",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 6,
          placeholder: "최대 6개 옵션의 선택이 가능합니다.",
          allowClear: true
        });
      });
    </script>
    <!-- /Select2 -->
    
    <!-- validator -->
    <script>
      // initialize the validator function
      validator.message.date = 'not a real date';

      // validate a field on "blur" event, a 'select' on 'change' event & a '.reuired' classed multifield on 'keyup':
      $('form')
        .on('blur', 'input[required], input.optional, select.required', validator.checkField)
        .on('change', 'select.required', validator.checkField)
        .on('keypress', 'input[required][pattern]', validator.keypress);

      $('.multi.required').on('keyup blur', 'input', function() {
        validator.checkField.apply($(this).siblings().last()[0]);
      });

      $('form').submit(function(e) {
        e.preventDefault();
        var submit = true;

        // evaluate the form using generic validaing
        if (!validator.checkAll($(this))) {
          submit = false;
        }

        if (submit)
          this.submit();

        return false;
      });
    </script>
    <!-- /validator -->
  </body>
</html>