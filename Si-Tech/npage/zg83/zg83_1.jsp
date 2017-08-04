<%
/********************
 version v2.0
开发商: si-tech
*
*huangqi
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		String opCode = "zg83";
		String opName = "特殊激活";
		String orgCode     = (String)session.getAttribute("orgCode");
		String regionCode  = orgCode.substring(0,2);
		String workno      = (String)session.getAttribute("workNo");
		String workname    = (String)session.getAttribute("workName");
		String nopass      = (String)session.getAttribute("password");
		/****得到打印流水****/
		String printAccept="";
		printAccept = getMaxAccept();
%>
	 
<HTML>
<HEAD>
<script language="JavaScript">
var printFlag=9;
 function inits(){
 	
 }
 function docheck()
 {
 	var card_no = document.getElementById("card_no").value;//充值卡卡号 
	var remark = document.getElementById("remark").value;//备注
 	var cardType = document.getElementById("cardType").value;//充值卡是否已刮
	var user_phone_no = document.getElementById("user_phone_no").value;// 
	var user_no = document.getElementById("user_no").value;// 
	if(card_no==""){
		rdShowMessageDialog("请输入充值卡卡号！");
		return false;
	}
	else	if(user_phone_no==""){
		rdShowMessageDialog("请输入持卡人手机号码！");
		return false;
	}
	else	if(remark==""){
		rdShowMessageDialog("请输入备注信息！");
		return false;
	}
	else	if(user_no==""){
		rdShowMessageDialog("请输入持卡人证件号码！");
		return false;
	}
	else
	{
		/*
		var checkPwd_Packet = new AJAXPacket("zg83_check.jsp","正在进行查询，请稍候......");
		checkPwd_Packet.data.add("card_no",card_no);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
		*/
		//xl add new 免填单前 增加查询金额的地方 begin
		var checkPwd_Packet1 = new AJAXPacket("../zg82/zg82_getMoney.jsp","正在进行查询，请稍候......");
		checkPwd_Packet1.data.add("card_no",card_no);
		//printAccept
		checkPwd_Packet1.data.add("printAccept","<%=printAccept%>");
		core.ajax.sendPacket(checkPwd_Packet1,s_get_money);
		checkPwd_Packet1=null;
		//end of 查询金额

		//xl add for 免填单逻辑
	}
 }
 function  s_get_money(packet)
 {
	 var s_flag = packet.data.findValueByName("s_flag");
	 var loginAccept = packet.data.findValueByName("loginAccept");
	 var card_money = packet.data.findValueByName("card_money");
	 //alert("loginAccept is "+loginAccept);
	 document.getElementById("card_money").value=card_money;
	 var card_no = document.getElementById("card_no").value;//充值卡卡号 
	 var card_pwd = "";//卡密这个字段没用
	 var phoneNo = "";//被充值号码 字段没用
	 var user_phone_no = document.getElementById("user_phone_no").value;//持卡人手机号码 
	 var user_no = document.getElementById("user_no").value;//持卡人身份证号码
	 var cardType = document.getElementById("cardType").value;//充值卡是否已刮
	 var remark = document.getElementById("remark").value;//备注
	 if(s_flag=="0")
	 {
		//alert("1?"); 
		printCommit();
		//alert("2 printFlag is "+printFlag);
		if(printFlag!=1)
		{
			//alert("3?");
			return false;
		}
		else
		{
			//alert("4?");
			var checkPwd_Packet = new AJAXPacket("../zg82/zg82_check.jsp","正在进行查询，请稍候......");
			checkPwd_Packet.data.add("card_no",card_no);
			checkPwd_Packet.data.add("card_pwd","");
			checkPwd_Packet.data.add("phoneNo","");		
			checkPwd_Packet.data.add("user_phone_no",user_phone_no);
			checkPwd_Packet.data.add("user_no",user_no);
			checkPwd_Packet.data.add("cardType",cardType);
			checkPwd_Packet.data.add("loginAccept",loginAccept);
			//alert("loginAccept is "+loginAccept);
			core.ajax.sendPacket(checkPwd_Packet);
			checkPwd_Packet=null;
		}
	 }
	 else
     {
		 alert("无值!");
	 }
 } 
