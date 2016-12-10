<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.bank.*" %>
<%@ page import="ec.member.*, ec.grade.*" %>

<%  request.setCharacterEncoding("euc-kr"); %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
	
	memberDao mdao = new memberDao();
	int mem_id = mdao.nextInsertMemberId();
	
	bankDao bdao = new bankDao();
	ArrayList<bankVo> bankList = new ArrayList<bankVo>();
	bankList = bdao.bankList();
	
	gradeDao gdao = new gradeDao();
	ArrayList<gradeVo> gradeList = new ArrayList<gradeVo>();
	gradeList = gdao.gradeList();
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
              <div class="title_left"><h3>회원관리<small>EC Corporation의 가입회원에 대한 정보를 표시합니다.</small></h3></div>
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
                    <h2>회원 신규 등록<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" 현재" %></small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form id="memberInfo" method="post" action="adm_member_insert_proc.jsp" data-parsley-validate class="form-horizontal form-label-left">
                    <div class="row">
                      <div class="col-md-6">
                        <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">회원번호 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="mem_id" name="mem_id" value="<%=mem_id %>" class="form-control col-md-12 col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">유입경로<span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                         <select id="mem_method" name="mem_method" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option>
	                          <option value="Android">Android</option>
	                          <option value="iOS">iOS</option>
	                         </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">ID <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="text" id="mem_user_id" name="mem_user_id" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12" for="first-name">PASSWORD <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input type="password" id="mem_password" name="mem_password" required="required" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">생년월일 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input id="mem_birth" name="mem_birth" class="date-picker form-control col-md-12 col-xs-12" required="required" type="text">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">성별 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <div class="radio">
	                      	  <label><input type="radio" value="0" id="mem_gender" name="mem_gender" checked>남자&nbsp;&nbsp;</label>
                              <label><input type="radio" value="1" id="mem_gender" name="mem_gender">여자</label>
                          	</div>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">연락처 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <input id="mem_phone" name="mem_phone" class="date-picker form-control col-md-12 col-xs-12" required="required" type="text">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">회원 등급<span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                         <select id="mem_grade" name="mem_grade" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                          <option></option>
	                          <%for(gradeVo gvo : gradeList){ %>
	                          <option value="<%=gvo.getGrd_id()%>"><%=gvo.getGrd_name() %></option>
	                          <%} %>
	                         </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-4 col-sm-4 col-xs-12">알림 수신여부 <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <div class="radio">
	                      	  <label><input type="radio" value="0" id="mem_msg_receive" name="mem_msg_receive" checked>수신&nbsp;&nbsp;</label>
                              <label><input type="radio" value="1" id="mem_msg_receive" name="mem_msg_receive">미수신</label>
                          	</div>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="row">
	                  <div class="col-md-12">   
	                 	<div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">기본 수령인명</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="ma_name_recipient" name="ma_name_recipient" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">기본 수령인 연락처</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="ma_phone_recipient" name="ma_phone_recipient" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">기본 배송지 우편번호</label>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                        <input type="text" id="ma_addr_zipcode" name="ma_addr_zipcode"  class="form-control col-md-12 col-xs-12" readonly>
	                         
	                      </div>
	                      <div class="col-md-2 col-sm-2 col-xs-12">
	                       <button type="button" class="btn btn-warning">주소검색</button>
	                      </div> 
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">기본 배송지 주소</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="ma_addr_base" name="ma_addr_base"  class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="row">
	                  <div class="col-md-12">   
	                 	<div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">예금주명</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="mac_name" name="mac_name" class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12">환불계좌은행<span class="required"></span></label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <select id="mac_bank" name="mac_bank" class="select2_single form-control col-md-12 col-xs-12" tabindex="-1">
	                        <option></option>
	                        <%for(bankVo bvo : bankList){ %>
	                          <option value="<%=bvo.getBank_id()%>"><%=bvo.getBank_name() %></option>
	                        <%} %>
	                        </select>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">환불계좌번호</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="mac_account" name="mac_account"  class="form-control col-md-12 col-xs-12">
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="form-group">
	                  <div class="col-md-6 col-sm-6 col-xs-6">
	                  	<!-- 회원 가입시간 정보전달 -->
	                  	<input type="hidden" id="mem_reg" name="mem_reg" value="<%=now %>">
	                    <button type="submit" class="btn btn-primary pull-right">작성완료</button>
	                    <button type="button" class="btn btn-danger pull-right">작성취소</button>	                        
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