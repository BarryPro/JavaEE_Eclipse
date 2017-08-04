<%
  /* *********************
   * 功能:手机电视管理系统
   * 版本: 1.0
   * 日期: 2009/7/30
   * 作者: fengry
   * 版权: si-tech
   * *********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
	String work_no =(String)session.getAttribute("workNo");
	String work_name =(String)session.getAttribute("workName");
	String orgCode =(String)session.getAttribute("orgCode");
	//String regionCode = orgCode.substring(0,2);
	//String ip_Addr =(String)session.getAttribute("ip_Addr");
	//String password = (String)session.getAttribute("password");
	String op_Code=request.getParameter("opCode");
	String op_Name=request.getParameter("opName");
	
	String paraAray[] = new String[9];				
	paraAray[0] = work_no;		
	paraAray[1] = orgCode;
	paraAray[2] = request.getParameter("phoneNo");
	if(op_Code.equals("6937"))
	{
		paraAray[3] = "99";
	}
	else if(op_Code.equals("6938"))
	{
		paraAray[3] = "04";
	}
	else if(op_Code.equals("6939"))
	{
		paraAray[3] = "05";
	}
	else if(op_Code.equals("6940"))
	{
		paraAray[3] = "06";
	}
	else if(op_Code.equals("6941"))
	{
		paraAray[3] = "07";
	}
	//paraAray[3] = op_Code;
	paraAray[4] = "08";
	paraAray[5] = "";
	paraAray[6] = request.getParameter("printAccept");
	paraAray[7] = request.getParameter("sInSpid");
	paraAray[8] = request.getParameter("sInBizCode");
				
	System.out.println("paraAray[0]=========================="+paraAray[0]);
	System.out.println("paraAray[1]=========================="+paraAray[1]);
	System.out.println("paraAray[2]=========================="+paraAray[2]);
	System.out.println("paraAray[3]=========================="+paraAray[3]);
	System.out.println("paraAray[4]=========================="+paraAray[4]);
	System.out.println("paraAray[5]=========================="+paraAray[5]);
	System.out.println("paraAray[6]=========================="+paraAray[6]);
	System.out.println("paraAray[7]=========================="+paraAray[7]);
	System.out.println("paraAray[8]=========================="+paraAray[8]);
%>

<wtc:service name="s6936Cfm" routerKey="phone" routerValue="<%=work_no%>" retcode="errCode" retmsg="errMsg" outnum="2" >
	<wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="01"/>
	<wtc:param value="<%=paraAray[3]%>"/>
	<wtc:param value="<%=paraAray[0]%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=paraAray[2]%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=paraAray[1]%>"/>
	<wtc:param value="<%=paraAray[4]%>"/>
	<wtc:param value="<%=paraAray[5]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value="<%=paraAray[8]%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
<%
	if(errCode.equals("0") || errCode.equals("000000"))
	{
		System.out.println("f6936_login.jsp调用服务s6936Cfm成功!");
%> 
<script language="JavaScript">
	rdShowMessageDialog("操作成功!");
	window.location="f6936_login.jsp?opCode=<%=op_Code%>&opName=<%=op_Name%>&activePhone=<%=paraAray[2]%>";
</script>
<%
	}else{
		System.out.println("f6936_login.jsp调用服务s6936Cfm失败!");
		System.out.println("errCode==="+errCode+"errMsg==="+errMsg);
%>   
<script language="JavaScript">
		rdShowMessageDialog("操作失败!<%=errMsg%>");
		window.location="f6936_login.jsp?opCode=<%=op_Code%>&opName=<%=op_Name%>&activePhone=<%=paraAray[2]%>";
</script>
<%	
	}
%>
