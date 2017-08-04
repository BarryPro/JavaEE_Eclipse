<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>

<%	
	String opCode = "126b";
	String opName = "预存话费赠机";
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	
	String paraAray[] = new String[10];
	
  paraAray[0] = opCode;//操作代码
	paraAray[1] = request.getParameter("phoneNo");//服务号码
  paraAray[2] = work_no;//工号
	paraAray[3] = request.getParameter("machine_type");//机器类型
	paraAray[4] = request.getParameter("should_fee");//扣减预存款
	paraAray[5] = request.getParameter("machine_fee");//价格
	paraAray[6] = request.getParameter("consume_term");//消费时限
  paraAray[7] = ip_Addr;//ip地址  
	paraAray[8] = request.getParameter("order_code");//方案代码
	paraAray[9] = request.getParameter("opNote");//操作备注

	/*为打印组织参数*/
	String op_type=request.getParameter("op_type");//扣费类型
	String printAccept=request.getParameter("printAccept");//打印流水	
	String bp_name=request.getParameter("bp_name");//用户名称
	String phoneNo = request.getParameter("phoneNo");//服务号码
	String machine_type = request.getParameter("machine_type");//机器类型
	String machine_fee = request.getParameter("machine_fee");//价格
	float fMachineFee = Float.parseFloat(machine_fee); 
	S1100View callView = new S1100View();
	String chinaFee = ((String[][])(callView.view_sToChinaFee(WtcUtil.formatNumber(machine_fee,2)).get(0)))[0][2];//大写金额
%>
<wtc:service name="s126b_ApplyEx" routerKey="phone" routerValue="<%=paraAray[1]%>" retcode="errCode" retmsg="errMsg" outnum="2" >
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
	<wtc:param value="<%=paraAray[9]%>"/>
</wtc:service>

<wtc:array id="ret" scope="end"/>
	
<%
	
	
	System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
	if(errCode.equals("0")||errCode.equals("000000")){
		if(ret.length>0){
		  //printAccept=ret[0][0];
		}
	}	
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+errCode+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+printAccept+"&pageActivePhone="+paraAray[1]+"&retMsgForCntt="+errMsg+"&opBeginTime="+opBeginTime;
	System.out.println("url="+url);	
	%>
	<jsp:include page="<%=url%>" flush="true" />
	<%
	System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 
	
	
	
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="jscript">
function printBill(){
	 var infoStr="";                                                                         
	 infoStr+="<%=work_no%>  <%=printAccept%>"+"  预存赠机非按月扣费"+"|";//工号                                      
     infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";//年
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";//月
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";//日

     infoStr+="<%=bp_name%>"+"|";//用户名称 
     infoStr+=" "+"|";//卡号

	 infoStr+="<%=phoneNo%>"+"|";//移动号码                                                   
	 infoStr+=" "+"|";//协议号码                                                          
	 infoStr+=" "+"|";//支票号码  
	 
	 infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
	 infoStr+="<%=WtcUtil.formatNumber(machine_fee,2)%>"+"|";//小写

	 infoStr+="购机款：  <%=WtcUtil.formatNumber(machine_fee,2)%>"+
		 "~~~机器型号：<%=machine_type%>"+"|";//项目

	 infoStr+="<%=work_name%>"+"|";//开票人
	 infoStr+=" "+"|";//收款人

	 var dirtPage="/npage/obill/fa26b_login.jsp?opCode=a26b%26activePhone="+<%=paraAray[1]%>;
	 location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage="+dirtPage;
}

</script>
<script language="JavaScript">
	   <%if(op_type.equals("9")){%>
	       rdShowMessageDialog("预存话费赠机成功,下面将打印发票!");
           printBill();
	   <%}else{%>
		   rdShowMessageDialog("预存话费赠机成功!");
		   location="fa26b_login.jsp?opCode=a26b&activePhone"+paraAray[1];
	   <%}%>
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("预存话费赠机失败!<br>errCode:"+"<%=errCode%>"+"<br>errMsg:"+"<%=errMsg%>");
	history.go(-1);
</script>
<%}%>
