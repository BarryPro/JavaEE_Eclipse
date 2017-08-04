<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-06
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="java.util.ArrayList"%>
<%
    String opCode = (String)request.getParameter("opCode");
    String opName = (String)request.getParameter("opName");
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String nopass = (String)session.getAttribute("password");
    String orgCode = (String)session.getAttribute("orgCode");
    String retCode = "";
    String retMsg = "";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=opName%></TITLE>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
</HEAD>
<script language="javascript">
//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	//core.rpc.onreceive = doProcess;
}
function validDateNoFocus(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("日期格式有误，请重新输入！");
	//obj.value="";
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("年的格式有误，请重新输入！");
	   //obj.value="";
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("月的格式有误，请重新输入！");
  	   //obj.value="";
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("日的格式有误，请重新输入！");
	   //obj.value="";
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("该月份最多30天,没有31号！");
 	         //obj.value="";
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("闰年二月份最多29天！");
      	     //obj.value="";
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("非闰年二月份最多28天！");
      	     //obj.value="";
             return false;
		   }
		 }
      }
  }
  return true;
}
function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	var errCode = packet.data.findValueByName("errCode");
	var errMsg = packet.data.findValueByName("errMsg");
		
	var errCodeInt = parseInt(errCode);
	if(cfmFlag==0){
		if(errCodeInt==0){
			rdShowMessageDialog("操作成功！",2);
			document.frm.userId.value=backString[0][0];
			document.frm.vTotalDate.value=backString[0][1];
			document.frm.vSmCode.value=backString[0][2];
			document.frm.vSmName.value=backString[0][3];
			document.frm.vBelongCode.value=backString[0][4];
			document.frm.vPhoneNo.value=backString[0][5];
			document.frm.vOrgCode.value=backString[0][6];
			document.frm.vOpCode.value=backString[0][7];
			document.frm.vOpName.value=backString[0][8];
			document.frm.vOpTime.value=backString[0][9];
			document.frm.vMachineCode.value=backString[0][10];
			document.frm.vMachName.value=backString[0][11];
			document.frm.vCashPay.value=backString[0][12];
			document.frm.vSimFee.value=backString[0][13];
			document.frm.vMachineFee.value=backString[0][14];
			document.frm.vInnetFee.value=backString[0][15];
			document.frm.vChoiceFee.value=backString[0][16];
			document.frm.vOtherFee.value=backString[0][17];
			document.frm.vHandFee.value=backString[0][18];
			document.frm.vDeposit.value=backString[0][19];
			document.frm.vBackFlag.value=backString[0][20];
			document.frm.vSystemNote.value=backString[0][21];
			document.frm.vOpNote.value=backString[0][22];
			infoDiv.style.display="";
			document.frm.submit.disabled=false;
		
		}else{
			
			rdShowMessageDialog(errCodeInt+errMsg,0);
			infoDiv.style.display="none";
			document.frm.submit.disabled=true;
		}
	}
	if(cfmFlag==9){
		
		rdShowMessageDialog(errCodeInt+errMsg,0);
		infoDiv.style.display="none";
		document.frm.submit.disabled=true;
	
	}
	
}
function getUserInfo(){

		document.frm.submit.disabled=true;
		if(!forNonNegInt(document.frm.loginAccept)){
		return false;
		}
		if(!forMobil(document.frm.phoneNo)){
		return false;
		}
		if(document.frm.loginAccept.value.length==0){
			rdShowMessageDialog("请输入流水号!");
			return;
		}
		document.frm.checkDate.value=document.frm.totalDate.value+"01";
		if(!validDateNoFocus(document.frm.checkDate)){
		return false;
		}
		if(document.frm.totalDate.value>document.frm.nowDate.value){
		rdShowMessageDialog("输入的日期应该小于当前日期！");
		return false;
		}
		var myPacket = new AJAXPacket("getUserInfo.jsp","正在提交，请稍候......");
		
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("totalDate",document.frm.totalDate.value);
		

		
    	core.ajax.sendPacket(myPacket);

    	myPacket = null;
}
function resett(){
document.frm.phoneNo.value="";
document.frm.loginAccept.value="";
document.frm.totalDate.value="";
document.frm.userId.value="";
document.frm.vTotalDate.value="";
document.frm.vSmCode.value="";				
document.frm.vSmName.value="";				
document.frm.vBelongCode.value="";
document.frm.vPhoneNo.value="";
document.frm.vOrgCode.value="";
document.frm.vOpCode.value="";
document.frm.vOpName.value="";
document.frm.vOpTime.value="";
document.frm.vMachineCode.value="";
document.frm.vMachName.value="";
document.frm.vCashPay.value="";
document.frm.vSimFee.value="";
document.frm.vMachineFee.value="";
document.frm.vInnetFee.value="";
document.frm.vChoiceFee.value="";
document.frm.vOtherFee.value="";
document.frm.vHandFee.value="";
document.frm.vDeposit.value="";
document.frm.vBackFlag.value="";
document.frm.vSystemNote.value="";
document.frm.vOpNote.value="";
infoDiv.style.display="none";
document.frm.submit.disabled=true;




}
</script>
<body>

