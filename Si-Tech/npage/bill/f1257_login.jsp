<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
  request.setCharacterEncoding("GBK");
  String opCode = "1257";
  String opName = "包年冲正";	
%>

<head>
<title><%=opName%></title>
<%  
  String workNoFromSession=(String)session.getAttribute("workNo");
	boolean workNoFlag=false;
	if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
 
    String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
%>

<script language=javascript>
  onload=function()
  {
   	self.status="";
    document.all.srv_no.focus();

  }

//----------------验证及提交函数-----------------
function doCfm(subButton)
{
  controlButt(subButton);//延时控制按钮的可用性
  if(check(frm))
  {
    frm.action="f1257Main.jsp";
    frm.submit();	
  }
}
function controlButt(subButton){
	subButt2 = subButton;
    subButt2.disabled = true;
	setTimeout("subButt2.disabled = false",3000);
  }
</script>
</head>
<body>
<form name="frm" method="POST" onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">包年冲正</div>
	</div>
    <table cellspacing="0">
    <tr> 
      <td width="15%" class="blue"> 
        手机号码
      </td>
      <td> 
          <input Class="InputGrey"  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone"  v_name="服务号码" maxlength="11" index="0" value="<%=activePhone%>" readOnly>
      </td>
    </tr>
  </table>
  <table>
        <tr> 
          <td id="footer"> 
          <input class="b_foot" type=button name="confirm" value="确认" onClick="doCfm(this)" index="2">    
          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab(<%=opCode%>)">
      		</td>
    		</tr>
  </table>
   <input type="hidden" name="flag" value="1">
 	<%@ include file="../../npage/common/pwd_comm.jsp" %>
 	<%@ include file="/npage/include/footer_simple.jsp" %> 
  </form>
</body>
</html>