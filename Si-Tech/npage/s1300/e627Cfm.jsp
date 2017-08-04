<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-19 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
 
    String opCode = "";
	String opName = "";
	String return_code="";
	String ret_msg="";

	String phoneNo = request.getParameter("phoneNo");
	String payMoney = request.getParameter("payMoney");
	String date1 = request.getParameter("date1");
	String workno = (String)session.getAttribute("workNo");
	String PrintAccept="";
    PrintAccept = getMaxAccept();
	String return_page = "e627.jsp";
	String [] inParas1 = new String[2];
	String [] inParas2 = new String[2];
	String id_no = "";
	
	inParas1[0] = "select to_char(id_no) from dcustmsg where phone_no=:phoneno";
	inParas1[1] = "phoneno="+phoneNo;
  	
%>

	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>	
	</wtc:service>
	<wtc:array id="ret_val" scope="end" />
<%
		
	if(ret_val==null||ret_val.length==0 )
	{
%>
		 <script language="javascript">
			  rdShowMessageDialog("此号码为空号");
			  window.location.href="<%=return_page%>";
		 </script>
<%		
	}
	if(ret_val.length>0)	
	{
	
		id_no = ret_val[0][0];	
	}
	inParas2[0] = "select count(*) from ddsmpordermsg where serv_code='54' and valid_flag=1 and end_time > sysdate and id_no = :id_no";
	inParas2[1] = "id_no="+id_no;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	    <wtc:param value="<%=inParas2[0]%>"/>
	    <wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="tempArr1" scope="end" />	
<% 

	if(tempArr1 == null || tempArr1.length==0)
	{
%>
		 <script language="javascript">
			  rdShowMessageDialog("查询非手机支付错误");
			  window.location.href="<%=return_page%>";
		 </script>
<%		
	}
	System.out.print("tempArr1[0][0]="+tempArr1[0][0]);
	if(tempArr1.length>0 && tempArr1[0][0].equals("0"))
	{
%>
		<script language="javascript">
			  rdShowMessageDialog("此号码非手机支付用户，不允许办理！");
			  window.location.href="<%=return_page%>";
		 </script>

<%	
	}

	String [] inParas = new String[5];
	inParas[0]  = phoneNo;
	inParas[1]  = payMoney;
	inParas[2]  = workno;
	inParas[3]  = PrintAccept;
	inParas[4]  = date1;
%>
	<wtc:service name="bs_6270Cfm" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
		<wtc:param value="<%=inParas[4]%>"/>
	</wtc:service>
	<wtc:array id="tempArr" scope="end"/>
<%	
   return_code = retCode;
   ret_msg = retMsg;
   
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">

<body >
  <%	
	if (return_code.equals("000000"))
	{	
%>	
 <script language="javascript">
	  rdShowMessageDialog("签约成功！");
	  window.location.href="<%=return_page%>";
 </script>


<%
}else{
%>
		<SCRIPT LANGUAGE="JavaScript">
			rdShowMessageDialog("签约错误!<br>错误代码：'<%=return_code%>'，错误信息：'<%=ret_msg%>'。");
			window.location.href="<%=return_page%>";
		</SCRIPT>
<%}
%>
</body></html>