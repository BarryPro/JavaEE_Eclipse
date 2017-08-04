<%
/********************
 version v2.0
开发商: si-tech
update: sunaj@2009-06-22
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = "8357";
	String opName = "购G3上网卡冲正";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>

<%

	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");

	String phone_no = request.getParameter("phone_no");
	String cust_name=request.getParameter("cust_name");
	String card_info=request.getParameter("cardy");
	String card_money=request.getParameter("card_money");
	String net_fee=request.getParameter("net_fee");
	String paraAray[] = new String[6];
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String type_name=request.getParameter("type_name");
	String spec_fee =request.getParameter("spec_fee");
	String login_accept = request.getParameter("login_accept");
	String op_code=request.getParameter("op_code");
	String op_name=request.getParameter("op_name");
	String second_phone=request.getParameter("second_phone").trim();
	String IMEINo=request.getParameter("IMEINo");
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");

%>
<wtc:service  name="s8357Cfm" routerKey="region" routerValue="<%=org_code%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+login_accept+"&pageActivePhone="+phone_no+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(sum_money,2);
	  String outParaNums= "4";
%>
  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=org_code%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	String chinaFee =chinaFee1[0][0];
	System.out.print(chinaFee);

%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功! 打印发票！");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       购G3上网卡"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="上网卡品牌型号："+'<%=type_name%>'+"|";//支票号码
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写
   var jkinfo="";
   jkinfo+="IMEI码<%=IMEINo%>"+",捆绑语音卡号码<%=second_phone%>"+",退款合计<%=sum_money%>"+"元|";
  
   
   //alert(jkinfo);
	infoStr+=jkinfo+"|";
	infoStr+="<%=work_name%>"+"|";//开票人
	infoStr+=" "+"|";//收款人
	location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8356_login.jsp?activePhone=<%=phone_no%>%26opCode=8357%26opName=购G3上网卡冲正";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("购G3上网卡冲正失败!(<%=errMsg%>");
	window.location="f8356_login.jsp?activePhone=<%=phone_no%>&opCode=8356&opName=购G3上网卡";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>