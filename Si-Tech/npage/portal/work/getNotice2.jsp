<%
   /*
   * 功能: 查询温馨提示
　 * 版本: v1.0
　 * 日期: 2008年7月11日
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人  shibc
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
%>

<wtc:service name="sIndexNote" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="2"/>
</wtc:service>
<wtc:array id="result" scope="end" />

	<div class="itemContent">
		<div id="form">
		    <table width="99%" border="0" cellpadding="0" cellspacing="0"  class="list">
<%
if(retCode.equals("000000"))
{
	for(int i=0;i<result.length;i++){
		String classes="";
		if(i%2==1){classes="grey";}
%>         
          <tr>
            <td class="<%=classes%>"><img src="../../../nresources/default/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> <a href="#this"><%=result[i][0]%></a> </td>
          </tr>
<%
	}
}
else
{
out.println("<tr><td>获取温馨提示失败</td></tr>");
}
%>
    </table>
		  </div>
		</div>
		
<script>
   $("#wait3").hide();		   
</script>		
		
		
		