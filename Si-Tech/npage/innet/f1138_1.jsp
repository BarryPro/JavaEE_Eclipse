<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%

		
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
		String workName = WtcUtil.repNull((String)session.getAttribute("workName"));	
		String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
		String powerCode= WtcUtil.repNull((String)session.getAttribute("powerCode")); 
		String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
		String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
		String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		String loginNoPass = WtcUtil.repNull((String)session.getAttribute("password"));
		String  groupId = WtcUtil.repNull((String)session.getAttribute("groupId"));
		
        String rowNum = "16";
        String sys_Date = "";
%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
<HTML><HEAD><TITLE>入网发票补打</TITLE>
</HEAD>

<script type="text/javascript" src="/njs/si/validate_class.js"></script>

<SCRIPT type=text/javascript>

var printInfo="";
var printInfo1="";
var  billArgsObj = new Object();
onload=function()
{

}
//---------1------RPC处理函数------------------
function doProcess(packet)
{
    //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
    self.status="";
	if(retCode=="")
	{
       rdShowMessageDialog("调用"+retType+"服务时失败！",0);
       return false;
	}
	if(retType == "innetInfo")
	{
		if(retCode == "000000")
		{
			/*
			var Op_time = "";
			var Function_name = "";
			var Sm_Name = "";
			var Cust_name = "";
			var Cust_address = "";
			var Id_name = "";
			var Id_iccid = "";
			var Phone_no = "";
			var Hand_Fee = "";
			var Choice_Fee = "";
			var Sim_Fee = "";
			var Machine_Fee = "";
			var Innet_Fee = "";
			var PrePay_Fee = "";
			var Cash_pay = "";
			var Check_pay = "";
			var payMode = "";
			var Op_note = "";
			 */

			document.frm1138.innetTime.value = packet.data.findValueByName("Op_time");
			document.frm1138.opName.value = packet.data.findValueByName("Function_name");
			document.frm1138.smCode.value = packet.data.findValueByName("Sm_Name");
			document.frm1138.custName.value = packet.data.findValueByName("Cust_name");
			document.frm1138.custAddr.value = packet.data.findValueByName("Cust_address");
			document.frm1138.iccType.value = packet.data.findValueByName("Id_name");
			document.frm1138.iccId.value = packet.data.findValueByName("Id_iccid");

			document.frm1138.beginPhoneNo.value = packet.data.findValueByName("Phone_no");
			document.frm1138.handFee.value = packet.data.findValueByName("Hand_Fee");
			document.frm1138.choiceFee.value = packet.data.findValueByName("Choice_Fee");
			document.frm1138.simFee.value = packet.data.findValueByName("Sim_Fee");
			document.frm1138.machFee.value = packet.data.findValueByName("Machine_Fee");

			document.frm1138.innetFee.value = packet.data.findValueByName("Innet_Fee");
			document.frm1138.preFee.value = packet.data.findValueByName("PrePay_Fee");
			document.frm1138.cashFee.value = packet.data.findValueByName("Cash_pay");
			document.frm1138.checkFee.value = packet.data.findValueByName("Check_pay");
			document.frm1138.h_payMode.value = packet.data.findValueByName("payMode");
  			document.frm1138.sysNote.value = packet.data.findValueByName("Op_note"); 
 			document.frm1138.vLogin_no.value = packet.data.findValueByName("vLogin_no");
 		}
		else
		{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			document.frm1138.opAccept.select();
		    document.frm1138.opAccept.focus();
			return false;
		}
	}


	if(retType == "flowNo")
	{
        if(retCode=="000000")
		{
           document.frm1138.opAccept.value=packet.data.findValueByName("flowNo");
		   document.frm1138.opAccept.focus();
		}
		else
		{
		   rdShowMessageDialog(retMessage,0);
		   document.frm1138.srv_no.select();
		   document.frm1138.srv_no.focus();
		}
	}

}

//---------------------------------------------
function printCommit()
{
	//根据流水得到开户信息
    if(document.frm1138.opAccept.value.trim().length == 0)
    {
    	rdShowMessageDialog("请输入开户的服务流水！",1);
    	document.frm1138.opAccept.focus();
    	return false;
    }
	else
	{
      if(parseInt(document.frm1138.opAccept.value)==0)
	  {
        rdShowMessageDialog("开户流水为0，不能补打发票！",1);
    	document.frm1138.opAccept.focus();
    	return false;
	  }
	}
	 var busi_sumPay = 1*document.frm1138.cashFee.value+1*document.frm1138.checkFee.value+1*document.frm1138.preFee.value;
	if(busi_sumPay>0.01)
	{
	    showPrtDlg("Bill","确认要补打发票吗？","Yes");
		document.frm1138.action="spubPrint_1138.jsp";
		document.frm1138.submit();
	}else{
		 rdShowMessageDialog("本次开户没有产生费用，因此不能发票打印！");
	}
}

