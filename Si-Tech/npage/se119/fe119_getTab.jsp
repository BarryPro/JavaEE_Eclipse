<%
/********************
 * version v2.0
 * ������: si-tech
 * update by wanglm 
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  
<%
	String loginNo = request.getParameter("loginNo");
	String workNo = (String)session.getAttribute("workNo");
	String passWord = (String)session.getAttribute("passWord");
	String groupId = (String)session.getAttribute("groupId");
	String regionCode=(String)session.getAttribute("regCode");
%>
	<wtc:service name="se119Qry" routerKey="region" routerValue="<%=regionCode%>" 
			 retcode="retCode" retmsg="retMsg" outnum="8">
				<wtc:param value="0"/>
				<wtc:param value="01"/>
				<wtc:param value="e119"/>
				<wtc:param value="<%=workNo%>"/>
				<wtc:param value="<%=passWord%>"/>
				<wtc:param value=""/>
				<wtc:param value=""/>
				<wtc:param value="<%=groupId%>"/>
				<wtc:param value="<%=loginNo%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>  
		
	<table id="tab2">
	<tr>
	<th class='blue' nowrap>����</th>
	<th class='blue' nowrap>��������</th>
	<th class='blue' nowrap>����</th>
	<th class='blue' nowrap>��ɫ���������</th>
	<th class='blue' nowrap>��Ч��</th>
	<th class='blue' nowrap>�ʷ�Ȩ��</th>
	<th class='blue' nowrap>�ʷ�Ȩ������</th>
	<th class='blue' nowrap>����ʱ��</th>
	</tr>
	
   <%
   
    if(retCode.equals("000000") && result.length > 0){
       for(int i=0;i<result.length;i++){
          %>
            <tr>
            	<td><%=result[i][0]%></td>
            	<td><%=result[i][1]%></td>
            	<td><%=result[i][2]%></td>
            	<td><%=result[i][3]%></td>
            	<td>
            	<%
            		if ("0".equals(result[i][4])) {
            			%>
            			��Ч
            			<%
            		} else if ("1".equals(result[i][4])) {
            			%>
            			��Ч
            			<%
            		}
            	%>
            	</td>
            	<td><%=result[i][5]%></td>
            	<td><%=result[i][6]%></td>
            	<td><%=result[i][7]%></td>
            </tr>
            	<input type="hidden" name="code" id="code" value="<%=retCode%>" />
            	<input type="hidden" name="msg" id="msg" value="<%=retMsg%>" />
          <%
       }
    }else{
    	%>
            	<input type="hidden" name="code" id="code" value="<%=retCode%>" />
            	<input type="hidden" name="msg" id="msg" value="<%=retMsg%>" />
    	<%
    }
	%>
</table>


	    
		