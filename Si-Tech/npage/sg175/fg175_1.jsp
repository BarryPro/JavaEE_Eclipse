<%
  /*
   * ����:
   * �汾: 1.0
   * ����: 
   * ����: gaopeng
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
/*************************************************************
  *@ ��������:sPosPayPre
  *@ ��������:20121009
  *@ ����汾:1.0
  *@ ������Ա:
  *@ ��������:ʵ��pos������ҵ���ύ��һ�ε���MIS-POS�����յ����з��غ󣬽�������Ϣ���浽���ݿ���
  *@ �������:
  *@     iLoginAccept  ��ˮ
  *@		 iChnSource    ������ʶ(��������01-BOSS��02-����Ӫҵ����
                             03-����Ӫҵ����04-����Ӫҵ����05-��ý���ѯ����06-10086)
  *@		 iOpCode       ��������	
  *@		 iLoginNo      ����
  *@		 iLoginPwd     ��������
  *@		 iPhoneNo,     �û�����
  *@		 iUserPwd,     ��������
  *@     iPayType      �ɷ�����
  *@     iPayFee       �ɷѽ��
  *@     iCatdNo       �����к�
  *@     iInstNum      ���ڸ�������
  *@     iResponseTime ԭ��������
  *@     iTerminalId   ԭ�����ն˺�
  *@     iRrn          ԭ����ϵͳ������
  *@     iRequestTime  �ύ����
  *@     iOtherS       Ԥ���ֶ�
  *@
  *@ ���ز���:
  *@    SVC_ERR_NO32,oRetCode ������Ϣ����
  *@    SVC_ERR_MSG32,oRetMsg  ������Ϣ        
  **************************************************************/


	/*===========��ȡ����============*/
	String  regionCode     = (String)session.getAttribute("regCode");
  String  iLoginAccept   = (String)request.getParameter("iLoginAccept");  
  String  iChnSource     = (String)request.getParameter("iChnSource");  
  String  iOpCode        = (String)request.getParameter("iOpCode"); 
  String  iLoginNo       = (String)request.getParameter("iLoginNo");
  String  iLoginPwd      = (String)request.getParameter("iLoginPwd");
  String  iPhoneNo       =  (String)request.getParameter("iPhoneNo");
  String  iUserPwd       = (String)request.getParameter("iUserPwd");
  String  iPayType       = (String)request.getParameter("iPayType");
  String  iPayFee        = (String)request.getParameter("iPayFee");
  String  iCatdNo        = (String)request.getParameter("iCatdNo");
  String  iInstNum       = (String)request.getParameter("iInstNum");
  String  iResponseTime  = (String)request.getParameter("iResponseTime");
  String  iTerminalId    = (String)request.getParameter("iTerminalId"); 
  String  iRrn           = (String)request.getParameter("iRrn"); 
  String  iRequestTime   = (String)request.getParameter("iRequestTime"); 
  String  iOtherS        = (String)request.getParameter("iOtherS"); 
%>
<wtc:service name="sPosPayPre" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="2">
		<wtc:param value="<%=iLoginAccept%>" />
		<wtc:param value="<%=iChnSource%>" />
		<wtc:param value="<%=iOpCode%>" />
		<wtc:param value="<%=iLoginNo%>" />
		<wtc:param value="<%=iLoginPwd%>" />
		<wtc:param value="<%=iPhoneNo%>" />
		<wtc:param value="<%=iUserPwd%>" />
		<wtc:param value="<%=iPayType%>" />
		<wtc:param value="<%=iPayFee%>" />
		<wtc:param value="<%=iCatdNo%>" /> 
		<wtc:param value="<%=iInstNum%>" />
		<wtc:param value="<%=iResponseTime%>" />
		<wtc:param value="<%=iTerminalId%>" />  
		<wtc:param value="<%=iRrn%>" />
		<wtc:param value="<%=iRequestTime%>" />
		<wtc:param value="<%=iOtherS%>" />
 	</wtc:service>
	<wtc:array id="result1" scope="end" />



	var response = new AJAXPacket();
	response.data.add("retCode12","<%=errCode%>");
	response.data.add("retMsg12","<%=errMsg%>");
	core.ajax.receivePacket(response);
