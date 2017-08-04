<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-18 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
		response.setHeader("Pragma","No-Cache"); 
    response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 

		String opCode = "1302";
		String opName="账号缴费";
		String region_code = request.getParameter("region_code").trim();
		String district_code = request.getParameter("district_code").trim();
		String bank_name = request.getParameter("bank_name").trim();
    String bank_code = request.getParameter("bank_code").trim();
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);

		StringBuffer  strBuffer = new StringBuffer(80);

	 	 strBuffer.append("select BANK_CODE,BANK_NAME from sBankCode where REGION_CODE ='");
		 strBuffer.append(region_code);
     strBuffer.append("' and  DISTRICT_CODE='");
     strBuffer.append(district_code);
	 	 strBuffer.append("' ");
	 	 
	 if(!bank_name.equals("")){
        strBuffer.append(" and BANK_NAME like '%");
				strBuffer.append(bank_name);
				strBuffer.append("%'");
	 }
     if(!bank_code.equals("")){
        strBuffer.append(" and BANK_CODE like '%");
				strBuffer.append(bank_code);
				strBuffer.append("%'");
	 }

	 strBuffer.append("  order by bank_code");
	 String sqlStr = strBuffer.toString();
%>
		<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />

<%if(result==null||result.length==0){%>
 	<SCRIPT LANGUAGE="JavaScript">
	<!--
	    window.close();

	//-->
	</SCRIPT>
<% } else if(result.length == 1){ %>
    <SCRIPT LANGUAGE="JavaScript">
	<!--
       window.returnValue="";
		   window.returnValue="<%=result[0][0].trim()%>,<%=result[0][1].trim()%>";
		   window.close();
	//-->
	</SCRIPT>
<% } else { %>
<HTML><HEAD><TITLE>银行代码查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">

function selBank()
{	
	window.returnValue="";    
 
	if(isNaN(document.frm.bank.length))
	 {
            window.returnValue=document.frm.bank.value;    
 	 }else
       for(i=0;i<document.frm.bank.length;i++) 
	  {		    
		      if (document.frm.bank[i].checked==true)
		     {
 					 window.returnValue=document.frm.bank[i].value;     
					 break;
			  }
	   } 
 		window.close(); 
}
	
 </script>
</head>

<BODY>
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">银行代码查询</div>
		</div>

  <table cellspacing="0">
    <tr align="center"> 
      <th>&nbsp;</th>
      <th>银行代码</th>
      <th>银行名称</th>
    </tr>
    <% 
    String tbClass="";
    for(int i=0; i < result.length  ; i++)
	{
		if(i%2==0){
			tbClass="Grey";
		}else{
			tbClass="";	
		}
		%>
			<tr align="center"> 
			  <td class="<%=tbClass%>"> 
				  <input type="radio" name="bank" value="<%=result[i][0].trim()%>,<%=result[i][1].trim()%>"     <%if (i==0) {%>checked<%}%>>&nbsp;
			  </td>
			  <td class="<%=tbClass%>"><%=result[i][0]%>&nbsp;</td>
			  <td class="<%=tbClass%>"><%=result[i][1]%>&nbsp;</td>
			</tr>
    <%}%>

 
    <tr> 
      <td colspan="3" id="footer"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selBank()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
  </table>
  
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
<%}%>
 

