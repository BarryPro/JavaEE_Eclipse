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

	//1322的
	String grp_phone_no = request.getParameter("grp_phone_no");
	String grp_contract_no = request.getParameter("grp_contract_no");
	String s_money = request.getParameter("s_money");
	String s_accepts = request.getParameter("s_invoice_accept");
	System.out.println("cccccccccccccccccccc aaaaaaaaaaaaa test grp_phone_no is "+grp_phone_no); 
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
	if(bill_opy!=null&&bill_opy.length>0)
	{
		
	 
		s_code=bill_opy[0][1];//sql通过
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

//1322的
var grp_phone_no = "<%=grp_phone_no%>"; 
var grp_contract_no = "<%=grp_contract_no%>"; 
var s_money = "<%=s_money%>"; 
var s_accepts = "<%=s_accepts%>"; 
 
response.data.add("ocpy_begin_no",ocpy_begin_no);
response.data.add("ocpy_end_no",ocpy_end_no);
response.data.add("ocpy_num",ocpy_num); 
response.data.add("res_code",res_code); 
response.data.add("bill_code",bill_code); 
response.data.add("bill_accept",bill_accept);
response.data.add("s_invoice_flag",s_invoice_flag);
response.data.add("grp_phone_no",grp_phone_no);
response.data.add("grp_contract_no",grp_contract_no);
response.data.add("s_money",s_money);
response.data.add("s_accepts",s_accepts);
core.ajax.receivePacket(response);

 

 
