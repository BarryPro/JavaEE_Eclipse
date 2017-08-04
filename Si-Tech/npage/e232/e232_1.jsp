<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 赠送预存款 8379
   * 版本: 1.0
   * 日期: 2010/3/12
   * 作者: sunaj
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
	request.setCharacterEncoding("GBK");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>赠送预存款</title>
<%
    //String opCode="8379";
	//String opName="赠送预存款";

    String opCode=request.getParameter("opCode");
	String opName=request.getParameter("opName");	
	String phoneNo = (String)request.getParameter("activePhone");
    String workNo=(String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String regionCode=(String)session.getAttribute("regCode");
    String[][] favInfo=(String[][])session.getAttribute("favInfo");
	boolean workNoFlag=false;
	if(workNo.substring(0,1).equals("k"))
		workNoFlag=true;
%>
<%
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
%>

  </script>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language="javascript">

 

</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
 	<input type="hidden" name="opcode" value = "e232" >
	<input type="hidden" name="opname" value = "两码合一社会渠道返费模式" >
	<%@ include file="/npage/include/header.jsp" %>
	 
<table cellspacing="0">
   
	<tr> 
		<td class="blue">主卡手机号码 </td>
		<td> 
			<input type="text" size="12" name="srv_no" value="<%=activePhone%>" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" index="0" class="InputGrey" readOnly>
			&nbsp;&nbsp;&nbsp;&nbsp;	 
	 
			<input type=button class="b_text" name="check2" value="校验" onclick="check1()" >
		</td>
		
	</tr>
     
	<tr> 
		<td class="blue">副卡手机号码 </td>
		<td> 
			<input type="text" size="12" name="srv_no2"  id="srv_no2" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1 maxlength="11" >
			&nbsp;&nbsp;&nbsp;&nbsp;	 
	 
			<input type=button class="b_text" name="checkNew" value="确认" onclick="confrims()" disabled>
		</td>	 
	</tr>
</table>
<input type = "hidden" name="custName">
<input type = "hidden" name="custId">
<input type = "hidden" name="custAddr">
<input type = "hidden" name="dMainFee">
<input type = "hidden" name="dMainMonth">
<input type = "hidden" name="mainPer">
<input type = "hidden" name="dSecondFee">
<input type = "hidden" name="dSecondMonth">
<input type = "hidden" name="secPer">
<input type="hidden" id="s_accept" name="s_accept">
<input type="hidden" name="printcount">
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
<script language="javascript">
var printFlag=9;
	function check1()
	{
		var myPacket = new AJAXPacket("e232_check.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",document.frm.srv_no.value);
		core.ajax.sendPacket(myPacket);
    	myPacket=null;
	}
	function confrims()
	{
		var sec_phone = document.all.srv_no2.value;
		if(sec_phone=="")
		{
			rdShowMessageDialog("请输入副卡手机号码！");
			document.all.srv_no2.focus();
			return false;
		}
		//xl add 免填单
		var myPacket = new AJAXPacket("e232_qry.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",document.frm.srv_no.value);
		myPacket.data.add("phoneNo2",document.frm.srv_no2.value);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
	function doProcess(packet)
	{
		var flagMain =  packet.data.findValueByName("flag1");
		var custName =packet.data.findValueByName("cust_name"); 
		var custId =packet.data.findValueByName("cust_id"); 
		var custAddr =packet.data.findValueByName("cust_addr"); 
		//alert("custName is "+custName+" and id is "+custId+" and custAddr is "+custAddr);
		document.all.custName.value=custName;
		document.all.custId.value=custId;
		document.all.custAddr.value=custAddr;
		var dMainFee =packet.data.findValueByName("dMainFee"); 
		var dMainMonth =packet.data.findValueByName("dMainMonth"); 
		var mainPer =packet.data.findValueByName("mainPer"); 
		var dSecondFee =packet.data.findValueByName("dSecondFee"); 
		var dSecondMonth =packet.data.findValueByName("dSecondMonth"); 
		var secPer =packet.data.findValueByName("secPer"); 
		document.all.dMainFee.value=dMainFee;
		document.all.dMainMonth.value=dMainMonth;
		document.all.mainPer.value=mainPer;
		document.all.dSecondFee.value=dSecondFee;
		document.all.dSecondMonth.value=dSecondMonth;
		document.all.secPer.value=secPer;
		//alert("dMainFee is "+dMainFee+" and dMainMonth is "+dMainMonth+" and mainPer is "+mainPer);
		if(flagMain==1)
		{
			var errCode =  packet.data.findValueByName("errCode");
			var errMsg =  packet.data.findValueByName("errMsg");
			rdShowMessageDialog("校验失败！错误原因："+errMsg+",错误代码："+errCode);
			return false;
		}
		if(flagMain==0)
		{
			rdShowMessageDialog("主卡号码校验成功！请输入副卡号码。");
			document.all.srv_no2.focus();
			document.all.checkNew.disabled=false;
		}
		var flagConfirm =  packet.data.findValueByName("flag2");
		//alert("flagConfirm is "+flagConfirm);
		if(flagConfirm==1)
		{
			var errCode2 =  packet.data.findValueByName("errCode2");
			var errMsg2 =  packet.data.findValueByName("errMsg2");
			rdShowMessageDialog("操作失败！失败原因："+errMsg2+",错误代码："+errCode2);
			return false;
		}
		if(flagConfirm==0)
		{
			//rdShowMessageDialog("操作成功!");
			//add 免填单
			printCommit();
			//flag3 do页面返回的
			if(printFlag!=1)
			{
				return false;
			}
			else
			{
				var myPacket = new AJAXPacket("e232_do.jsp","正在提交，请稍候......");
				myPacket.data.add("phoneNo",document.frm.srv_no.value);
				myPacket.data.add("phoneNo2",document.frm.srv_no2.value);
				//增加流水 var sysAccept = "<%=printAccept%>";
				myPacket.data.add("sysAccept","<%=printAccept%>");
				core.ajax.sendPacket(myPacket,retsWLWI);
				myPacket=null;
			}
			//打印之后再调do页面 进行业务受理
			//window.location="e232_1.jsp?activePhone=<%=activePhone%>&opCode=e232&opName="+document.all.opname.value;
		}

	}
	function retsWLWI(packet)
	{
		var flag3 =  packet.data.findValueByName("flag3");
		//alert("flag3 is "+flag3);
		if(flag3==0)
		{
			rdShowMessageDialog("操作成功!");
			window.location="e232_1.jsp?activePhone=<%=activePhone%>&opCode=e232&opName="+document.all.opname.value;
		}
		else
		{
			var errCode2 =  packet.data.findValueByName("errCode2");
			var errMsg2 =  packet.data.findValueByName("errMsg2");
			rdShowMessageDialog("操作失败！失败原因："+errMsg2+",错误代码："+errCode2);
			return false;
		}
	}
</script>
<script>

function printCommit()
{          
	showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");  	
}

function showPrtDlg(printType,DlgMessage,submitCfn)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1"; 
	var mode_code=null;
	var fav_code=null;
	var area_code=null;
	var firstIdStr = $("#firstId").val();	
	var secondIdStr = $("#secondId").val();
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	var sysAccept = "<%=printAccept%>";	
   var printStr = printInfo(printType);
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage + "&iccidInfo=" +firstIdStr +"|"+secondIdStr + "&accInfoStr="+accInfoStr;

	path+="&mode_code="+mode_code+
	"&fav_code="+fav_code+"&area_code="+area_code+
	"&opCode=<%=opCode%>&sysAccept="+sysAccept+
	"&phoneNo="+document.frm.srv_no.value+
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
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
/*
	opr_info+='<%=workNo%>'+' '+'<%=loginName%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
*/	cust_info+="手机号码："+document.all.srv_no.value+"|";
	cust_info+="客户姓名："+document.all.custName.value+"|";
	cust_info+="证件号码："+document.all.custId.value+"|";
	cust_info+="客户地址："+document.all.custAddr.value+"|";

	opr_info+="绑定副卡: "+document.all.srv_no2.value+"|";
	opr_info+="业务类型：主副卡绑定业务"+"|";
	opr_info+="业务受理时间: "+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="主卡赠送话费 "+document.all.dMainFee.value+"元,分 "+document.all.dMainMonth.value+"月返还,每月返还 "+document.all.mainPer.value+"元"+"|";
	opr_info+="副卡赠送话费 "+document.all.dSecondFee.value+"元,分 "+document.all.dSecondMonth.value+"月返还,每月返还 "+document.all.secPer.value+"元"+"|";　　

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
</script>
<script>
/*
function printBill(){
	  var infoStr="";  
      retInfo+='<%=workNo%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   
      retInfo+="手机号码："+document.all.srv_no.value+"|";
 
       
       
      retInfo+=document.all.remark.value+"|"; 

	location.href="<%=request.getContextPath()%>/page/innet/hljPrint.jsp?retInfo="+infoStr+"&dirtPage=e232_1.jsp";  
                  
}*/
</script>