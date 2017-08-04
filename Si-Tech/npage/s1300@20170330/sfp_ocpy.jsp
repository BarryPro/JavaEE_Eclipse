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
    String invoice_no = request.getParameter("ocpy_begin_no");
	String invoice_code = request.getParameter("bill_code");
	String payAccept  = request.getParameter("payAccept");
	String workno = (String)session.getAttribute("workNo");
	String paySeq  = request.getParameter("paySeq");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
//	String bill_code = request.getParameter("bill_code");
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
	//取消预占的时候 按照流水更新状态 改为未打印 
	String ocpy_begin_no="";
	String ocpy_end_no="";
	String ocpy_num="";
	String res_code="";
	String bill_code="";
	String bill_accept="";
	String s_invoice_flag="";
	String return_note="";

	String s_ret_code="";
	String s_ret_msg=""; 
	 
%>
 


	<wtc:service name="scancelInDB" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1"  outnum="8" >
 
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
	 
		<wtc:param value="6"/>
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
	<wtc:array id="bill_opy" scope="end"/>
 
<%
	s_ret_code=retCode1;
	s_ret_msg=retMsg1;
	if(bill_opy!=null&&bill_opy.length>0)
	{
		
	 
		s_code=bill_opy[0][1];//sql通过
		//bill_opy[0][0]="123123";
		//retCode1="123123";
		//s_ret_msg="手动写的报错原因";

		if(bill_opy[0][0]=="000000" ||bill_opy[0][0].equals("000000"))
		{
			 ocpy_begin_no=bill_opy[0][2];
			 ocpy_end_no=bill_opy[0][3];
			 ocpy_num=bill_opy[0][4];
	         res_code=bill_opy[0][5];
			 bill_code=bill_opy[0][6];
			 bill_accept=bill_opy[0][7];
			 s_invoice_flag="0";
		}
		else
		{
			s_flag="1";
			s_note=bill_opy[0][1];
		}
		
	}
	else
	{
		return_note=bill_opy[0][1];
		s_invoice_flag="1";
	}

%>
 
var response = new AJAXPacket();
var ocpy_begin_no = "<%=ocpy_begin_no%>";
var ocpy_end_no = "<%=ocpy_end_no%>";
var ocpy_num = "<%=ocpy_num%>"; 
var res_code = "<%=res_code%>";
var bill_code = "<%=bill_code%>"; 
var bill_accept = "<%=bill_accept%>"; 
var s_invoice_flag = "<%=s_invoice_flag%>"; 
var return_note = "<%=return_note%>";
var s_ret_code = "<%=s_ret_code%>";
var s_ret_msg = "<%=s_ret_msg%>";
 
response.data.add("s_ret_code",s_ret_code);
response.data.add("s_ret_msg",s_ret_msg);
response.data.add("return_note",return_note); 
response.data.add("ocpy_begin_no",ocpy_begin_no);
response.data.add("ocpy_end_no",ocpy_end_no);
response.data.add("ocpy_num",ocpy_num); 
response.data.add("res_code",res_code); 
response.data.add("bill_code",bill_code); 
response.data.add("bill_accept",bill_accept);
response.data.add("s_invoice_flag",s_invoice_flag);
 
core.ajax.receivePacket(response);

 

 
