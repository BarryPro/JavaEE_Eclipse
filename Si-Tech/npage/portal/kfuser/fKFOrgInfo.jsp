<%
   /*
   * 功能: 集团客户信息
　 * 版本: v1.0
　 * 日期: 2008/09/12
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期 2009-05-19     修改人  libina     修改目的  增加业务点击统计（报表）
 　*/
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
    	<th>集团名称</th>
			<th>集团联系人</th>
			<th>加入集团时间</th>
			<th>集团签约时间</th>
			<th>集团联系电话</th>
			<th>操作</th>
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
			<td >&nbsp;<a href="javaScript:getViwe();"><span class='orange'>[查看]</span></a></td>
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
