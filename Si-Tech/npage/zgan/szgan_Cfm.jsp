<%
  /*
   * 功能: 生日关怀参数配置
   * 版本: 1.0
   * update:
  */
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

 <%
  String opCode = "zgan";
  String opName = "生日关怀参数配置";
  
	String region_code	= request.getParameter("region_code");
	String login_no 		= request.getParameter("login_no");
	String sel_mode			= request.getParameter("sel_mode");

	System.out.println("+++++++++++++++++++++++++zhaorh=====>"+region_code+"  "+login_no+"  "+sel_mode);
	

%>

<wtc:service name="szganCfm" routerKey="region" routerValue="<%=region_code%>" retCode="retCode" retMsg="retMsg" outnum="2" >
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=region_code%>"/>
	<wtc:param value="<%=login_no%>"/>
	<wtc:param value="MODE"/>
	<wtc:param value="<%=sel_mode%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%

	if(retCode.equals("000000"))
  {
%>
      <script>
	      rdShowMessageDialog("数据配置成功！",2);
				history.go(-1);
          
	    </script>
<%
   }
   else
   {
%>
	   <script>
	     rdShowMessageDialog('错误<%=retMsg%>，请重新操作！',0);
			history.go(-1);
	   </script>
<%
   }
%>		