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
	String phone_no=request.getParameter("phone_no");
	String cpdm =  request.getParameter("cpdm");
	String dgls = request.getParameter("dgls");
	String dates = request.getParameter("dates");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String inParas[] = new String[10];
	inParas[0]="BIP3A310";
	inParas[1]="T3000313";
	inParas[2]=work_no;
	inParas[3]=org_code;
	inParas[4]="";
	inParas[5]=phone_no;
	inParas[6]="451";
	inParas[7]=dates;
	inParas[8]=cpdm;
	inParas[9]=dgls;
 
%>
   
<wtc:service name="sTSNPubSnd" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="29">
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=inParas[3]%>"/>
			<wtc:param value="<%=inParas[4]%>"/>
			<wtc:param value="<%=inParas[5]%>"/>
			<wtc:param value="<%=inParas[6]%>"/>
			<wtc:param value="<%=inParas[7]%>"/>
			<wtc:param value="<%=inParas[8]%>"/>
			<wtc:param value="<%=inParas[9]%>"/>
			<wtc:param value="0"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
</wtc:service>
  
<wtc:array id="result1" scope="end" />
 
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
        <th>订购生效时间</th>
		<th>产品失效时间</th>
        <th>剩余天数</th>
		<th>已使用天数</th>
		<th>包天类产品包含总天数</th>
		<th>剩余流量数</th>
		<th>已使用量</th>
		<th>包量类产品包含总流量数</th>
		<th>剩余语音分钟数</th>
		<th>已使用语音分钟数</th>
		<th>包语音类产品的全部语音分钟数</th>
      </tr>
<%
	
 
		for(int i=0;i<result1.length;i++)
		{
		 
			%>
				<tr>
					<td><%=result1[i][15]%></td>
					<td><%=result1[i][18]%></td>
					<td><%=result1[i][19]%></td>
					<td><%=result1[i][20]%></td>
					<td><%=result1[i][21]%></td>
					<td><%=result1[i][22]%></td>
					<td><%=result1[i][23]%></td>
					<td><%=result1[i][24]%></td>
					<td><%=result1[i][25]%></td>
					<td><%=result1[i][26]%></td>
					<td><%=result1[i][28]%></td>
				</tr>
			<%
		}
		
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog('<%=retCode2%>:<%=retMsg2%>',0);
				document.location.replace('zgbd_1.jsp');
			</script>
		<%
	}
%> 
 

         
          <tr id="footer"> 
      	    <td colspan="11">
    	      <input class="b_foot" name=back onClick="window.location = 'zgbd_1.jsp' " type=button value=返回>
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

