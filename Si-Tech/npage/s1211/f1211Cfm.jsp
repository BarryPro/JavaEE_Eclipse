<%
/********************
version v2.0
开发商: si-tech
update zhaohaitao at 2008.12.24
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<% request.setCharacterEncoding("GBK"); %>

<%  
	String region_code = (String)session.getAttribute("regCode");
	String work_no = (String)session.getAttribute("workNo");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String printAccept = request.getParameter("printAccept");
	String paraStr[]=new String[30];
	
	paraStr[0] = printAccept;
	paraStr[1] = "1211";
	paraStr[2] = request.getParameter("vWorkNo");
	paraStr[3] = request.getParameter("vWorkPaswd");
	paraStr[4] = request.getParameter("vOrgCode");
	paraStr[5]= request.getParameter("vConID");
	paraStr[6]= request.getParameter("vBankCode");
	paraStr[7]= request.getParameter("vPostCode");
	paraStr[8]= request.getParameter("vAcountNum");
	paraStr[9]= request.getParameter("vAcountName");
	paraStr[10]= request.getParameter("vCountType");
	paraStr[11]= request.getParameter("vCountStatus");
	paraStr[12]= request.getParameter("vPostFlag");
	paraStr[13]= request.getParameter("vPostType");
	paraStr[14]= request.getParameter("vPostAddress");
	paraStr[15]= request.getParameter("vFaxNo");
	paraStr[16]= request.getParameter("vPostZip");
	paraStr[17]= request.getParameter("vMailAddress");
	paraStr[18]= request.getParameter("vPayCode");
	paraStr[19]= WtcUtil.repStr(request.getParameter("vNewPaswd")," ");
	paraStr[19] = Encrypt.encrypt(paraStr[19]);
	paraStr[20]= request.getParameter("vHandFee");
	paraStr[21]= request.getParameter("vPayFee");
	paraStr[22]= WtcUtil.repStr(request.getParameter("vSysNote")," ");
	paraStr[23]= WtcUtil.repStr(request.getParameter("vSysNote")," ")+WtcUtil.repStr(request.getParameter("vOpNote")," ");
	paraStr[24]= request.getParameter("vIpAddress");
	paraStr[25]= request.getParameter("billOrder");
	paraStr[26]= request.getParameter("wm_counttype");
	paraStr[27]= request.getParameter("wm_paytype");
	paraStr[28]= request.getParameter("paycode");
	paraStr[29]= request.getParameter("vDocFlag");
	
	String vPhoneNo=WtcUtil.repStr(request.getParameter("vPhoneNo"),"0");
	if(!vPhoneNo.equals("0"))
	  paraStr[22]=vPhoneNo+"~"+paraStr[22];
/*
for(int i= 0; i< paraStr.length; i++)
{
	System.out.println("paraStr[" + i + "] = "+paraStr[i]);
}*/

	//S1227Impl s1211View = new S1227Impl();
	//String backMaxAccept =s1211View.s1211Cfm(paraStr);
%>
	<wtc:service name="s1211Cfm" routerKey="region" routerValue="<%=region_code%>" retcode="retCode" retmsg="retMsg" outnum="3">
		<wtc:param value="<%=paraStr[0]%>"/>
		<wtc:param value="<%=paraStr[1]%>"/>
		<wtc:param value="<%=paraStr[2]%>"/>
		<wtc:param value="<%=paraStr[3]%>"/>
		<wtc:param value="<%=paraStr[4]%>"/>
		<wtc:param value="<%=paraStr[5]%>"/>
		<wtc:param value="<%=paraStr[6]%>"/>
		<wtc:param value="<%=paraStr[7]%>"/>
		<wtc:param value="<%=paraStr[8]%>"/>
		<wtc:param value="<%=paraStr[9]%>"/>
		<wtc:param value="<%=paraStr[10]%>"/>
		<wtc:param value="<%=paraStr[11]%>"/>
		<wtc:param value="<%=paraStr[12]%>"/>
		<wtc:param value="<%=paraStr[13]%>"/>
		<wtc:param value="<%=paraStr[14]%>"/>
		<wtc:param value="<%=paraStr[15]%>"/>
		<wtc:param value="<%=paraStr[16]%>"/>
		<wtc:param value="<%=paraStr[17]%>"/>
		<wtc:param value="<%=paraStr[18]%>"/>
		<wtc:param value="<%=paraStr[19]%>"/>
		<wtc:param value="<%=paraStr[20]%>"/>
		<wtc:param value="<%=paraStr[21]%>"/>
		<wtc:param value="<%=paraStr[22]%>"/>
		<wtc:param value="<%=paraStr[23]%>"/>
		<wtc:param value="<%=paraStr[24]%>"/>
		<wtc:param value="<%=paraStr[25]%>"/>
		<wtc:param value="<%=paraStr[26]%>"/>
		<wtc:param value="<%=paraStr[27]%>"/>
		<wtc:param value="<%=paraStr[28]%>"/>
		<wtc:param value="<%=paraStr[29]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>


