<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=GBK" %>

<%

String workNo = (String)session.getAttribute("workNo");
String org_code = (String)session.getAttribute("orgCode");
String regionCode=org_code.substring(0,2);
String sPOSpecNumber = request.getParameter("sPOSpecNumber");
System.out.println("sPOSpecNumber:"+sPOSpecNumber);
%>
<div id="form">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		<form id="bug_form" method="post" action="">
	      <tr>	        
	      	<th width="25%" nowrap>业务开放省代码</th>
	        <th width="75%" nowrap>业务开放省名称</th>
	      </tr>
<wtc:service name="s9100DetQry" outnum="6" routerKey="region" routerValue="<%=regionCode%>">	
	<wtc:param value="<%=sPOSpecNumber%>"/>
  <wtc:param value="4"/>
</wtc:service>
<wtc:array id="result" start="2" length="4" scope="end" />
<%
if(retCode.equals("000000")){
	if(result.length>0){
		for(int i=0;i<result.length;i++){		
%>
  			  <tr>					
					  <td class=p_HasITDept><%=result[i][1]%>&nbsp;
					  </td>
					  <td class=p_FeeCase><%=result[i][2]%>&nbsp;
					  </td>
	        </tr>
<%
    }
  }
}
%>
		</form>
	</table>
</div>
<script>
$("#wait0").hide();
</script>
