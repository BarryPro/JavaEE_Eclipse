<%
/********************
version v2.0
开发商: si-tech
update:zhangnc@2009-07-21 补充生成电子托收单
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");	
	String WorkNo = (String)session.getAttribute("workNo");
	String CheckNo="";	//要验证的条数 序号
	//String TMoney0="";
	//String TContract0="";
	
    	
  //s1300viewBean viewBean = new s1300viewBean();//实例化viewBean
  ArrayList retArray = new ArrayList();
  String [][] result = new String[][]{};
  //String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
 
	//取上个月
	Calendar calendar = new GregorianCalendar();
    	int year = calendar.get(Calendar.YEAR);
    	int month = calendar.get(Calendar.MONTH);
        
	Date date = new Date();
    	date.setYear(year-1900);
    	date.setMonth(month - 1);
  String yearMonth = new java.text.SimpleDateFormat("yyyyMM").format(date);
%>

<HTML>
<HEAD>
<SCRIPT type="text/javascript">
window.onload=function() 
{
	for(var i=0;i<document.getElementsByName("busyType").length;i++){
		if((document.getElementsByName("busyType"))[i].checked&&(document.getElementsByName("busyType"))[i].value=="2"){
			document.all.Check1.disabled=false;
			  document.all.Submit1.disabled=true;
     		return true;
    }
		if((document.getElementsByName("busyType"))[i].checked&&(document.getElementsByName("busyType"))[i].value=="3"){
			document.all.Check1.disabled=true;
			  document.all.Submit1.disabled=false;
     		return true;
    }
	}
}
function sel2()
{
	document.all.busy_type.value = "2";
	document.all.Check1.disabled=false;
	document.all.Submit1.disabled=true;
	//document.all.preview.disabled=false;
	//document.all.printer.disabled=false;
}
function sel3()
{
	document.all.busy_type.value = "2";
	document.all.Check1.disabled=true;
	document.all.Submit1.disabled=false;
	//document.all.preview.disabled=false;
	//document.all.printer.disabled=false;
}
//-----------------------------------------------------
function DoValid()
{
 // alert('验证~~');
  with(document.form1)
  {	
    if (TPrintDate.value == ""){
      rdShowMessageDialog("托收年月不能为空!");
      return false;
    }
    else if (!forDate(TPrintDate)){
      return false;
    }    
    return true;
  }
}
//-----------------------------------------------------
function doProcess(packet){		
	var flag = packet.data.findValueByName("flag");

	if(flag == 1)
	{
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode != "000000"){
			rdShowMessageDialog("["+errorCode+"]:"+errorMsg,0);
			return;
		}
	}
	DoCfm();
}
//-----------------------------------------------------
function DoCheck() {
	/*switch (tmpa)
	{
		case 1:		
			document.all.CheckNo.value="1";
			document.all.TContract0.value=document.all.TContract1.value;
			document.all.TMoney0.value=document.all.Money1.value;
			break;
		case 2:		
			document.all.CheckNo.value="2";
			document.all.TContract0.value=document.all.TContract2.value;
			document.all.TMoney0.value=document.all.Money2.value;
			break;
		case 3:		
			document.all.CheckNo.value="3";
			document.all.TContract0.value=document.all.TContract3.value;
			document.all.TMoney0.value=document.all.Money3.value;
			break;
		case 4:
			document.all.CheckNo.value="4";		
			document.all.TContract0.value=document.all.TContract4.value;
			document.all.TMoney0.value=document.all.Money4.value;
			break;
		case 5:		
			document.all.CheckNo.value="5";
			document.all.TContract0.value=document.all.TContract5.value;
			document.all.TMoney0.value=document.all.Money5.value;
			break;
		case 6:	
			document.all.CheckNo.value="6";	
			document.all.TContract0.value=document.all.TContract6.value;
			document.all.TMoney0.value=document.all.Money6.value;
			break;
		case 7:		
			document.all.CheckNo.value="7";
			document.all.TContract0.value=document.all.TContract7.value;
			document.all.TMoney0.value=document.all.Money7.value;
			break;
		case 8:		
			document.all.CheckNo.value="8";
			document.all.TContract0.value=document.all.TContract8.value;
			document.all.TMoney0.value=document.all.Money8.value;
			break;
		case 9:		
			document.all.CheckNo.value="9";
			document.all.TContract0.value=document.all.TContract9.value;
			document.all.TMoney0.value=document.all.Money9.value;
			break;
		case 10:
			document.all.CheckNo.value="10";		
			document.all.TContract0.value=document.all.TContract10.value;
			document.all.TMoney0.value=document.all.Money10.value;
			break;																											
		default:
			break;		
	}
	*/
	if (DoValid()) {
	var getNote_Packet = new AJAXPacket("s4427Check.jsp","正在验证数据的正确性，请稍候......");
		getNote_Packet.data.add("TPrintDate",document.all.TPrintDate.value);
		getNote_Packet.data.add("WorkNo",document.all.WorkNo.value);
		getNote_Packet.data.add("opCode",document.all.opCode.value);
		getNote_Packet.data.add("opName",document.all.opName.value);
			
		getNote_Packet.data.add("TContract1",document.all.TContract1.value);
		getNote_Packet.data.add("TContract2",document.all.TContract2.value);
		getNote_Packet.data.add("TContract3",document.all.TContract3.value);
		getNote_Packet.data.add("TContract4",document.all.TContract4.value);
		getNote_Packet.data.add("TContract5",document.all.TContract5.value);
		getNote_Packet.data.add("TContract6",document.all.TContract6.value);
		getNote_Packet.data.add("TContract7",document.all.TContract7.value);
		getNote_Packet.data.add("TContract8",document.all.TContract8.value);
		getNote_Packet.data.add("TContract9",document.all.TContract9.value);
		getNote_Packet.data.add("TContract10",document.all.TContract10.value);

		getNote_Packet.data.add("Money1",document.all.Money1.value);
		getNote_Packet.data.add("Money2",document.all.Money2.value);
		getNote_Packet.data.add("Money3",document.all.Money3.value);
		getNote_Packet.data.add("Money4",document.all.Money4.value);
		getNote_Packet.data.add("Money5",document.all.Money5.value);
		getNote_Packet.data.add("Money6",document.all.Money6.value);
		getNote_Packet.data.add("Money7",document.all.Money7.value);
		getNote_Packet.data.add("Money8",document.all.Money8.value);
		getNote_Packet.data.add("Money9",document.all.Money9.value);
		getNote_Packet.data.add("Money10",document.all.Money10.value);		
		core.ajax.sendPacket(getNote_Packet);
		getNote_Packet=null;
	}
	
} 
//-----------------------------------------------------
function DoCfm() {
	getAfterPrompt();
	if (DoValid()) {
		document.form1.action="s4426Cfm.jsp";
		form1.submit();
	}
	
} 

