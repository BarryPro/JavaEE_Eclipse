<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
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
 
	//ȡ��Ԥռ��ʱ�� ������ˮ����״̬ ��Ϊδ��ӡ 
	//xl add for ��Ϊ�·ֱ� ���������ֶ�
	 
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
			s_flag="0";//���óɹ�
	 
		}
		else
		{
			s_flag="1";
	 
		}
		
	}
	else
	{
		s_flag="1";//sql�����쳣
		s_note="��Ʊȡ��ִ���쳣";
	}
	
 
%>
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
 
 
response.data.add("s_flag",s_flag); 
core.ajax.receivePacket(response);

 

 
