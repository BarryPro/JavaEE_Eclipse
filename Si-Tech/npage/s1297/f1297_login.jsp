 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-07 页面改造,修改样式
	********************/
%>  

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
	<head>
		<title>12580中文秘书台</title>
<%
 	String opCode = request.getParameter("opCode");	
	String opName = request.getParameter("opName");		//header.jsp需要的参数   
	String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
%>

<script language=javascript>
	  onload=function()
	  {
	    document.all.srv_no.focus();
	  }

//----------------验证及提交函数-----------------
	function doCfm(subButton)
	{
	  controlButt(subButton);//延时控制按钮的可用性
	  if(!check(frm)) return false;
	  var radio1 = document.getElementsByName("opFlag");
	  for(var i=0;i<radio1.length;i++)
	  {
	    if(radio1[i].checked)
		{
		  var opFlag = radio1[i].value;
		  if(opFlag=="one")
		  {
		    frm.action="f1297Main.jsp";
		  }else if(opFlag=="two")
		  {
		    frm.action="f1298Main.jsp";
		  }else if(opFlag=="three")
		  {
		    frm.action="f7193Main.jsp";
		  }
		}
	  }
	  frm.submit();
	  return true;
	}
</script>
</head>
<body>
	<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
		<input type="hidden" name="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" value="<%=opName%>">
		<%@ include file="/npage/include/header.jsp" %>     	
			<div class="title">
				<div id="title_zi">12580中文秘书台</div>
			</div>
		<table cellspacing="0">	
		     	<TR>
		          	<TD width="16%" class="blue">操作类型</TD>
	              		<TD>
				       	<input type="radio" name="opFlag" value="one" checked>开户&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="two" >销户&nbsp;&nbsp;
						<input type="radio" name="opFlag" value="three" >冲正
		          	</TD>	         
	         	</TR>
	         	<tr>
		            	<td width="16%" nowrap class="blue">
		              		手机号码
		            	</td>
	            		<td>            
		                	<input s type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0" onblur="checkElement(this)" value =<%=activePhone%>  Class="InputGrey" readOnly >
		                	<font class="orange">*</font>
	            		</td>            
	         	</tr>
	        </table>
	        <table cellspacing="0">
	         	<tr>
		            	<td id="footer">             
			              	<input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">
			              	<input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
					<input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab();">	             
		           	</td>
	        	</tr>
	      </table>     
    	<%@ include file="/npage/include/footer_simple.jsp" %>	  
   </form>
</body>
</html>
