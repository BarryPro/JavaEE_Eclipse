<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

	String opCode     = WtcUtil.repNull(request.getParameter("opCode"));
	String phoneNo    = WtcUtil.repNull(request.getParameter("phoneNo"));
	
  String workNo     = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String custName   = "";
	String custAddr   = "";
	
	System.out.println("---hejwa---------opCode-------------------"+opCode);
	System.out.println("---hejwa---------phoneNo------------------"+phoneNo);
	
	//7����׼�����
	
    String paraAray[]  = new String[9];
				   paraAray[0] = "";
				   paraAray[1] = "01";
				   paraAray[2] = opCode;
				   paraAray[3] = (String)session.getAttribute("workNo");
				   paraAray[4] = (String)session.getAttribute("password");
				   paraAray[5] = phoneNo;
				   paraAray[6] = "";
				   paraAray[7] = "";
				   paraAray[8] = "ͨ��phoneNo[" + activePhone + "]��ѯ�ͻ���Ϣ";
   
try{
%>
		<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="code" retmsg="msg" outnum="40" >
		      <wtc:param value="<%=paraAray[0]%>"/>
		      <wtc:param value="<%=paraAray[1]%>"/>
		      <wtc:param value="<%=paraAray[2]%>"/>
		      <wtc:param value="<%=paraAray[3]%>"/>
		      <wtc:param value="<%=paraAray[4]%>"/>
		      <wtc:param value="<%=paraAray[5]%>"/>
		      <wtc:param value="<%=paraAray[6]%>"/>
		      <wtc:param value="<%=paraAray[7]%>"/>
		      <wtc:param value="<%=paraAray[8]%>"/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		      <wtc:param value=""/>
		  </wtc:service>
		<wtc:array id="result_t2" scope="end" />		
			
<%
	retCode = code;
	retMsg = msg;


	System.out.println("--hejwa--------code--------------"+code);
	System.out.println("--hejwa--------msg---------------"+msg);
	
		if("000000".equals(retCode)){
        if(result_t2.length>0){
              custName = result_t2[0][5];
              custName = custName.trim();
              
              custAddr = result_t2[0][11];
              custAddr = custAddr.trim();
        }
    }
   
   System.out.println("--hejwa--------custName---------------"+custName);
   System.out.println("--hejwa--------custAddr---------------"+custAddr);

}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���sUserCustInfo��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("custName","<%=custName%>");
response.data.add("custAddr","<%=custAddr%>");


core.ajax.receivePacket(response);
