<%
  /*
   * 功能: 临时导入号码
　 * 版本: 1.0.0
　 * 日期: 2009/02/16
　 * 作者: libin
　 * 版权: sitech
   * update:
　 */
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<html>
  <head>
  	<base target="_self">
  	
		<script language="javascript">
			function gohis(){
				document.sitechform.action="plCh.jsp";
				
				document.sitechform.submit();
			}
			function guidephone(){
				var path = document.sitechform.filename.value;
				
				document.sitechform.action="readfile.jsp?path="+path;
				document.sitechform.submit();
			}
		</script>
		
  </head>
  
  <body>
  	<form name="sitechform" action="" target=""><BR><BR><BR><BR>
  		<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
  			<tr align="center">
  				<td><input name="filename" type="file"><BR>
  					<font color="orange" size="2">
  						txt文件格式，格式内容如：<BR>
							13412345678<BR>
							13512345678<BR>
							13612345678<BR>
							13712345678<BR>
						</font>
					</td>
  			</tr>
  			<tr align="center">
  				<td>&nbsp;</td>
  			</tr>
  			<tr align="center">
  				<td><input type="button" class="b_foot" value="上一步" onClick="gohis();">&nbsp;<input type="button" class="b_foot" value="确定" onClick="guidephone();">&nbsp;<input type="button" class="b_foot" value="取消" onClick="window.close();"></td>
  			</tr>
  		</table>
  	</form>    
  </body>
</html>
