<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String opCode = "e250";
		String opName = "国开行锚定申请";
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String phoneNo = request.getParameter("phoneNo");
		//String loginAccept = request.getParameter("loginAccept");

%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
		
		
		String  inputParsm [] = new String[9];
		inputParsm[0] = loginAccept;
		inputParsm[1] = "01";
		inputParsm[2] = "e250";
		inputParsm[3] = workNo;
		inputParsm[4] = password;
		inputParsm[5] = "";
		inputParsm[6] = "";
		inputParsm[7] = phoneNo;
		inputParsm[8] = "1";

%>
		<wtc:service name="se250Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
<%
	String vSrvName = "";
	if("000000".equals(retCode)){
		System.out.println(" ======== se250Cfm 调用成功 ========");
		%>	
  <script language="javascript">

 	rdShowMessageDialog("申请成功！",2);
 		window.location="fe250.jsp";
 	</script>
 	<%
	}
else {
	System.out.println(" ======== se250Cfm 调用失败 ========");
	%>
  	<script language="javascript">
 	  rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 		//window.location="fe250.jsp";
 	</script>
 	<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>国开行锚定申请</title>
</head>
<BODY>
	<form name="frm" action="" method="post" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
	<div id="title_zi">未成功号码列表</div>
</div>
 	<TABLE cellSpacing="0">
    <tr>
        <TH width='50%' align='center'>未添加成功号码</TH>
        <TH >失败原因</TH>
    </tr>
    
    <%
    String phonelist = ret[0][2];
    String reasonlist = ret[0][3];
    String phonelist1[] =phonelist.split("\\|");
    String reasonlist1[] =reasonlist.split("\\|");
    for(int is=0;is<phonelist1.length;is++) {
    %>
    <tr>
            <td align='center'><%=phonelist1[is]%></td>
            <td ><%=reasonlist1[is]%></td>
    </tr>
    <%
    }
    %>
  </TABLE>
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">	
					<input type="button" name="quchoose" class="b_foot" value="返回" onClick="window.location='fe250.jsp'"  />		
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();">
			</div>
			</td>
		</tr>
	</table>

</form>
<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>
	
 	<%
	}
%>
