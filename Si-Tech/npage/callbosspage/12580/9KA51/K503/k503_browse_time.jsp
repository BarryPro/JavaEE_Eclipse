<%
  /*
   * ����: 12580ԤԼ����ʱ����
�� * �汾: 1.0.0
�� * ����: 2009/02/18
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>

<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<html>
  <head>
		
		<%
			String serial_no = (String)request.getParameter("serial_no");
			String[][] dataRows = new String[][] {};
		%>
  </head>
  
  <body>
    	<div id="Operation_Table">

				<div class="title">

					ʱ����

				</div>
    	<table cellspacing="0">
    		<tr align="center">
    			<th>���</th>
    			<th>ʱ��(����)</th>
    		</tr>
    		<%
    			String sql = "select interval from DPRESERVICETIME where serial_no = '"+serial_no+"' order by order_no";    			
	    	%>
	    	<wtc:service name="s151Select" outnum="2">
					<wtc:param value="<%=sql %>"/>
				</wtc:service>
				<wtc:array id="queryList"  scope="end"/>
				<%
					if(queryList.length > 0){
						
						dataRows = queryList;
						
						for(int i = 0; i < dataRows.length; i++){
				%>
				<tr align="center">
	    		<td>��<%=i+1 %>��~��<%=i+2 %>��</td><td><%=dataRows[i][0] %></td>	    		
	    	</tr>
				<%			
						}
				  					  	
				  }
				%>
    		<tr align="center">
    			<td colspan="2"><input type="button" class="b_foot" value="�ر�" onClick="window.close();"></td>    			
    		</tr>
    	</table>
    	</div>
  </body>
</html>
