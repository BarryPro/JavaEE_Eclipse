<%
   /*
   * ����: ��ѯ�û�EMEI��Ϣ
�� * �汾: v1.0
�� * ����: 2008/07/10
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
     String password = (String)session.getAttribute("password");
     String phoneNo  = (String)session.getAttribute("activePhone");
     
%>

<wtc:service name="sAccuGetImei"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="6">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="K081"/>
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<wtc:service name="sAccuGetArpu"  routerKey="phone" routerValue="<%=phoneNo%>" outnum="37">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="K081"/>
	<wtc:param value="<%=phoneNo%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

<div id="content">
	<table cellpadding="0" cellspacing="0" class="ctl">
		<tr class="jiange">
  	  <td width=30%><b>IMEI��Ϣ</b></td>
  	  <td width=70%>&nbsp;</td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>IMEI��Ϣ</td>
  	  <td width=70%><%=result[0][2].equals("")?"&nbsp;":result[0][2]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>�ֻ�Ʒ�ƣ�</td>
  	  <td><%=result[0][3].equals("")?"&nbsp;":result[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>�ֻ��ͺţ�</td>
  	  <td><%=result[0][4].equals("")?"&nbsp;":result[0][4]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>�ֻ����ܣ�</td>
  	  <td title="<%=result[0][5]%>"><%=result[0][5].equals("")?"&nbsp;":result[0][5]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%><b><%=rows[0][2]%>������Ϊ</b></td>
  	  <td width=70%>&nbsp;</td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>ARPU��</td>
  	  <td width=70%><%=rows[0][3].equals("")?"&nbsp;":rows[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>����ѣ�</td>
  	  <td><%=rows[0][3].equals("")?"&nbsp;":rows[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>�����ѣ�</td>
  	  <td><%=rows[0][4].equals("")?"&nbsp;":rows[0][4]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>��Ե���ŷѣ�</td>
  	  <td width=70%><%=rows[0][5].equals("")?"&nbsp;":rows[0][5]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>GPRS���ã�</td>
  	  <td><%=rows[0][6].equals("")?"&nbsp;":rows[0][6]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>������Ϣ�ѣ�</td>
  	  <td><%=rows[0][7].equals("")?"&nbsp;":rows[0][7]%></td>
  	</tr>
   <tr class="jiange">
  	  <td width=30%>����ͨ�ŷѣ�</td>
  	  <td width=70%><%=rows[0][8].equals("")?"&nbsp;":rows[0][8]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>������Ϣ�ѣ�</td>
  	  <td><%=rows[0][9].equals("")?"&nbsp;":rows[0][9]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>����������Ϣ�ѣ�</td>
  	  <td><%=rows[0][10].equals("")?"&nbsp;":rows[0][10]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>����WAP��Ϣ�ѣ�</td>
  	  <td width=70%><%=rows[0][11].equals("")?"&nbsp;":rows[0][11]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>USSD����ʹ�÷ѣ�</td>
  	  <td><%=rows[0][12].equals("")?"&nbsp;":rows[0][12]%></td>
  	</tr>
  </table>
</div>
