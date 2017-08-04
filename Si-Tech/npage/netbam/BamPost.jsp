   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>
<%
  String opCode = "1448";
  String opName = "BAM监控数据传输";
%>    
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
	String strLine1 = request.getParameter("line1");
	String strLine2 = request.getParameter("line2");
	String regionCode = "01";
	
	System.out.println("----------------------f1448BackCfm.jsp---------------------");					
	String[][] result = new String[][]{};
	String paraAray[] = new String[2];   
	
	
	paraAray[0] = strLine1; //流水
	paraAray[1] = strLine2; //类型
%>

    <wtc:service name="sBamPost" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end"  />

<% String errMsg = msg1;	%>
	
<%
	if (code1.equals("000000"))
	{
	//loginAccept = result1[0][0];

%>
	
<script language="JavaScript">
	rdShowMessageDialog("BAM监控数据传输处理成功！",2);
	window.location="sMainBam.jsp?op_code=1448";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("BAM监控数据传输处理失败: <%=errMsg%>",0);
	window.location="sMainBam.jsp?op_code=1448";
</script>
<%}
%>

