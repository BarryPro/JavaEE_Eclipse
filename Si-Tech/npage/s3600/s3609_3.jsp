<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: BOSS侧V网成员按手机号删除
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
	String work_no = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[4];

    String phoneNo = request.getParameter("phoneNo");//服务号码

    paraAray[0] = phoneNo ;//服务号码    
    paraAray[1] = "3609";//操作代码
    paraAray[2] = work_no;//工号
    paraAray[3] = pass; //工号密码
    
	//String[] ret     = impl.callService("s3605Cfm",paraAray,"1","phone",phoneNo);
	//String[] ret     = impl.callService("s3605Cfm",paraAray,"1");
%>
	<wtc:service name="s3605Cfmexc" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">			
	<wtc:param value="<%=phoneNo%>"/>	
	<wtc:param value="3609"/>	
	<wtc:param value="<%=work_no%>"/>	
	<wtc:param value="<%=pass%>"/>	
	</wtc:service>	
	<wtc:array id="result"  scope="end"/>
<%
	String errCode = retCode1;
	String errMsg   = retMsg1;
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+result[0][0]+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+retMsg1+"&opBeginTime="+opBeginTime;
%>	
	<jsp:include page="<%=url%>" flush="true" />	
<%	
	if (errCode.equals("000000"))
	{		
%>
<script language="JavaScript">
   rdShowMessageDialog("按手机号删除成功!",2);
   removeCurrentTab();
</script>
<%
		
	}else{
%>   
<script language="JavaScript">
	
	 var path="<%=request.getContextPath()%>/npage/s3600/s3609_3_printxls.jsp?phoneNo=" + "<%=phoneNo%>";
            
	if (rdShowConfirmDialog("按手机号删除失败!<br>errCode: <%=errCode%><br>errMsg: <%=errMsg%>"+"<br>是否保存错误信息？")==1)	
	{
		path = path + "&returnMsg=" + "<%=errCode%>" + "[" + "<%=errMsg%>" + "]";
		path = path + "&loginAccept=" + "<%=errCode%>"  ;
		path = path + "&op_Code=" + "3609";
		path = path + "&orgCode=" + "<%=org_code%>";
  		window.open(path);
	}	
	history.go(-1);
</script>
<%}%>
