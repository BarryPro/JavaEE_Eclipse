<%
/********************
 version v2.0
开发商: si-tech
update:huangrong@2010-09-19
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "b881";
	String opName = "积分礼品配置";
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
	String subtype = request.getParameter("subtype");
	String itemid_type = request.getParameter("itemid_type");
	
  String paraAray[] = new String[9]; 
	paraAray[0] = printAccept;
	paraAray[1] = "01";
  paraAray[2] = op_code;
	paraAray[3] = work_no;
	paraAray[4] = pass;
	paraAray[5] = "";
	paraAray[6] = "";
	paraAray[7] = itemid_type;      
	paraAray[8] = subtype;  
	System.out.println("****************************************************************");   
	System.out.println("***********printAccept***********"+printAccept);   
	System.out.println("***********op_code***********"+op_code);   
	System.out.println("***********work_no***********"+work_no);       
	System.out.println("***********pass***********"+pass);   
	System.out.println("***********itemid_type***********"+itemid_type);   
	System.out.println("***********subtype***********"+subtype);   
	
%>
<wtc:service  name="sItemCfg" routerKey="region" routerValue="<%=orgCode%>" outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
	<wtc:param  value="<%=paraAray[8]%>"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if (errCode.equals("0")||errCode.equals("000000"))
	{
%>
<script language="JavaScript">
   rdShowMessageDialog("提交成功!",2);
	 window.location="fb881_1.jsp?opCode=b881&opName=积分礼品配置";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("积分下线礼品配置失败!(<%=errMsg%>",0);
	window.location="fb881_1.jsp?opCode=b881&opName=积分礼品配置";
</script>
<%}%>
