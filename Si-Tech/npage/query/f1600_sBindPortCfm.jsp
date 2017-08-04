<%
/********************
 version v2.0
开发商: si-tech
*
*create by lipf 20120509
*
********************/
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String opCode = "1600";
  String opName = "宽带信息查询之端口初始化";
  String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String iLoginAccept = "0";     //流水
  String iChnSource = "01";			//渠道标识
  String iOpCode=request.getParameter("iOpCode");//操作代码
  String iLoginNo = (String)session.getAttribute("workNo");//工号
	String iLoginPwd = (String)session.getAttribute("password");//工号密码
	String iPhoneNo  = request.getParameter("iPhoneNo");//手机号码
  String iUserPwd = "";					//手机密码
	String iOpNote="端口初始化";//备注
	String iAccount  =request.getParameter("iAccount");//用户账号
	String iNasPort="0000";//绑定端口
%>
	<wtc:service name="sBindPortCfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=iOpCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=iPhoneNo%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		<wtc:param value="<%=iOpNote%>"/>
		<wtc:param value="<%=iAccount%>"/>
		<wtc:param value="<%=iNasPort%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if ("000000".equals(retCode1)){
%>
		<script language="JavaScript">
			rdShowMessageDialog("<%=retMsg1%>");
			history.go(-1);
		</script>
<%	
	}else{
	%>
		<script language="JavaScript">
			rdShowMessageDialog("错误提示:<%=retMsg1%>");
			history.go(-1);
		</script>
	<%	
	}
%>

