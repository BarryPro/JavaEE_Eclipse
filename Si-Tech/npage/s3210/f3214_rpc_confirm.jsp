 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-01-15 ҳ�����,�޸���ʽ
	********************/
%> 

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<% 

	String regionCode = (String)session.getAttribute("regCode");   
	String opName=(String)request.getParameter("opName");
	String error_code = "0";
	String error_msg="ϵͳ��������ϵͳ����Ա��ϵ";
	
	String[][] callData = new String[][]{};	
	
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	
	String verifyType = request.getParameter("verifyType");
	String opType = request.getParameter("opType");	
	String org_code  = request.getParameter("orgCode");	 /* ��������		   */
	String iRegion_Code = org_code.substring(0,2);
	String userPhone = (String)request.getParameter("lNo");
		
	String[] ParamsIn = null;		
	System.out.println("verifyType="+verifyType);

	ParamsIn = new String[26];
	ParamsIn[0]  = request.getParameter("loginNo");	 	/* ��������		   */
	ParamsIn[1]  = request.getParameter("orgCode");	 	/* ��������		   */
	ParamsIn[2]  = request.getParameter("opCode");	  /* ��������		   */
	ParamsIn[3]  = request.getParameter("op_note");	 	/* ������ע		   */
	ParamsIn[4]  = request.getParameter("GRPID");	   	/* ���ź�			 */
	ParamsIn[5]  = "0";   														/* �û�����		   */
	ParamsIn[6]  = request.getParameter("CLOSENO1");	/* �պ�Ⱥ��1		  */
	ParamsIn[7]  = request.getParameter("CLOSENO2");	/* �պ�Ⱥ��2		  */
	ParamsIn[8]  = request.getParameter("CLOSENO3");	/* �պ�Ⱥ��3		  */
	ParamsIn[9]  = request.getParameter("CLOSENO4");	/* �պ�Ⱥ��4		  */
	ParamsIn[10] = request.getParameter("CLOSENO5");	/* �պ�Ⱥ��5		  */
	ParamsIn[11] = request.getParameter("USERPIN1");	/* �û�����		   */
	ParamsIn[12] = request.getParameter("LOCKFLAG");	/* �û�������־	   */
	ParamsIn[13] = request.getParameter("FLAGS");	   	/* �û�����Ȩ�޼�	 */
	ParamsIn[14] = request.getParameter("STATUS");	  /* ״̬������		 */
	ParamsIn[15] = request.getParameter("USERTYPE");	/* �û�����		   */
	ParamsIn[16] = request.getParameter("OUTGRP");	  /* ������������	 */
	ParamsIn[17] = request.getParameter("MAXOUTNUM"); /* ������������	 */
	ParamsIn[18] = request.getParameter("FEEFLAG");	 	/* �����޶��־ѡ��   */
	ParamsIn[19] = request.getParameter("LMTFEE");	  /* �·����޶�		 */
	ParamsIn[20] = request.getParameter("PKGTYPE");	 	/* ���·��ʷ��ײ����� */
	ParamsIn[21] = "0";								  							/* �����û�Ʒ��	   */
	ParamsIn[22] = request.getParameter("PKGDAY");	  /* �ʷ��ײ���Ч����   */
	ParamsIn[23] = request.getParameter("strType");	   	/* ��������		   */
	ParamsIn[24] = request.getParameter("tmpR2");	   	/* ���봮����		 */
	ParamsIn[25] = request.getParameter("unit_id_id"); /*��ʵunit_id luxc10070117add*/
%>

<%
	if( opType.equals("u") ){
		//callData = callView.callService("s3214Cfm", ParamsIn, "2", "region", iRegion_Code);
	%>
	 <wtc:service name="s3214Cfm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
			<wtc:params value="<%=ParamsIn%>" />
   	</wtc:service>
    	<wtc:array id="callData1" scope="end" />	
	<%	
	callData=callData1;
	error_code=retCode1;
	error_msg=retMsg1;
	
}	

	//error_code = callView.getErrCode();
	//error_msg= callView.getErrMsg(); 
	
	
	System.out.println("error_code========="+error_code);
    	System.out.println("error_msg============"+error_msg);
%>


var response = new AJAXPacket();
response.data.add("verifyType","<%= verifyType %>");
response.data.add("errorCode","<%= error_code %>");
response.data.add("errorMsg","<%= error_msg %>");

<%
	if (callData != null)
	{
%>
		response.data.add("backArrMsg","<%= callData[0][0] %>" );
		response.data.add("backArrMsg1","<%= callData[0][1] %>" );
<%      	System.out.println("backArrMsg========="+ callData[0][0] ); 
		System.out.println("backArrMsg1========"+callData[0][1]); 
	}else{
	%>
		response.data.add("backArrMsg","" );
		response.data.add("backArrMsg1","" );
	<%}
%>
core.ajax.receivePacket(response);
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<% System.out.println("wwwwwwwwwwwwwwwwwwf3214rpc_confirm");%>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+ParamsIn[2]+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg
		+"&opName="+opName+"&workNo="+ParamsIn[0]+"&loginAccept="+loginAccept+"&pageActivePhone="+userPhone
		+"&opBeginTime="+opBeginTime+"&contactId="+ParamsIn[4]+"&contactType=grp";
%>
	<jsp:include page="<%=url%>" flush="true" />
