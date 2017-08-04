		   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-16
********************/
%>
              
<%
  String opCode = "1428";
  String opName = "托收关系解除";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
%>
<html>
<head>
<title>托收关系解除</title>
<%   
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
	if(ReqPageName.equals("s1212Main"))
	{
	  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
	  {        
%>   	 
	    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
<%
	  }
	  else if(retMsg.equals("100"))
	  {
%>
    	rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费，不能办理业务！',0);	    
<%
	  }
      else if(retMsg.equals("101"))
	  {
%>
        rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%><%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>',0);	    
<%
	  }
	}
%>
  }


//----------------验证及提交函数-----------------
function doCfm()
{
    frm.action="s1428_1.jsp";
    frm.submit();	

}
</script>
</head>
<body>
<form name="frm" method="POST"   onKeyUp="chgFocus(frm)">
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">托收关系解除</div>
	</div>
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Login">

        <table  cellspacing="0" >

          <tr> 
            <td width="16%"  nowrap> 
              <div align="left" class="blue">服务号码</div>
            </td>
      <td nowrap  width="34%"> 
        <div align="left"> 
                <input  type="text" size="12" name="srv_no" id="srv_no" v_minlength=1 v_maxlength=16 v_type=mobphone  v_name="服务号码" maxlength="11" index="0" value =<%=activePhone%>  Class="InputGrey" readOnly >
                 <font class="orange">*</font></div>
      </td>
            
    </tr>
 
          <tr > 
            <td colspan="5"  id="footer"> 
              <div align="center"> 
          <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2" >      
          <input class="b_foot" type=button name=back value="清除" onClick="frm.reset()"  >
		  <input class="b_foot" type=button name=qryPage value="关闭" onClick="removeCurrentTab()"  >
              </div>
      </td>
    </tr>
  </table>

  <%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>