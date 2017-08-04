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
	String op_code = "g090";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "集团信用等级调整";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
 
    String beginYms = request.getParameter("beginYm");
	String endYm = request.getParameter("endYm"); 
	String unit_id = request.getParameter("unit_id");
	 
	String credit_code =  request.getParameter("credit_code");
	 
	String paraAray[] = new String[6];
	paraAray[0] = unit_id; 
	paraAray[1] = credit_code;
	paraAray[2] = beginYms;
	paraAray[3] = endYm;
	paraAray[4] = op_code;
	paraAray[5] = work_no; 
%>

<wtc:service name="s_insertCfg" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/> 
    
</wtc:service>
<wtc:array id="g089Arr" scope="end"/>
<%
	String retCode= g089CfmCode;
	String retMsg = g089CfmMsg;

	System.out.println("retCode === "+ retCode);
	System.out.println("retMsg === "+ retMsg);
%>
 
<%
   

	String errMsg = g089CfmMsg;
	if ( g089CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("办理成功！");
	window.location="g090_1.jsp?opCode=g090&opName=集团信用等级调整";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="g090_1.jsp?opCode=g090&opName=集团信用等级调整";
	</script>
<%}
%>
