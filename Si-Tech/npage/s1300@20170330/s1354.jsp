<%
/********************
 version v2.0
 开发商: si-tech
 模块：陈帐.死帐回收
 update zhaohaitao at 2008.12.29
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>	
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
 
 <%
 	String opCode = request.getParameter("opCode");
  	String opName = request.getParameter("opName");
  	String flag = "";
  	String flag1 = "";
  	if(opCode.trim().equals("1358")){
  		flag = "checked";
  	}else{
  		flag1 = "checked";
  	}
  	activePhone = request.getParameter("activePhone");
    String workno = (String)session.getAttribute("workNo");

	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr1 = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%>

<HEAD>
 
<title>黑龙江BOSS-陈帐.死帐回收</title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">

</HEAD>
 <BODY onLoad="form_load();">
<FORM action="s1354Cfm.jsp" method="post" name="form" >
	<%@ include file="/npage/include/header.jsp" %>  
	
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	
<INPUT TYPE="hidden" name="busyType" value="1">
<INPUT TYPE="hidden" name="Op_Code" value="1354">
<input type="hidden" name="totaldate"  value="<%=dateStr1%>">
<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
<input type="hidden" name="billdate"  value="<%=dateStr%>">
<input type="hidden" name="idno">
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">

<input type="hidden" name="contractno"  value="">
<input type="hidden" name="water_number"  value="">

<table cellspacing="0">
    <tr> 
	    <td class="blue">操作类型</td>
	    <td colspan="3"> 
			<input type="radio" name="busy"   value="1" <%=flag1%> onclick="sel1()">陈帐回收 
			<input type="radio" name="busy"  value="2" <%=flag%>   onclick="sel2()">死帐回收 
		</td>
	</tr> 
	<tr>
		<td class="blue">服务号码</td>
	    <td> 
			<input type="text" name="phoneNo" onkeydown="if(event.keyCode==13) DoCheck();"  onKeyPress="return isKeyNumberdot(0)">
			<input type="button" class="b_text" name="sure" value="查询"  onClick="DoCheck()">            
	    </td>
	    <td class="blue">归属地区</td>
	    <td>
	      	<input type="text" disabled name="count23">
	    </td>
	</tr>
	<tr > 
		<td class="blue">付费帐户</td>
		<td> 
		  	<input type="text" disabled class="InputGrey"  name="count">
		</td>
		<td class="blue">客户名称</td>
		<td> 
		  	<input type="text" name="custName" readonly class="InputGrey" value="">
		</td>
	</tr>
	<tr> 
		<td class="blue">大 客 户</td>
		<td> 
		  	<input type="text" disabled class="InputGrey"  name="count2">
		</td>
		<td class="blue">集团标志</td>
		<td> 
		  	<input type="text" class="InputGrey"  disabled name="regionName">
		</td>
	</tr>
	<tr> 
		<td class="blue">预存款</td>
		<td>
		  	<input type="text" disabled class="InputGrey"  name="count22">
		</td>
		<td class="blue">补收月租</td>
		<td> 
		  	<input type="text"  class="InputGrey" name="creditStand" disabled>
		</td>
	</tr>
	<tr> 
		<td id="footer" colspan="4"> 
			<div align="center"> 
				<input type="submit" name="sure1" class="b_foot" value="确认" disabled>
				&nbsp;
				<input type="button" name="cancel" class="b_foot" value="清除" onclick="doclear()">
				&nbsp;
				<input type="button" name="reprint"  class="b_foot" value="重打发票" onclick="doreprint()">
				&nbsp;
				<input type="button" name="nopay" class="b_foot_long" value="上笔缴费冲正" onclick="donopay()">
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab()">
			</div>
		</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
<!--
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";

function form_load()
{
	var op_code = "<%=opCode%>";
	if(op_code=="1354"){
		document.form.busyType.value = "1";
	}else{
		document.form.busyType.value = "2";
	}	
}
function DoCheck()
{
 	getAfterPrompt();
	if(document.form.phoneNo.value.length<11)
	{
		rdShowMessageDialog("请输入服务号码!");
		document.form.phoneNo.focus();
		return false;
	}
	
	var returnValue=window.showModalDialog('getUser.jsp?phoneNo='+document.form.phoneNo.value+"&opName=<%=opName%>","",prop);
	//alert(returnValue);
	if(returnValue==null)
	{
		rdShowMessageDialog("没有找到对应的用户！",0);
		//document.form.phoneNo.focus();
		return false;
	}
	if(returnValue=="")
	{
		rdShowMessageDialog("你没有选择用户！",0);
		//document.form.phoneNo.focus();
		return false;
	}
 
		document.form.idno.value = returnValue;
		document.form.cancel.disabled=true;
		document.form.reprint.disabled=true;
		document.form.nopay.disabled=true;
		document.form.close.disabled=true;
		document.form.submit();
}
function sel1()
{
	document.form.busyType.value = "1";
	//document.all.phoneNo.focus();
	document.all.Op_Code.value="1354";
	document.all.opCode.value="1354";
}
function sel2()
{
	document.form.busyType.value = "2";
	//document.all.phoneNo.focus();
	document.all.Op_Code.value="1358";
	document.all.opCode.value="1358";
}
function doclear()
{
	document.form.reset();
	//document.all.phoneNo.focus();
}

function donopay()
{
     if(form.phoneNo.value.length<11)
     {
		 rdShowMessageDialog("请输入正确的服务号码！");
	     document.form.phoneNo.focus();
	     return false;
	}
 
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
 
	var returnValue = window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneNo.value,"",prop);
	  
    if(returnValue==null)
	 {
	   		rdShowMessageDialog("没有找到对应的帐号！",0);
	   		document.form.phoneNo.focus();
	   		return false;
	  }
	  if(returnValue=="")
	 {
	   		rdShowMessageDialog("你没有选择帐号！",0);
	   		document.form.phoneNo.focus();
	   		return false;
	  }
	document.form.contractno.value = returnValue; 
 
	 returnValue=window.showModalDialog('getlast.jsp?phoneNo='+document.form.phoneNo.value+'&contractno='+document.form.contractno.value+'&yearmonth='+document.form.yearmonth.value+'&op_code='+document.form.Op_Code.value,"",prop);

	if( returnValue==null )
	{
			 
		rdShowMessageDialog("查询失败，该号码今天未做业务！",0);
		document.form.contractno.value="";
		//document.form.phoneNo.focus();
		return  false;
	}
 
    document.form.water_number.value=returnValue;		
	document.form.action="s1354_2.jsp";
	document.form.cancel.disabled=true;
	document.form.reprint.disabled=true;
	document.form.nopay.disabled=true;
	document.form.close.disabled=true;
	form.submit();					
}
  
function doreprint()
{
var opname="号码缴费";
if(form.phoneNo.value.length<11)
{
	rdShowMessageDialog("请输入正确的服务号码！");
	document.form.phoneNo.focus();
	return false;
}
else{
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	var str="";
	str = window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneNo.value,"",prop);
	  
	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0){
	   		rdShowMessageDialog("没有找到对应的帐号！",0);
	   		//document.form.phoneNo.focus();
	   		return false;}
	   	else{
			document.form.contractno.value = str;}
			}

	str=window.showModalDialog('getlast.jsp?phoneNo='+document.form.phoneNo.value+'&count='+document.form.contractno.value+'&yearmonth='+document.form.yearmonth.value+'&op_code='+document.form.Op_Code.value,"",prop);
	 
	if( typeof(str) != "undefined" ){
		if (parseInt(str)==0){
	   		rdShowMessageDialog("查询失败，该号码今天未做业务！",0);
	   		//document.form.phoneNo.focus();
	   		return false;}
	   	else{
			var chPos_str = str.indexOf(".");
			var contractno=str.substring(0,chPos_str);
			var login_accept=str.substring(chPos_str+1);
			str=window.showModalDialog('s1354_print.jsp?count='+contractno+'&total_date=<%=dateStr%>&payAccept='+login_accept+'&workno=<%=workno%>',"",prop);			
	}
	return true;
}
}
}
 
-->
</script>

</BODY>
</HTML>
