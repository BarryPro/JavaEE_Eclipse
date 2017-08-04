<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	
	String opCode = "zg18";
    String opName = "通用机打发票作废开具申请";
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String tax_number= request.getParameter("tax_number");
    String tax_code= request.getParameter("tax_code");
  String count= request.getParameter("count");
	String s_cust_id= "";
	String op_code = "zg18";//操作代码
	String work_no = (String)session.getAttribute("workNo");
	String sprid= "";
	 
	String year_month =  request.getParameter("year_month");
	 
	String paraAray[] = new String[11]; 
	paraAray[0] = tax_number;
	paraAray[1] = tax_code;
	paraAray[2] = s_cust_id;
	paraAray[3] = op_code;
	paraAray[4] = work_no;
	paraAray[5] = "";
	paraAray[6] = "1";
	paraAray[7] = count;
 
  
 
%>
<wtc:service name="bs_zg20Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=year_month%>"/>
    
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode= sCode;
	String retMsg = sMsg;
   

	String errMsg = sMsg;
	if ( sCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("办理成功！");
	window.location="zg18_1.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=sCode%>",0);
	window.location="zg18_1.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%}
%>