//-----------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框
   getPrintInfo();
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	  //var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + DlgMessage;
			//发票项目修改为新路径
	var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + DlgMessage;

	var path = path + "&loginAccept="+document.frm1138.opAccept.value+"&opCode=<%=opCode%>&submitCfm=submitCfm";
	var ret = window.showModalDialog(path,billArgsObj,prop);
}

//---------------------------------
function getPrintInfo()
{
    //====================1======================
 	//var busi_sumPay=1*frm1138.innetFee.value+1*frm1138.choiceFee.value+1*frm1138.simFee.value+1*frm1138.machFee.value;
	//liucm封,合计金额加上预存var busi_sumPay = 1*frm1138.cashFee.value+1*frm1138.checkFee.value;
  	var fee_sumPay=1*document.frm1138.preFee.value;
    var busi_sumPay = 1*document.frm1138.cashFee.value+1*document.frm1138.checkFee.value;+1*document.frm1138.preFee.value;
	var note = document.frm1138.sysNote.value;
		$(billArgsObj).attr("10001",document.frm1138.Login_no.value);       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm1138.custName.value); //客户名称
 		$(billArgsObj).attr("10006","入网发票补打"); //业务类别
 		$(billArgsObj).attr("10008",document.frm1138.beginPhoneNo.value ); //用户号码
 		$(billArgsObj).attr("10015", busi_sumPay.toFixed(2)); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", busi_sumPay.toFixed(2)); //大写金额合计
 		var sumtypes1="*";
 		var sumtypes2="";
 		var sumtypes3="";
 		
 				
 		$(billArgsObj).attr("10017",sumtypes1); //本次缴费现金
 		$(billArgsObj).attr("10018",sumtypes2); //支票
 		$(billArgsObj).attr("10019",sumtypes3); //刷卡
 		$(billArgsObj).attr("10020",parseFloat(document.frm1138.innetFee.value).toFixed(2)); //入网费
 		$(billArgsObj).attr("10021",parseFloat(document.frm1138.handFee.value).toFixed(2)); //手续费
 		$(billArgsObj).attr("10022",parseFloat(document.frm1138.choiceFee.value).toFixed(2)); //选号费
 		$(billArgsObj).attr("10024",parseFloat(document.frm1138.simFee.value).toFixed(2)); //SIM卡费
 		$(billArgsObj).attr("10025",fee_sumPay.toFixed(2)); //预存话费
 		$(billArgsObj).attr("10026",parseFloat(document.frm1138.machFee.value).toFixed(2) ); //机器费
 		$(billArgsObj).attr("10030",document.frm1138.opAccept.value ); //流水号--业务流水
 		$(billArgsObj).attr("10036","<%=opCode%>"); //操作代码

	//====================2======================prepayFee
		var pay_money = parseFloat(document.frm1138.cashFee.value)+parseFloat(document.frm1138.checkFee.value);
		document.frm1138.pay_money.value=pay_money;
		printInfo1=document.frm1138.beginPhoneNo.value+"|"+document.frm1138.opAccept.value+"|"+document.frm1138.vLogin_no.value +"|"+document.frm1138.innetTime.value+"|"+pay_money+"|";
 		
}

//-----------------------------------
function getInfo()
{
	//根据流水得到开户信息
    if(document.frm1138.opAccept.value.trim().length == 0)
    {
    	rdShowMessageDialog("请输入开户的服务流水！",1);
    	document.frm1138.opAccept.focus();
    	return false;
    }
	else
	{
      if(parseInt(document.frm1138.opAccept.value)==0)
	  {
        rdShowMessageDialog("开户流水为0，不能补打发票！",1);
    	document.frm1138.opAccept.focus();
    	return false;
	  }
	} 
	
	document.all.print.disabled=false;
    var getIdPacket = new AJAXPacket("f1138_3.jsp","正在获得开户信息，请稍候......");
	getIdPacket.data.add("retType","innetInfo");
	getIdPacket.data.add("opAccept",document.frm1138.opAccept.value);
			core.ajax.sendPacket(getIdPacket);
			getIdPacket = null;
}

function getInfoBySrvNo()
{
   //根据服务号码得到流水号
    if(document.frm1138.srv_no.value.trim().length > 0)
    {

		 /* 号段改造20090422 liyan */
		//if(checkElement("srv_no")==false) return false;


		var getIdPacket = new AJAXPacket("f1138_4.jsp","正在获得流水号，请稍候......");
		getIdPacket.data.add("retType","flowNo");
		getIdPacket.data.add("srv_no",document.frm1138.srv_no.value);
			core.ajax.sendPacket(getIdPacket);
			getIdPacket = null;
	}
	else {
		 rdShowMessageDialog("请输入服务号码！",1);
		}
}

function chgFlowNo()
{
  document.all.srv_no.value="";
  document.all.print.disabled=true;
}
//========================================
</SCRIPT>

<!--**************************************************************************************-->


