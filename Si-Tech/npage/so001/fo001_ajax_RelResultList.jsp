<%
   /*
   * ����: ��ֵ˰��˰��������Ϣ�б�
�� * �汾: v1.0
�� * ����: 2013-08-30
�� * ����: wangjxc	
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:  	
   * �޸���:
   * �޸�Ŀ��:
 ��*/
%>
 
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
		String  par_cust_id	     = (String)request.getParameter("par_cust_id");
		String  low_cust_id   = (String)request.getParameter("low_cust_id");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
%>

<wtc:service name="so001RelQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=par_cust_id%>"/>
	  <wtc:param value="<%=low_cust_id%>"/>
	  <wtc:param value="1"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>	


<div class="list">
		<table id="tbSort">
	<tr>
		<th>�ϼ��ͻ���ʶ</th>
		<th>�ϼ���˰��ʶ���</th>
		<th>�¼��ͻ���ʶ</th>
		<th>�¼���˰��ʶ���</th>
    	<th>����ʱ��</th>
    	<th>����</th>
	</tr>

	<% 
	if("000000".equals(retCode)){

			if(retList.length==0){
				out.println("<tr height='25' align='center'><td colspan='12'>");
				out.println("<font class='orange'>û���κμ�¼��</font>");
				out.println("</td></tr>");
			}else if(retList.length>0){
				for(int i=0;i<retList.length;i++){
				
				
	%>
   <tr>
		<td><%=retList[i][2]%></td>
		<td><%=retList[i][3]%></td>
		<td><%=retList[i][0]%></td>
		<td><%=retList[i][1]%></td>
		<td><%=retList[i][4]%></td>	
		<td>
			<input class="butDel" type="button" title="ɾ��" onClick="delTaxPayerRel(<%=retList[i][5]%>)"/>
		</td>
   </tr>
   <%
		
	}
   %>
</table>
</div>
	
	
<%	}}else{

		return;
	}
	%>
	<input type="hidden" name="retCode" id="retCode" value="<%=retCode%>" />
	<input type="hidden" name="retMsg" id="retMsg" value="<%=retMsg%>" />
	
