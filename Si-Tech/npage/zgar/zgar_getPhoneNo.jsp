<%
/********************
 version v2.0
开发商: si-tech
*
*create:wanghfa@2010-8-16 校验密码是否正确
*
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String workNo = (String)session.getAttribute("workNo");
	String qry_type =  WtcUtil.repStr(request.getParameter("qry_type"),"");//号码类型
	String phone_no = WtcUtil.repStr(request.getParameter("qryvalue"),""); //号码
	String paraAray[] = new String[2];
	System.out.println("ffffffffffffffffffffffftttt qry_type is "+qry_type+" and phone_no is "+phone_no);
	int i_count=0;
	String s_phone_no_out="";
	String s_count="";
	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");
	String s_flag="";//Y=通过 N=未通过
	String retCode_mm="";
	String retMsg_mm="";
	if(qry_type=="0"||qry_type.equals("0"))
	{
		paraAray[0]="select trim(to_char(phone_no)) from dcustmsg where phone_no =:s_no";
		paraAray[1]="s_no="+phone_no;
	}
	else if(qry_type=="1"||qry_type.equals("1"))
	{
		//判断号码开头 10648的需要转义
		if(phone_no.substring(0,5)=="10648"||phone_no.substring(0,5).equals("10648"))
		{
			System.out.println("ttttttttttttttttttttttaaaaaaaaaaaaaaaaaaaaaaaa");
			paraAray[0]="select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno =:s_no";
			paraAray[1]="s_no="+phone_no;
		}
		else
		{
			System.out.println("bddddddddsssssssssssssssssssssbbbbbbbbbbbbbbbbbbbbbbbbbb");
			paraAray[0]="select trim(to_char(phone_no)) from dcustmsg where phone_no =:s_no";
			paraAray[1]="s_no="+phone_no;
		}
		 
	}
	else if(qry_type=="2"||qry_type.equals("2"))
	{
		paraAray[0]="select trim(to_char(phone_no)) from dbroadbandmsg where cfm_login=:s_no ";//宽带
		paraAray[1]="s_no="+phone_no;
	}
	//3=离网的 4=虚拟的集团的 5=一点支付的
	//其他的咋弄呢 校验号码合法性 离网的看dead表是否有记录 虚拟的看集团那个表 一点支付的看account_type
	else if(qry_type=="3"||qry_type.equals("3")) 
	{
		paraAray[0]="select to_char(count(0)) from dcustmsgdead where phone_no=:s_no ";
		paraAray[1]="s_no="+phone_no;
		//不需要进行密码校验
	}
	else if(qry_type=="4"||qry_type.equals("4")) 
	{
		paraAray[0]="select to_char(count(0)) from dvirtualgrpmsg where unit_id=:s_no ";
		paraAray[1]="s_no="+phone_no;
	}
	else if(qry_type=="5"||qry_type.equals("5")) 
	{
		paraAray[0]="select to_char(count(0)) from dconmsg where contract_no=:s_no and account_type='A' ";
		paraAray[1]="s_no="+phone_no;
	}
	
%>
<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode" retmsg="retMsg" outnum="5">
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	if(result.length>0)
	{
		s_phone_no_out=result[0][0];
	}
	//密码校验的begin 只有 0 1 2的才校验 phone_no s_phone_no_out
	if(qry_type=="0"||qry_type.equals("0")||qry_type=="1"||qry_type.equals("1")||qry_type=="2"||qry_type.equals("2"))
	{
		%>
		<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode2" retmsg="retMsg2" outnum="5">
			<wtc:param value="01"/>
			<wtc:param value="<%=s_phone_no_out%>"/>
			<wtc:param value="<%=custPaswd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=workNo%>"/>
		</wtc:service>
		<wtc:array id="result_mm" scope="end"/>
		<%
		 retCode_mm=retCode2;
		 retMsg_mm=retMsg2;

	}
	
	//end of 密码校验
%>
var response = new AJAXPacket();
var retResult = "<%=retCode%>";
var msg = "<%=retMsg%>";
var retResult = "<%=retCode_mm%>";
var retResultMsg = "<%=retMsg_mm%>";
response.data.add("s_phone_no_out","<%=s_phone_no_out%>");
response.data.add("qry_type","<%=qry_type%>");
response.data.add("retResult","<%=retCode_mm%>");
response.data.add("retResultMsg","<%=retMsg_mm%>");
core.ajax.receivePacket(response);
