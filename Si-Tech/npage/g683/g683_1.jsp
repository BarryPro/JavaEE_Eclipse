<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 退预存款1362
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
 	String opCode="g683";//request.getParameter("opCode");
	String opName="家庭退费";//request.getParameter("opName");
	 
	String phoneNo = (String)request.getParameter("activePhone");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
  	String pwrf1="N";
    
        
	Date date = new Date();
	DateFormat df = new SimpleDateFormat("yyyyMMdd");   
	String now = df.format(date);
	 

	activePhone = request.getParameter("activePhone");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>黑龙江BOSS-退预存款</title>
	<META content="text/html; charset=gbk" http-equiv=Content-Type>
	<META content=no-cache http-equiv=Pragma>
	<META content=no-cache http-equiv=Cache-Control>
</head>
 
 
<body onload="inits()">
<form action="s1362_2.jsp" method="post" name="form">
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="busy_type"  value="2">
	<div class="title">
		<div id="title_zi">选择用户类型</div>
	</div>
<table cellspacing="0" >
	 
	<tr> 
		<th>用户类型</th>
		<th>
			 
			<input name="busytype" type="radio"  value="1" checked>
			在网用户
		</th>
		<th colspan="2">部门：<%=orgCode%> </th>
	</tr>

	<tr> 

		<td  class="blue">号码类型</td>
		<td colspan=3>
			<select name="bank_name" id= "selOp" onchange="selType()">
				 
				<option value="1" selected>家长号码</option>
				 
			</select>
			<!--
			<select name="bank_name" id= "selOp" onchange="selType()">
				<option value="0" >---请选择</option>
				<option value="1" selected>家长号码</option>
				<option value="2" >家庭号码</option> 
			</select>
			-->
		</td>


		 
		 
	</tr>

	<tr id="jz"> 
		<td class="blue">家长号码</td>
		<td colspan=3> 
			<input type="text" name="jzPhone" maxlength="11"  onKeyPress="return isKeyNumberdot(0)" value="<%=activePhone%>"  >
		</td>
		 
	</tr>
	
	<tr id="jt"> 
		<td class="blue">家庭号码</td>
		<td colspan=3>  
			<input type="text" name="jtPhone" maxlength="11"  onKeyPress="return isKeyNumberdot(0)">
		</td>
		
	</tr>
	<!--
	<tr>
		<td class="blue">用户密码</td>
		<td colspan=3>
			<jsp:include page="/npage/common/pwd_one.jsp">
				<jsp:param name="width1" value="16%"  />
				<jsp:param name="width2" value="34%"  />
				<jsp:param name="pname" value="cus_pass"  />
				<jsp:param name="pwd" value="12345"  />
			</jsp:include>
			
		</td>
	</tr>
-->
	<tr> 
		<td class="blue">家庭帐户号码</td>
		<td> 
			<input type="text" name="contractno" maxlength="20" class="button"  onKeyPress="return isKeyNumberdot(0)" readonly>
		</td>
		<td class="blue">用户名称</td>
		<td>
			<input type="text" name="textfield7" class="InputGrey" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue">现有预存金额 </td>
		<td> 
			<input type="text" name="textfield3" class="InputGrey" readonly>
		</td>
		<td class="blue">总欠费 </td>
		<td> 
			<input type="text" name="textfield2" class="InputGrey" readonly>
		</td>
	</tr>
	<tr> 
		<td class="blue"> 可退金额</td>
		<td>
			<input type="text" name="textfield" class="InputGrey" readonly>
		</td>
		<td class="blue">退费金额</td>
		<td> 
			<input class="button" name=remark2 size=20 value="0.00">
		</td>
	</tr>
	<!--  add liuxmc 
	<tr>
		<td class="blue">退预存款信息查询：</td>
		<td class="blue" colspan="3">			
			日期：<input type="text" class="button" name="reuturn_time" value="<%=now%>">格式：YYYYMMDD&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="b_text"  type=button value="查 询" onClick="getTKDate();">
		</td>
	</tr>
  end -->
	
	 
	<tr> 
		<td align="center" colspan="4" id="footer"> 
		<!--
			<input class="b_foot" name=sure type=button value=确认>
			-->
			<input class="b_text" type=button value="查询" onClick="docheck();">
			&nbsp;
			<!--<input class="b_foot" name=clear type=reset value=清除>-->
			<input class="b_foot" name=clear type=button value=清除 onClick="doClean()">
			&nbsp;
			<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
			&nbsp; 
		</td>
	</tr>
