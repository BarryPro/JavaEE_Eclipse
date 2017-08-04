<%
/*
 * 功能: 
 * 版本: 1.0
 * 日期: liangyl 2017/06/06 关于协助开发手机代付宽带费用功能的函
 * 作者: liangyl
 * 版权: si-tech
*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String kdNo =  request.getParameter("kdNo");
	String[] inParas = new String[2];
	inParas[0]="SELECT m.cust_name,b.phone_no FROM dbroadbandmsg a,dcustmsg b,dcustdoc m WHERE cfm_login = :kdNo and a.id_no = b.id_no and b.cust_id = m.cust_id";
	inParas[1]="kdNo="+kdNo;
	String retCode11 = "";
	String retMsg11 = "";
try{		
%>
	<wtc:service name="TlsPubSelCrm"    retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>	
	</wtc:service>
	<wtc:array id="infoRet1" scope="end" />
	var infoArray = new Array();
<%
	retCode11 = retCode;
	retMsg11 = retMsg;
	if("000000".equals(retCode)){
		for(int i=0;i<infoRet1.length;i++){
			%>
				infoArray[<%=i%>] = new Array();
			<%
			for(int j=0;j<infoRet1[i].length;j++){
				%>
				infoArray[<%=i%>][<%=j%>] = "<%=infoRet1[i][j]%>";
				<%
			}
		}
	}
}catch(Exception e){
	System.out.println(e);
	retCode11 = "444444";
	retMsg11 = "服务未启动或不正常，请联系管理员！";
	%>
	var infoArray = new Array();
	<%
}
%>
var response = new AJAXPacket();
response.data.add("retCode","<%=retCode11%>");
response.data.add("retMsg","<%=retMsg11%>");
response.data.add("infoArray",infoArray);
core.ajax.receivePacket(response);                                                                                                                                                                                                                                                                                                                                                                         