<%
  /*
   * 功能: 可重复质检权限设置
   * 版本: 1.0
   * 日期: 2009/10/16
   * 作者: liujied
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
       
String opCode = "K301";
String opName = "可重复质检权限定义";


%>
<html>
  <head>
    <title>可重复质检权限定义</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
    <script type="text/javascript">
      
    </script>
  </head>
  <body>
    <form method="POST" name="repeatCheckForm" id="repeatCheckForm">
      <div id="Operation_Table" style="width: 100%;">
	<div class="title">
          <div id="title_zi">
            <div style="float:left">可重复质检权限定义</div>
	  </div>
	</div>
        <table id="ErrTable" cellspacing="0">
          
        </table>
    </form>
  </body>
</html>
