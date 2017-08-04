<%
/********************
 * version v2.0
 * 开发商: si-tech
 * author: huangrong
 * date  : 20101103
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "b883";
	String opName = "订单撤单";
	
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>

<%
	String work_no = (String)session.getAttribute("workNo");
	String pass = (String)session.getAttribute("password");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
  
	String printAccept = request.getParameter("printAccept");
	String op_code = request.getParameter("opcode");	
	
	
	String s_order_code = request.getParameter("s_order_code");
	
  String paraAray[] = new String[8]; 
	paraAray[0] = printAccept;
	paraAray[1] = "01";
  paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = pass;
	paraAray[5] = "";
	paraAray[6] = "";
	paraAray[7] = s_order_code;  
	
	System.out.println("dddddddddddddddddddddddddddddddddddd");    
	System.out.println("printAccept======================"+printAccept);    
	System.out.println("op_code======================"+op_code);    
	System.out.println("work_no======================"+work_no);     
	System.out.println("pass======================"+pass);    
	System.out.println("s_order_code======================"+s_order_code);     
%>
<wtc:service  name="sMarkOrderBack" routerKey="region" routerValue="<%=orgCode%>" outnum="1"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功!",2);
	 window.location="fb883_1.jsp?opCode=b883&opName=订单撤单";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("订单撤销失败!(<%=errMsg%>)",0);
	window.location="fb883_1.jsp?opCode=b883&opName=订单撤单";
</script>
<%}%>

