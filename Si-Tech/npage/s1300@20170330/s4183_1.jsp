<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>

<head>
<title>POS缴费总账查询界面</title>
<%
	String opCode = (String)request.getParameter("opCode");
	String opName="POS缴费总账查询界面";

	String work_no = (String)session.getAttribute("workNo");
	String loginName = (String)session.getAttribute("workName");
	String org_Code = (String)session.getAttribute("orgCode");
	String groupId = (String)session.getAttribute("groupId");
	
%>
<script language=javascript>
	function padLeft(str, pad, count) 
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function searchshowDetail(payType) {
		if(payType == "BX"){
			
			/*set 输入参数*/
			var transerial    = "";  	                    //交易唯一号 ，将会取消
			var trantype      = "22";                     // 业务类型00消费
			var bMoney        = "";												//缴费金额
			var tranamount    = "";
			var tranoper      = "<%=work_no%>";
			var orgid         = "";
			var trannum       = "";                       //phone_no				
			var respstamp     = "";
			var transerialold = "";			                  //原交易唯一号,在缴费时传入空
			var org_code      = "";
			
			/* 调用 posCCB.jsp 中方法设置 IP，端口，串口端口 */
  	  SetSysInfo();
  	  /* 调用控件，进行参数传递 */
			BankCtrl.SetTranData(transerial,trantype,tranamount,tranoper,orgid,trannum,respstamp,transerialold,org_code);
			
			/*调用开始交易*/
			BankCtrl.StratTran();
		}else if(payType == "BY"){
			var TransType     = padLeft("33"," ",2);
			var Amount        = padLeft(""," ",12);
			var OldAuthDate   = padLeft(""," ",8);
			var ReferNo       = padLeft(""," ",8);
			var InstNum       = padLeft(""," ",2);
			var oldterid      = padLeft(""," ",15);
			var requestTime   = padLeft(""," ",14);
			var login_no      = padLeft(""," ",6);
			var org_code      = padLeft(""," ",9);
			var org_id        = padLeft(""," ",10);
			var phone_no      = padLeft(""," ",15);
			var toBeUpdate    = padLeft(""," ",100);
			var inputStr = TransType+Amount+OldAuthDate+ReferNo+InstNum+oldterid+requestTime+login_no+org_code+org_id+phone_no+toBeUpdate;	
			
			/* 调用 posICBC.jsp 中方法设置 IP，端口，串口端口 以及传入参数*/
			var str = SetICBCCfg(inputStr);
			
			
			if(str.split("|").length==21)
			{
				if (str.split("|")[19] !="00")
				{
					rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[19]+"错误信息："+str.split("|")[0]);
				}else{
					var TransTotal = str.split("|")[16];
					if(TransTotal.substr(0,2)=="31"){
						/*TransTotal.substr(12,4);
						TransTotal.substr(16,12);
						TransTotal.substr(76,4);
						TransTotal.substr(80,12);
						TransTotal.substr(124,4);
						TransTotal.substr(128,2);
						TransTotal.substr(130,12);*/
						document.all.totalMoneyBY.value = 
						"消费笔数"+TransTotal.substr(12,4)+
						"消费金额"+TransTotal.substr(16,12)+
						"撤销笔数"+TransTotal.substr(76,4)+
						"撤销金额"+TransTotal.substr(80,12);
					}else if(TransTotal.substr(2,2)=="31"){
						
					}else if(TransTotal.substr(4,2)=="31"){
						
					}else if(TransTotal.substr(6,2)=="31"){
						
					}else if(TransTotal.substr(8,2)=="31"){
						
					}else if(TransTotal.substr(10,2)=="31"){
						
					}
					
				}
			}else{
				rdShowMessageDialog("返回值数量错误！");
			}
		}
	}
  onload=function()
  {
  }
</script>

</head>

<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">POS缴费总账查询界面</div>
</div>

<table cellspacing="0">
	<tr> 
		<td class="blue">建行POS缴费查询交易</td>
		<td class="blue" colspan="3">
		<input type="text" name="totalMoneyBX" id="totalMoneyBX" value="">
		<input type="button" class="b_text" name="showdetailBX" class="b_text" value="显示总账"  onClick="searchshowDetail('BX')">
		</td>
	</tr>
	<tr> 
		<td class="blue">工行POS缴费查询交易</td>
		<td class="blue" colspan="3"> 
		<input type="text" name="totalMoneyBY" id="totalMoneyBY" value="">
		<input type="button" class="b_text" name="showdetailBY" class="b_text" value="显示总账"  onClick="searchshowDetail('BY')">
		</td>
	</tr>
	<tr>
		<td class=Lable nowrap colspan="4">&nbsp;</td>
	</tr>
	<tr> 
		<td colspan="4" id="footer"> 
			<div align="center">
			<input class="b_foot" type="button" name="return1"  value="返回" onClick="window.location.href='s4182.jsp'">
			</div>
		</td>
	</tr>
</table>


<!-- tianyang add at 20090928 for POS缴费需求*****start*****-->
<input type="hidden" name="MerchantNameChs"  value="">
<input type="hidden" name="MerchantId"  value="">
<input type="hidden" name="TerminalId"  value="">
<input type="hidden" name="IssCode"  value="">
<input type="hidden" name="AcqCode"  value="">
<input type="hidden" name="CardNo"  value="">
<input type="hidden" name="BatchNo"  value="">
<input type="hidden" name="Response_time"  value="">
<input type="hidden" name="Rrn"  value="">
<input type="hidden" name="AuthNo"  value="">
<input type="hidden" name="TraceNo"  value="">
<input type="hidden" name="Request_time"  value="">
<!-- tianyang add at 20090928 for POS缴费需求*****end*******-->



<%@ include file="/npage/include/footer_simple.jsp"%>
</form>

<!-- **********加载建行控件页 BankCtrl ******** -->
<%@ include file="/npage/s1300/posCCB.jsp" %>
<script language="javascript" FOR="BankCtrl" event="Completed()" >
	str = BankCtrl.GetTranData();
	if(str.split("|").length==21)
	{
		if (str.split("|")[6] !="00")
		{
			rdShowMessageDialog("银行返回错误!<br>错误代码："+str.split("|")[6]+"，错误信息："+str.split("|")[7]+"。");
		}else{
			var TransTotal = str.split("|")[19];  /*交易总账*/
			document.all.totalMoneyBX.value = 
			"消费笔数"+TransTotal.substr(0,3)+
			"消费金额"+TransTotal.substr(3,12)+
			"撤销笔数"+TransTotal.substr(15,3)+
			"撤销金额"+TransTotal.substr(18,12);
		}	    
	}else{
		rdShowMessageDialog("返回值数量错误！");
	}
</script>

<!-- **********加载工行控件页 KeeperClient ******** -->
<%@ include file="/npage/s1300/posICBC.jsp" %>

</body>
</html>