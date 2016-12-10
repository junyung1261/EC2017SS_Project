<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*" %>
<%@ page import="ec.date.*" %>
<%@ page import="ec.bank.*" %>
<%@ page import="ec.member.*, ec.member_address.*, ec.member_account.*" %>

<%  request.setCharacterEncoding("euc-kr"); %>
<%	dateDao ddao = new dateDao();
	dateVo dvo = new dateVo();
	dvo = ddao.getToday();
	String now = dvo.getMonth()+"/"+dvo.getDate()+"/"+dvo.getYear()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond();
	
	int req_id = Integer.parseInt(request.getParameter("mem_id"));
	memberDao mdao = new memberDao();
	memberVo mvo = mdao.selectMember(req_id);
	
	member_addressDao madao = new member_addressDao();
	member_addressVo mavo = madao.getMemberInfo(req_id);
	
	member_accountDao macdao = new member_accountDao();
	member_accountVo macvo = macdao.getMemberAccountInfo(req_id);
	
	bankDao bdao = new bankDao();
	ArrayList<bankVo> bankList = new ArrayList<bankVo>();
	bankList = bdao.bankList();
	
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
        
        <!-- page content -->
        <div class="right_col" role="main"> 
          <div class="">
            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>ȸ�� �� ����<small><%=dvo.getYear()+"-"+dvo.getMonth()+"-"+dvo.getDate()+" "+dvo.getHour()+":"+dvo.getMinute()+":"+dvo.getSecond()+" ����" %></small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <br />
                    <form id="memberInfo" method="post" action="adm_member_insert_proc.jsp" data-parsley-validate class="form-horizontal form-label-left">
                    <div class="row">
                      <div class="col-xs-12">
                        <div class="form-group">
	                      <label class="control-label col-xs-6" for="first-name">ȸ����ȣ</label>
	                      <label class="control-label col-xs-6">���԰��</label>
	                    </div>
	                    <div class="form-group">
	                      <div class="col-xs-6">
	                        <input type="text" id="mem_id" name="mem_id" value="<%=mvo.getMem_id() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                      <div class="col-xs-6">
	                         <%if(mvo.getMem_method().equalsIgnoreCase("Android")){ %>
	                        <input id="mem_method" name="mem_method" value="Android" class="form-control col-xs-12" type="text" readonly>
	                        <%}else{ %>
	                        <input id="mem_method" name="mem_method" value="iOS" class="form-control col-xs-12" type="text" readonly>
	                        <%} %>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-12" for="first-name">ȸ�� ���̵�</label>
	                      <div class="col-xs-12">
	                        <input type="text" id="mem_user_id" name="mem_user_id" value="<%=mvo.getMem_user_id() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-12" for="first-name">ȸ�� ��й�ȣ</label>
	                      <div class="col-xs-12">
	                        <input type="password" id="mem_password" name="mem_password" value="<%=mvo.getMem_password() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-6">�������</label>
	                      <label class="control-label col-xs-6">���� </label>
	                    </div>
	                    <div class="form-group">
	                      <div class="col-xs-6">
	                        <input id="mem_birth" name="mem_birth" value="<%=mvo.getMem_birth()%>" class="form-control form-control col-xs-12" type="text" readonly>
	                      </div>
	                      <div class="col-xs-6">
	                      	<%if(mvo.getMem_gender()==0){ %>
	                        <input id="mem_gender" name="mem_gender" value="����" class="form-control col-xs-12" type="text" readonly>
	                        <%}else{ %>
	                        <input id="mem_gender" name="mem_gender" value="����" class="form-control col-xs-12" type="text" readonly>
	                        <%} %>
                          </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-6">����ó</label>
	                      <label class="control-label col-xs-6">ȸ�� ���</label>
	                    </div>
	                    <div class="form-group">
	                      <div class="col-xs-6">
	                        <input id="mem_phone" name="mem_phone" value="<%=mvo.getMem_phone() %>" class="form-control col-xs-12" type="text" readonly>
	                      </div>
	                      <div class="col-xs-6">
	                         <select id="mem_grade" name="mem_grade" class="select2_single form-control col-xs-12" tabindex="-1">
	                          <%if(mvo.getMem_grade()==1){ %>
	                          <option selected>�ű�ȸ��</option>
	                          <%}else if(mvo.getMem_grade()==2){ %>
	                          <option selected>�����</option>
	                          <%}else if(mvo.getMem_grade()==3){ %>
	                          <option selected>�ǹ�</option>
	                          <%}else if(mvo.getMem_grade()==4){ %>
	                          <option selected>���</option>
	                          <%}else if(mvo.getMem_grade()==5){ %>
	                          <option selected>�÷�Ƽ��</option>
	                          <%}else{ %>
	                          <option selected>���̾Ƹ��</option>
	                          <%} %>
	                         </select> 
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-12">�˸� ���ſ��� <span class="required">*</span></label>
	                      <div class="col-md-8 col-sm-8 col-xs-12">
	                        <div class="radio">
	                      	  <label><input type="radio" value="0" id="mem_msg_receive" name="mem_msg_receive" <%if(mvo.getMem_msg_receive()==0){ %>checked<%} %>>�̼���&nbsp;&nbsp;</label>
                              <label><input type="radio" value="1" id="mem_msg_receive" name="mem_msg_receive" <%if(mvo.getMem_msg_receive()==1){ %>checked<%} %>>����</label>
                          	</div>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="row">
	                  <div class="col-md-12">   
	                 	<div class="form-group">
	                      <label class="control-label col-xs-6" for="first-name">�����θ�</label>
	                      <label class="control-label col-xs-6" for="first-name">������ ����ó</label>
	                    </div>
	                    <div class="form-group">
	                      <div class="col-xs-6">
	                        <input type="text" id="ma_name_recipient" name="ma_name_recipient" value="<%=mavo.getMa_name_recipient() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                      <div class="col-xs-6">
	                        <input type="text" id="ma_phone_recipient" name="ma_phone_recipient" value="<%=mavo.getMa_phone_recipient() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-12" for="first-name">�����ȣ</label>
	                      <div class="col-xs-6">
	                        <input type="text" id="ma_addr_zipcode" name="ma_addr_zipcode"  value="<%=mavo.getMa_addr_zipcode()%>" class="form-control col-xs-12" readonly>
	                      </div>
	                      
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-xs-12" for="first-name">�⺻ ����� �ּ�</label>
	                      <div class="col-xs-12">
	                        <input type="text" id="ma_addr_base" name="ma_addr_base"  value="<%=mavo.getMa_addr_base() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="row">
	                  <div class="col-xs-12">   
	                 	<div class="form-group">
	                      <label class="control-label col-xs-6" for="first-name">�����ָ�</label>
	                      <label class="control-label col-xs-6">����</label>
	                    </div>
	                    <div class="form-group">
	                      <div class="col-xs-6">
	                        <input type="text" id="mac_name" name="mac_name" value="<%=macvo.getMac_name() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                      <div class="col-xs-6">
	                        <select id="mac_bank" name="mac_bank" class="select2_single form-control col-xs-12" tabindex="-1">
	                          <%if(macvo.getMac_bank()==1){ %>
	                          <option selected>��������</option>
	                          <%}else if(macvo.getMac_bank()==2){ %>
	                          <option selected>�츮����</option>
	                          <%}else if(macvo.getMac_bank()==3){ %>
	                          <option selected>��������</option>
	                          <%}else if(macvo.getMac_bank()==4){ %>
	                          <option selected>�������</option>
	                          <%}else{ %>
	                          <option selected>����</option>
	                          <%}%>
	                         </select> 
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label class="control-label col-md-2 col-sm-2 col-xs-12" for="first-name">ȯ�Ұ��¹�ȣ</label>
	                      <div class="col-md-4 col-sm-4 col-xs-12">
	                        <input type="text" id="mac_account" name="mac_account" value="<%=macvo.getMac_account() %>" class="form-control col-xs-12" readonly>
	                      </div>
	                    </div>
	                  </div>
	                </div>
	                <div class="ln_solid"></div>
	                <div class="form-group">
	                  <div class="col-xs-12">
	                  	<!-- ȸ�� ���Խð� �������� -->
	                  	<input type="hidden" id="mem_reg" name="mem_reg" value="<%=now %>">
	                    <button type="button" onClick="javascript:window.close()" class="btn btn-primary pull-right">�ݱ�</button>
	                    <button type="button" class="btn btn-danger pull-right">�ۼ����</button>	                        
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
          placeholder: "�׸��� �����ϼ���.",
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