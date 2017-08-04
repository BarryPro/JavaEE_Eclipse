<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-5
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
%>
<html>
<head>
<title>集团用户预存话费优惠购机</title>
<%
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    String work_no = (String)session.getAttribute("workNo");							//操作工号
	String regionCode = (String)session.getAttribute("regCode");						//地市
	String phoneNo=(String)request.getParameter("activePhone");							//手机号码
%>

<%
/***************需要判断工号是否是集团工号*****************/
 
  String sql1 = " select dept_code from dloginmsg where login_no='" +work_no+"'";
  //ArrayList agentCodeArr1 = co1.spubqry32("1",sql1);
%>

	<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	<wtc:sql><%=sql1%></wtc:sql>
 	  	</wtc:pubselect>
	<wtc:array id="result_t" scope="end"/>

<%  
	String[][] agentCodeStr1 = result_t;
	String dept=agentCodeStr1[0][0];
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  onload=function()
  {
    document.all.phoneNo.focus();
  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性

 var radio1 = document.getElementsByName("opFlag");
  for(var i=0;i<radio1.length;i++)
  {
    if(radio1[i].checked)
	{
	  var opFlag = radio1[i].value;
	  if(opFlag=="one")
	  {
	  		if(!checkElement(document.all.phoneNo)) return false;
	    	frm.action="f8030_1.jsp";
	    	document.all.opcode.value="8030";
			document.all.dept.value='<%=dept%>';
	    	
	  }else if(opFlag=="two")
	  {
	  	if(!checkElement(document.all.backaccept)) return false;
	    	frm.action="f8030_2.jsp";
	    	document.all.opcode.value="8031";
	    	
	  }
	}
  }
  frm.submit();	
  return true;
}
function opchange(){

	 if(document.all.opFlag[0].checked==true) 
	{
	  	document.all.backaccept_id.style.display = "none";
	  }else {
	  	document.all.backaccept_id.style.display = "";
	  	
	  }

}
</script>
</head>
<body>
	
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>

 <input type="hidden" name="opcode" value="<%=opCode%>">
 <input type="hidden" name="opName" value="<%=opName%>">
 <input type="hidden" name ="dept" >
 
 	<div class="title">
		<div id="title_zi">集团用户预存话费优惠购机</div>
	</div>

      <table cellspacing="0">

	       <TR > 
	          <TD width="16%" class="blue">操作类型</TD>
              <TD width="34%">
				<input type="radio" name="opFlag" value="one" onclick="opchange()" checked >申请&nbsp;&nbsp;
				<input type="radio" name="opFlag" value="two" onclick="opchange()" >冲正
	          </TD>
        </TR>    
        
         <tr> 
            <td width="16%"  nowrap> 
              <div align="left" class="blue">手机号码</div>
            </td>
            <td nowrap  width="34%"> 
            <div align="left"> 
                <input type="text" size="12" name="phoneNo" id="phoneNo" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value="<%=phoneNo%>" Class="InputGrey" readOnly >
                <font class="orange">*</font></div>
            </td>
         </tr>
         <tr style="display:none" id="backaccept_id"> 
	          <TD width="16%" class="blue">业务流水</TD>
              <TD width="34%">
			<input  type="text" name="backaccept" v_must=1 v_type="string" >
			<font class="orange">*</font>
	          </TD>
		</tr>
         <tr bgcolor="e8e8e8"> 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input  type=button name="confirm" value="确认" onClick="doCfm(this)" index="2" class="b_foot">    
              <input  type=button name=back value="清除" onClick="frm.reset()" class="b_foot">
		      <input  type=button name=qryP value="关闭" onClick="removeCurrentTab();" class="b_foot">
              </div>
           </td>
        </tr>
      </table>

    <%@ include file="/npage/common/pwd_comm.jsp" %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>