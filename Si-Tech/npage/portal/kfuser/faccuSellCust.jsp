<%
   /*
   * 功能: 营销活动
　 * 版本: v1.0
　 * 日期: 2008/05/22
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
     String workNo = (String)session.getAttribute("workNo");
     String password = (String)session.getAttribute("password");
     String phoneNo  = (String)session.getAttribute("activePhone");
     String org_code = (String)session.getAttribute("orgCode");
		 String regionCode=org_code.substring(0,2);
		 String district_code = org_code.substring(2,4);
		 String vProfile = regionCode + "," + district_code;
		 String chncode = "03";
		 String op_cmd = "K081";
%>
<wtc:service name="sAccuSellCust" outnum="17" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=password%>"/>
	<wtc:param value="<%=op_cmd%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=chncode%>"/>
	<wtc:param value="<%=vProfile%>"/>
</wtc:service>
<wtc:array id="result" start="3" length="2" scope="end" />
	<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
<link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">

	
	
<div  id="form">
	<div class="table_biaoge" style="overflow-x:auto">
		<table width="100%" class="ctl" cellpadding="0" cellspacing="0">
			<tr> 
				<th>活动名称</th>
				<th>时间</th>
			</tr>
<%
		for(int i=0;i<result.length;i++){
			String classes="";
			if(i%2==1){classes="grey";}
%>
			<tr> 
				<td class="<%=classes%>" title="<%=result[i][0]%>"><%=result[i][0].equals("")?"&nbsp;":result[i][0]%></td>
				<td class="<%=classes%>" title="<%=result[i][1]%>"><%=result[i][1].equals("")?"&nbsp;":result[i][1]%></td>
			</tr>
<%		
		}
%>			
		</table>
	</div>
</div>	
