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
	
	String opCode = "zgbi";
	String opName = "冲正工号添加";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String s_login_no= request.getParameter("s_login_no");
 
 
	String work_no = (String)session.getAttribute("workNo");
	 
 
	 
	String paraAray[] = new String[4]; 
	paraAray[0] = s_login_no;
	paraAray[1] = work_no;
 
  
 
%>
<wtc:service name="s1310ghdel" routerKey="region" routerValue="<%=regionCode%>" retcode="sCode" retmsg="sMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
 
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
	window.location="zgbi_del.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=sCode%>",0);
	window.location="zgbi_del.jsp?opCode=zg27&opName=增值税红字发票开具申请";
	</script>
<%}
%>

