<%
  /*
   * ����: ��ѯ���̺�����Ϣ
�� * �汾: 2.0
�� * ����: 2009/03/05
�� * ����: liuyj
�� * ��Ȩ: sitech
   * �޸���:
   * �޸�ԭ��:
��*/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
	String workNo = (String)session.getAttribute("workNo");	
	String orgCode=(String)session.getAttribute("orgCode");   /*��������*/
	String password=(String)session.getAttribute("password");
	//String orgCode = (String)session.getAttribute("orgCode");
	String deadflag=request.getParameter("deadflag");       /*�Ƿ�����������־Y N*/
	String RegionCode=orgCode.substring(0,2);                /*���д���*/
	 opCode=request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");     /*����ҵ���ʶ��*/
	String pageTitle = "����������Ϣ��ѯ";
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
       		 //	alert("�޴˷���������Ϣ��");
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
      <th> �����</th>
      <th> Ʒ��</th>
      <th> �ͻ�����</th>
      <th> ���֤����</th>
      <th> ���֤����</th>
      <th> ����ʱ��</th>
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
     <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selAccount()">
     <input class="b_foot" type="button" name="return" value="����" onClick="window.close()">
     </div>
</form>
</div>
</body>
</html>
<%}%>

