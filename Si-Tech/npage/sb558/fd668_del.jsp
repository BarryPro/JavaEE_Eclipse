<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%  
    String opCode = "d668";
    String opName = "局数据管理";	
   	String workNo = (String)session.getAttribute("workNo");
	  String org_code_note = (String)session.getAttribute("orgCode");
	  String paraAray[] = new String[4];
	  String tmp[] = new String[3];
	  paraAray[0] = request.getParameter("opt_flag");
	  if(paraAray[0].equals("0"))
    {
	    paraAray[1] = workNo;
	    paraAray[2] = request.getParameter("check_flag");
    }
	  else
		{
			paraAray[1] = workNo;
	    tmp = request.getParameter("check_flag").split(",");
	    paraAray[2] = tmp[0];
	    paraAray[3] = tmp[1];
	  }
%>
	<wtc:service name="sd668del" routerKey="region" routerValue="<%=org_code_note%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
core.ajax.receivePacket(response);
