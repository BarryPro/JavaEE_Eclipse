<%
  /*
   * ����: ������û���ǰ֤�����ͣ��Ƿ������֤
   * �汾: 1.0
   * ����: 2015/3/11 
   * ����: diling
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<% 
  String regionCode=(String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");  
	String passwd = ( String )session.getAttribute ( "password" );
	String ipAddr = ( String )session.getAttribute ( "ipAddr" );
	String opCode=(String)request.getParameter("opCode");
	String phone_no=(String)request.getParameter("phone_no");
	String g_CustId=(String)request.getParameter("g_CustId");
	String opNote = "����phone_no:"+phone_no+"��ѯ�û�����,�������Ϣ.";
  String isExitCustFlag = "N";
  String userIdType = "";
%>
<wtc:service name = "sUserCustInfo"  outnum = "50" routerKey = "region" routerValue = "<%=regionCode%>" 	retcode = "retCode" retmsg = "retMsg"  >
	<wtc:param value = "0"/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
		
	<wtc:param value = "<%=ipAddr%>"/>
	<wtc:param value = "<%=opNote%>"/>
	<wtc:param value = "<%=g_CustId%>"/>
	
	<wtc:param value = ""/>
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result1" start="1" length="28" scope="end"/>
<wtc:array id="result2" start="30" length="11" scope="end"/> 	
<%
  if(retCode.equals("000000")){
  	if(returnFlag.length > 0){ //���ر�ʶ  ���ڿͻ�
  		if("01".equals(returnFlag[0][0])){ //������һ���û�����û���û�
  			if(result2.length > 0){ //�û���Ϣ�Ƿ���� >0
  				isExitCustFlag = "Y";
  			}else{ //û���û�
  				isExitCustFlag = "N";
  			}
  		}else if("02".equals(returnFlag[0][0])){ //����û� 
  			isExitCustFlag = "Y";
  		}
  		if(result1.length > 0){
  			userIdType = result1[0][11];
  		}
  	}else{ //û�пͻ�
  		isExitCustFlag = "N";
  	}
  }
%>
var response = new AJAXPacket();
response.data.add("isExitCustFlag","<%=isExitCustFlag%>");
response.data.add("userIdType","<%=userIdType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMsg","<%=retMsg%>");
core.ajax.receivePacket(response);

