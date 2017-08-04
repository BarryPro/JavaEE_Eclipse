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
	String op_code = "g088";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "集团交费通知短信配置";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
 
    String unit_id = request.getParameter("unit_id");
	String cust_id = request.getParameter("cust_id"); 
	String imp = request.getParameter("imp");
	System.out.println("AAAAAAAAAAAAAAAAAA cust_id is "+cust_id+" and imp is "+imp);

	String paraAray[] = new String[4];
	paraAray[0] = unit_id;
	paraAray[1] = cust_id;
	paraAray[2] = imp;
	paraAray[3] = work_no;
%>
 <wtc:service name="s_upgopr" routerKey="region" routerValue="<%=regionCode%>" retcode="s4Code" retmsg="s4CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/> 
    <wtc:param value="<%=paraAray[3]%>"/> 
</wtc:service>
<wtc:array id="s4CfmArr" scope="end"/>
<%
	String retCode= s4Code;
	String retMsg = s4CfmMsg;
 
%>
 
<%
   

	String errMsg = s4CfmMsg;
	if ( s4Code.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("办理成功！");
	window.location="asdf_1.jsp?opCode=g088&opName=集团交费通知短信配置";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=s4Code%>",0);
	window.location="asdf_1.jsp?opCode=g088&opName=集团交费通知短信配置";
	</script>
<%}
%>

 

