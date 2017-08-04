<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.lang.*"%>

<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
%>

<%
String czkkh = request.getParameter("czkkh");
String[] inParas_mz = new String[2];
inParas_mz[0]="select to_char(card_money) from dchncardres where card_no=:s_no and card_status ='2'";
inParas_mz[1]="s_no="+czkkh;
%>
<wtc:service name="TlsPubSelCrm"  retcode="retCodeims" retmsg="retMsgims" outnum="1">
		<wtc:param value="<%=inParas_mz[0]%>"/>
		<wtc:param value="<%=inParas_mz[1]%>"/>	
</wtc:service>
<wtc:array id="resultMz" scope="end" /> 

var response = new AJAXPacket();
<%
	String o_money = "";
	if(resultMz.length>0)
	{
		o_money=resultMz[0][0];
		%>
			response.data.add("flagMoney","0");//查询成果
			response.data.add("mz","<%=o_money%>");
		<%//成功的
	}
	else
	{
		o_money="0";
		%>
			response.data.add("flagMoney","1");//查询失败
			response.data.add("mz","<%=o_money%>");
		<%
	}
%>
 


core.ajax.receivePacket(response);
 
