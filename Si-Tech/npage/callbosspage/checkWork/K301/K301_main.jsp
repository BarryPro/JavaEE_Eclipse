<%
  /*
   * ����: ���ظ��ʼ�Ȩ������
   * �汾: 1.0
   * ����: 2009/10/16
   * ����: liujied
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
       
String opCode = "K301";
String opName = "���ظ��ʼ�Ȩ�޶���";


%>
<html>
  <head>
    <title>���ظ��ʼ�Ȩ�޶���</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
    <script type="text/javascript">
      
    </script>
  </head>
  <body>
    <form method="POST" name="repeatCheckForm" id="repeatCheckForm">
      <div id="Operation_Table" style="width: 100%;">
	<div class="title">
          <div id="title_zi">
            <div style="float:left">���ظ��ʼ�Ȩ�޶���</div>
	  </div>
	</div>
        <table id="ErrTable" cellspacing="0">
          
        </table>
    </form>
  </body>
</html>
