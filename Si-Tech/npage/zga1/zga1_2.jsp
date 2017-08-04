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
	String op_code = "zga1";              //操作代码
	
	String work_no = (String)session.getAttribute("workNo"); 
	String phone_no = request.getParameter("phone_no"); 
	 
	
%>
<wtc:service name="sdestcustpay" routerKey="phone" routerValue="<%=phone_no%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=phone_no%>"/>
    <wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=op_code%>"/> 
     
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
	
    System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
	  
	System.out.println("success");
%>
<script language="JavaScript">
	rdShowMessageDialog("充值处理成功！",2);
	window.location="zga1_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("充值处理失败: <%=retMsg%>",0);
	window.location="zga1_1.jsp";
	</script>
<%}
%>

