<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "b632";
	String opName = "三码合一裸机销售";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>
<%
	System.out.println("========= ningtn ======== fb632Cfm.jsp");
	String orgCode = (String)session.getAttribute("orgCode");
	String cust_name=request.getParameter("userName");
	String regionCode= (String)session.getAttribute("regCode");
	String loginAccept = request.getParameter("login_accept");
	String chnSource = "01";
	String workNo = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String password = (String)session.getAttribute("password");
	String phoneNo = request.getParameter("phone_no");
	String userPwd = "";
	String inSaleCode = request.getParameter("sale_code");			//营销代码
	String inCashPay = request.getParameter("sum_money");			//应付金额
	String inOpNote = request.getParameter("opNote");			//操作备注
	String inIpAddr = (String)session.getAttribute("ipAddr");;			//IP地址
	String inMachType = request.getParameter("phone_typename");			//手机型号
	String inImeiNo = request.getParameter("IMEINo");			//iMei
	String inModLoginAccept = request.getParameter("updateAccept");	//修改绑定关系使用的操作流水
	String inBxBegin = request.getParameter("payTime");			//付机时间
	String inBxMonth = request.getParameter("repairLimit");			//保修时限
	String iOldImei = request.getParameter("oldimei");
	String iActiveDate = request.getParameter("activedate");
	
	String paraAray[] = new String[18];
	paraAray[0] = loginAccept;
	paraAray[1] = chnSource;
	paraAray[2] = opCode;
	paraAray[3] = workNo;
	paraAray[4] = password;
	paraAray[5] = phoneNo;
	paraAray[6] = userPwd;
	paraAray[7] = inSaleCode;
	paraAray[8] = inCashPay;
	paraAray[9] = inOpNote;
	paraAray[10] = inIpAddr;
	paraAray[11] = inMachType;
	paraAray[12] = inImeiNo;
	paraAray[13] = inModLoginAccept;
	paraAray[14] = inBxBegin;
	paraAray[15] = inBxMonth;
	paraAray[16] = iOldImei;
	paraAray[17] = iActiveDate;
%>
<wtc:service  name="sb632Cfm" routerKey="region" routerValue="<%=orgCode%>" 
			outnum="2"  retcode="errCode" retmsg="errMsg">
		<wtc:param  value="<%=paraAray[0]%>"/>
		<wtc:param  value="<%=paraAray[1]%>"/>
		<wtc:param  value="<%=paraAray[2]%>"/>
		<wtc:param  value="<%=paraAray[3]%>"/>
		<wtc:param  value="<%=paraAray[4]%>"/>
		<wtc:param  value="<%=paraAray[5]%>"/>
		<wtc:param  value="<%=paraAray[6]%>"/>
		<wtc:param  value="<%=paraAray[7]%>"/>
		<wtc:param  value="<%=paraAray[8]%>"/>
		<wtc:param  value="<%=paraAray[9]%>"/>
		<wtc:param  value="<%=paraAray[10]%>"/>
		<wtc:param  value="<%=paraAray[11]%>"/>
		<wtc:param  value="<%=paraAray[12]%>"/>
		<wtc:param  value="<%=paraAray[13]%>"/>
		<wtc:param  value="<%=paraAray[14]%>"/>
		<wtc:param  value="<%=paraAray[15]%>"/>
		<wtc:param  value="<%=paraAray[16]%>"/>
		<wtc:param  value="<%=paraAray[17]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+paraAray[0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println(url);
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(paraAray[8],2);
		String outParaNums= "4";
	
%>
		<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" 
			outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
		</wtc:service>
		<wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
		String chinaFee =chinaFee1[0][0];
		System.out.print(chinaFee);
%>
		<script language="JavaScript">
			rdShowMessageDialog("提交成功! 下面将打印发票！");
			var infoStr="";
			infoStr+="<%=workNo%>  <%=paraAray[0]%>"+"      三码合一裸机销售"+"|";//工号
			infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			infoStr+='<%=cust_name%>'+"|";
			infoStr+=" "+"|";
			infoStr+='<%=paraAray[5]%>'+"|";
			infoStr+=" "+"|";//协议号码
			infoStr+="手机型号: "+'<%=paraAray[11]%>'+"|";
			infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   			infoStr+="<%=WtcUtil.formatNumber(paraAray[8],2)%>"+"|";//小写
   			infoStr+="缴款合计：<%=paraAray[8]%>元"+"|";
   			infoStr+="<%=work_name%>"+"|";
	 		infoStr+=" "+"|";//收款人
	 		infoStr+="IMEI码：<%=paraAray[12]%>"+"|";
	 		infoStr+=" "+"|";
	 		alert(infoStr);
	 		location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sb631/fb632.jsp?activePhone=<%=phoneNo%>%26opCode=<%=opCode%>";
		</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("三码合一裸机销售失败!(<%=errCode%><%=errMsg%>",0);
	window.location="fb632.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>
