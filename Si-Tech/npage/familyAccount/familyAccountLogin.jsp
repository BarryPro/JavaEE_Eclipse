<%
/********************
version v2.0
开发商: si-tech
模块：用户付费计划变更
日期：2013-5-10 16:27:19
作者：何敬伟
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml"> 
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	request.setCharacterEncoding("GBK");
	
	String opCode     = request.getParameter("opCode");
	String opName     = request.getParameter("opName");
	String phone_no   = (String)request.getParameter("activePhone");
	String regionCode = (String)session.getAttribute("regCode");
if(activePhone==null||"NULL".equals(activePhone))	{
%>
<script language=javascript>
	rdShowMessageDialog("服务号码不能为空",0);
	removeCurrentTab();
</script>
<%
}
//判断是否为责任人

String phoneNotype = "";
if(activePhone.length()>3){
	if(activePhone.substring(0,3).equals("207")){
		phoneNotype = "1";
	}else{
		phoneNotype = "0";
	}
	%>
	 <wtc:service name="sG645Qry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodem" retmsg="retMsgm" outnum="7">
		  <wtc:param value="<%=phone_no%>"/>
		  <wtc:param value="<%=phoneNotype%>"/>
	 </wtc:service>
	<wtc:array id="result_t2"  scope="end"/>
	<%	
	if(result_t2.length==0)	{
	%>
	<script language=javascript>
		alert("phone_no = <%=phone_no%>\nphoneNotype = <%=phoneNotype%>\nresult_t2.length = <%=result_t2.length%>");
		rdShowMessageDialog("此号码非家庭责任人号码");
		removeCurrentTab();
	</script>
	<%
	}
}else{
%>
	<script language=javascript>
		rdShowMessageDialog("此号码非家庭责任人号码");
		removeCurrentTab();
	</script>
<%	
}
%>


<head>
<title>家庭合帐业务</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<% 
 
  String[][]  temfavStr = (String[][])session.getAttribute("favInfo");
	String[]    favStr    = new String[temfavStr.length];
	for(int i=0;i<favStr.length;i++)
	   favStr[i]=temfavStr[i][0].trim();
	boolean pwrf=true;
	if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;

	
	String ReqPageName=WtcUtil.repNull(request.getParameter("ReqPageName"));
  %>

<script language=javascript>
 var js_pwFlag="false";
 js_pwFlag="<%=pwrf%>";
 

//----------------验证及提交函数-----------------
function doCfm(){
    if(js_pwFlag=="false"){
	   if(document.all.cus_pass.value.trim().length==0){
	     rdShowMessageDialog("用户密码不能为空！");
		 	 document.all.cus_pass.focus();
 	     return false;
	   }
	}
	
    frm.action="familyAccountMain.jsp";
    frm.submit();	
  if(!check(frm)){return false}
}

 
</script>
</head>
<body>
<form name="frm" method="POST"   onKeyUp="chgFocus(frm)">
<%@ include file="/npage/include/header.jsp" %> 
 <div class="title">
	<div id="title_zi">用户登录</div>
</div>
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1212Login">
  <table cellspacing="0">
   <tr>
     <td nowrap class="blue" width="20%"> 
       服务号码
     </td>
     <td nowrap class="blue"> 
          <input type="text" size="12" name="srv_no" id="srv_no"  value="<%=phone_no%>" v_minlength=1 v_maxlength=16 v_type=mobphone  maxlength="11" index="0" Class="InputGrey" readOnly />
          <font class="orange">*</font>
      </td>
     <td nowrap class="blue" style="display:none"> 
      用户密码
     </td>     
     <td nowrap class="blue" style="display:none"> 
      <jsp:include page="/npage/common/pwd_one_new.jsp">
	   <jsp:param name="width1" value="16%"  />
	   <jsp:param name="width2" value="34%"  />  
	   <jsp:param name="pname" value="cus_pass"  />
	   <jsp:param name="pwd" value="12345"  />      
 	   </jsp:include> 
      </td>        
    </tr>
        <tr>
          <td id="footer" colspan='2'>
              <input class="b_foot" type=button name=qryPage value="确认" onClick="doCfm()" index="2">      
	          <input class="b_foot" type=button name=qryPage value="关闭" onClick="parent.removeTab('<%=opCode%>')">
          </td>
        </tr>
   </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
  
<input type="hidden" name="phoneNotype" value="<%=phoneNotype%>">  
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">  
   </form>
  </body>
</html>    
<%@ include file="../../npage/common/pwd_comm.jsp" %>  
    
  

  
  
