<%
   /*
   * ����: Ͷ�߽���
�� * �汾: v1.0
�� * ����: 2008/09/19
�� * ����: ranlf
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����:2009/04/30      �޸���:libina      �޸�Ŀ��:��ʾ����ʷͶ�߼�¼��Ҫ������ʱ�䵹������
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
		String phoneNo  = (String)session.getAttribute("activePhone");
		String workNo = (String)session.getAttribute("workNo");
		String sqlStr = "select r.access_name acName,r.class_name className,r.case_content caContent,r.status_name stName,r.accept_time acTime,r.accept_no acNo from workflow.case_rec r where r.phone_no = '?' order by r.accept_time desc";
%>
<wtc:pubselect name="sPubSelect" outnum="6">
	 <wtc:sql><%=sqlStr%></wtc:sql>
	 <wtc:param value="<%=phoneNo%>"/>
</wtc:pubselect>
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
					<div class="table_biaoge" style="overflow-x:auto">
	<table width="150%" class="ctl" cellpadding="0" cellspacing="0">
  	<tr> 
  		<th width="15%">��    ˮ</th>
    	<th width="15%">Ͷ������</th>
			<th width="15%">��������</th>
			<th width="15%">Ͷ������</th>
			<th width="15%">����״̬</th>
			<th width="45%">����ʱ��</th>
			
	  </tr>

	  <wtc:iter id="rows" indexId="i" >        
	  <tr align="center">
	  	<td title="<%=rows[5]%>"><a target="_blank" href="http://10.208.199.4:27001/workflow/pages/workflow/query/detailquery/queryOperater.do?method=show&acceptNo=<%=rows[5]%>&login_no=<%=workNo%>">[<%=rows[5]%>]</a></td>
			<td title="<%=rows[0]%>"><%=rows[0].equals("")?"&nbsp;":rows[0]%></td>
			<td title="<%=rows[1]%>"><%=rows[1].equals("")?"&nbsp;":rows[1]%></td>
			<td title="<%=rows[2]%>"><div style="width:5em; line-height:1em; text-overflow:ellipsis; white-space:nowrap; overflow:hidden; "><%=rows[2].equals("")?"&nbsp;":rows[2]%></div></td>
			<td title="<%=rows[3]%>"><%=rows[3].equals("")?"&nbsp;":rows[3]%></td>
			<td title="<%=rows[4]%>"><%=rows[4].equals("")?"&nbsp;":rows[4]%></td>
		</tr>
   </wtc:iter>
     </table>
	 </div>
        </div>

