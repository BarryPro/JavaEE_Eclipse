<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
 
<%
    String dzhm = request.getParameter("dzhm");
	String dzdm = request.getParameter("dzdm");
	String kyny = request.getParameter("kyny");
	String phone_no = request.getParameter("phone_no");
//select nvl(sum(xmdj*xmsl),0) from winvoice201702 where phone_no='15046775560' and  fp_hm='01184139' and fp_dm='023001600211';
	String s_invoice = "winvoice"+kyny;
	String[] inParas = new String[2];
	String s_money="";
	String s_flag="";
	inParas[0]="select to_char(nvl(sum(xmdj*xmsl),0)) from "+s_invoice+" where phone_no=:s_2 and  fp_hm=:s_3 and fp_dm=:s_4";
	inParas[1]="s_2="+phone_no+",s_3="+dzhm+",s_4="+dzdm;
%>
	<wtc:service name="TlsPubSelBoss"  outnum="1" >
 
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		
		s_money=bill_cancel[0][0];
		s_flag="0";
	}
	else
	{
		s_flag="1";//sql运行异常
		 
	}
	
 
%>
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
var s_money = "<%=s_money%>";
 
 
 
response.data.add("s_flag",s_flag);
response.data.add("s_money",s_money);
 
core.ajax.receivePacket(response);

 

 
