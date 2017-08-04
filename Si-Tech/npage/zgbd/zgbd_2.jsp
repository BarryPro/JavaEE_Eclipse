<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
    String opCode = "zgbd";
    String opName = "国漫用户产品使用情况查询";
	String phoneNo=request.getParameter("phoneNo");
 
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String inParas[] = new String[2];
	String s_date=""; 
	inParas[0]="select to_char(PHONE_NO),to_char(PROD_ID),to_char(ProdInst_ID),to_char(sysdate,'YYYYMMDDHH24MISS') from DBBILLADM.DPRODUCT_INFO_FUN where phone_no=:s_no";
	inParas[1]="s_no="+phoneNo;
%>
   
<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="4">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
  
<wtc:array id="result1" scope="end" />
<script language="javascript">
	function doqry(phone_no,cpdm,dgls,dates)
	{
		//alert("dates is "+dates);
		document.frm1508_2.action="zgbd_3.jsp?phone_no="+phone_no+"&cpdm="+cpdm+"&dgls="+dgls+"&dates="+dates;
		frm1508_2.submit();
	}
</script> 
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>国漫用户产品使用情况查询</TITLE>
</HEAD>
<body>
<%
	if(retCode2=="000000" ||retCode2.equals("000000") )
	{
	 
%>

<FORM method=post name="frm1508_2">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">查询结果</div>
</div>
	  
      <table cellspacing="0">
      <tr> 
        <th>手机号码</th>
		<th>产品代码</th>
        <th>产品订购流水号</th>
		<th>操作</th>
      </tr>
<%
	
 
		for(int i=0;i<result1.length;i++)
		{
		 
			%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
					<td><%=result1[i][2]%></td>
					<td><input type="button" value="查询" onclick="doqry('<%=result1[i][0]%>','<%=result1[i][1]%>','<%=result1[i][2]%>','<%=result1[i][3]%>')"></td>
				</tr>
			<%
		}
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zgbd_1.jsp?activePhone=<%=phoneNo%>');
			</script>
		<%
	}
%> 
 

         
          <tr id="footer"> 
      	    <td colspan="9">
    	      <input class="b_foot" name=back onClick="window.location = 'zgbd_1.jsp?activePhone=<%=phoneNo%>' " type=button value=返回>
    	      <input class="b_foot" name=back onClick="removeCurrentTab();" type=button value=关闭>
			  <!--
			  <input class="b_foot" name=back onClick="toExcel();" type=button value=导出EXCEL>
			  -->
    	    </td>
          </tr>
          
      </table>
      <tr id="footer"> 
      	   
          </tr>
    
      	
    	    
        

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>

