<%
  /*
   * ����: 4G��������¼�� m036
   * �汾: 1.0
   * ����: 2014/1/13 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String simNo = request.getParameter("simNo");
	String opCode = request.getParameter("opCode");
	String v_phoneNo = request.getParameter("phoneNo");
	String shenhestate = request.getParameter("shenhestate");

	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String regCode=(String)session.getAttribute("regCode");
	String notes = workNo+"�Ժ���"+v_phoneNo+"�������";
		String num = WtcUtil.repNull((String)request.getParameter("num"));
	String state = WtcUtil.repNull((String)request.getParameter("state"));
	String otherResn = WtcUtil.repNull((String)request.getParameter("otherResn"));
	String dingdanliushui="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

	<wtc:service name="sm145Cfm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4" >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="m145"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=v_phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=notes%>"/>
		<wtc:param value="<%=shenhestate%>"/>
		<wtc:param value="<%=otherResn%>"/>
	</wtc:service>
	<wtc:array id="result"  scope="end" />
<%
	if(retCode2.equals("000000")) {
			if(result.length>0) {
				dingdanliushui=result[0][0];
			}
	}
%>

var response = new AJAXPacket();
response.data.add("retCode2","<%=retCode2%>");
response.data.add("retMsg2","<%=retMsg2%>");
response.data.add("num","<%=num%>");
response.data.add("state","<%=state%>");
response.data.add("dingdanliushui","<%=dingdanliushui%>");
response.data.add("shenhestate","<%=shenhestate%>");
core.ajax.receivePacket(response);
