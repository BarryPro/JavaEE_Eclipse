<%
/********************
 version v2.0
开发商: si-tech
<!-- baixf 20080613 modify 将“集团无条件赠机”名称更改为“集团客户行业应用赠机”  -->
********************/

%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.06
 模块:集团客户行业应用赠机
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%
  request.setCharacterEncoding("GBK");
%>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>集团客户行业应用赠机</title>
<%

	String phoneNo = request.getParameter("activePhone"); 
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	
    String work_no = (String)session.getAttribute("workNo");
    
%>
<%
 
/***************需要判断工号是否是集团工号*****************/

  String sql1 = " select dept_code from dloginmsg where login_no='" +work_no+"'";
  String[] inParams = new String[2];
  inParams[0] = " select dept_code from dloginmsg where login_no=:work_no";
  inParams[1] = "work_no="+work_no;
  //System.out.println("sql1====="+sql1);
  //ArrayList agentCodeArr1 = co1.spubqry32("1",sql1);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=inParams[0]%>"/>	
	<wtc:param value="<%=inParams[1]%>"/>	
	</wtc:service>	
	<wtc:array id="agentCodeStr1"  scope="end"/>
<%
  String dept="";
  if(agentCodeStr1.length>0)
  	dept=agentCodeStr1[0][0];
  //System.out.println("dept========="+agentCodeStr1[0][0]);
 %>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language=javascript>
  onload=function()
  {
    opchange();
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
	  	
	    	frm.action="f8032_1.jsp";
	    	document.all.opcode.value="8032";
	    	document.all.opname.value="集团客户行业应用赠机";
			document.all.dept.value='<%=dept%>';
	    	
	  }else if(opFlag=="two")
	  {
	    if(document.all.backaccept.value==""){
	    	rdShowMessageDialog("请输入业务流水！");
	    	return;
	    }
	   
	    	frm.action="f8033_1.jsp";
	    	document.all.opcode.value="8033";
	    	document.all.opname.value="集团客户行业应用赠机冲正";
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
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>
 <input type="hidden" name="opcode">
 <input type="hidden" name="opname">
 <input type="hidden" name="dept" >

      <table cellspacing="0">
	  <TR> 
          <TD class="blue">操作类型</TD>
          <TD>
			<input type="hidden" name="opFlag" value="one" onclick="opchange()" >
			<input type="radio" name="opFlag" value="two" onclick="opchange()"  checked >冲正
	      </TD>
       </TR>    
         <tr> 
            <td class="blue"> 
              <div align="left">手机号码</div>
            </td>
            <td> 
            <div align="left"> 
                <input class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" value="<%=phoneNo%>" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  readOnly index="0">
            </td>
         </tr>
         <TR style="display:none" id="backaccept_id"> 
	          <TD class="blue">业务流水</TD>
              <TD>
				<input type="text" name="backaccept">
				<font color="orange">*</font>
	          </TD>
         </TR>    
         </tr>
         <tr> 
            <td id="footer" colspan="2"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()">
              </div>
           </td>
        </tr>
      </table>
     <%@ include file="/npage/include/footer_simple.jsp" %>   
   </form>
</body>
</html>