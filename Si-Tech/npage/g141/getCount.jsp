<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
        response.setHeader("Pragma","No-Cache"); 
	    response.setHeader("Cache-Control","No-Cache");
        response.setDateHeader("Expires", 0); 
%>
<%
    String opCode = "g142";
    String opName = "集团缴费信息查询";
	String unit_id = request.getParameter("unit_id");
	String outNum = "5";
	String [] paraIn = new String[2];
    paraIn[0] = "select to_char(account_id),user_name,to_char(user_no) from dgrpusermsg where cust_id =(select cust_id from dgrpcustmsg where unit_id=:unit_id ) and run_code<'a'";    
    paraIn[1]="unit_id="+unit_id;
%>
    <wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=unit_id%>" retcode="retCode" retmsg="retMsg" outnum="3" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
 	 
    paraIn[0] = "select to_char(account_id),user_name,to_char(user_no) from dgrpusermsg where cust_id =(select cust_id from dgrpcustmsg where unit_id=:unit_id ) and run_code >='a'";    
    paraIn[1]="unit_id="+unit_id;
%>
    <wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=unit_id%>" retcode="retCode" retmsg="retMsg" outnum="3" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="resultdead" scope="end"/>
<%
 	//String resultdead[][]  = value.getData();
%>

 
<%  if ((result.length + resultdead.length)==1 ) { %>      
 	<SCRIPT LANGUAGE="JavaScript">
        window.returnValue='';
        <%if (result.length == 1) {%>
            var temp = new Array();
            temp[0] = '<%=result[0][0].trim()%>';
	        temp[1] = '0';
	        temp[2] = '<%=result[0][2].trim()%>';
		    window.returnValue = temp;
			window.close();		    
		<%} else {%>
			var temp = new Array();
            temp[0] = '<%=resultdead[0][0].trim()%>';
	        temp[1] = '1';
	        temp[2] = '<%=resultdead[0][2].trim()%>';
		    window.returnValue = temp;
			window.close();
       <%}%>
 	</SCRIPT>
<%  } else { %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selAccount() {
	if(typeof(document.frm.account)!="undefined"){
	   for(i=0;i<document.frm.account.length;i++) {    
		  if (document.frm.account[i].checked==true) {
	 	    var temp = new Array();
	        temp[0] = document.frm.account[i].value;
		    temp[1] = document.frm.userType.value;
		    temp[2] = document.frm.userno.value;
			window.returnValue = temp;
	        break;
		  }
	   }		
	}
   window.close();
}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi">客户信息</div>
</div>
<input type="hidden" name="userType" value="">
<input type="hidden" name="userno" value="">      
  
  <table cellSpacing=0>
    <tr> 
      <th> 
        <div align="center">&nbsp;</div>
      </th>
      <th> 
        <div align="center">产品帐号</div>
      </th>
      <th> 
        <div align="center">产品名称</div>
      </th>
	  <th> 
        <div align="center">产品号码</div>
      </th>	
      

    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
		%>
			<tr> 
			  <td > 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=result[i][0].trim()%>" onClick="JavaScript:document.frm.userType.value='0',document.frm.userno.value='<%=result[i][2]%>'">
				</div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][0]%></div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][1]%></div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][2]%></div>
			  </td> 
			</tr>
    <%}%>

	<% for(int i=0; i < resultdead.length  ; i++)
	{
		%>
			<tr> 
			  <td > 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=resultdead[i][0].trim()%>" onClick="JavaScript:document.frm.userType.value='1',document.frm.userno.value='<%=resultdead[i][2]%>'">
				</div>
			  </td>
			  <td> 
				<div align="center"><%=resultdead[i][0]%></div>
			  </td>
			  <td> 
				<div align="center"><%=resultdead[i][1]%></div>
			  </td>
			  <td> 
				<div align="center"><%=resultdead[i][2]%></div>
			  </td> 
			</tr>
    <%}%>
 
    <tr> 
      <td id="footer" colspan="6"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>

