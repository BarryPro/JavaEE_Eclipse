<%
   /*
   * ����: ���ſͻ���Ϣ
�� * �汾: v1.0
�� * ����: 2008/09/12
�� * ����: wuln
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸����� 2009-05-19     �޸���  libina     �޸�Ŀ��  ����ҵ����ͳ�ƣ�����
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%    
     String phoneNo  = (String)session.getAttribute("activePhone");
     String workNo = (String)session.getAttribute("workNo");
     System.out.println("***************************"+workNo);
%>   
<wtc:service name="sKFOrgInfo_new" outnum="14" routerKey="phone" routerValue="<%=phoneNo%>">
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
	<div class="table_biaoge">
	<table width="100%" class="ctl" cellpadding="0" cellspacing="0">
  	<tr> 
    	<th>��������</th>
			<th>������ϵ��</th>
			<th>���뼯��ʱ��</th>
			<th>����ǩԼʱ��</th>
			<th>������ϵ�绰</th>
			<th>����</th>
	  </tr>	
	<%
	  if(retCode.equals("000000"))
	  {
	%>
	 <wtc:iter id="rows" indexId="i" >              
	  <tr align="center">
			<td class="" title="<%=rows[0]%>"><%=rows[0].equals("")?"&nbsp;":rows[0]%></td>
			<td class="" title="<%=rows[1]%>"><%=rows[1].equals("")?"&nbsp;":rows[1]%></td>
			<td class="" title="<%=rows[2]%>"><%=rows[2].equals("")?"&nbsp;":rows[2]%></td>
			<td class="" title="<%=rows[3]%>"><%=rows[3].equals("")?"&nbsp;":rows[3]%></td>
			<td class="" title="<%=rows[4]%>"><%=rows[4].equals("")?"&nbsp;":rows[4]%></td>
			<td >&nbsp;<a href="javaScript:getViwe();"><span class='orange'>[�鿴]</span></a></td>
		</tr>
	   </wtc:iter>
<%
  }
%>
     </table>
	 </div>
        </div>
<script>

function getViwe(){
				window.open('<%=request.getContextPath()%>/npage/portal/kfuser/fKFOrgInfoDetail.jsp?workNo=<%=workNo%>');
}
</script>
