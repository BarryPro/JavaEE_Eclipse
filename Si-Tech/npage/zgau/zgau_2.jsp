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
	String op_code = "zgau";              //操作代码
	
	String work_no = (String)session.getAttribute("workNo"); 
	String s_login_no = request.getParameter("s_login_no"); 
	 
	
%>
<wtc:service name="s4141add"  retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=s_login_no%>"/>
	<wtc:param value="<%=work_no%>"/>
    <wtc:param value="<%=regionCode%>"/> 
     
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	  
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("操作成功！",2);
	window.location="zgau_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("操作失败: <%=retMsg%>",0);
	window.location="zgau_1.jsp";
	</script>
<%}
%>

