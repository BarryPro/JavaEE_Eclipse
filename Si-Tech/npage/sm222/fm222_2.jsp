<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-29 14:53:49-------------------
 ���Ķ���tabΪһ��tab��ҳ��ԭ����ֱ�Ӳ�ѯ�ŵ�ajax�в�ѯ
 -------------------------��̨��Ա����--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

 	  String retCode  = "";
	  String retMsg   = "";
	
		String custName = "";
		/*�û�״̬*/
		String run_code = "";
		/*�û��ϴ�״̬��־*/
		String run_code_last = "";
		/*�û��ϴ�״̬����*/
		String run_name_last = "";
		/*�û���ǰ״̬��־*/
		String run_code_now = "";
		/*�û���ǰ״̬����*/
		String run_name_now = "";
		
try{

 		String opCode      = (String)request.getParameter("opCode");
		String opName      = (String)request.getParameter("opName");
		String phoneNo     = (String)request.getParameter("phoneNo");
		String loginAccept = (String)request.getParameter("loginAccept");
/*		
		System.out.println("------hejwa------------opCode----------->"+opCode);
		System.out.println("------hejwa------------opName----------->"+opName);
		System.out.println("------hejwa------------phoneNo---------->"+phoneNo);
		System.out.println("------hejwa------------loginAccept------>"+loginAccept);
*/		
    String regionCode  = (String)session.getAttribute("regCode");
    String loginNo     = (String)session.getAttribute("workNo");
 		String noPass      = (String)session.getAttribute("password");
 		String groupID     = (String)session.getAttribute("groupId");
		String ipAddrM     = (String)session.getAttribute("ipAddr");

		
		
 		String inst = "ͨ��phoneNo[" + phoneNo + "]��ѯ";
	
		
		
%>
  	
   <wtc:service name="sUserCustInfo" outnum="41"  retmsg="msg" retcode="code"  >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
	<wtc:array id="result11" scope="end" />
<%
	
	retCode = code;
	retMsg = msg;
 	if(result11.length <= 0){
 		retCode = "m222_ERR1";
 		retMsg = "���û����������û���״̬��������";
	}else{
		custName = result11[0][5];
	}
%>
	
	<wtc:service name="sUserInfoQry" outnum="51"  retmsg="msg1" retcode="code1" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
  </wtc:service>
	<wtc:array id="result22" scope="end" />
<%		
		retCode = code1;
		retMsg = msg1;
		if(result22.length > 0){
			/*�û�״̬*/
			run_code = result22[0][29];
			/*�û��ϴ�״̬��־*/
			run_code_last = result22[0][30];
			/*�û��ϴ�״̬����*/
			run_name_last = result22[0][31];
			/*�û���ǰ״̬��־*/
			run_code_now = result22[0][32];
			/*�û���ǰ״̬����*/
			run_name_now = result22[0][33];
		}
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���sUserInfoQry��������ϵ����Ա";
}

/*
		System.out.println("------hejwa------------retCode----------->"+retCode);
		System.out.println("------hejwa------------retMsg------------>"+retMsg);
		System.out.println("------hejwa------------run_code---------->"+run_code);
		System.out.println("------hejwa------------run_code_last----->"+run_code_last);
		System.out.println("------hejwa------------run_name_last----->"+run_name_last);
		System.out.println("------hejwa------------run_code_now------>"+run_code_now);
		System.out.println("------hejwa------------run_name_now------>"+run_name_now);
		System.out.println("------hejwa------------custName---------->"+custName);
*/		
		
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("run_code","<%=run_code%>");
response.data.add("run_code_last","<%=run_code_last%>");
response.data.add("run_name_last","<%=run_name_last%>");
response.data.add("run_code_now","<%=run_code_now%>");
response.data.add("run_name_now","<%=run_name_now%>");
response.data.add("custName","<%=custName%>");
core.ajax.receivePacket(response);
