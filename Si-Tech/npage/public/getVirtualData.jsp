<%
  /*
   * 功能: 查询数固号码信息
　 * 版本: 2.0
　 * 日期: 2009/03/05
　 * 作者: liuyj
　 * 版权: sitech
   * 修改人:
   * 修改原因:
　*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");	
	String orgCode=(String)session.getAttribute("orgCode");   /*机构代码*/
	String password=(String)session.getAttribute("password");
	//String orgCode = (String)session.getAttribute("orgCode");
	String deadflag=request.getParameter("deadflag");       /*是否在网离网标志Y N*/
	String RegionCode=orgCode.substring(0,2);                /*地市代码*/
	 opCode=request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");     /*数据业务标识号*/
	String pageTitle = "固网号码信息查询";
	String[][] result  = null;
%>
	<wtc:service  name="s1522DataQuery"  outnum="6">
		<wtc:param   value="<%=workNo%>"/>
		<wtc:param   value="<%=password%>"/>
		<wtc:param   value="<%=orgCode%>"/>
		<wtc:param   value="<%=opCode%>"/>
		<wtc:param   value="<%=RegionCode%>"/>
		<wtc:param   value="<%=phoneNo%>"/>
		<wtc:param   value="<%=deadflag%>"/>
	</wtc:service>
	<wtc:array id="rows">
	<%
		result=rows;
	%>
	</wtc:array>
	<%
	System.out.println("result.length="+result.length);
	if(result.length==0||result[0].length==0)
	{
%>
      <SCRIPT LANGUAGE="JavaScript">
       		 //	alert("无此服务号码的信息！");
       		 window.returnValue="0";
       		  window.close();
       		 
      </SCRIPT>
<%
	}
	else  if ( result.length==1 )
	{
%>      
	<SCRIPT LANGUAGE="JavaScript">

		window.returnValue="<%=result[0][0].trim()%>";
		window.close(); 		

	</SCRIPT>
<%
}
else
{
%>
<HTML><HEAD><TITLE><%=pageTitle%></TITLE>
	

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<script language="JavaScript">
window.returnValue='';

function selAccount()
{     
	for(i=0;i<document.form1.account.length;i++) 
	{		    
		if (document.form1.account[i].checked==true)
		{
			window.returnValue=document.form1.account[i].value;     
			break;
		}
	} 
	window.close(); 
}
</script>
</head>

<BODY>
<div id="operation">
<form name="form1" method="post" action="">
 	<div id="operation_table">
	<div class="list">
  <table>
    <tr> 
      <th>&nbsp; </th>
      <th> 虚拟号</th>
      <th> 品牌</th>
      <th> 客户名称</th>
      <th> 身份证类型</th>
      <th> 身份证号码</th>
      <th> 入网时间</th>
    </tr>
    <% 
	for(int i=0; i < result.length;i++)
	{
	%>
		<tr> 
		  <td>
			  <input type="radio" name="account" value="<%=result[i][0].trim()%>" onKeyDown="if(event.keyCode==13) selAccount()"  <%if (i==0) {%>checked<%}%>>
		  </td>
		  <td><%=result[i][0]%></td>
		  <td><%=result[i][1]%></td>
		  <td><%=result[i][2]%></td>
		  <td><%=result[i][3]%></td>
		  <td><%=result[i][4]%></td>
		  <td><%=result[i][5]%></td>
		 
		</tr>
  <%        
	}
  %>
  </table>
</div>
</div>
        
		 <div id="operation_button">
     <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
     <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
     </div>
</form>
</div>
</body>
</html>
<%}%>

