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
	var loginAcceptss = packet.data.findValueByName("loginAcceptss");	
	
		
	var errCodeInt = parseInt(errCode);
	if(cfmFlag==0){
		if(errCodeInt==0){
			//rdShowMessageDialog("操作成功！",2);
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
			//document.frm.vMachineCode.value=backString[0][10];
			//document.frm.vMachName.value=backString[0][11];
			//document.frm.vCashPay.value=backString[0][12]; ---感觉只展示crm计的钱数有问题，改成展示总钱数以免用户有疑问
			document.frm.vCashPay.value=backString[0][23];
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
			document.frm.pay_money.value=Number(backString[0][23])-Number(backString[0][12]);
			document.frm.custnames.value=backString[0][24];
			document.frm.loginAcceptss.value=loginAcceptss;
			document.frm.zongqianshussss.value=backString[0][23];
			document.frm.iccidtypes.value=backString[0][26];
			document.frm.iccidnoss.value=backString[0][25];
			
			//alert(backString[0][23]);
			infoDiv.style.display="";
			document.frm.submit.disabled=false;
		
		}else{
			
			rdShowMessageDialog(errCode+""+errMsg,0);
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
//document.frm.vMachineCode.value="";
//document.frm.vMachName.value="";
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
document.frm.pay_money.value="";
document.frm.custnames.value="";
document.frm.zongqianshussss.value="";

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
        <td class=blue>宽带账号</td>
        <td > 
            <input  id=Text2 type=text size=17 name=phoneNo   value="">
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
    <tr>
    	        <td colspan="6">
        <font color="orange">注：此界面只支持“宽带入网”的发票补打</font>
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
        <td class=blue>宽带预存款</td>
        <td > 
            <input class=InputGrey id=Text2 type=text size=17 name=pay_money readOnly >
        </td>
                <td class=blue>操作时间</td>
        <td colspan="3"> 
            <input class=InputGrey id=Text2 type=text size=17 name=vOpTime readOnly >
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

<input type=hidden name=opCode value="<%=opCode%>">
<input type=hidden name=opName value="<%=opName%>">
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
<input type=hidden name=custnames>
<input type=hidden name=loginAcceptss>
<input type=hidden id=zongqianshussss name=zongqianshussss>	
<input type=hidden id=iccidtypes name=iccidtypes>
<input type=hidden id=iccidnoss name=iccidnoss>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>


<script>
function printBill_before(){
	var busi_sumPay = 1*document.getElementById("zongqianshussss").value;//现金交款+支票交款+预存费
	var zdfy= 1*document.frm.vMachineFee.value;
	var yajinfy= 1*document.frm.vDeposit.value;
	if(busi_sumPay>0.01 || busi_sumPay<-0.01){
	  if(zdfy>0.01 || zdfy<-0.01) {
	  	showBroadKdZdBill();
		}
	  if(yajinfy>0.01 || yajinfy<-0.01) {
	  	showBroadKdZdBill();
		}
		printBill();

	}else{
		 rdShowMessageDialog("本次开户没有产生费用，因此不能发票打印！");
		 return;
	}
	
} function printBill(){ getAfterPrompt();
	
	var printInfo = "";
	var zongqianshu= Number(document.frm.pay_money.value)+Number(document.frm.vInnetFee.value);
	  printInfo += "<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += "<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>" + "|";
		printInfo += document.frm.loginAccept.value + "|";
		printInfo += document.frm.custnames.value + "|";
		printInfo += " " + "|";
		printInfo += " " + "|";
		printInfo += document.frm.phoneNo.value + "|";
		printInfo += " " + "|";
		printInfo += zongqianshu+ "|";
		printInfo += zongqianshu + "|";
		printInfo += "宽带发票补打" + "|";
		printInfo += "初装费：" + document.frm.vInnetFee.value + "元" + "~";
		if(Number(document.frm.pay_money.value) > 0){
			printInfo += "宽带套餐预存款：" + document.frm.pay_money.value + "元" + "~";
		}


		if(document.frm.vSmCode.value == "kf"){
			printInfo += "客服热线：10086" + "|";
		}else{
			printInfo += "客服热线：10050" + "~";
			printInfo += "网址：http://www.10050.net" + "|";
		}
		
		
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
		$(billArgsObj).attr("10001","<%=workNo%>");       //工号
 		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
 		$(billArgsObj).attr("10005",document.frm.custnames.value); //客户名称
 		$(billArgsObj).attr("10006","宽带入网发票补打"); //业务类别
 		$(billArgsObj).attr("10008",document.frm.vPhoneNo.value); //用户号码
 		$(billArgsObj).attr("10015", zongqianshu); //本次发票金额(小写)￥
 		$(billArgsObj).attr("10016", zongqianshu); //大写金额合计
 		$(billArgsObj).attr("10036","m123"); //操作代码	
 		$(billArgsObj).attr("10030",document.frm.loginAccept.value); //流水号--业务流水
 		$(billArgsObj).attr("10065", document.frm.phoneNo.value); //宽带账号
 		$(billArgsObj).attr("10066", document.frm.vInnetFee.value); //初装费
 		$(billArgsObj).attr("10067", document.frm.pay_money.value); //宽带套餐预存款
 		$(billArgsObj).attr("10017","*"); //本次缴费现金
 		$(billArgsObj).attr("10031","<%=workName%>");//开票人
		$(billArgsObj).attr("10071","8");//模板号
		
		
  var path ="";
  if(document.frm.phoneNo.value.indexOf("yd")==0 || document.frm.phoneNo.value.indexOf("jt")==0){
		path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
	}else{
		path = "/npage/public/pubBillPrintBroad.jsp?dlgMsg=" + "确实要进行发票打印吗？";
	}
	
	
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = path + "&infoStr="+printInfo+"&loginAccept="+document.frm.loginAccept.value+"&opCode=1244&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 

	  location = "chkPrint.jsp?opCode=<%=opCode%>&opName=宽带发票补打&vPhoneNo="+document.frm.vPhoneNo.value+"&workNo=<%=workNo%>&totalDate="+document.frm.totalDate.value+"&loginAccept="+document.frm.loginAccept.value;

}

function showBroadKdZdBill(){
			
	var printInfo = "";
	var prtLoginAccept = "";
	var iccidtypess=document.frm.iccidtypes.value;
	var iccidnoss=document.frm.iccidnoss.value;
	var fysqfss="";
	var kdZdFee = "";
	var kdpinpai=document.frm.vSmCode.value;
	
	var zdfy= 1*document.frm.vMachineFee.value;
	var yajinfy= 1*document.frm.vDeposit.value;
	
		if(zdfy>0.01 || zdfy<-0.01) {
	  	fysqfss="";
	  	kdZdFee=zdfy;
		}
	  if(yajinfy>0.01 || yajinfy<-0.01) {
	  	fysqfss="zsj";
	  	kdZdFee=yajinfy;
	  	
		}

	
	var  billArgsObj = new Object();

		var opType = "";
		var custName = "";
		var phoneNo = "";
		var feeName = "宽带终端费用";


 		/*2014/09/11 15:18:07 gaopeng 宽带资费展现及终端管理等七项系统支撑优化需求
	  		加入 宽带设备终端款 
	  	*/
	  	var shuilv = 0.17;  	
	  	var danjia = 0;
	  	var shuie = 0;
	  	if(yajinfy>0.01 || yajinfy<-0.01) {
	  		/*2016/7/25 10:55:51 gaopeng 关于集团宽带产品BOSS二次开发的需求 
	  				ki  押金的时候 税率为0
	  			*/
	  			//alert(kdpinpai);
	  		if(kdpinpai == "ki"){
					shuilv == 0.00;
				}
	  	}
		
		
		danjia = Number(kdZdFee) - Number(kdZdFee)*shuilv;
		shuie = Number(kdZdFee)*shuilv;
 		
			$(billArgsObj).attr("10001","<%=workNo%>");     //工号
			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
			$(billArgsObj).attr("10005",document.frm.custnames.value);   //客户名称
			$(billArgsObj).attr("10006","宽带入网发票补打");    //业务类别
			$(billArgsObj).attr("10008",document.frm.vPhoneNo.value);    //用户号码
			$(billArgsObj).attr("10015", kdZdFee+"");   //本次发票金额
			$(billArgsObj).attr("10016", kdZdFee+"");   //大写金额合计
			$(billArgsObj).attr("10017","*");        //本次缴费：现金
			/*10028 10029 不打印*/
		  $(billArgsObj).attr("10028","");   //参与的营销活动名称：
			$(billArgsObj).attr("10029","");	 //营销代码	
			$(billArgsObj).attr("10030",document.frm.loginAccept.value);   //流水号：--业务流水
			$(billArgsObj).attr("10036","m123");   //操作代码
		
			$(billArgsObj).attr("10042","台");                   //单位
			$(billArgsObj).attr("10043","1");	                   //数量
			$(billArgsObj).attr("10044",kdZdFee+"");	                //单价
			/*10045不打印*/
			$(billArgsObj).attr("10045","");	       //IMEI
			/*型号不打*/
			$(billArgsObj).attr("10061","");	       //型号
			$(billArgsObj).attr("10062",shuilv+"");	//税率
			$(billArgsObj).attr("10063",shuie+"");	//税额	   
	    $(billArgsObj).attr("10071","6");	//税额	
	 		$(billArgsObj).attr("10076",danjia+"");
	 		$(billArgsObj).attr("10077", kdZdFee+""); //宽带终端金额
 			$(billArgsObj).attr("10078", kdpinpai); //宽带品牌			
 			
 			if(fysqfss=="zsj") {
 			$(billArgsObj).attr("10083", iccidtypess); //证件类型
 			$(billArgsObj).attr("10084", iccidnoss); //证件号码
 			$(billArgsObj).attr("10085", fysqfss); //宽带费用收取方式
 			$(billArgsObj).attr("10086", "尊敬的用户，如您办理销户、撤单时，请携带ONT设备、押金发票、有效证件，到移动指定自有营业厅办理返还押金。"); //备注
 			$(billArgsObj).attr("10041", "宽带终端押金费用");           //品名规格 实际是宽带终端类型
 			$(billArgsObj).attr("10065", document.frm.phoneNo.value); //宽带账号
 			
 			}else {
 			$(billArgsObj).attr("10041", "宽带终端费用");           //品名规格 实际是宽带终端类型
 			}
 			
	 		
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
			var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？"+"&feeName="+feeName;
			var loginAccept = prtLoginAccept;
			var path = path + "&infoStr="+printInfo+"&loginAccept="+document.frm.loginAccept.value+"&opCode=1244&submitCfm=submitCfm";
			var ret = window.showModalDialog(path,billArgsObj,prop);		

}


</script>
</BODY></HTML>
