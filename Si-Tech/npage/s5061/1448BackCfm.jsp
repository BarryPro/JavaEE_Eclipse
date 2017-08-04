   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>
<%
  String opCode = "1448";
  String opName = "邮寄帐单";
%>    
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>

<%	
	String op_code = request.getParameter("op_code");
	String loginAccept = request.getParameter("loginAccept");
	String phoneno = request.getParameter("phoneno");
	String order_code = request.getParameter("order_code");
	String r_cus = request.getParameter("r_cus");
	String postFlag = request.getParameter("postFlag");
	String post_name = request.getParameter("post_name");
	String post_address = request.getParameter("post_address");
	String post_zip = request.getParameter("post_zip");
	String fax_no = request.getParameter("fax_no");
	String mail_address = request.getParameter("mail_address");
	String t_sys_remark = request.getParameter("t_sys_remark");
	
	System.out.println("----------------------f1448BackCfm.jsp---------------------");					
	String[][] result = new String[][]{};
	
	
	String work_no = (String)session.getAttribute("workNo");
	String loginName =(String)session.getAttribute("workName");
	String org_code =(String)session.getAttribute("orgCode");
	String pass = (String)session.getAttribute("password");
	String regionCode = (String)session.getAttribute("regCode");

	String paraAray[] = new String[19];   
	
	paraAray[0] = loginAccept; //流水
	paraAray[1] = "01"; //渠道标识
	paraAray[2] = "1448";	//功能代码
	paraAray[3] = work_no;  //操作工号
	paraAray[4] = ""; //工号密码
	paraAray[5] = phoneno;	//用户号码 
	paraAray[6] = ""; //号码密码
	paraAray[7] = r_cus; //类型
	paraAray[8] = "1";
	paraAray[9] = postFlag;//邮寄类型
	paraAray[10] = post_name;	//邮寄姓名
	paraAray[11] = post_address;//邮寄地址
	paraAray[12] = post_zip; //邮编
	paraAray[13] = fax_no;  //传真
	paraAray[14] = mail_address; //E_Mail
	paraAray[15] = ""; //E_Mail
	paraAray[16] = ""; //E_Mail
	paraAray[17] = t_sys_remark; //用户备注
	paraAray[18] = "";
	
	//String[] ret = impl.callService("sPostPrtBill",paraAray,"1","phone",phoneno);
%>

    <wtc:service name="sPostPrtBill" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraAray[0]%>" />
			<wtc:param value="<%=paraAray[1]%>" />
			<wtc:param value="<%=paraAray[2]%>" />
			<wtc:param value="<%=paraAray[3]%>" />			
			<wtc:param value="<%=paraAray[4]%>" />	
			<wtc:param value="<%=paraAray[5]%>" />	
			<wtc:param value="<%=paraAray[6]%>" />
			<wtc:param value="<%=paraAray[7]%>" />
			<wtc:param value="<%=paraAray[8]%>" />
			<wtc:param value="<%=paraAray[9]%>" />
			<wtc:param value="<%=paraAray[10]%>" />
			<wtc:param value="<%=paraAray[11]%>" />						
			<wtc:param value="<%=paraAray[12]%>" />	
			<wtc:param value="<%=paraAray[13]%>" />
			<wtc:param value="<%=paraAray[14]%>" />		
			<wtc:param value="<%=paraAray[15]%>" />	
			<wtc:param value="<%=paraAray[16]%>" />	
			<wtc:param value="<%=paraAray[17]%>" />	
			<wtc:param value="<%=paraAray[18]%>" />
		</wtc:service>
		<wtc:array id="result1" scope="end"  />

<% String errMsg = msg1;	%>
	
	<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode+
							"&retCodeForCntt="+code1+
							"&opName="+opName+
							"&workNo="+work_no+
							"&loginAccept="+loginAccept+
							"&pageActivePhone="+phoneno+
							"&retMsgForCntt="+msg1+
							"&opBeginTime="+opBeginTime; %>
  <jsp:include page="<%=url%>" flush="true" />
	
<%
System.out.println("url："+url);
	if (code1.equals("000000"))
	{
	loginAccept = result1[0][0];

%>
	
<script language="JavaScript">
	rdShowMessageDialog("邮寄帐单业务处理成功！",2);
	window.location="s1448.jsp?op_code=1448&ph_no=<%=phoneno%>";
</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("邮寄帐单失败: <%=errMsg%>",0);
	window.location="s1448.jsp?op_code=1448&ph_no=<%=phoneno%>";
</script>
<%}
%>