<%	
System.out.println("zhangyan@调用预约服务开始");
String iOpCode = 		"1211";
String iLoginNo = 		"";
String iLoginPwd = 		"";
String iPhoneNo = 		request.getParameter("vPhoneNo");	
String iUserPwd = 		"";
String inOpNote = 		"";
String iBookingId = 	request.getParameter("bookingId");
String iLoginAccept=	printAccept;
System.out.println("zhangyan@page=[f1211Cfm.jsp]iOpCode=["+iOpCode+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iLoginNo=["+iLoginNo+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iLoginPwd=["+iLoginPwd+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iPhoneNo=["+iPhoneNo+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iUserPwd=["+iUserPwd+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]inOpNote=["+inOpNote+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iBookingId=["+iBookingId+"]");
System.out.println("zhangyan@page=[f1211Cfm.jsp]iLoginAccept=["+iLoginAccept+"]");


String booking_url = "/npage/public/pubCfmBookingInfo.jsp?iOpCode="+iOpCode
	+"&iLoginNo="+iLoginNo
	+"&iLoginPwd="+iLoginPwd
	+"&iPhoneNo="+iPhoneNo
	+"&iUserPwd="+iUserPwd
	+"&inOpNote="+inOpNote
	+"&iLoginAccept="+iLoginAccept
	+"&iBookingId="+iBookingId;		 
System.out.println("zhangyan@page=[f1211Cfm.jsp]booking_url=["+booking_url+"]");
if (!iBookingId.equals(""))
{
%>
	<jsp:include page="<%=booking_url%>" flush="true" />
<%
	System.out.println("zhangyan@调用预约服务结束");
}
%>

<%
	String backMaxAccept = result[0][0];
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&retMsgForCntt="+retMsg+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+backMaxAccept+"&pageActivePhone="+""+"&opBeginTime="+opBeginTime+"&contactId="+paraStr[5]+"&contactType=acc";
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
   /*if(Integer.parseInt(backMaxAccept) > 0) wangmei add 20051105 */
System.out.println("retcode = "+retCode);
	if(!retCode.equals("000000"))
	{
			%>
		<script>
		rdShowMessageDialog("<%=retMsg%>帐户资料变更失败!",0);
		location = "f1211Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>";
		</script>
		<%	
	}
	else if(backMaxAccept!="0")
   {
	   if(Double.parseDouble(paraStr[21])==0)
	   {
%>
		<script>
			rdShowMessageDialog("<%=paraStr[5]%>帐户资料变更成功!",2);
			location = "f1211Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>";
		</script>
	<%
	   }
		else
		{
	%>
		<script>
		rdShowMessageDialog("<%=paraStr[5]%>帐户资料修改成功! 下面将打印发票！",2);
		var infoStr="";
	     infoStr+="<%=paraStr[5]%>"+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+=" "+"|";
	     infoStr+=" "+"|";
	     infoStr+=" "+"|";
	     infoStr+="<%=paraStr[9]%>"+"|";
	     infoStr+="帐户资料变更。*手续费："+"<%=paraStr[21]%>"+"*流水号："+"<%=backMaxAccept%>"+"|";
		 location="/npage/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1211/f1211Main.jsp?opName=<%=opName%>%26opCode=<%=opCode%>";

		</script>
	<%
		}
   }
	else
	{
	%>
	<script>
		rdShowMessageDialog("<%=paraStr[5]%>帐户资料变更失败!",0);
		location = "f1211Main.jsp?opName=<%=opName%>&opCode=<%=opCode%>";
	</script>
<%	
	}
%>
