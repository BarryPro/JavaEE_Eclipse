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
    String invoice_no = request.getParameter("ocpy_begin_no");
	String invoice_code = request.getParameter("bill_code");
	String payAccept  = request.getParameter("payAccept");
	String workno = (String)session.getAttribute("workNo");
	String paySeq  = request.getParameter("paySeq");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
	String bill_code = request.getParameter("bill_code");
	String s_flag="";
	String s_note="";
	String s_code="";
	String userName =  request.getParameter("userName");
	String op_code = request.getParameter("op_code");
	String phoneNo = request.getParameter("phoneNo");
	String payMoney = request.getParameter("payMoney");

	System.out.println("payMoney--------------------------------"+payMoney);
	if("d340".equals(op_code)){
		phoneNo="0";
	}
	String contractno = request.getParameter("contractno");
				System.out.println("contractno--------------------------------"+contractno);
	if(contractno==null||"".equals(contractno)){
        	contractno="0";
   }
	//ȡ��Ԥռ��ʱ�� ������ˮ����״̬ ��Ϊδ��ӡ 
%>
 


	<wtc:service name="scancelInDB" routerKey="region" routerValue="<%=regionCode%>"  outnum="8" >
 
		<wtc:param value="<%=paySeq%>"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value=""/> 
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="0"/>
		<wtc:param value="<%=contractno%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=invoice_no%>"/>
		<wtc:param value="<%=invoice_code%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=payMoney%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
	 
		<wtc:param value="5"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
 
		<wtc:param value="<%=userName%>"/>
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=groupId%>"/> 
		<wtc:param value="1"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa bill_cancel is "+bill_cancel+" and bill_cancel.length is "+bill_cancel.length);
		s_code=bill_cancel[0][1];//sqlͨ��
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			s_flag="0";//���óɹ�
			bill_code =bill_cancel[0][6];
			s_note="��Ʊȡ��ִ�гɹ�";
		}
		else
		{
			s_flag="1";
			s_note=bill_cancel[0][1];
		}
		
	}
	else
	{
		s_flag="1";//sql�����쳣
		s_note="��Ʊȡ��ִ���쳣";
	}
	
	System.out.println("cccccccccccccccccccccccccccc s_flag is "+s_flag+" and bill_code is "+bill_code+" and s_note is "+s_note+" and bill_code is "+bill_code);
%>
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
var s_code = "<%=s_code%>";
var s_note = "<%=s_note%>"; 
var s_invoice_code = "<%=bill_code%>"; 
 
response.data.add("s_flag",s_flag);
response.data.add("s_code",s_code);
response.data.add("s_note",s_note); 
response.data.add("s_invoice_code",s_invoice_code); 
core.ajax.receivePacket(response);

 

 
