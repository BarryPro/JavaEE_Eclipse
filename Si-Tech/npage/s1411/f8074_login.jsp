<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-24 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<% 
	try{
		DataOutputStream out2 = 
		new DataOutputStream(
		new BufferedOutputStream(
		new FileOutputStream("data.txt")));
		out2.writeChars("\naaa\n");
		out2.close();
	}
		catch(EOFException e){
		System.out.println("End of stream");
	}
%>
<html>
<head>
<title>预存话费送笔记本</title>
<%
	String opCode = (String)request.getParameter("opCode");	
	String opName = (String)request.getParameter("opName");	
%>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language=javascript>
onload=function()
{
	document.all.srv_no.focus();
}

//----------------验证及提交函数-----------------
function doCfm(subButton){	
	var radio1 = document.getElementsByName("opFlag");
	for(var i=0;i<radio1.length;i++)
	{
		if(radio1[i].checked){
		  	var opFlag = radio1[i].value;
			  if(opFlag=="one"){			  	
			    	frm.action="f8074_1.jsp";
			    	document.all.opcode.value="8074";			    	
			  }else if(opFlag=="two"){
				if(document.all.backaccept.value==""){
					rdShowMessageDialog("请输入业务流水！");
				return;
				}			   
				frm.action="f8608_1.jsp";
				document.all.opcode.value="8608";			    	
			  }
		}
	}
	frm.submit();	
	return true;
}

function opchange(){
	 if(document.all.opFlag[0].checked==true){	  	
	  	document.all.backaccept_id.style.display = "none";
	  }else{
	  	document.all.backaccept_id.style.display = "";	  	
	  }
}
</script>
</head>
<body>	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
		<div id="title_zi">预存话费送笔记本</div>
	</div> 
	<input type="hidden" name="opcode" >	
	<input type="hidden" name="opName" value="<%=opName%>">
	<table cellspacing="0" >         
		<TR> 
			<TD width="16%" class="blue">操作类型</TD>
			<TD>
				<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
			</TD>
		</TR>    
		<tr> 
			<td width="16%"  nowrap class="blue">手机号码 </td>
			<td nowrap  width="34%"> 
				<input   type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  value =<%=activePhone%>  readonly class="InputGrey"  maxlength="11" index="0">
				<font class="orange">*</font>
			</td>
		</tr>
		<TR  style="display:none" id="backaccept_id"> 
			<TD width="16%" class="blue">业务流水</TD>
			<TD>
				<input  type="text" name="backaccept" v_must=1 onblur="checkElement(this)" >
				<font class="orange">*</font>
			</TD>
		</TR>  
	</table>  
        
	<table cellspacing="0" >            
		<tr> 
			<td id="footer" > 
				<input  type=button class="b_foot" name="confirm" value="确认" onClick="doCfm(this)" index="2">    
				<input  type=button class="b_foot" name=back value="清除" onClick="frm.reset()">
				<input  class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">
			</td>
		</tr>
	</table>
	 <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>