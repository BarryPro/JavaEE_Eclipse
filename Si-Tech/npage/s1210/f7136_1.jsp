<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-04
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");
  HashMap hm=new HashMap();
  hm.put("1","该用户对应的客户客户ID不存在！");
  hm.put("3","用户密码错误，请重新输入！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","用户信息不全，禁止操作，请联系系统管理员！");
  hm.put("10","用户资料不存在->10!");
  hm.put("11","用户资料不存在->11!");
  hm.put("12","调用服务返回参数失败->12!"); 
  hm.put("13","该地区下无特服配置信息->13!"); 
  hm.put("14","用户资料不存在->14!"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>资费绑定特服变更</title>
<%
    String opCode="7136";
    String opName="资费绑定特服变更";
	  String workNoFromSession=(String)session.getAttribute("workNo");
	  boolean workNoFlag=false;
	  if(workNoFromSession.substring(0,1).equals("k"))
		workNoFlag=true;

   
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");

	ArrayList initArr = new ArrayList();
    ArrayList groupArr = new ArrayList();

	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));

%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>


  onload=function()
  {
 	self.status="";
	<%
	  //if(workNoFlag)
	  if(0 != 0)
	  {
	%>
 		document.all.srv_no.value=<%=activePhone%>;
		document.all.srv_no.readOnly=true;
		document.all.qryPage.focus();
   <%
	  }
	  else
	  {
	%>
       document.all.srv_no.focus();
    <%
	  }
	%>

<%
	if(ReqPageName.equals("f7136Main"))
	{
	  String retMsg=request.getParameter("retMsg");
 	   
%>   	 
	    rdShowMessageDialog("<%=retMsg%>");	 


<%
	  
	}
%>
  }


//----------------验证及提交函数-----------------
function doCfm()
{
	 
    frm.action="f7136Main.jsp";
    frm.submit();	
}
</script>
</head>
<body>
	
<form name="frm" method="POST"   onKeyUp="chgFocus(frm)">
    <%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">资费绑定特服变更</div>
</div>
<input type="hidden" name="ReqPageName" id="ReqPageName" value="f7136_1">

<table cellspacing="0">
    <tr> 
        <td class="blue" nowrap width="25%"> 
            <div align="left">服务号码</div>
        </td>
        <td nowrap colspan=3> 
            <div align="left"> 
                <input class="InputGrey" readOnly  type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" v_minlength=1 v_maxlength=16 v_type=mobphone  maxlength="11" index="0">
            </div>
        </td>
    </tr>
    <tr id="footer">
        <td colspan="4" > 
            <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2">  
            <input class="b_foot" type=button name=qryP value="关闭" onClick="removeCurrentTab()"  >
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>
