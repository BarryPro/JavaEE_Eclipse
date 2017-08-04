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
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
    String flag =  request.getParameter("flag"); 
	String phone_no =  request.getParameter("phone_no"); 
	String tax_id = request.getParameter("tax_id");   
	String cust_id="";
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String s_qry_flag="";
	//xl add 一点支付的 flag传A
	if(flag=="A" ||flag.equals("A"))
	{
		//增加判断 需要是一点支付账号类型才可以 A

		String[] inParasA = new String[2];
		inParasA[0]="select to_char(con_cust_id) from dconmsg where contract_no=:s_con_no and account_type='A' ";
		inParasA[1]="s_con_no="+phone_no;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inParasA[0]%>"/>
			<wtc:param value="<%=inParasA[1]%>"/>
		</wtc:service>
		<wtc:array id="result_cust_A" scope="end"/>
		<%
			System.out.println("fsssssssssssssssssssssffffffffffffffffffff test result_cust_A.length is "+result_cust_A.length);
			if(result_cust_A.length>0)
			{
				cust_id=result_cust_A[0][0];
				//cust_id="23002348611";
				//cust_id="33005780155";
				s_qry_flag="1";//按手机号码查询
				flag="1";
				System.out.println("ffffffffffffffffffffffffffffff cust_id is "+cust_id);
			}
			else
			{
				%>
					alert("输入账号非一点支付账号!");
				<%
			}
	}
	else if(flag=="1" ||flag.equals("1"))
	{
		String[] inParas2 = new String[2];
		inParas2[0]="select trim(to_char(cust_id)) from dcustmsg where phone_no=:s_phone_No ";
		inParas2[1]="s_phone_No="+phone_no;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="1">
			<wtc:param value="<%=inParas2[0]%>"/>
			<wtc:param value="<%=inParas2[1]%>"/>
		</wtc:service>
		<wtc:array id="result_cust" scope="end"/>
		<%
		if(result_cust.length>0 )
		{
			cust_id=result_cust[0][0];
			//cust_id="23002348611";
			//cust_id="33005780155";
			s_qry_flag="1";//按手机号码查询
		}
		else
		{
			%>
				alert("查询手机号码失败!");
			<%
		}
	}
	else
	{
		s_qry_flag="0";
	}
	%>
	<wtc:service name="sTaxpayerQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="10">
			<wtc:param value="<%=cust_id%>"/>
			<wtc:param value="<%=tax_id%>"/>
			<wtc:param value="<%=flag%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" start="0"  length="1"/>
	<wtc:array id="result2" scope="end" start="1"  length="1"/>
	<wtc:array id="result_flag" scope="end" start="9"  length="1"/>
<%
	 String s_flag="";
	 String oCustId ="";
	 String oTaxpayerId ="";
	 String oTaxpayerType ="";
	 String oBillType ="";
	 String oUnitName ="";
	 String oAddress ="";
	 String oPhoneNo ="";
	 String oBankName ="";
	 String oBankAcount ="";
	 String oValidDate ="";
	 String oExpireDate ="";
	 String s_tax_no="";
	 String s_zf="";
	 if(retCode2=="000000" ||retCode2.equals("000000") &&result1.length>0)
	 {
		s_flag="Y";
		oCustId =result1[0][0];
		s_tax_no=result2[0][0];
		s_zf = result_flag[0][0];
		/*oTaxpayerId=result1[0][2];
		oTaxpayerId =result1[0][1];
		oTaxpayerType =result1[0][2];
		oBillType =result1[0][3];
		oUnitName =result1[0][4];
		oAddress =result1[0][5];
		oPhoneNo =result1[0][6];
		oBankName =result1[0][7];
		oBankAcount =result1[0][8];
		oValidDate =result1[0][9];
		oExpireDate =result1[0][10];*/
	 }
	 else
	 {
		 s_flag="N";
	 }
	 
%>
 
 
var response = new AJAXPacket();
 
var s_qry_flag =   "<%=s_qry_flag%>";
var s_flag = "<%=s_flag%>";
var oCustId = "<%=oCustId%>"; 
var s_tax_no = "<%=s_tax_no%>"; 
var s_zf = "<%=s_zf%>"; 
response.data.add("s_tax_no",s_tax_no); 
response.data.add("s_flag",s_flag); 
response.data.add("oCustId",oCustId);
response.data.add("s_qry_flag",s_qry_flag);
response.data.add("s_zf",s_zf);
core.ajax.receivePacket(response);



 
