<%
  /*
   * 功能: 外网高端客户带机转网
   * 版本: 1.0
   * 日期: 20110524
   * 作者: 王怀峰wanghfa
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<%
	String opCode = WtcUtil.repStr(request.getParameter("opCode"), "");
	String opName = WtcUtil.repStr(request.getParameter("opName"), "");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");
	String workName = (String)session.getAttribute("workName");
	String phone = WtcUtil.repStr(request.getParameter("activePhone"), "");
	String backAccept = request.getParameter("backAccept");
	String custName = WtcUtil.repStr(request.getParameter("custName"), "");
	String custAddr = WtcUtil.repStr(request.getParameter("custAddr"), "");
	String salePrice = WtcUtil.repStr(request.getParameter("salePrice"), "");
	String imeiCode = WtcUtil.repStr(request.getParameter("imeiCode"), "");
	String chinaFee = "";
	
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====0==== iLoginAccept = 0");
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====1==== iChnSource = 01");
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====2==== inOpCode = " + opCode);
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====3==== iLoginNo = " + workNo);
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====4==== iLoginPsw = " + password);
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====5==== iPhoneNo = " + phone);
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====6==== iPhonePwd = " );
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====7==== iOpNote = ");
	System.out.println("====wanghfa====fd926_cfm.jsp====sd926Cfm====8==== iBackAccept = " + backAccept);
%>
	<wtc:service name="sd926Cfm" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=phone%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=backAccept%>"/>
	</wtc:service>
	<wtc:array id="result1"  scope="end"/>
<%
	System.out.println("====wanghfa====fd926_cfm.jsp====sd570Cfm==== " + retCode1 + ", " + retMsg1);
	
	if ("000000".equals(retCode1)) {
		%>
			<script language="javascript">
				rdShowMessageDialog("业务办理申请成功！打印发票......", 2);
				window.location = "fd925.jsp?opCode=<%=opCode%>&opName=<%=opName%>&activePhone=<%=phone%>&backAccept=<%=backAccept%>";
				<%
					System.out.println("====wanghfa====fd925_main.jsp====sToChinaFee==== salePrice = " + salePrice);
				%>
					<wtc:service name="sToChinaFee" routerKey="phone" routerValue="<%=activePhone%>" retcode="retCodeCf" retmsg="retMsgCf" outnum="3" >
						<wtc:param value="<%=salePrice%>"/>
					</wtc:service>
					<wtc:array id="chinaFeeArr" scope="end"/>
				<%
					System.out.println("====wanghfa====fd925_main.jsp====sToChinaFee: " + retCodeCf + " " + retMsgCf);
					if(("000000".equals(retCodeCf) || ("0".equals(retCodeCf))) && chinaFeeArr != null && chinaFeeArr.length > 0) {
						chinaFee = chinaFeeArr[0][2];
					}
				%>
				var infoStr="";
				infoStr+="<%=workNo%>  <%=backAccept%>"+"       <%=opName%>"+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日期
				infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
				infoStr+='<%=custName%>'+"|";//用户名称
				infoStr+=""+"|";//合同号码
				infoStr+="<%=phone%>"+"|";//移动号码
				infoStr+=""+"|";//用户地址
				infoStr+=""+"|";
				
				infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
				infoStr+="<%=salePrice%>"+"|";//小写 
				infoStr+="预存金额：<%=salePrice%>元~";
				infoStr += "IMEI码：<%=imeiCode%>|";
				infoStr+="<%=workName%>"+"|";//开票人
				infoStr+=" "+"|";//收款人
				location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sd925/fd925.jsp?opCode=<%=opCode%>%26opName=<%=opName%>%26activePhone=<%=phone%>";
			</script>
		<%
	} else {
		%>
			<script language="javascript">
				rdShowMessageDialog("sd926Cfm服务：<%=retCode1%>，<%=retMsg1%>", 0);
				window.history.go(-1);
			</script>
		<%
	}
%>
