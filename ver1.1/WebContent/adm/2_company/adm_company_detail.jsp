<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>    
<%@ page import="ec.date.*" %>
<%@ page import="ec.company.*" %>

<% request.setCharacterEncoding("euc-kr"); %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	
	String co_id = (String)request.getParameter("co_id");
	companyDao cdao = new companyDao();
	companyVo cvo = cdao.getCompanyInfo(co_id);

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>EC Corporation </title>

    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- bootstrap-daterangepicker -->
    <link href="../../vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">
    <!-- Select2 -->
    <link href="../../vendors/select2/dist/css/select2.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">
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
              <div class="title_left"><h3>협력업체 <small>EC Corporation의 협력업체 정보를 표시합니다.</small></h3></div>
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
                    <h2>업체 신규등록<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form id="companyInfo" method="post" action="adm_company_insert_proc.jsp" data-parsley-validate class="form-horizontal form-label-left">
                    <div class="row">
                    <div class="col-md-6">
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">회사명</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_name" name="co_name" value="<%=cvo.getCo_id()%>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">담당자연락처</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_phone" name="co_phone" value="<%=cvo.getCo_phone() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">팩스번호</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_fax" name="co_fax" value="<%=cvo.getCo_fax() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="last-name">E-mail</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_email" name="co_email" value="<%=cvo.getCo_email() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                 </div>
	                 
	                 <div class="col-md-6">   
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">대표자명</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_ceo" name="co_ceo" value="<%=cvo.getCo_ceo() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">사업장연락처</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_tel" name="co_tel" value="<%=cvo.getCo_tel() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">사업장 소재지</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_address" name="co_address" value="<%=cvo.getCo_address() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                 <div class="col-md-12">   
	                 	<div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">사업자등록번호</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="co_reg_num1" name="co_reg_num1" value="<%=cvo.getCo_reg_num1() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                      	<button type="button" class="btn btn-warning btn-sm">유효성검증</button>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">통신판매신고번호</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="co_reg_num2" name="co_reg_num2" value="<%=cvo.getCo_reg_num2()%>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                      	<button type="button" class="btn btn-warning btn-sm">유효성검증</button>
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                 <div class="col-md-6">
	                   <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">배송비설정 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                         <select id="co_delivery" name="co_delivery" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option value="0" <%if(cvo.getCo_delivery()==0){ %>selected<%} %>>무료배송</option>
	                          <option value="1" <%if(cvo.getCo_delivery()==1){ %>selected<%} %>>기본배송</option>
	                          <option value="2" <%if(cvo.getCo_delivery()==2){ %>selected<%} %>>조건부 무료배송</option>
	                        </select>
	                      </div>
	                    </div>
					</div>
	                 <div class="col-md-6">
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">기본배송비</label>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                        <input type="text" id="co_delivery_base" name="co_delivery_base" value="<%=cvo.getCo_delivery_base() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>

	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">도서/산간</label>
	                      <div class="col-md-2 col-sm-2 col-xs-12"> 
	                        <input type="text" id="co_delivery_exception" name="co_delivery_exception" value="<%=cvo.getCo_delivery_exception() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                     <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">조건부 무료</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="co_delivery_condition" name="co_delivery_condition" value="<%=cvo.getCo_delivery_condition() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                      	<button type="button" class="btn btn-warning btn-sm">원 이상 구매 시 무료</button>
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                 <div class="col-md-6">   
	                     <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">전용은행</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <select id="co_bank" name="co_bank" class="select2_single form-control" tabindex="-1" readonly>
	                          <option selected><%=cvo.getCo_bank() %></option>
	                        </select>
	                      </div>
	                    </div>
	                 </div>
	                 <div class="col-md-6">
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">계좌번호</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_account" name="co_account" value="<%=cvo.getCo_account() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                 <div class="col-md-6">     
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">발급 ID</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_id" name="co_id" value="<%=cvo.getCo_id() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">발급 Password</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="password" id="co_password" name="co_password" value="<%=cvo.getCo_password() %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">최초계약일</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_reg_date" name="co_reg_date" value="<%=cvo.getCo_reg_date()%>" class="date-picker form-control col-md-12 col-xs-12"  readonly>
	                      </div>
	                    </div>
	                 </div>
	                 <div class="col-md-6">     
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">발급 등급</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <select id="co_grade" name="co_grade" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option selected><%=cvo.getCo_grade() %></option>
	                        </select>
	                        
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">Password 확인</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="password" id="co_password2" name="co_password2" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">계약만료일</label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="co_exp_date" name="co_exp_date" value="<%=cvo.getCo_exp_date() %>" class="date-picker form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                 </div>
	                 </div>
	                 <div class="ln_solid"></div>
	                 <div class="row">
	                 <div class="col-md-12">   
	                    <div class="form-group">
	                        <label class="control-label col-md-2 col-sm-2 col-xs-12">대표항목</label>
	                        <div class="col-md-10 col-sm-10 col-xs-12">
	                          <input type="text" id="co_tags" name="co_tags" class="tags form-control" value="<%=cvo.getCo_tags() %>" />
	                          <div id="suggestions-container" style="position: relative; float: left; width: 250px; margin: 10px;"></div>
	                        </div>
                        </div>
	                    <div class="ln_solid"></div>
	                    <div class="form-group">
	                      <div class="col-md-12 col-sm-12 col-xs-12">
	                        <button type="button" class="btn btn-danger pull-right">정보수정</button>	                        
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
        <%@include file = "../adm_footer.jsp" %>
        <!-- /footer content -->
      </div>
 
    <!-- jQuery -->
    <script src="../../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../../vendors/nprogress/nprogress.js"></script>
    <!-- validator -->
    <script src="../../vendors/validator/validator.js"></script>
	<!-- jquery.inputmask -->
    <script src="../../vendors/jquery.inputmask/dist/min/jquery.inputmask.bundle.min.js"></script>
     <!-- Select2 -->
    <script src="../../vendors/select2/dist/js/select2.full.min.js"></script>
    <!-- bootstrap-daterangepicker -->
    <script src="../../vendors/moment/min/moment.min.js"></script>
    <script src="../../vendors/bootstrap-daterangepicker/daterangepicker.js"></script>
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>
    <!-- jQuery Tags Input -->
    <script src="../../vendors/jquery.tagsinput/src/jquery.tagsinput.js"></script>
    
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
        $('#co_tags').tagsInput({
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
          maximumSelectionLength: 4,
          placeholder: "With Max Selection limit 4",
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