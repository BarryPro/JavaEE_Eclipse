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
	//分为 集团联系人和 重要成员两种   

	String id_arrays[]=request.getParameterValues("id_arrays");  //集团联系人
	
	
	String id_new="";
	 
    System.out.println("TTTTTTTTTTTTTTTTTTTTTTTTTT id_arrays is "+id_arrays);
	 
	 
 
	String s_count = request.getParameter("s_count");
	String regionCodes = request.getParameter("regionCode");
	String paraAray[] = new String[14]; 
 
	String s_flag = request.getParameter("s_flag"); 
	String s_returnPage="";
	s_returnPage="i092_1.jsp";
	String s_dis_code = request.getParameter("s_dis_code");
%>
<wtc:service name="bi092_delall" routerKey="region" routerValue="<%=regionCode%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=id_new%>"/> 
	<wtc:param value="<%=s_count%>"/>
	<wtc:param value="<%=regionCodes%>"/>
	<wtc:param value="<%=s_dis_code%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/> 
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
	window.location="<%=s_returnPage%>";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=s4141CfmCode%>",0);
	window.location="<%=s_returnPage%>";
	</script>
<%}
%>
 