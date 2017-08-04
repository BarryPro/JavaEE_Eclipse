<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-09 页面改造,修改样式
     *废弃了页面密码验证功能
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	String opCode = "1240";
	String opName = "呼转设置";
	String OPflag =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//OPflag == "2"时为客服工号进入
%>

<%
  request.setCharacterEncoding("GBK");
  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
 	hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  hm.put("5","未能取得用户完整的基本信息!");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>呼转设置</title>
<%  
		String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
%>

<script language=javascript>
 onload=function()
 {
 		self.status="";
		<%
			if(ReqPageName.equals("s1240Main"))
			{
			  String retMsg=WtcUtil.repNull(request.getParameter("retMsg"));
		 	  if(!retMsg.equals("100") && !retMsg.equals("101"))
			  {        
		%>   	 
			    rdShowMessageDialog("<%=(String)(hm.get(retMsg))%>");	 
		<%
			  }else if(retMsg.equals("100")){
		%>
					rdShowMessageDialog('帐户<%=WtcUtil.repNull(request.getParameter("oweAccount"))%>已欠费，不能办理业务！');	    
		<%
			  }else if(retMsg.equals("101")){
		%>
		      rdShowMessageDialog('错误<%=WtcUtil.repNull(request.getParameter("errCode"))%>：<%=WtcUtil.repStr(request.getParameter("errMsg"),ErrorMsg.getErrorMsg(request.getParameter("errCode")))%>');
		<%
			  }
			}
		%>
		 //如果号码为空,则关闭此页面
    if (<%=activePhone%>==null||<%=activePhone%>=="") {
        parent.removeTab('<%=opCode%>');
        return false;
        }
    /*else{	
  		doCfm();
  	}*/
  	
  		if("2"=="<%=OPflag%>"){
  			doCfm();
	   	}
  }

		//提交函数
		function doCfm()
		{
		    //getAfterPrompt();//add by qidp
		    frm.action="s1240Main.jsp";
		    frm.submit();	
		}
</script>
</head>
<body>
<form name="frm" method="POST"  onKeyUp="chgFocus(frm)" >
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1240Login">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
			    <div id="title_zi">呼转设置</div>
			</div>
	    <table cellspacing="0">
          <tr> 
            <td width="16%" class="blue">服务号码</td>
      			<td>  
                <input type="text" size="12" name="srv_no" id="srv_no" value="<%=activePhone%>" class="InputGrey" readonly>
      			</td>
			    </tr>
			    <tr> 
			      <td colspan="5" id="footer"> 
			          <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()">
					  		<input class="b_foot" type=button name=qryP value="关闭" onClick="parent.removeTab('<%=opCode%>')">
			      </td>
			    </tr>
  		</table>
  		<%@ include file="/npage/include/footer_simple.jsp" %>
   </form>
</body>
</html>