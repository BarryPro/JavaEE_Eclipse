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
	
	String opCode = "zg75";
	String opName = "新版月结";
	
	       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
	String s_op_code_input = "AAAA";//录入的余额发票 特殊记录为AAAA
	String login_accept= request.getParameter("login_accept");
    String phoneno= request.getParameter("phoneno");
	String left_invoice= request.getParameter("left_invoice");//发票余额
	String cust_name= request.getParameter("cust_name");
	 
 
	String work_no = (String)session.getAttribute("workNo");
	String groupId = (String)session.getAttribute("groupId"); 
	 
 
  
	//1. 判断该号码是否已经录入过
	//2. 未录入的 可以录入 新写一个录入接口
%>
<wtc:service name="sleftInDB" routerKey="phone" routerValue="<%=phoneno%>" retcode="sCode" retmsg="sMsg"  outnum="2" >
		<wtc:param value="<%=login_accept%>"/>
		<wtc:param value="<%=s_op_code_input%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value=""/><!--op_time-->
		<wtc:param value="<%=phoneno%>"/>
		<wtc:param value="0"/><!--id_no-->
		<wtc:param value="0"/><contractno>
		<wtc:param value=""/><!--s_check_num-->
		<wtc:param value="0"/><!--发票号码 0-->
		<wtc:param value="0"/><!--发票代码 0-->
		<wtc:param value=""/><!--sm_code -->
		<wtc:param value="<%=left_invoice%>"/><!--小写金额-->
		<wtc:param value=""/><!--大写金额-->
		<wtc:param value=""/><!--备注-->
	 
		<wtc:param value="6"/><!--预占是6 取消是5即未打印-->
		<wtc:param value=""/><!--暂空-->
		<wtc:param value=""/><!--税率-->
		<wtc:param value=""/><!--税额-->
		<wtc:param value=""/>

		<!--给basd的 0是预占 1是取消预占 这个参数不要了 -->
		<wtc:param value="<%=cust_name%>"/><!--userName-->
		<!--xl add 新增入参 发票类型 货物名称 规格型号 单位 数量 单价 regionCode groupId 是否冲红-->
		<wtc:param value="0"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=regionCode%>"/>
		<wtc:param value="<%=groupId%>"/> 
		<wtc:param value="1"/>
</wtc:service>
<wtc:array id="sArr" scope="end"/>
<%
	String retCode= sCode;
	String retMsg = sMsg;
   
 
	if ( retCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("余额发票录入成功！");
	window.location="zg75_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("余额发票录入失败: <%=retMsg%>,<%=retCode%>",0);
	window.location="zg75_1.jsp";
	</script>
<%}
%>

