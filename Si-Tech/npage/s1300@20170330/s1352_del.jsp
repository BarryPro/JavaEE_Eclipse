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
    String login_accept = request.getParameter("login_accept");
	String total_date = request.getParameter("total_date");
	total_date = total_date.substring(0,6);
	String workno = (String)session.getAttribute("workNo");
 
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
 
	String s_flag="";
	String s_note="";
	String s_code="";
	String pay_money = request.getParameter("pay_money");
	String phoneno = request.getParameter("phoneno");
 
	//取消预占的时候 按照流水更新状态 改为未打印 
	//xl add for 改为月分表 增加年月字段
	 
%>
 


	<wtc:service name="sDelFor1352" routerKey="region" routerValue="<%=regionCode%>"  outnum="2" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=total_date%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			s_flag="0";//调用成功
	 
		}
		else
		{
			s_flag="1";
	 
		}
		
	}
	else
	{
		s_flag="1";//sql运行异常
		s_note="发票取消执行异常";
	}
	
 
%>
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
 
 
response.data.add("s_flag",s_flag); 
core.ajax.receivePacket(response);

 

 
