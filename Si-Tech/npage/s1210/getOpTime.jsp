<%
  /*
   * ����: �жϴ˴λ��������ϴο���/����ʱ����30��֮�� 1220
   * �汾: 1.8.2
   * ����: 2011/6/16
   * ����: huangrong
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String regionCode = (String) session.getAttribute("regCode");
  
  String olderSimNo =  request.getParameter("olderSimNo");
	String verifyType = request.getParameter("verifyType");
	String opTimeFlag="0";
	String opTimeSql=" select count(*)  from dsimres a where a.sim_no = :vOlderSimNo  and a.op_time between (sysdate - 30) and sysdate";
  String [] paraIn = new String[2];
  paraIn[0] = opTimeSql;
  paraIn[1]="vOlderSimNo="+olderSimNo;
%>	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="1">
<wtc:param value="<%=paraIn[0]%>"/>
<wtc:param value="<%=paraIn[1]%>"/>
</wtc:service>
<wtc:array id="opTimeStr" scope="end" />	
<%		
	if(retCode.equals("000000"))
  {	
		if(opTimeStr.length>0)
		{
		opTimeFlag=opTimeStr[0][0];	
		}
  }
%>	
var response = new AJAXPacket();
response.data.add("verifyType","<%=verifyType%>");
response.data.add("opTimeFlag","<%=opTimeFlag%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMsg%>");
core.ajax.receivePacket(response);


