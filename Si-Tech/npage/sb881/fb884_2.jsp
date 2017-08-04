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
  
	String iLoginAccept = "";
	String iChnSource = "01";
	String iLoginNo = (String)session.getAttribute("workNo");
	String iLoginPwd = (String)session.getAttribute("password");
	String b_order_code = (String)request.getParameter("b_order_code");
	String s_order_code = (String)request.getParameter("s_order_code");
	System.out.println("++++++++++++++++++++++++++++"+s_order_code);
	String workName   = (String)session.getAttribute("workName");
	String [] inParas = new String[9];
	inParas[0] = iLoginAccept;
	inParas[1] = iChnSource;
	inParas[2] = opCode;
	inParas[3] = iLoginNo;
	inParas[4] = iLoginPwd;
	inParas[5] = "";
	inParas[6] = "";
	inParas[7] = b_order_code;
	inParas[8] = s_order_code;
String svcName = "sOrderQry";//"sOrderQry";
%>
<wtc:service name="<%=svcName%>" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="50">
	<wtc:param value="<%=inParas[0]%>" />
	<wtc:param value="<%=inParas[1]%>" />
	<wtc:param value="<%=inParas[2]%>" />
	<wtc:param value="<%=inParas[3]%>" />
	<wtc:param value="<%=inParas[4]%>" />
	<wtc:param value="<%=inParas[5]%>" />
	<wtc:param value="<%=inParas[6]%>" />
	<wtc:param value="<%=inParas[7]%>" />
	<wtc:param value="<%=inParas[8]%>" />
</wtc:service>
	<wtc:array id="result"      scope="end" start="0"  length="25"/>
	<wtc:array id="acceptRel"   scope="end" start="25"  length="1"  />
	<wtc:array id="custNameRel" scope="end" start="26"  length="1" />	

<%
	String billAccept   = "";//发票打印的流水
	String billCustName = "";//发票打印的客户姓名
	
	if(acceptRel.length>0){
		if(acceptRel[0].length>0){
			billAccept = acceptRel[0][0];
		}
	}
	
	if(custNameRel.length>0){
		if(custNameRel[0].length>0){
			billCustName = custNameRel[0][0];
		}
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
	var custPayNum  = 0.00;
	var custName    = "<%=billCustName%>";
	$("#shoTable tr:gt(0)").each(function(){
		if(custPhoneNo==""){
			custPhoneNo = $(this).find("td:eq(0)").text().trim();
		}
		custPayNum += parseFloat($(this).find("td:eq(15)").text().trim());
	});
 
	var loginAccept = "<%=billAccept%>";
	if(custPayNum>0){//金额为0不打印发票
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
	}else{
		rdShowMessageDialog("订单应付总金额为0，无需打印发票");
	}
}	
</script>
</head>

<body>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
<div style="overflow-x:auto;overflow-y:hidden;">
<table cellspacing="0" id="shoTable">
	<tr>
		<th class="blue" align="center">客户手机号码</th>			
		<th class="blue" align="center">大订单编号</th>									
		<th class="blue" align="center">订购日期</th>
		<th class="blue" align="center">订购渠道</th>
		<th class="blue" align="center">包裹运费积分</th>
		
		<th class="blue" align="center">包裹礼品积分</th>
		<th class="blue" align="center">仓库编号</th>
		<th class="blue" align="center">子订单编号</th>
		<th class="blue" align="center">礼品编码</th>
		<th class="blue" align="center">礼品名称</th>
		
		<th class="blue" align="center">礼品积分值</th>
		<th class="blue" align="center">子订单状态</th>
		
		<!-- hejwa add 关于各省BOSS系统改造以支持积分商城双版本并行的通知 -->
		<th class="blue" align="center">订单应扣总积分</th>
		<th class="blue" align="center">订单配送总积分</th>
		<th class="blue" align="center">订单礼品应扣总积分</th>
		<th class="blue" align="center">订单应付总金额</th>
		<th class="blue" align="center">包裹应付金额</th>
		<th class="blue" align="center">礼品全积分</th>
		<th class="blue" align="center">单个礼品应付金额</th>
		<th class="blue" align="center">支付状态</th>
		<th class="blue" align="center">支付方式</th>
		<th class="blue" align="center">线下支付描述</th>
		<th class="blue" align="center">支付有效期</th>
		
	</tr>	
	<%	
	if (retCode.equals("000000"))
	{
		System.out.println("result.length==================="+result.length);
		if(result.length>0 && result[0][0]!=null && result[0][0]!="")
		{
			for ( int i = 0 ; i < result.length ; i ++ )
			{
	%>
				<tr align="center">
					<td nowrap><%=result[i][2]%></td>
					<td nowrap><%=result[i][3]%></td>
					<td nowrap><%=result[i][4]%></td>
					<td nowrap><%=result[i][5]%></td>
					<td nowrap><%=result[i][6]%></td>
					                          
					<td nowrap><%=result[i][7]%></td>
					<td nowrap><%=result[i][8]%></td>
					<td nowrap><%=result[i][9]%></td>
					<td nowrap><%=result[i][10]%></td>
					<td nowrap><%=result[i][11]%></td>		
					                           
					<td nowrap><%=result[i][12]%></td>		
					<td nowrap><%=result[i][13]%></td>		
					
					<td nowrap><%=result[i][14]%></td>		
					<td nowrap><%=result[i][15]%></td>		
					<td nowrap><%=result[i][16]%></td>		
					<td nowrap><%=result[i][17]%></td>		
					<td nowrap><%=result[i][18]%></td>		
					<td nowrap><%=result[i][19]%></td>		
					<td nowrap><%=result[i][20]%></td>		
					<td nowrap><%=result[i][21]%></td>		
					<td nowrap><%=result[i][22]%></td>		
					<td nowrap><%=result[i][23]%></td>		
					<td nowrap><%=result[i][24]%></td>		
				</tr>
	<%
			}
		}
	}
	else{
	%>
	<script language="JavaScript">
		rdShowMessageDialog("查询错误!<br>错误代码：'<%=retCode%>'，错误信息：'<%=retMsg%>'。",0);
		history.go(-1);
	</script>
<%
	}
%>	
</table>
<br>
</div>
<table cellspacing="0">
	<tr>
    <td noWrap colspan="12" id="footer">
			<div align="center">
 				<input type="button" name="print" class="b_foot" value="确认" onClick="removeCurrentTab()">
               &nbsp;
				<input type="button" name="return1" class="b_foot" value="返回" onClick="history.go(-1)">
              &nbsp;
        <input type="button" name="close1" class="b_foot" value="关闭" onClick="removeCurrentTab()">
      </div>
   	</td>
	</tr>
<table>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>


