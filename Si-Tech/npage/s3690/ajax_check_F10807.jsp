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

	String F10807_val     = WtcUtil.repNull(request.getParameter("F10807_val"));
	String unit_id     = WtcUtil.repNull(request.getParameter("unit_id"));
	
  String regionCode = (String)session.getAttribute("regCode");
	String retCode    = "";
	String retMsg     = "";
	
	String result_count = "0";
	String paramIn =   
									" SELECT count(1)   "+
									" FROM dbvipadm.dgrpcontractinfo t   "+
									" WHERE t.contract_no = :F10807_val  "+
									" and t.charge_flag = '5' ";

System.out.println("-----------------paramIn--------------->"+paramIn);
										
	String param	 = "F10807_val="+F10807_val;
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
	retMsg = "���÷���TlsPubSelCrm��������ϵ����Ա";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("result_count","<%=result_count%>");
core.ajax.receivePacket(response);
