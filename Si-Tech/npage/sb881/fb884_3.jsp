<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: huangrong
 * date  : 20101103
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	String regionCode = (String)session.getAttribute("regCode");
 	String workName   = (String)session.getAttribute("workName"); 
	String iLoginAccept = "";
	String iChnSource = "01";
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String b_order_code = (String)request.getParameter("b_order_code");
	String s_order_code = (String)request.getParameter("s_order_code");
	 
	String isBillPrintFlag = "";
	String isBillPrintSql  =  " select b.custname, a.maxaccept, a.orderid, a.phoneno, a.orgname, decode(trim(a.userbrand),'G','动感地带','M','神州行','E','全球通'),to_char(a.optime, 'yyyy-MM-dd HH24:mi:ss'),a.ordersumpoint,"+
														" a.invoicetitle, a.ordersumcash  "+
														" from dbcustadm.tobmarkorderinfo a   "+
														" left join (select dd.cust_name as custName, dt.phone_no as phoneNo   "+
														" from dcustmsg dt, dcustdoc dd   "+
														" where dt.cust_id = dd.cust_id ) b  "+
														" on trim(to_char(a.phoneno))||'    ' = b.phoneno "+
														" where a.orderid=:orderId";
	String isBillPrtSqlParam = "orderId="+b_order_code;			
	
	System.out.println("---------------------------------------------------------------");
	System.out.println(isBillPrintSql);
	System.out.println("---------------------------------------------------------------");
		System.out.println(isBillPrtSqlParam);
%>
  <wtc:service name="TlsPubSelCrm" outnum="11" retmsg="retMsg" retcode="retCode" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=isBillPrintSql%>" />
		<wtc:param value="<%=isBillPrtSqlParam%>" />	
	</wtc:service>
	<wtc:array id="resultBillPrtFlag" scope="end"   />

<%
String custNameForBill = "";
String loginAcceptForBill = "";
String custPayNum = "";
String custPhoneNo ="";
	if(resultBillPrtFlag.length>0){
		custNameForBill = resultBillPrtFlag[0][0];
		loginAcceptForBill = resultBillPrtFlag[0][1];
		custPayNum = resultBillPrtFlag[0][9];
		custPhoneNo = resultBillPrtFlag[0][3];
		
	}
%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>订单查询</title>
<script language=javascript>
//hejwa add 打印发票 关于各省BOSS系统改造以支持积分商城双版本并行的通知
function showPrtDlgbill(printType,DlgMessage,submitCfm){
	
	var custPhoneNo = "";
	var custPayNum  = "<%=custPayNum%>";
	var custName    = "<%=custNameForBill%>";
	var loginAccept = "<%=loginAcceptForBill%>";
 
		//20140321155339396798
		//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
	//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
			var printinfo = "";
			    printinfo += "<%=iLoginNo%>|";
			    printinfo += loginAccept+"|";//流水
			    printinfo += "积分商城积分现金混合支付" + "|";  //业务名称
			    printinfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>"+"|";
			    printinfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>"+"|";
			    printinfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>"+"|";
					printinfo += custName+"|";
					printinfo += "|";
					printinfo += custPhoneNo+"|";
					printinfo += "|";
					printinfo += "|";
					printinfo += custPayNum+"|"; //大写
					printinfo += custPayNum+"|"; //小写
					printinfo += "现金支付金额："+custPayNum+"元|";
					printinfo += "<%=workName%>|";
					printinfo += "|";
					printinfo += "|";
					
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		
		var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=" + DlgMessage;
		
		var path = path + "&printInfo="+printinfo+"&submitCfm=submitCfm";
		var path = path + "&infoStr="+printinfo+"&loginAccept="+loginAccept+"&opCode=1121&submitCfm=submitCfm";
		var ret=window.showModalDialog(path, "", prop);
	 
}	
</script>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<table cellspacing="0" id="shoTable">
	<tr>
		<th class="blue" align="center">客户姓名</th>			
		<th class="blue" align="center">大订单编号</th>									
		<th class="blue" align="center">手机号码</th>
		<th class="blue" align="center">发起请求方名称</th>
		<th class="blue" align="center">客户品牌</th>
		<th class="blue" align="center">操作日期</th>
		<th class="blue" align="center">订单应扣总积分</th>
		<th class="blue" align="center">订单应付总金额</th>
	</tr>	
	<%	
		if(resultBillPrtFlag.length>0)
		{
			for ( int i = 0 ; i < resultBillPrtFlag.length ; i ++ )
			{
	%>
				<tr align="center">
					<td nowrap><%=resultBillPrtFlag[i][0]%></td>
					<td nowrap><%=resultBillPrtFlag[i][2]%></td>
					<td nowrap><%=resultBillPrtFlag[i][3]%></td>
					<td nowrap><%=resultBillPrtFlag[i][4]%></td>
					<td nowrap><%=resultBillPrtFlag[i][5]%></td>
					<td nowrap><%=resultBillPrtFlag[i][6]%></td>
					<td nowrap><%=resultBillPrtFlag[i][7]%></td>
					<td nowrap><%=resultBillPrtFlag[i][9]%></td>		
				</tr>
	<%
			}
	}
%>	
</table>
<br>
<table cellspacing="0">
	<tr>
    <td noWrap colspan="12" id="footer">
			<div align="center">
        <input type="button" name="doPrintBill" class="b_foot" value="打印发票" onClick="showPrtDlgbill('Bill','确实要进行发票打印吗？','Yes');">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
      </div>
   	</td>
	</tr>
<table>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>


