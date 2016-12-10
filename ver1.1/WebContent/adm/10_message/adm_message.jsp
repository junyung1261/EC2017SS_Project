<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.*" %>    
<%@ page import = "ec.date.*" %>
<%@ page import = "ec.message.*" %>   
<%

	String loginId = (String)session.getAttribute("loginId");
	dateDao dao = new dateDao();
	String now = dao.now();
	
	messageDao msgdao = new messageDao();
	ArrayList<messageVo> receiveMsgList = new ArrayList<messageVo>();
	receiveMsgList = msgdao.getReceivedMessage(loginId);
	
	int msg_id = 0;
	if(request.getParameter("msg_id")==null){
		msg_id = 0;
	}else{
		msg_id = Integer.parseInt(request.getParameter("msg_id"));
		msgdao.updateMessageReceiveState(msg_id);
		msgdao.updateMessageSendState(msg_id); 
	}
%> 
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=EUC-kr">
    <!-- Meta, title, CSS, favicons, etc. -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>MessageList</title>

    <!-- Bootstrap -->
    <link href="../../vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="../../vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <!-- NProgress -->
    <link href="../../vendors/nprogress/nprogress.css" rel="stylesheet">
    
    <!-- Custom styling plus plugins -->
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
                <h3>Messages <small>메세지 관리</small></h3>
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
              <div class="col-md-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>받은 메세지<small><%=now %> 현재</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <div class="row">
                      <div class="col-sm-3 mail_list_column">
                        <button type="button" class="btn btn-sm btn-success btn-block" data-toggle="modal" data-target=".write_msg">메세지 작성</button><br>
                        <form name="writemsg" action="adm_message_send_proc.jsp" method="post">
                        <div class="modal fade write_msg" tabindex="-1" role="dialog" aria-hidden="true">
                          <div class="modal-dialog modal-lg">
                            <div class="modal-content">

                              <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
                                <h4 class="modal-title" id="myModalLabel">메세지 작성</h4><small><%=now %></small>
                              </div>
                              <div class="modal-body">
                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">수신자 <span class="required">*</span></label>
                                  <div class="col-md-10 col-sm-10 col-xs-12">
                                    <input type="text" name="msg_receiver" value=""required="required" class="form-control col-md-12 col-xs-12" >
                                  </div>
                                </div>
                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">제&nbsp;&nbsp;&nbsp;목 <span class="required">*</span></label>
                                  <div class="col-md-10 col-sm-10 col-xs-12">
                                    <input type="text" name="msg_title" value="" required="required" class="form-control col-md-12 col-xs-12">
                                  </div>
                                </div>
                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">내&nbsp;&nbsp;&nbsp;용 <span class="required">*</span></label>
                                  <div class="col-md-10 col-sm-10 col-xs-12">
                                    <textarea name="msg_contents" class="form-control col-md-12"></textarea>
                                  </div>
                                </div>
                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">긴급여부 <span class="required">*</span></label>
                                  <div class="col-md-10 col-sm-10 col-xs-12">
                                    <input type="radio" name="msg_type" value="0" class="">&nbsp;&nbsp;일반&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="msg_type" value="1">&nbsp;&nbsp;긴급
                                  </div>
                                </div>
                                <p><br><br><br><br><br><br><br><br><br></p>
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                                <input type="hidden" name="msg_state" value="0">
                                <input type="hidden" name="msg_time" value="<%=now %>">
                                <input type="hidden" name="msg_writer" value="<%=loginId %>">
                                <input type="submit" class="btn btn-primary" value="메세지 전송">
                              </div>
                            </div>
                          </div>
                        </div>
                        </form>
                        <%for(messageVo msgvo : receiveMsgList){ %>
                        <a href="adm_message.jsp?msg_id=<%=msgvo.getMsg_id() %>">
                          <div class="mail_list">
                            <div class="left">
                            <%if(msgvo.getMsg_state()==0){ %><i class="fa fa-folder"></i><%}
                            else{%><i class="fa fa-folder-open"></i><%} %>
                            <%if(msgvo.getMsg_type()==1){ %>  
                              <i class="fa fa-exclamation-triangle"></i>
                            <%} %>  
                            </div>
                            <div class="right">
                              <h3><%=msgvo.getMsg_writer() %> <small><%=msgvo.getMsg_time() %></small></h3>
                              <p><%=msgvo.getMsg_title() %></p>
                            </div>
                          </div>
                        </a>
                        <%} %>
                      </div>
                      <!-- /MAIL LIST -->

                      <!-- CONTENT MAIL -->
                      <%if(msg_id==0){ %>
                      <div class="col-sm-9 mail_view">
                        <div class="inbox-body"> 
                          <div class="mail_heading row">
                            <div class="col-md-8">
                              <div class="btn-group">
                                <button class="btn btn-sm btn-primary" type="button"><i class="fa fa-reply"></i> Reply</button>
                                <button class="btn btn-sm btn-default" type="button"  data-placement="top" data-toggle="tooltip" data-original-title="Forward"><i class="fa fa-share"></i></button>
                                <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="인쇄"><i class="fa fa-print"></i></button>
                                <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="삭제"><i class="fa fa-trash-o"></i></button>
                              </div>
                            </div>
                            <div class="col-md-12">
                              <h4>메세지를 선택하세요.</h4>
                            </div>
                          </div>
                          
                          <div class="view-mail" style="text-align:center;"><br>
                            <p><font size="150px"><i class="fa fa-envelope-o"></i></font></p> 
                          </div>
                          
                          <div class="btn-group">
                            <button class="btn btn-sm btn-primary" type="button"><i class="fa fa-reply"></i> Reply</button>
                            <button class="btn btn-sm btn-default" type="button"  data-placement="top" data-toggle="tooltip" data-original-title="Forward"><i class="fa fa-share"></i></button>
                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="인쇄"><i class="fa fa-print"></i></button>
                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="삭제"><i class="fa fa-trash-o"></i></button>
                          </div>
                        </div>
                      </div>
                      <%}else{
                      messageVo msgvo = msgdao.selectReceivedMessage(msg_id);
                      
                      %>
                      
                      <div class="col-sm-9 mail_view">
                        <div class="inbox-body"> 
                          <div class="mail_heading row">
                            <div class="col-md-8">
                              <div class="btn-group">
                                <button class="btn btn-sm btn-primary" type="button" data-toggle="modal" data-target=".reply_msg"><i class="fa fa-reply"></i> Reply</button>
                                <button class="btn btn-sm btn-default" type="button"  data-placement="top" data-toggle="tooltip" data-original-title="Forward"><i class="fa fa-share"></i></button>
                                <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="인쇄"><i class="fa fa-print"></i></button>
                                <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="삭제"><i class="fa fa-trash-o"></i></button>
                                
                                <form name="replymsg" action="adm_message_send_proc.jsp" method="post">
		                        <div class="modal fade reply_msg" tabindex="-1" role="dialog" aria-hidden="true">
		                          <div class="modal-dialog modal-lg">
		                            <div class="modal-content">
		
		                              <div class="modal-header">
		                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span></button>
		                                <h4 class="modal-title" id="myModalLabel">메세지 작성</h4><small><%=now %></small>
		                              </div>
		                              <div class="modal-body">
		                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
		                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">수신자 <span class="required">*</span></label>
		                                  <div class="col-md-10 col-sm-10 col-xs-12">
		                                    <input type="text" name="msg_receiver" value="<%=msgvo.getMsg_writer() %>" required="required" class="form-control col-md-12 col-xs-12" >
		                                  </div>
		                                </div>
		                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
		                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">제&nbsp;&nbsp;&nbsp;목 <span class="required">*</span></label>
		                                  <div class="col-md-10 col-sm-10 col-xs-12">
		                                    <input type="text" name="msg_title" value="[RE]<%=msgvo.getMsg_title() %>" required="required" class="form-control col-md-12 col-xs-12">
		                                  </div>
		                                </div>
		                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
		                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">내&nbsp;&nbsp;&nbsp;용 <span class="required">*</span></label>
		                                  <div class="col-md-10 col-sm-10 col-xs-12">
		                                    <textarea name="msg_contents" class="form-control col-md-12"></textarea>
		                                  </div>
		                                </div>
		                                <div class="form-group col-md-12 col-sm-12 col-xs-12">
		                                  <label class="control-label col-md-2 col-sm-2 col-xs-4">긴급여부 <span class="required">*</span></label>
		                                  <div class="col-md-10 col-sm-10 col-xs-12">
		                                    <input type="radio" name="msg_type" value="0" class="">&nbsp;&nbsp;일반&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="msg_type" value="1">&nbsp;&nbsp;긴급
		                                  </div>
		                                </div>
		                                <p><br><br><br><br><br><br><br><br><br></p>
		                              </div>
		                              <div class="modal-footer">
		                                <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
		                                <input type="hidden" name="msg_state" value="0">
		                                <input type="hidden" name="msg_time" value="<%=now %>">
		                                <input type="hidden" name="msg_writer" value="<%=loginId %>">
		                                <input type="submit" class="btn btn-primary" value="메세지 전송">
		                              </div>
		                            </div>
		                          </div>
		                        </div>
		                        </form>
		                        
                              </div>
                            </div>
                            <div class="col-md-12">
                              <h4>
                              <%if(msgvo.getMsg_type()==1){ %>[긴급]<%}else{ %>[일반]<%} %>
                              <%=msgvo.getMsg_title() %></h4>
                              <p class="date"> <small><%=msgvo.getMsg_time() %></small></p>
                            </div>
                          </div>
                          <div class="sender-info">
                            <div class="row">
                              <div class="col-md-12">
                                From&nbsp;:&nbsp;<strong><%=msgvo.getMsg_writer() %></strong><br>
                                To&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;<strong><%=msgvo.getMsg_receiver() %></strong>
                                <a class="sender-dropdown"><i class="fa fa-chevron-down"></i></a>
                              </div>
                            </div>
                          </div>
                          <div class="view-mail"><br>
                            <p><%=msgvo.getMsg_contents() %></p> 
                          </div>
                          
                          <div class="btn-group">
                            <button class="btn btn-sm btn-primary" type="button" data-toggle="modal" data-target=".reply_msg"><i class="fa fa-reply"></i> Reply</button>
                            <button class="btn btn-sm btn-default" type="button"  data-placement="top" data-toggle="tooltip" data-original-title="Forward"><i class="fa fa-share"></i></button>
                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="인쇄"><i class="fa fa-print"></i></button>
                            <button class="btn btn-sm btn-default" type="button" data-placement="top" data-toggle="tooltip" data-original-title="삭제"><i class="fa fa-trash-o"></i></button>
                          </div>
                        </div>
                      </div>

                      
                      <%} %>
                      <!-- /CONTENT MAIL -->
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

    <!-- compose -->

    <!-- /compose -->

    <!-- jQuery -->
    <script src="../../vendors/jquery/dist/jquery.min.js"></script>
    <!-- Bootstrap -->
    <script src="../../vendors/bootstrap/dist/js/bootstrap.min.js"></script>
    <!-- FastClick -->
    <script src="../../vendors/fastclick/lib/fastclick.js"></script>
    <!-- NProgress -->
    <script src="../../vendors/nprogress/nprogress.js"></script>
    
    <!-- Custom Theme Scripts -->
    <script src="../../build/js/custom.min.js"></script>

   
  </body>
</html>