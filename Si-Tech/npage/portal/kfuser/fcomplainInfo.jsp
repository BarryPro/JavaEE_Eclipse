<%
   /*
   * 功能: 投诉情况
　 * 版本: v1.0
　 * 日期: 2008/09/19
　 * 作者: ranlf
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
    	<th>投诉情况</th>
			<th>投诉次数</th>
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


