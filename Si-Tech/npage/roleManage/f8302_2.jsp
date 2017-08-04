<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%	
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
	String paraAray[] = new String[10];
	String agt_bz=request.getParameter("agt_bz");
	String login_no="";
	String op_count="";
	String op_type=request.getParameter("op_type");
	String op_code=request.getParameter("sopcode");
	String grantReason = request.getParameter("grantReason");
	String fileNumber = request.getParameter("fileNumber");
	String fileName = request.getParameter("fileName");
	System.out.println("~~~~==== " + grantReason + " | " + fileNumber + " | " + fileName);
	String begin_time="";
	String end_time="";
	if(agt_bz.equals("0")){
		login_no=request.getParameter("login_no");
		if(op_type.equals("0")){
		 	begin_time=request.getParameter("begin_time");
			end_time=request.getParameter("end_time");
		}else{
			op_count=request.getParameter("op_count");
		}
	}else{
		login_no=request.getParameter("agt_login");
		op_count=request.getParameter("op_count");
	}

	paraAray[0] = work_no;
	paraAray[1] =login_no;
	paraAray[2] = op_code;
	paraAray[3] = op_type;
	paraAray[4] = op_count;
	paraAray[5] = begin_time;
	paraAray[6] = end_time;
	paraAray[7] = grantReason;
	paraAray[8] = fileNumber;
	paraAray[9] = fileName;
 
%>
	<wtc:service name="s8302Cfm" routerKey="region" routerValue="<%=regionCode%>" 
			retcode="errCode" retmsg="errMsg" outnum="2">
			<wtc:param value="<%=paraAray[0]%>"/>
			<wtc:param value="<%=paraAray[1]%>"/>
			<wtc:param value="<%=paraAray[2]%>"/>
			<wtc:param value="<%=paraAray[3]%>"/>
			<wtc:param value="<%=paraAray[4]%>"/>
			<wtc:param value="<%=paraAray[5]%>"/>
			<wtc:param value="<%=paraAray[6]%>"/>
			<wtc:param value="<%=paraAray[7]%>"/>
			<wtc:param value="<%=paraAray[8]%>"/>
			<wtc:param value="<%=paraAray[9]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if ("000000".equals(errCode) || "0".equals(errCode))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功！");
   window.location="f8302_1.jsp";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("提交失败!(<%=errMsg%>)");
	window.location="f8302_1.jsp";
</script>
<%}%>