<FORM action="" method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>

<table cellspacing="0">
    <tr> 
        <td class=blue>移动号码</td>
        <td > 
            <input  id=Text2 type=text size=17 name=phoneNo  maxlength=11 value="">
        </td>
        <td class=blue>流水号</td>
        <td > 
            <input id=Text1 size=17 name=loginAccept type=text value="">
        </td>
        <td class=blue>日期</td>
        <td>
            <input type=text size=17 name=totalDate maxlength=6 v_format="yyyyMM" value="">
            <input class="b_text" type=button name=inp value="查询" onclick="getUserInfo()">
        </td>
    </tr>
</table>


<div id=infoDiv style="display:none">

<br>
<div class="title">
	<div id="title_zi">业务信息</div>
</div>
<table cellspacing="0">
    <tr> 
        <td class=blue>用户I D</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=userId readOnly>
        </td>
        <td class=blue>帐户日期</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vTotalDate readOnly >
        </td>
        <td class=blue>业务代码</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vSmCode readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>业务名称</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vSmName readOnly >
        </td>
        <td class=blue>归属代码</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vBelongCode readOnly >
        </td>
        <td class=blue>移动号码</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vPhoneNo readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>归属地区</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vOrgCode readOnly >
        </td>
        <td class=blue>操作代码</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOpCode readOnly >
        </td>
        <td class=blue>操作名称</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOpName readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>操作时间</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vOpTime readOnly >
        </td>
        <td class=blue>机器代码</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vMachineCode readOnly >
        </td>
        <td class=blue>机器名称</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vMachName readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>收取现金</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vCashPay readOnly >
        </td>
        <td class=blue>SIM卡费</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vSimFee readOnly >
        </td>
        <td class=blue>机器费用</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vMachineFee readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>入网费用</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vInnetFee readOnly >
        </td>
        <td class=blue>选号费用</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vChoiceFee readOnly >
        </td>
        <td class=blue>其他费用</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vOtherFee readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>手续费</td>
        <td> 
            <input class=InputGrey id=Text2 type=text size=17 name=vHandFee readOnly >
        </td>
        <td class=blue>押金</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vDeposit readOnly >
        </td>
        <td class=blue>冲正标志</td>
        <td> 
            <input class="InputGrey" type=text size=17 name=vBackFlag readOnly >
        </td>
    </tr>
    <tr> 
        <td class=blue>备注</td>
        <td colspan="5"> 
            <input class=InputGrey id=Text2 type=text size=75 name=vSystemNote readOnly >
        </td>
    </tr>
    <tr style="display:none"> 
        <td class=blue>操作备注</td>
        <td colspan="5"> 
            <input class=InputGrey id=Text2 type=text size=75 name=vOpNote readOnly >
        </td>
    </tr>

</table>
</div>
<table>

    <TR id="footer">
        <TD colspan=6>
            <input class="b_foot" name=submit  type=button value="打印" onclick="printBill_before()" disabled >
            <input class="b_foot" name=back  type=button value="关闭" onclick="removeCurrentTab()">
            <input class="b_foot" name=back  type=button value="复位" onclick="resett()">
        </TD>
    </TR>
</table>

<input type=hidden name=opCode value="1236">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=sysRemark value="发票补打变更">
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%><%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>">
<input type=hidden name=qryFlagT>
<input type=hidden name=customPass>
<input type=hidden name=idCardNo>
<input type=hidden name=custAddress>
<input type=hidden name=backLoginAccept>
<input type=hidden name=checkDate>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>


