<%
/*****************************
 * ģ�����ƣ��������պ�Ⱥ����
 * ����汾��version 1.0
 * �� �� ��: SI-TECH
 * ��    ��: shengzd
 * ����ʱ��: 2010-05-10
 *****************************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
  	String retType = request.getParameter("retType");
    String region_code = request.getParameter("region_code"); 
    String idType = request.getParameter("idType");
    String oldId = request.getParameter("oldId"); 
    String newId = "";
    String sqlStr = "SELECT MaxCloseNo.NEXTVAL FROM dual";
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1" routerKey="region" routerValue="<%=region_code%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%
  	String retCode = "7777777";      
    String retMessage = "ȡ�ͻ�ID����δ�ܳɹ�";
    String retnewId = "";
    
		if(result!=null&&result.length>0){
	    retnewId = result[0][0];
	    System.out.println("\n\n\n+++++++++++++++++++"+retnewId+"+++++++++++++++++++\n\n\n");
		} 
%>
		var response = new AJAXPacket();
		var retType = "";
		var retCode = "000000";
		var retMessage = ""
		var retnewId = "";
		retType = "<%=retType%>";
		retMessage = "<%=retMessage%>";
		retnewId = "<%=retnewId%>";
		response.data.add("retType",retType);
		response.data.add("retCode",retCode);
		response.data.add("retMessage",retMessage);
		response.data.add("retnewId",retnewId);
		core.ajax.receivePacket(response);