</table>
<input type="hidden" name="reason1" value="0">
<input type="hidden" name="reason2">
	<%@ include file="/npage/include/footer_simple.jsp" %>
	<%@ include file="../../npage/common/pwd_comm.jsp" %>
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<input type="hidden" name="check_flag"  >
</form>
</body>
 <script language="JavaScript">

 function inits()
 {
	 /*
	 document.getElementById("jz").style.display="none";
	 document.getElementById("jt").style.display="none";
	 document.all.jzPhone.value="";
	 document.all.jtPhone.value="";
	*/
	 document.getElementById("jz").style.display="";
	 document.getElementById("jt").style.display="none";
	 document.all.check_flag.value="1";
 }
 function selType()
 {
	  var objSel = document.getElementById("selOp"); 
	   
	  if(objSel.value==1) //jz
	  {
		  document.getElementById("jz").style.display="";
		  document.getElementById("jt").style.display="none";
		  document.all.check_flag.value="1";
	  }
	  if(objSel.value==2) //jt
	  {
		  document.getElementById("jt").style.display="";
		  document.getElementById("jz").style.display="none";
		  document.all.check_flag.value="2";
	  }
 }
 
function docheck()
{
	//可以通过 家长号码 或者207号码 来查询退费 成员的话 报错

	  var objSel = document.getElementById("selOp"); 
	  if(objSel.value==0)
	  {
		  rdShowMessageDialog("请选择号码类型!");
		  return false;
	  }
	  if(objSel.value==1 && (form.jzPhone.value=="" || form.jzPhone.value.length<11))
	  {
		  rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		  document.form.jzPhone.focus();
		  return false;
	  }	
	  if(objSel.value==2 && (form.jtPhone.value=="" || form.jtPhone.value.length<11))
	  {
		  rdShowMessageDialog("请输入服务号码,长度为11位数字 !!")
		  document.form.jtPhone.focus();
		  return false;
	  }
	 
		 
        var myPacket = new AJAXPacket("getKdNo_new.jsp","正在查询客户，请稍候......");
		myPacket.data.add("jzPhone",(document.all.jzPhone.value).trim());
		myPacket.data.add("jtPhone",(document.all.jtPhone.value).trim());
		myPacket.data.add("check_flag",(document.all.check_flag.value).trim());
		myPacket.data.add("return_page","g683_1.jsp");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
    /*
	var returnValue;
	var h=480;
	var w=650;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    if (document.all.busy_type.value=="2") {
    	
		returnValue =window.showModalDialog('getCountdead.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
    } else {
	     returnValue=window.showModalDialog('getCount.jsp?phoneNo='+document.form.phoneno.value+'&password='+document.all.cus_pass.value+'&reqPass=<%=pwrf1%>',"",prop);
	}
	
	if(returnValue=='0')
	 {
		rdShowMessageDialog("帐号或者密码输入错误！",0);
		document.form.phoneno.focus();
		return false;
	  }
	  if(returnValue=="")
	 {
		rdShowMessageDialog("你没有选择帐号！",0);
		document.form.phoneno.focus();
		return false;
	  }
	  document.form.contractno.value = returnValue;
	 
	 document.form.action="s1362_select.jsp";
     */
	 
	
}

//  add liuxmc
	function getTKDate(){
		
		var time = document.form.reuturn_time.value;
		if(time == "" || time.length==0){
			alert("日期不能为空！");
			return false;
		}
		
		if(time.length != 8){
			alert("对不起，您输入的日期格式不对，请按照正确的格式(YYYYMMDD)填写!");
			return false;
		}

    if(time.length!=0){    
       var reg = /^(\d{1,4})(\d{1,2})(\d{1,2})$/;     
       var r = time.match(reg);     
       if(r==null){
         alert("对不起，您输入的日期格式不正确，请按照正确的格式(YYYYMMDD)填写!");
         return false;
       }
     }
     
		var path = "<%= request.getContextPath()%>/npage/s1300/s1362_selectTK.jsp?time="+time;
		window.showModelessDialog(path);
	}
	
	//  end
//预约情况查询
  
function doClean()
{
	document.all.orderId.value="";
	document.all.phoneno.value="";
	document.all.cus_pass.value="";
	document.all.contractno.value="";
	document.all.textfield7.value="";
	document.all.textfield3.value="";
	document.all.textfield2.value="";
	document.all.textfield.value="";
	document.all.remark2.value="";
}

function doProcess(packet)
{
   //alert("111");
   var retResult=packet.data.findValueByName("retResult");
   var phone_new=packet.data.findValueByName("s_phone_new");
   var s_contract_out=packet.data.findValueByName("s_contract_out");
   var ret_msg = packet.data.findValueByName("ret_msg");
   //alert("retResult is "+retResult+" 直接输入家庭帐号 怎么校验是否正确?");
   if(retResult=="true")
   {
	   document.form.action="g683_select.jsp?phoneno="+phone_new+"&contractno="+s_contract_out+"&jzPhone="+document.all.jzPhone.value;
	   form.submit();
   }	
   else
   {
	   rdShowMessageDialog(ret_msg);
   }		
   
}
</script>
</HTML>