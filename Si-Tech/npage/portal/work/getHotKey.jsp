<%
   /*
   * ����: ��ѯӪҵԱ��ݼ�
�� * �汾: v1.0
�� * ����: 2008��4��14��
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
	  String workNo = (String)session.getAttribute("workNo");
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
%>


<wtc:service name="s7012Sel" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />

	<div class="itemContent">
		<div id="form" align="center">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="list">
				<tr> 
					<th>��ݼ�</th>
					<th>����</th> 
				</tr>
<%

if(retCode.equals("000000"))
{
	for(int i=0;i<result.length;i++){
		String classes="";
		if(i%2==1){classes="grey";}
		//System.out.println("result["+i+"][0]=="+result[i][0]);
		//System.out.println("result["+i+"][2]=="+result[i][2]);
%>
				<tr>
					<td class="<%=classes%>" align="center"><b><span class="orange"><%=result[i][0]%></span></b></td>
					<td class="<%=classes%>" align="center"><%=result[i][2]%></td> 
				</tr>
<%
	}
}
else
{
out.println("<tr><td>��ȡ���ݴ���</td></tr>");
}
%>
		</table>
	</div>
</div>
     
     
<script>
	$("#wait1").hide();		   
</script>