<body >
<FORM method=post name="frm1138" action="f1138_2.jsp" onKeyUp="chgFocus(frm1138)">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">入网发票补打</div>
</div> 

      <table cellspacing="0" >
        <tr>
          <td >
              <TABLE >
               
                <TR >
                  <TD class="blue">
                    服务号码
                  </TD>
                  <TD >
                    <input class="button" name=srv_no index="0" onKeyUp="if(event.keyCode==13)getInfoBySrvNo();" v_must=0 v_maxlength=16 v_type=mobphone  v_name="服务号码" maxlength=11>
                    <input name=infoQuery2 type=button class="b_text" onClick="getInfoBySrvNo()" style="cursor:hand" value="查询流水" v_must=0 v_maxlength=16 v_type=mobphone  v_name="服务号码">
                  </TD>
                  <td class="blue">
                   服务流水
                  </td>
                  <td >
                    <input class="button" name=opAccept v_type=int v_must=1 v_maxlength=14 v_name="服务流水" onKeyUp="if(event.keyCode==13){getInfo();}else{chgFlowNo();}" maxlength="14" index="1">
                    <font color="orange">*</font>
                    <input name=infoQuery type=button class="b_text" onClick="getInfo()" style="cursor:hand" value="查询明细">
                  </td>
                </TR>

                <TR >
                  <TD class="blue">
                    操作名称
                  </TD>
                  <TD >
                    <input  name=opName readonly class=InputGrey>
                  </TD>
                  <td class="blue">
                    开户时间
                  </td>
                  <td >
                    <input  name=innetTime readonly class=InputGrey>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                    业务类型
                  </td>
                  <td >
                    <input class=InputGrey name=smCode readonly>
                  </td>
                  <td class="blue">
                    客户名称
                  </td>
                  <td >
                    <input class=InputGrey name=custName size=35 readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                  客户证件类型
                  </td>
                  <td >
                    <input class=InputGrey name=iccType readonly>
                  </td>
                  <td class="blue">
                    客户证件号码
                  </td>
                  <td >
                    <input class=InputGrey name=iccId readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                   服务号码
                  </td>
                  <td >
                    <input class=InputGrey name=beginPhoneNo readonly size=25>
                  </td>
                  <td class="blue">
                    客户地址
                  </td>
                  <td >
                    <input class=InputGrey name=custAddr size=35 readonly>
                  </td>
                </TR>
                <TR >
                  <td class="blue">
                   手续费
                  </td>
                  <td >
                    <input class=InputGrey name=handFee readonly>
                  </td>
                  <TD class="blue">入网费</TD>
                  <TD >
                    <input class=InputGrey name=innetFee readonly>
                  </TD>
                </TR>
                <TR bgc>
                  <td class="blue">
                    预存费
                  </td>
                  <td >
                    <input class=InputGrey name=preFee readonly>
                  </td>
                  <TD class="blue">
                    选号费
                  </TD>
                  <TD >
                    <input class=InputGrey name=choiceFee readonly>
                  </TD>
                </TR>
                <TR >
                  <td class="blue">
                    SIM卡费
                  </td>
                  <td >
                    <input class=InputGrey name=simFee readonly>
                  </td>
                  <TD class="blue">
                   机器费
                  </TD>
                  <TD >
                    <input class=InputGrey name=machFee readonly>
                  </TD>
                </TR>
                <TR >
                  <td class="blue">
                   现金交款
                  </td>
                  <td >
                    <input class=InputGrey name=cashFee readonly>
                  </td>
                  <td class="blue">
                   支票交款
                  </td>
                  <td >
                    <input class=InputGrey name=checkFee readonly>
                  </td>
                </TR>
                  <TR >
                  <TD class="blue">
                    系统备注
                  </TD >
                  <TD colspan=3>
                    <input class=InputGrey name=sysNote size=60 readonly maxlength="30">
                  </TD>
                </TR>
               
                   <TR id="footer">
                   <TD colspan=4>
                       <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" type=button value=打印 index="2" disabled>
                    <input class="b_foot" name=reset1  type=button value=清除 onclick="frm1138.reset();" index="3">
                    <input class="b_foot" name=back  onClick="window.close()" type=button value=关闭 index="4">
        </TD>
    </TR>
              </TABLE>



  	<!------------------------>
	<input type="hidden" name="Login_no" value="<%=workNo%>">  		<!--登陆工号-->
	<input type="hidden" name="Org_code" value="<%=orgCode%>"> 		<!--机构编码-->
	<input type="hidden" name="Ip_addr" value="<%=ip_Addr%>">		<!--IP地址-->
  	<input type="hidden" name="sysAccept" value="<%=printAccept%>">							<!--系统流水号---->
  	<input type="hidden" name="printInfo" >							<!--打印信息---->
	<input type="hidden" name="printInfo1" >							<!--打印信息---->
	<input type="hidden" name="vLogin_no" >							<!--开户时候的工号---->
	<input type="hidden" name="h_payMode" value="1">
	<input type="hidden" name="pay_money">
  	<!------------------------>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
