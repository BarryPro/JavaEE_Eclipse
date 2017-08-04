<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%
  String submit_page="f1848.jsp";
%>

<html>
<head>
<title>视频会议</title>
<%		
	String workNoFromSession=(String)session.getAttribute("workNo");
	String userPhoneNo=(String)session.getAttribute("userPhoneNo");
	session.removeAttribute("userPhoneNo");
	String op_code = "1848";
    String opCode = "1848";
    String op_name="视频会议";
    String opName="视频会议";
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("z")||workNoFromSession.substring(0,1).equals("Z"))
	workNoFlag=true;
    String work_no =(String)session.getAttribute("workNo");
    String loginName =(String)session.getAttribute("workName");
    String orgCode =(String)session.getAttribute("orgCode");
    activePhone = request.getParameter("activePhone");

%>

<script language=javascript>
	var js_pwFlag="false";
onload=function()
{
	self.status="";
	document.all.phone_no.focus();
}

//----------------验证及提交函数-----------------
function doCfm()
{
	var h=480;
    var w=650;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+300+"px; dialogWidth:"+500+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
    frm.action="<%=submit_page%>";
    frm.submit();
}

//-------------------------------------------------------

</script>
</head>
<body >
	
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
	<div id="title_zi">视频会议</div>
  	</div>
  	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s<%=op_code%>">
  	<input type="hidden" name="op_code" id="op_code" value="<%=op_code%>">
  	<input type="hidden" name="org_code" id="org_code" value="<%=orgCode%>">
  	<input type="hidden" name="work_no" id="work_no" value="<%=work_no%>">
    <table width="98%" border="0" cellspacing="1" align="center" bgcolor="#FFFFFF">
    	<tr> 
      		<td colspan="7" bgcolor="#eeeeee" nowrap>&nbsp;</td>
    	</tr>
    	<tr bgcolor="e8e8e8"> 
           <td width="16%" nowrap class="blue"> 
           		<div align="left" >服务号码</div>
           </td>
           <td> 
           		<div align="left"> 
               	<input   type="text" size="12" name="phone_no" id="phone_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1   maxlength="11" index="0"  Class="InputGrey" readOnly  value ="<%=activePhone%>">
				</div>
           </td>               
    	</tr>   
   		<tr>    
        	<td nowrap colspan="4" class="blue">&nbsp;</td>
    	</tr>
    	<tr> 
        	<td colspan="5" class="blue" > 
            <div align="center"> 
            	<input class="b_foot" type=button name=confirm value="确认" onClick="doCfm()">    
          		<!--<input class="b_foot" type=reset name=reset value="清除">-->
		  		<input class="b_foot" type=button name=close value="关闭" onClick="parent.removeTab('<%=opCode%>');">
        	</div>
      		</td>
    	</tr>
	</table>
   	<%@ include file="/npage/include/footer_simple.jsp"%>
	
   </form>
</body>
</html>
