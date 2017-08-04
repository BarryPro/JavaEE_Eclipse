<%
    /********************
    * 功  能: 手机支付主账户现金充值 9994
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: dujl
    * update：diling@2011/11/2 手机支付主账户充值冲正功能完善需求
    ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>手机支付主账户现金充值</title>
<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String activePhone1 = request.getParameter("activePhone");
	
	System.out.println("-----------9994-------activePhone9994="+activePhone1);
	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=activePhone1%>" id="printAccept"/>

</script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
//----------------验证及提交函数-----------------
function doCfm()
{
	frm.action="f9994Cfm.jsp";
	document.all.opcode.value="9994";
  	frm.submit();
}

function printCommit()
{
 	if(document.frm.payEd.value=="")
  	{
	     rdShowMessageDialog("请输入充值金额!");
	     document.frm.payEd.focus();
	     return false;
  	}
	
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm"))
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				doCfm();
			}
		}
		if(ret=="continueSub")
		{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1)
			{
				doCfm();
			}
		}
	}
	else
	{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		{
			doCfm();
		}
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";  
	var printStr = printInfo(printType);
   
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept=<%=printAccept%>&phoneNo=<%=activePhone1%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}

function printInfo(printType)
{
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
  
	 var retInfo = "";
	 
	cust_info+="手机号码：   "+document.all.phoneNo.value+"|";
	cust_info+="客户姓名：   "+document.all.custName.value+"|";
	
	opr_info+="操作流水： <%=printAccept%>"+"|";
	
	var opCode = "<%=opCode%>";
		opr_info+="受理内容： 手机号码"+document.all.phoneNo.value+"本地手机支付账户现金充值"+document.all.payEd.value+"元"+"|";
		note_info1+="备注：本地手机支付账户现金充值"+"|";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}

function getCustName() {
    if(!check(frm)) return false;
    var phoneNo = document.all.phoneNo.value;
	var money = document.all.payEd.value;
	var getCustName_Packet = new AJAXPacket("getCustName.jsp","正在获取客户名称，请稍候......");
	getCustName_Packet.data.add("phoneNo", phoneNo);
	core.ajax.sendPacket(getCustName_Packet, doGetCustName);
	getCustName_Packet=null;
}

function doGetCustName(packet) {
	document.all.custName.value = packet.data.findValueByName("custName");
	printCommit();
}

</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %> 	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
      <table cellspacing="0">
        <tr> 
		<td class="blue">手机号码 </td>
		<td> 
			<input type="text" size="12" name="phoneNo" value="<%=activePhone1%>" id="phoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly />
			<font color="orange">*</font>
		</td>

	</tr>
         <TR>
	          <TD class="blue" width="20%">充值金额（元）</TD>
	          <TD>
				<input class="button" type="text" name="payEd" id="payEd" v_type="money" size="20" maxlength="14" onKeyPress="return isKeyNumberdot(1)" onKeyDown="if(event.keyCode==13) getCustName();" />
	         </TD>
         </TR>
         <tr> 
            <td colspan="2" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="getCustName()" index="2" />    
              <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()" />
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();" />
              </div>
           </td>
        </tr>
      </table>
   
<input type="hidden" name="loginAccept" value="<%=printAccept%>" />
<input type="hidden" name="opCode" value="<%=opCode%>" />
<input type="hidden" name="opName" value="<%=opName%>" />
<input type="hidden" name="custName" value="" />
<input type="hidden" name="activePhone" id="activePhone" value="<%=activePhone1%>" />
<input type="hidden" name="opcode" value="<%=opCode%>" />
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
   
</body>
</html>
