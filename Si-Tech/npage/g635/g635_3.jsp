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
	String op_code = "g635";//需要新申请             //操作代码
	String op_note = "担保开机";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	// 
	String phone_no = request.getParameter("phone_no");
	String iLevel = request.getParameter("iLevel");
	String hours = request.getParameter("hours");
	String bdbr = request.getParameter("bdbr"); 
	
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAA phone_no"+phone_no+" and work_no "+work_no+" iLevel is "+iLevel+" and hours is "+hours); 
	 
	
	 
 
%>
<wtc:service name="sAssureBoot" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=bdbr%>"/>
    <wtc:param value="<%=iLevel%>"/> 
    <wtc:param value="<%=hours%>"/>
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=op_code%>"/>
    <wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = s4141CfmMsg;
	if ( s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("办理成功！");
	window.location="g635_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="g635_1.jsp";
	</script>
<%}
%>

