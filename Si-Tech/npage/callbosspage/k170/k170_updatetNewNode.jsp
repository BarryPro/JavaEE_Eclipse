<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
	String retType = WtcUtil.repNull(request.getParameter("retType"));
	String nodeName = WtcUtil.repNull(request.getParameter("nodeName"));
	String nodeId = WtcUtil.repNull(request.getParameter("nodeId"));
	String selectId = WtcUtil.repNull(request.getParameter("selectId"));
	String cityid= WtcUtil.repNull(request.getParameter("cityid"));
	String note = WtcUtil.repNull(request.getParameter("note"));
	String flag = WtcUtil.repNull(request.getParameter("flag"));
	String fullname = WtcUtil.repNull(request.getParameter("fullname"));
	//System.out.println("ppppppppppppppppppp++\t"+retType+"\t"+nodeName+"\t"+nodeId+"\t"+isleaf+"\t"+flag+"\t"+cityid+"\t"+fullname);
	String login_no = (String)session.getAttribute("workNo");	// boss工号代码
	String orgCode  = (String)session.getAttribute("orgCode");	// 组织代码
	String ip_Addr  = (String)session.getAttribute("ipAddr");
  //int maxCount =0;
%>
<wtc:service name="sK410Update" outnum="5">
	<wtc:param value="<%=nodeName%>" />
	<wtc:param value="<%=nodeId%>" />
	<wtc:param value="<%=note%>" />
	<wtc:param value="<%=login_no%>" />
	<wtc:param value="<%=selectId%>" />
	<wtc:param value="<%=cityid%>" />
	<wtc:param value="<%=flag%>" />
	<wtc:param value="<%=fullname%>"/>
	<wtc:param value="<%=orgCode%>"/>
	<wtc:param value="<%=ip_Addr%>"/>
</wtc:service>

<wtc:array id="rows" scope="end" />
<%
	if (rows[0][0].equals("000000")) {
	retCode = "000000";
	retMsg = "增加新节点成功！";
	
System.out.println("retCode_________"+retCode);
System.out.println("retMsg_________"+retMsg);
}


%>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
response.data.add("caption","<%=nodeName%>");
response.data.add("visible","<%=flag%>");
response.data.add("cityid","<%=cityid%>");
response.data.add("note","<%=note%>");
response.data.add("fullname","<%=fullname%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);