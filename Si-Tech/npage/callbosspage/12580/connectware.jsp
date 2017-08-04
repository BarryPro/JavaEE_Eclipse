<%
  /*
   * 功能: 转接商旅中心
　 * 版本: 1.0.0
　 * 日期: 2009/02/18
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
  <head>
		<script language="javascript">
			function connectphone(){
				//var top_button_calloutex=window.top.document.getElementById("K029");
				//top_button_calloutex.click(); 
			}
		</script>
  </head>
  
  <body>
    <form name="sitechform" id="sitechform">
    	<div id="Operation_Table">
    	<table cellspacing="0">
    		<tr align="center">
    			<th>转接号码<input type="text" name="cphone" value=""></th>	
    		</tr>
    		<tr align="center">
    			<td colspan="3"><input type="button" class="b_foot" value="转接" onClick="connectphone();" >&nbsp;<input type="button" class="b_foot" value="关闭" onClick="window.close();" ></td>
    		</tr>
    	</table>
    	</div>
    </form>
  </body>
</html>
