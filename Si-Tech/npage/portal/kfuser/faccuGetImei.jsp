<%
   /*
   * 功能: 查询用户EMEI信息
　 * 版本: v1.0
　 * 日期: 2008/07/10
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
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
  	  <td width=30%><b>IMEI信息</b></td>
  	  <td width=70%>&nbsp;</td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>IMEI信息</td>
  	  <td width=70%><%=result[0][2].equals("")?"&nbsp;":result[0][2]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>手机品牌：</td>
  	  <td><%=result[0][3].equals("")?"&nbsp;":result[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>手机型号：</td>
  	  <td><%=result[0][4].equals("")?"&nbsp;":result[0][4]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>手机功能：</td>
  	  <td title="<%=result[0][5]%>"><%=result[0][5].equals("")?"&nbsp;":result[0][5]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%><b><%=rows[0][2]%>消费行为</b></td>
  	  <td width=70%>&nbsp;</td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>ARPU：</td>
  	  <td width=70%><%=rows[0][3].equals("")?"&nbsp;":rows[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>月租费：</td>
  	  <td><%=rows[0][3].equals("")?"&nbsp;":rows[0][3]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>语音费：</td>
  	  <td><%=rows[0][4].equals("")?"&nbsp;":rows[0][4]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>点对点短信费：</td>
  	  <td width=70%><%=rows[0][5].equals("")?"&nbsp;":rows[0][5]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>GPRS费用：</td>
  	  <td><%=rows[0][6].equals("")?"&nbsp;":rows[0][6]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>彩信信息费：</td>
  	  <td><%=rows[0][7].equals("")?"&nbsp;":rows[0][7]%></td>
  	</tr>
   <tr class="jiange">
  	  <td width=30%>彩信通信费：</td>
  	  <td width=70%><%=rows[0][8].equals("")?"&nbsp;":rows[0][8]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>彩铃信息费：</td>
  	  <td><%=rows[0][9].equals("")?"&nbsp;":rows[0][9]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>梦网短信信息费：</td>
  	  <td><%=rows[0][10].equals("")?"&nbsp;":rows[0][10]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td width=30%>梦网WAP信息费：</td>
  	  <td width=70%><%=rows[0][11].equals("")?"&nbsp;":rows[0][11]%></td>
  	</tr>
  	<tr class="jiange">
  	  <td>USSD短信使用费：</td>
  	  <td><%=rows[0][12].equals("")?"&nbsp;":rows[0][12]%></td>
  	</tr>
  </table>
</div>