function doProcess(packet)
{
	var checkresult = packet.data.findValueByName("checkresult");
	var checkMsg = packet.data.findValueByName("checkMsg");
	var loginAccept = packet.data.findValueByName("loginAccept");
	if(checkresult=="Y")
	{		
		//没有数据，可以新增
		var card_no = document.getElementById("card_no").value;//充值卡卡号 
 	 
 		var cardType = document.getElementById("cardType").value;//充值卡是否已刮
		var user_no  =  document.getElementById("user_no").value;
		//document.frm.action="zg83_2.jsp?card_no="+card_no+"&cardType"+cardType+"&user_no="+user_no;
		document.frm.action="zg83_2.jsp?card_no="+card_no+"&cardType"+cardType+"&user_no="+user_no+"&loginAccept="+loginAccept;
		//alert(document.frm.action);
		document.frm.submit();
	}
	else
	{
		alert(checkMsg);
		return false;
	}
}	 
 


 //xl add for Huxl 免填单提前打印
 function printCommit()
 {          
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	
 }
 function showPrtDlg(printType,DlgMessage,submitCfn)
 {  //显示打印对话框
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;

	var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=printAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="zg83" ;                   			 		//操作代码
	var phoneNo=document.getElementById("user_phone_no").value;                  	 		//客户电话
	//alert("sysAccept is "+sysAccept);
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfn;
	path+="&mode_code="+mode_code+
		"&fav_code="+fav_code+"&area_code="+area_code+
		"&opCode=<%=opCode%>&sysAccept="+sysAccept+
		"&phoneNo="+phoneNo+
		"&submitCfm="+submitCfn+"&pType="+
		pType+"&billType="+billType+ "&printInfo=" + printStr;

	var ret=window.showModalDialog(path,printStr,prop);
	if(ret==""){
		ret="confirm";
	}
		  if(typeof(ret)!="undefined")
		  {
			 if((ret=="confirm")&&(submitCfn == "Yes"))
			 {
			   if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
			   {
				document.all.printcount.value="1";
				printFlag=1;
			   }
			 }
			 if(ret=="continueSub")
			 {
				if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
				{
					document.all.printcount.value="0";
					printFlag=1;
				}
			 }
		 }
		else
		{
			if(rdShowConfirmDialog('确认要进行此项服务吗？')==1)
			{
				document.all.printcount.value="0";
				printFlag=1;
			}
		}
 }
 function printInfo(printType)
 {
		var cust_info=""; //客户信息
		var opr_info=""; //操作信息
		var retInfo = "";  //打印内容
		var note_info1=""; //备注1
		var note_info2=""; //备注2
		var note_info3=""; //备注3
		var note_info4=""; //备注4
		
		cust_info+=" "+"|";
		opr_info+="手机号码:"+document.getElementById("user_phone_no").value+"|";
		opr_info+="证件号码:"+document.getElementById("user_no").value+"|";
		opr_info+="办理业务:充值卡激活操作"+"|";
		opr_info+="操作流水:"+"<%=printAccept%>"+"|";
		opr_info+="营业员工号:"+"<%=workno%>"+"|";
		opr_info+="操作时间：" + "<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>" +  "|";
		opr_info+="激活充值卡号:"+document.getElementById("card_no").value+"|";
		opr_info+="激活充值卡面值："+document.getElementById("card_money").value+"元"+"|";
		opr_info+="备注：为方便您的充值卡正常使用，请您在营业厅现场进行充值，并将充值卡返还给营业人员处理。"+"|";

		note_info1+=""+"|";

		retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

		return retInfo;
 }
 //end of huxl
  function doclear() {
 		frm.reset();
 }

-->
 </script> 
 
<title>黑龙江BOSS-普通缴费</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">		
		<%@ include file="/npage/include/header.jsp" %>  
 
     
  
	<table cellspacing="0">
		<tr > 
      <td class="blue" width="15%">充值卡卡号 </td>
     	<td> 
				<input class="button"type="text" id="card_no" name="card_no" onKeyPress="return isKeyNumberdot(0)" size="32" maxlength="32"   >
		  </td> 
		    <td class="blue" width="15%">充值卡是否已刮</td>
     	<td> 
				<select name="cardType" id="cardType" >
						<option value="0" selected>已刮</option>
						<option value="1">未刮</option>
				</select>
		  </td>   
	<input type="hidden" id="card_money">	    
  	</tr>
	<tr>
		<tr > 
			 <td class="blue" width="15%">持卡人身份证号码 </td>
     	<td> 
				<input class="button"type="text" id="user_no" name="user_no" size="20" onKeyPress="return isKeyNumberdot(0)" size="20" maxlength="20"   >
		  </td>
      <input type="hidden" name="printcount">
		  <td class="blue" width="15%">持卡人手机号码 </td>
     	<td> 
				<input class="button"type="text" id="user_phone_no" name="user_phone_no" size="20" onKeyPress="return isKeyNumberdot(0)"  maxlength="15"   >
		  </td>      
		</tr>
	</tr>
	<tr >   
		  <td class="blue" width="15%">备注</td>
     	<td colspan=3> 
				<textarea name="remark" id="remark" maxlength="256"  rows="5" cols="75" class="required" ></textarea>
		  </td>      
  	</tr>
	
    <!--
		
		<tr><td  colspan=4></td></tr>
		<tr > 
			 <td class="blue" width="15%">被充值手机号码 </td>
     	<td> 
				<input class="button"type="text" id="phone_no" name="phone_no" size="20" onKeyPress="return isKeyNumberdot(0)"  maxlength="15"   >
		  </td> 
		 <td class="blue" width="15%" >卡密</td>
     	<td> 
				<input class="button"type="text" id="card_pwd" name="card_pwd" onKeyPress="return isKeyNumberdot(0)" size="32" maxlength="32"   >
		  </td>   
    
    
    
    
		</tr>
		<tr >   
		  <td class="blue" width="15%">备注</td>
     	<td colspan=3> 
				<textarea name="remark" id="remark" maxlength="256"  rows="5" cols="75" class="required" ></textarea>
		  </td>      
  	</tr>
	-->
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="确认" onclick="docheck()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="重置" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="关闭" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>