<%
/********************
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------��̨��Ա�����ĸ�--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//���巵������
<%

	String prod_id     = WtcUtil.repNull(request.getParameter("prod_id"));
	String unit_id     = WtcUtil.repNull(request.getParameter("unit_id"));
	String c_prod_id   = WtcUtil.repNull(request.getParameter("c_prod_id"));
	String opCode      = WtcUtil.repNull(request.getParameter("opCode"));
	
	System.out.println("-----hejwa----prod_id------------------>"+prod_id);
	System.out.println("-----hejwa----unit_id------------------>"+unit_id);
	System.out.println("-----hejwa----c_prod_id---------------->"+c_prod_id);
	System.out.println("-----hejwa----opCode------------------->"+opCode);
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String serverName = "sQ018Cfm";
	String result_count = "0";
	
	
	String paramIn = "";
	String param   = "";
if("3690".equals(opCode)){
	 paramIn =  " select count(1)  from dgrpusermsg a ,dgrpcustmsg b "+
										" where a.account_id = :prod_id "+
										" and a.cust_id = b.cust_id "+
										" and b.unit_id = :unit_id"+
										" and a.run_code = 'A'";
	 param	 = "prod_id="+prod_id+",unit_id="+unit_id;
}else{
	 paramIn =  " select count(1)  from dgrpusermsg a ,dgrpcustmsg b "+
										" where a.account_id = :prod_id and a.account_id <> :c_prod_id "+
										" and a.cust_id = b.cust_id "+
										" and b.unit_id = :unit_id "+
										" and a.run_code = 'A'";
	 param	 = "prod_id="+prod_id+",c_prod_id="+c_prod_id+",unit_id="+unit_id;
}		
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paramIn%>" />
		<wtc:param value="<%=param%>" />	
	</wtc:service>
	<wtc:array id="result_t" scope="end" />
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		result_count = result_t[0][0];
	}
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "���÷���"+serverName+"��������ϵ����Ա";
}
System.out.println("-----hejwa----result_count------------------>"+result_count);
%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_count","<%=result_count%>");
core.ajax.receivePacket(response);
