<%
/********************
 version v2.0
开发商: si-tech
update:yanpx@2008-10-09
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode = "8660";//模块代码
	String opName = "购G3手机，赠话费冲正";//模块名称
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
	String paraAray[] = new String[6];
	String sum_money=request.getParameter("sum_money");
	String pay_money=request.getParameter("pay_money");
	String type_name=request.getParameter("type_name");
	String spec_fee =request.getParameter("spec_fee");
	String login_accept = request.getParameter("login_accept");
	String op_code=request.getParameter("op_code");
	paraAray[0] =request.getParameter("login_accept");
	paraAray[1] = request.getParameter("phone_no");
	paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = request.getParameter("backaccept");
	paraAray[5] = request.getParameter("opNote");

%>
<wtc:service  name="s8660Cfm" routerKey="region" routerValue="<%=org_code%>" outnum="2"  retcode="errCode" retmsg="errMsg">
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
   rdShowMessageDialog("提交成功! 下面将打印发票！");
   var infoStr="";
   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"    购G3手机，赠话费冲正"+"|";//工号
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+=" "+"|";
   infoStr+='<%=paraAray[1]%>'+"|";
   infoStr+=" "+"|";//协议号码
   infoStr+="手机型号："+'<%=type_name%>'+"|";//支票号码
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写
    var jkinfo="";
   /*if("<%=card_money%>"=="0"){
   	jkinfo+="退款合计：<%=sum_money%>"+
		 "元 含:预存话费　<%=pay_money%>"+"元";
   }else{
   jkinfo+="退款合计：<%=sum_money%>"+
		 "元 含:预存话费 <%=pay_money%>"+"元，"+"<%=card_info%>";
	}
 */
 jkinfo+="退款合计：<%=sum_money%>"+"元";
   //alert(jkinfo);
    infoStr+=jkinfo+"|";
	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人
   //location="/page/s1210/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=/page/s1141/f1145_login.jsp";
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/s1141/f8659_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=op_code%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("购G3手机，赠话费冲正失败!(<%=errMsg%>");
	window.location="f8659_login.jsp?activePhone=<%=phone_no%>&opCode=<%=op_code%>";
</script>
<%}%>
<jsp:include page="<%=url%>" flush="true"/>