<script>
function printBill_before(){
	var busi_sumPay = 1*document.getElementById("vCashPay").value;//现金交款+支票交款+预存费
	if(busi_sumPay>0.01 || busi_sumPay<-0.01){
		printBill();
	}else{
		 rdShowMessageDialog("本次开户没有产生费用，因此不能发票打印！");
		 return;
	}
	
}
function printBill(){
	getAfterPrompt();
	var infoStr = "";
//1		|2	 |3				|4 |5 |6 |7				|8	 |9				|10			 |11			|12						 |13				|14-?		 |15		|16		 |17		|18									 |19			|20-28
//工号|流水|业务名称|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
	infoStr = "<%=workNo%>|";
	infoStr += document.frm.loginAccept.value + "|";
	infoStr += "发票补打" + "|";
	infoStr += "<%=new java.text.SimpleDateFormat("yyyy|MM|dd", Locale.getDefault()).format(new java.util.Date())%>|";
	infoStr += " |";	//6
	infoStr += " |";
	infoStr += document.getElementById("vPhoneNo").value + "|";
	infoStr += document.frm.userId.value + "|";
	infoStr += " |";
	infoStr += document.getElementById("vCashPay").value + "|";	//10
	infoStr += document.getElementById("vCashPay").value + "|";
	infoStr += "发票补打。";
	infoStr += "~选号费用：" + document.frm.vChoiceFee.value;
	infoStr += "~SIM卡费：" + document.frm.vSimFee.value;
	infoStr += "~其他费用：" + document.frm.vOtherFee.value;
	infoStr += "~机器费用：" + document.frm.vMachineFee.value;
	infoStr += "~押金：" + document.frm.vDeposit.value;
	infoStr += "~入网费用：" + document.frm.vInnetFee.value;
	infoStr += "~";
	infoStr += "~备注：用户 "+document.frm.phoneNo.value+" 打印发票|";
	infoStr += "<%=workName%>|";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
	infoStr += " |";
/*
	 infoStr+='<%=workNo%>'+"  "+document.frm.loginAccept.value+"  "+"发票补打"+"|";
         infoStr+='<%=new java.text.SimpleDateFormat("yyyy   MM    dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	     infoStr+=""+"|";
	     infoStr+=""+"|";
	     infoStr+=document.frm.phoneNo.value+"|";
	     infoStr+=document.frm.userId.value+"|";
	     infoStr+=""+"|";
		 infoStr+=document.frm.vCashPay.value+"|";
	     infoStr+="发票补打。*SIM卡费："+document.frm.vSimFee.value+"*机器费用："+document.frm.vMachineFee.value+"*入网费用："+document.frm.vInnetFee.value+"|";
 		 infoStr+="选号费用："+document.frm.vChoiceFee.value+"*其他费用："+document.frm.vOtherFee.value+"*押金："+document.frm.vDeposit.value+"|";
 		 infoStr+="备注："+"用户 "+document.frm.phoneNo.value+" 打印发票"+"|";
 		 infoStr+='<%=workName%>'+"|";

	 var workNo = document.all.workNo.value;
	 var loginAccept = document.all.loginAccept.value;
	 var totalDate = document.all.totalDate.value;
	 var phoneNo = document.all.phoneNo.value;
	 location.href="chkPrint.jsp?retInfo="+infoStr+"&dirtPage=f1244.jsp&workNo="+workNo+"&loginAccept="+loginAccept+"&totalDate="+totalDate+"&phoneNo="+phoneNo;                    
*/
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001","<%=workNo%>");
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005","");//用户名称 公共页面自己查
		$(billArgsObj).attr("10006","");//opName
		$(billArgsObj).attr("10008",document.frm.phoneNo.value);
		$(billArgsObj).attr("10015",document.getElementById("vCashPay").value);//小写
		$(billArgsObj).attr("10016",document.getElementById("vCashPay").value);//合计金额(大写) 传小写，公共页转换
		$(billArgsObj).attr("10017","*");//本次缴费：现金
		$(billArgsObj).attr("10020",document.frm.vInnetFee.value);//入网费
		$(billArgsObj).attr("10021",document.frm.vHandFee.value);//手续费
		$(billArgsObj).attr("10022",document.frm.vChoiceFee.value);//选号费
		$(billArgsObj).attr("10023",document.frm.vDeposit.value);//押金
		$(billArgsObj).attr("10024",document.frm.vSimFee.value);//SIM卡费
		$(billArgsObj).attr("10026",document.frm.vMachineFee.value);//机器费
		$(billArgsObj).attr("10027",document.frm.vOtherFee.value);//其他费
		$(billArgsObj).attr("10030",document.frm.loginAccept.value);//业务流水
		$(billArgsObj).attr("10036",document.frm.vOpCode.value);//具体操作代码 只针对1244
		$(billArgsObj).attr("10073","发票补打"); //1244 特定参数
		$(billArgsObj).attr("10031","<%=workName%>");//开票人
		$(billArgsObj).attr("10071","4");//模板号，只要走1244补打发票，都为样张4
		
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=确实要进行发票打印吗？";
		
					//发票项目修改为新路径
			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=确实要进行发票打印吗？";
	
		var path = path + "&infoStr="+printInfo+"&loginAccept="+document.frm.loginAccept.value+"&opCode=1244&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		location = "/npage/s1244/f1244.jsp?opCode=1244&opName=<%=opName%>";

}

</script>
</BODY></HTML>
