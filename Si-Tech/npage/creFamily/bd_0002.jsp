<%
   /*
   *�ͻ�������Ϣ����ҳ��,gCustId�ȱ���Ҫ��Ҫ���õ�ҳ���ȶ���
   *
   */
%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<!--ȡ�ͻ�������Ϣ-->
<%
	String bd0002_orgCode = (String)session.getAttribute("orgCode");
	String bd0002_regionCode = bd0002_orgCode.substring(0,2);
%>
<wtc:utype name="sQBasicInfo" id="retBd0002" scope="end"  routerKey="region" routerValue="<%=bd0002_regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>
<%
String bd0002_retCode =retBd0002.getValue(0);
String bd0002_retMsg  =retBd0002.getValue(1);

String custName="";//�ͻ�����
String belongCity="";//��������
String custLevel="";//�ͻ�����
String linkmanName="";//��ϵ������
String bd0002_status="";//����״̬
String nationName = ""; //����
String agent_idType="";//֤������
String agent_idNo="";//֤������
String agent_phone="";//��ϵ�绰
String ba0002_black="";//������
		
if(bd0002_retCode.equals("0"))
{
	custName   =retBd0002.getValue("2.0");
	belongCity =retBd0002.getValue("2.1") == null ? "" : retBd0002.getValue("2.1");
	custLevel  =retBd0002.getValue("2.2");
	linkmanName=retBd0002.getValue("2.3");
	bd0002_status=retBd0002.getValue("2.4") == null ? "" : retBd0002.getValue("2.4");
	nationName =retBd0002.getValue("2.5");
	agent_idType =retBd0002.getValue("2.6");
	agent_idNo =retBd0002.getValue("2.7");
	agent_phone =retBd0002.getValue("2.8");
	ba0002_black =retBd0002.getValue("2.9");
	
}
%>


<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td class="blue" width="15%">�ͻ����� </td>
   			<td width="18%">
   				<span style="cursor:pointer;color:#ff9900" onclick="window.showModalDialog('/npage/common/qcommon/bd_0001.jsp?gCustId=<%=gCustId%>&opName=�ͻ���ϸ��Ϣ','dialogHeight=700px','dialogWidth=650px','help=no','status=no')"><%=custName%></span>
   				<input type="hidden" name="custNameforsQ046" value="<%=custName%>">
   				<%
   				if(ba0002_black.equals("N"))
   				{
   					//out.println("(�Ǻ�����)");
   				}else
   				{
   					out.println("(������)");
				%>
					<script>
						rdShowMessageDialog("�ÿͻ����ں������ͻ�");
					</script>
				<%
   				}
   				%>
   			</td>
   			<td  class="blue" width="15%">����</td>
   			<td width="18%"><%=nationName%></td> 
   			<td  class="blue" width="15%">��ϵ�� </td>
   			<td><%=linkmanName%></td>
   		</tr>
   	  <tr>
   			<td  class=blue>�ͻ����� </td>
   			<td ><%=custLevel%></td> 
   	  	<td  class=blue>����״̬</td>
   			<td><%=bd0002_status%></td>   
   	    <td  class=blue>�������� </td>
   			<td><%=belongCity%></td>
   	  </tr>
   	  	<input type="hidden" name="idType_0002" value="<%=agent_idType%>"/>
   	  </tr>
	</table>
</div>
 