</script>

<title>黑龙江BOSS-补充生成电子托收单</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
</head>

<BODY>
<FORM action="" method="post" name="form1" >
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">操作信息</div>
	</div> 
	<input type="hidden" value="" name="hString">
	<input type="hidden" value="" name="hType">
	<input type="hidden" value="1" name="busy_type">
	<input type="hidden" value="<%=opCode%>" name="opCode">
	<input type="hidden" value="<%=opName%>" name="opName">
	<input type="hidden" value="1" name="<%=CheckNo%>">	

	<table  cellspacing="0" >
		<tbody> 
			<tr> 		
				<td width="5%" class="blue">操作类型</td>
				<td width="25%"> 
					<input type="radio" name="busyType"  value="2" checked onclick="sel2()">补充生成电子托收单
					<input type="radio" name="busyType"  value="3" onclick="sel3()">免验证补充生成电子托收单
				</td>
			</tr>
		</tbody> 
	</table>
	<br>
    		<div class="title">
		<div id="title_zi">业务信息</div>
	</div> 
        <table  cellspacing=0 >
		<tr> 
			<td width="16%" nowrap class="blue">托收年月</td>
			<td width="25%"> 
				<input type="text" name="TPrintDate" v_format="yyyyMM"  maxlength="6" value="<%=yearMonth%>" onblur="checkElement(this)">
			</td>
			<td width="17%" nowrap class="blue">工号</td>
			<td width="25%"> 
				<input class="InputGrey" name="WorkNo" maxlength="6" value="<%=WorkNo%>" readonly>
			</td>
		</tr>

		<tr id="bat_id1" > 
			<td width="16%" nowrap class="blue">1        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract1" maxlength="15" onKeyPress="return isKeyNumberdot(0)" >
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money1" v_type ="money" maxlength="20" >
			</td>
		</tr>
		
		<tr id="bat_id2" > 
			<td width="16%" nowrap class="blue">2        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract2" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money2" v_type ="money" maxlength="20" >
			</td>
		</tr>		    

		<tr id="bat_id3" > 
			<td width="16%" nowrap class="blue">3        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract3" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money3" v_type ="money" maxlength="20" >
			</td>
		</tr>
 
 		<tr id="bat_id4" > 
			<td width="16%" nowrap class="blue">4        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract4" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money4" v_type ="money" maxlength="20" >
			</td>
		</tr>   
		
		<tr id="bat_id5" > 
			<td width="16%" nowrap class="blue">5        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract5" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money5" v_type ="money" maxlength="20" >
			</td>
		</tr>		

		<tr id="bat_id6" > 
			<td width="16%" nowrap class="blue">6        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract6" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money6" v_type ="money" maxlength="20" >
			</td>
		</tr>		

		<tr id="bat_id7" > 
			<td width="16%" nowrap class="blue">7        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract7" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money7" v_type ="money" maxlength="20" >
			</td>
		</tr>

		<tr id="bat_id8" > 
			<td width="16%" nowrap class="blue">8        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract8" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money8" v_type ="money" maxlength="20" >
			</td>
		</tr>

		<tr id="bat_id9" > 
			<td width="16%" nowrap class="blue">9        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract9" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money9" v_type ="money" maxlength="20" >
			</td>
		</tr>
		
		<tr id="bat_id10" > 
			<td width="16%" nowrap class="blue">10        合同号码</td>
			<td width="25%"> 
				<input type="text" name="TContract10" maxlength="15" onKeyPress="return isKeyNumberdot(0)">
			</td>
			<td  width="17%" nowrap class="blue">托收金额</td>
			<td  width="37%"> 
				<input type="text" name="Money10" v_type ="money" maxlength="20" >
			</td>
		</tr>
						  
  </table>
		  
	<TABLE cellSpacing="0" >          
		<TBODY> 
			<TR> 
				<TD id="footer">      
					<input type="button" class="b_foot" name="Check1" value="验证"  onClick="DoCheck()">
					&nbsp;
					<input type="button" class="b_foot" name="Submit1" value="确认"  onClick="DoCfm()" disabled>
					&nbsp;
					<input type="reset" class="b_foot" name="return1" value="清除">
					&nbsp;
					<input type="button" class="b_foot" name="return" value="关闭" onClick="removeCurrentTab()">   					    
				</TD>
			</TR>
		</TBODY> 
	</table>
	<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</body>
</html>

