<%
/********************
 version v2.0
 ������: si-tech
 update zhaohaitao at 2009.01.18
 ģ��:EC��Ʒ����
********************/
%>

<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<% 
	String regCode = (String)session.getAttribute("regCode");
	String sm_code = request.getParameter("sm_code");
	String retType = request.getParameter("retType");
	String service_name = "";
	String errCode = "";
	String errMsg = "";
	
	String createFlag = "";
	String pay_flag = "";
	
	String[] paraAray = new String[1];
	String[] retList = new String[] {  };
	//�õ�create_flag
	String sql = "select create_flag from sBusiTypeSmCode where busi_type='1000' and sm_code='"+sm_code+ "'";
	String[] inParams = new String[2];
	inParams[0] = "select create_flag from sBusiTypeSmCode where busi_type='1000' and sm_code=:sm_code";
	inParams[1] = "sm_code="+sm_code;
	service_name = "sPubSelect";
	paraAray[0] = sql;
	//retList = impl.callService(service_name, paraAray, "1");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result1"  scope="end"/>
<%
	
	if (errCode.equals("000000")) 
	{
		if (result1.length==0) 
		{
			errCode="1";
			errMsg = "create_flag��ѯΪ��!";
		}
		else
		{
			createFlag = result1[0][0];
		}
	}
	else
	{
	   errCode="1";
	   errMsg = "create_flag��ѯʧ��!";
	}
	System.out.println(">>>>>> createFlag="+createFlag);
	//�õ�pay_flag
	sql = "select pay_flag from sGrpSmCode where sm_code='"+sm_code+ "'";
	
	inParams[0] = "select pay_flag from sGrpSmCode where sm_code=:sm_code";
	inParams[1] = "sm_code="+sm_code;
	service_name = "sPubSelect";
	paraAray[0] = sql;
	//retList = impl.callService(service_name, paraAray, "1");
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="result2"  scope="end"/>
<%
	
	errCode = retCode2;
	errMsg = retMsg2;
	
	if (errCode.equals("000000")) 
	{
		if (result2.length==0) 
		{
			errCode="1";
			errMsg = "pay_flag��ѯΪ��!";
		}
		else
		{
			pay_flag = result2[0][0];
		}
		System.out.println(">>>>>> pay_flag="+pay_flag);
	}
	else
	{
		errCode="1";
		errMsg = "pay_flag��ѯʧ��!";
	}
	System.out.println("retCode====="+errCode);
%>
	
	var response = new AJAXPacket();
	var retType = "";
	var errCode = "";
	var retMsg = "";
	var createFlag = "";
	var pay_flag = "";
	
	retType = "<%=retType%>";
	errCode = "<%=errCode%>";
	retMsg = "<%=errMsg%>";
	createFlag = "<%=createFlag%>";
	pay_flag = "<%=pay_flag%>";
	
	response.data.add("retType",retType);
	response.data.add("retCode",errCode);
	response.data.add("retMsg",retMsg);
	response.data.add("createFlag",createFlag);
	response.data.add("pay_flag",pay_flag);
	
	core.ajax.receivePacket(response);
	
