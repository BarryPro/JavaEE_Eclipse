<%
  /*
   * ����: �û��������޸�2308
   * �汾: 1.0
   * ����: 2009/1/15
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>


<%
	 					//��������
	String phoneNo = request.getParameter("phoneNo").trim();					//�û�����
	String opCode = request.getParameter("opCode");						//��������
	String orgCode = request.getParameter("orgCode");					//��������
	String regionCode = (String)session.getAttribute("regCode");		//���д���
 
%>

 
 
	<wtc:service name="bs_sCodeMain" routerKey="region" routerValue="<%=regionCode%>" outnum="3" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=phoneNo%>"/>
 
	</wtc:service>
	<wtc:array id="mainInfo" scope="end"/>
<%
	String errCode = retCode;
	String errMsg = retMsg;
	String cust_name = "";
	String cust_id = "";
	String cust_addr = "";
	if(errMsg.equals("")){
		errMsg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errCode));
		if( errMsg.equals("null")){
			errMsg ="δ֪������Ϣ";
		}
	} 
	
	
	if(retCode.equals("0")||retCode.equals("000000"))
	{
			
		%>
			var response = new AJAXPacket();
			response.data.add("flag1","0");
			
			core.ajax.receivePacket(response);
		<%
	}
	else
	{
		%>
			var response = new AJAXPacket();
			response.data.add("flag1","1");
			response.data.add("errCode","<%=errCode%>");
			response.data.add("errMsg","<%=errMsg%>");
			core.ajax.receivePacket(response);
		<%
	}
	

%>
	
 