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
//查询卡面值 和已充值金额
String phoneNo = request.getParameter("phoneNo");
String card_no = request.getParameter("card_no");

String[] inParas_ycz = new String[2];
inParas_ycz[0] = "select to_char(sum(nvl(add_pay_money,0))) from wChargeCardMsg where phone_no1=:s_no1 and phone_no2=:s_no2 and to_char(op_time,'YYYYMMDD')>'20121118' ";
inParas_ycz[1] = "s_no1="+phoneNo+",s_no2="+phoneNo;

String[] inParas_mz = new String[2];
inParas_mz[0]="select to_char(card_money) from dchncardres where card_no=:s_no and card_status ='2'";
inParas_mz[1]="s_no="+card_no;
%>
<wtc:service name="TlsPubSelBoss"  retcode="retCode_ycz" retmsg="retMsg_ycz" outnum="1">
		<wtc:param value="<%=inParas_ycz[0]%>"/>
		<wtc:param value="<%=inParas_ycz[1]%>"/> 
</wtc:service>
<wtc:array id="result_ycz" scope="end" />

<wtc:service name="TlsPubSelCrm"  retcode="retCode_mz" retmsg="retMsg_mz" outnum="1">
		<wtc:param value="<%=inParas_mz[0]%>"/>
		<wtc:param value="<%=inParas_mz[1]%>"/> 
</wtc:service>
<wtc:array id="result_mz" scope="end" />
var response = new AJAXPacket();
<%
	String s_ycz = "";
	String s_mz="";
	String s_flag="";//0-ok 1=false
	if(result_ycz.length>0 &&result_mz.length>0)
	{
		s_ycz=result_ycz[0][0];
		s_mz =result_mz[0][0]; 
		%>
			response.data.add("s_flag","0");
			response.data.add("s_ycz","<%=s_ycz%>");
			response.data.add("s_mz","<%=s_mz%>");
		<%
	}
	else
	{
		%>
			response.data.add("s_flag","1");
			response.data.add("s_ycz","<%=s_ycz%>");
			response.data.add("s_mz","<%=s_mz%>");
		<%
	}
%>


core.ajax.receivePacket(response);
 
