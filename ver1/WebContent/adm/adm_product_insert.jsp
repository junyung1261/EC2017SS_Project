<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.company.*" %>
<%@ page import="ec.product.*" %>
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
	companyList = codao.CompanyNameAndIDList();

	colorDao  coldao = new colorDao();
	ArrayList<colorVo> colorList = new ArrayList<colorVo>();
	colorList = coldao.colorList();
	
	/*DB����Ǿ��ִ� pd_id �ִ밪*/
	productDao pdao = new productDao();
	int max = pdao.productIdMax();
	
	sizeDao szdao = new sizeDao();
	ArrayList<sizeVo> sizeList = new ArrayList<sizeVo>();
	sizeList = szdao.sizeList();
	
	/*��з� ����Ʈ*/
	category_productDao cgpDao = new category_productDao();
	ArrayList<String> cat1_list = new ArrayList<String>();
	cat1_list = cgpDao.getCgpCat1();
	
	
	/*��,�Һз� ����Ʈ*/
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
              <div class="title_left"><h3>��ǰ���� <small>EC Corporation�� ��ǰ ������ ǥ���մϴ�.</small></h3></div>
              <div class="title_right">
                <div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
                  <div class="input-group">
                    <input type="text" class="form-control" placeholder="�˻��� �Է�">
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
                    <h2>��ǰ �������<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" ����" %></small></h2>
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
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��ǰ��Ϲ�ȣ <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="max" name="max" value="<%=max%>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
                        <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��ü����<span class="required">*</span></label>
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
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��ǰ�� <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_name" name="pd_name" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">�ǸŻ���<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="pd_status" name="pd_status" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option>
	                          <option value="0">�ǸŴ��</option>
	                          <option value="1">�Ǹ���</option>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">�������� <span class="required">*</span></label>
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
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��ǥ�̹��� <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_main_img" name="pd_main_img" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">���̹��� <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_detail_img" name="pd_detail_img" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">������� <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_reg_date" name="pd_reg_date" class="form-control col-md-12 col-xs-12" value="<%=today %>" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">����������Ʈ <span class="required">*</span></label>
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
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��з�<span class="required">*</span></label>
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
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">��/�Һз�<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="cgp_id" name="cgp_id" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option> 
	                        </select>
	                      </div>
	                    </div>
	                   <div class="form-group">
	                     <label class="control-label col-md-2 col-sm-2 col-xs-12">������ɼ�</label>
                         <div class="col-md-4 col-sm-4 col-xs-12">
                           <select class="select2_multiple form-control" id="sz_id" name="sz_id[]" multiple="multiple">
                             <%for(sizeVo svo : sizeList){ %>
                             <option value="<%=svo.getSz_size()%>"><%=svo.getSz_size()%></option>
                             <%} %>
                           </select>
                         </div>
	                   </div>
	                   <div class="form-group">
	                     <label class="control-label col-md-2 col-sm-2 col-xs-12">����ɼ�</label>
                         <div class="col-md-4 col-sm-4 col-xs-12">
                           <select class="select2_multiple form-control" id="col_id" name="col_id[]" multiple="multiple">
                             <%for(colorVo cvo : colorList){ %>
                             <option value="<%=cvo.getCol_name()%>"><%=cvo.getCol_name()%> (<%=cvo.getCol_eng()+", "+cvo.getCol_eng_short() %>)</option>
                             <%} %>
                           </select>
                         </div>
	                   </div>
	                   <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">�ɼ� �� �⺻���� </label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="stk_count" name="stk_count" class="form-control col-md-12 col-xs-12" value="0">
	                      </div>
	                    </div>
	                   <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">������� <span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_reg_date" name="pd_reg_date" class="form-control col-md-12 col-xs-12" value="<%=today %>" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12">Ű����<span class="required">*</span></label>
	                        <div class="col-md-4 col-sm-4 col-xs-12">
	                          <input type="text" id="pd_keyword" name="pd_keyword" class="tags form-control" value="������, ��ĿƮ, û����" />
	                          <div id="suggestions-container" style="position: relative; float: left; width: 250px; margin: 10px;"></div>
	                        </div>
                        </div>
                      </div> 
                    </div>
                   <div class="ln_solid"></div>
	               <div class="row"> 
	                 <div class="col-md-12">     
	                 	<div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">�⺻�ǸŰ� (��)<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_price" name="pd_price" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">���ο��� <span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                      	<div class="radio">
	                      	<label><input type="radio" value="0" id="pd_sale" name="pd_sale"> ������</label>
                            <label><input type="radio" value="1" id="pd_sale" name="pd_sale"> ����</label>
                          	</div>
                          </div>
	                   
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12"> ���ι��<span class="required">*</span></label>
	                      <div class="col-md-1 col-sm-1 col-xs-12">
	                      	<div class="radio">
	                      	<label><input type="radio" value="0" id="pd_sale_type" name="pd_sale_type"> ����</label>
                            <label><input type="radio" value="1" id="pd_sale_type" name="pd_sale_type"> ����</label>
                          	</div>
                          </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">����:(%), ����:(��)<span class="required">*</span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="pd_sale_value" name="pd_sale_value" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                   <div class="col-md-12">
	                     <div class="form-group">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <button type="submit" class="btn btn-primary pull-right">�ۼ��Ϸ�</button>
	                        <button type="button" class="btn btn-danger pull-right">�ۼ����</button>	                        
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
    
    <script type="text/javascript">

	function changes() {
		
		var objSel = document.getElementById("cgp_id");
		for(i=objSel.length;i>=0;i--){
			objSel.options[i] = null;
		}
		var cgpName1 = document.getElementById("cgp_cat1").value;
		
		if(cgpName1=="����"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("����");
			
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}
		else if(cgpName1=="����"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("����");
			
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}
		else if(cgpName1=="����"){
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("����");
			
			for(category_productVo vo : cat2_cat3_list){%>
			var objOption = document.createElement("option");
			objOption.text = "<%=vo.getCgp_cat2()%> >> <%=vo.getCgp_cat3()%>";
			objOption.value= "<%=vo.getCgp_id()%>";
			objSel.options.add(objOption);
			
			<%}%>
		}else{
			<%
			cat2_cat3_list = cgpDao.getCgpCat2_Cat3("����");
			
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
          placeholder: "�׸��� �����ϼ���.",
          allowClear: true
        });
        $(".select2_group").select2({});
        $(".select2_multiple").select2({
          maximumSelectionLength: 6,
          placeholder: "�ִ� 6�� �ɼ��� ������ �����մϴ�.",
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