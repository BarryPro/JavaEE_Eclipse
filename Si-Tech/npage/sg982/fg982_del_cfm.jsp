<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
String opCode = "g982";
String opName = "资费与终端分离目标用户导入 ";
String workno = (String)session.getAttribute("workNo");
String workname =(String)session.getAttribute("workName");
String orgcode =(String)session.getAttribute("orgCode");//机构代码
String nopass =(String)session.getAttribute("password");
String ipAddr =(String)session.getAttribute("ipAddr");
String regionCode = orgcode.substring(0,2);
String op_code = "g982";
String remark = "操作员："+workno+"进行了资费与终端分离目标用户导入-删除提交";
String regionCode1 = WtcUtil.repStr(request.getParameter("regionCode"), "");
String phone_type = request.getParameter("phone_type"); //终端型号代码
String phone_brand = request.getParameter("phone_brand");//终端品牌代码 
String begin_time = request.getParameter("begin_time"); 
String end_time = request.getParameter("end_time"); 
String serverIp=realip.trim();

%>
	<wtc:service name="sg982Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="sReturnCode" retmsg="sErrorMessage"  outnum="7" >
		<wtc:param value="0"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workno%>"/>
		<wtc:param value="<%=nopass%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/> 
		<wtc:param value="1"/>   <%/*操作标识 q 查询 0 增加 1 删除*/%>
		<wtc:param value="<%=phone_brand%>"/>
		<wtc:param value="<%=phone_type%>"/>
		<wtc:param value="<%=begin_time%>"/>
		<wtc:param value="<%=end_time%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=remark%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=regionCode%>"/> <%/*地市代码 删除有值*/%>
	</wtc:service>
	<wtc:array id="result" scope="end" />
<%
  if("000000".equals(sReturnCode)){
%>
    <script language="JavaScript">
      rdShowMessageDialog("删除成功!",2);
      window.location="fg982_main.jsp?opCode=g982&opName=资费与终端分离目标用户导入";
    </script>
<%  
  }else{
%>
    <script language="JavaScript">
      rdShowMessageDialog("删除失败!<%=sReturnCode%><br><%=sErrorMessage%>",0);
      window.location="fg982_main.jsp?opCode=g982&opName=资费与终端分离目标用户导入";
    </script>
<%  
  }
%>





