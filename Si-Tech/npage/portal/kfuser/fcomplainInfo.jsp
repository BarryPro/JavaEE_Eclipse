<%
   /*
   * ����: Ͷ�����
�� * �汾: v1.0
�� * ����: 2008/09/19
�� * ����: ranlf
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
		String phoneNo  = (String)session.getAttribute("activePhone");
		String sqlStr = " select class_name,count(class_code) from workflow.case_rec  where phone_no = '" + phoneNo + "' group by class_name   ";
	  String param2 = "phone=13835174001" ;  
%>
<wtc:pubselect name="sPubSelect" outnum="2">
	 <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div  id="form">
					<div class="table_biaoge">
	<table width="100%" cellpadding="0" cellspacing="0">
  	<tr> 
    	<th>Ͷ�����</th>
			<th>Ͷ�ߴ���</th>
	  </tr>
	  <wtc:iter id="rows" indexId="i" >        
	  <tr align="center">
			<td title="<%=rows[0]%>"><%=rows[0].equals("")?"&nbsp;":rows[0]%></td>
			<td title="<%=rows[1]%>"><%=rows[1].equals("")?"&nbsp;":rows[1]%></td>
		</tr>
   </wtc:iter>

     </table>
	 </div>
        </div>


