<%
  /*
   * 功能: LTE自助换卡销售 m103
   * 版本: 1.0
   * 日期: 2014/5/13
   * 作者: diling
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode="m103";
	String opName="LTE自助换卡销售";
  String cardNo = (String)request.getParameter("cardNo");//空卡卡号
  String workNo = (String)session.getAttribute("workNo");
  String password = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
<%

   String paraAray[] = new String[9];
	 paraAray[0]=printAccept;
	 paraAray[1]="01";
	 paraAray[2]=opCode;
	 paraAray[3]=workNo;
	 paraAray[4]=password;
	 paraAray[5]="";
	 paraAray[6]="";
	 paraAray[7]=workNo+"进行了"+opName+"操作";
	 paraAray[8]=cardNo;
%>
<wtc:service name="sM103Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="2">
	<wtc:param value="<%=paraAray[0]%>" />
	<wtc:param value="<%=paraAray[1]%>" />
	<wtc:param value="<%=paraAray[2]%>" />
	<wtc:param value="<%=paraAray[3]%>" />
	<wtc:param value="<%=paraAray[4]%>" />
	<wtc:param value="<%=paraAray[5]%>" />
	<wtc:param value="<%=paraAray[6]%>" />
	<wtc:param value="<%=paraAray[7]%>" />
	<wtc:param value="<%=paraAray[8]%>" />
</wtc:service>
<wtc:array id="result1" scope="end" />
<%
	if("000000".equals(retCode)){
%>
	<script language="JavaScript">
		rdShowMessageDialog("LTE自助换卡销售办理成功！",2);
		window.location = 'fm103_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
	}else{
%>
	<script language="JavaScript">
		rdShowMessageDialog("办理失败！错误代码：<%=retCode%><br>错误信息：<%=retMsg%>",0);
		window.location = 'fm103_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>';
	</script>
<%
	}		

%>	