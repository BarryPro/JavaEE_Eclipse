<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String op_name = "";
	String regionCode = (String)session.getAttribute("regCode");
	
	String loginAccept = request.getParameter("loginAccept");
	String opCode = request.getParameter("opCode");
	String loginNo = request.getParameter("loginNo");
	String loginPwd = request.getParameter("loginPwd");
	String orgCode = request.getParameter("orgCode");
	String systemNote = request.getParameter("systemNote");
	String opNote = request.getParameter("opNote");
	String opType = request.getParameter("opType");
	String check_id = request.getParameter("check_id");
	String check_name = request.getParameter("check_name");
	String func_code = request.getParameter("func_code");
	String check_rule = request.getParameter("check_rule");
	String local_flag = request.getParameter("local_flag");
	String err_code = request.getParameter("err_code");
	String err_desc = request.getParameter("err_desc");
	System.out.println("**********"+loginAccept+"**********");
	%>

<wtc:service name="s9104Cfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=loginAccept%>"/>
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=loginNo%>"/>
	<wtc:param value="<%=loginPwd%>"/>
	<wtc:param value="<%=orgCode%>"/>
	<wtc:param value="<%=systemNote%>"/>
	<wtc:param value="<%=opNote%>"/>
	<wtc:param value="<%=opType%>"/>
	<wtc:param value="<%=check_id%>"/>
	<wtc:param value="<%=check_name%>"/>
	<wtc:param value="<%=func_code%>"/>
	<wtc:param value="<%=check_rule%>"/>
	<wtc:param value="<%=local_flag%>"/>
	<wtc:param value="<%=err_code%>"/>
	<wtc:param value="<%=err_desc%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

<%
if(retCode.equals("000000")){
%>
<script>
    rdShowMessageDialog("自动校验规则配置录入成功！",2);
    location="f9104_1.jsp";                                                                //打印流水
</script>
<%
     }
     else
     {
%>
<script>
    rdShowMessageDialog("错误代码：'<%=retCode%>'错误信息：'<%=retMsg%>'",0);
    location="f9104_1.jsp";
</SCRIPT>
<%
     }
%>	





