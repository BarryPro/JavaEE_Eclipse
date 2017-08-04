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
	String op_code = "g089";//需要新申请             //操作代码
	String loginAccept = "0";//request.getParameter("sysAccept");;       //操作流水 
	String op_note = "集团红名单管理";//request.getParameter("op_note");              //备注
 
	
	String work_no = (String)session.getAttribute("workNo");       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
 
    //String beginYms = request.getParameter("beginYm");
	//String endYm = request.getParameter("endYm"); 
	String unit_id = request.getParameter("unit_id");
	String id_no =  request.getParameter("id_no");
	String credit_code =  request.getParameter("credit_code");
	//System.out.println("AAAAAAAAAAAAAAAAAA credit_code is "+credit_code+" and unit_id is "+unit_id+" and endYm is "+endYm);

	//xl add
	String contract_no = request.getParameter("contract_no");
	String length_month = request.getParameter("length_month");

	String paraAray[] = new String[8];
	paraAray[0] = unit_id;
	paraAray[1] = id_no;
	paraAray[2] = credit_code;
	paraAray[3] = contract_no;
	paraAray[4] = length_month;
	paraAray[5] = "N";
	paraAray[6] = op_code;
	paraAray[7] = work_no; 
%>

<wtc:service name="s_insertRed" routerKey="region" routerValue="<%=regionCode%>" retcode="g089CfmCode" retmsg="g089CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
	<wtc:param value="<%=paraAray[7]%>"/> 
    
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
	window.location="g089_1.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("办理失败: <%=retMsg%>,<%=g089CfmCode%>",0);
	window.location="g089_1.jsp?opCode=g089&opName=集团红黑名单管理";
	</script>
<%}
%>
