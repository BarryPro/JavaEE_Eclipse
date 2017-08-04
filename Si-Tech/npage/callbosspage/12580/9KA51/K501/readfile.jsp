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
<%@ page contentType="text/html;charset=GBK"%>
<HTML>
	<%
		String path = request.getParameter("filename");		
	%>
	<HEAD>
			<base target="_self">
			<Script language="javascript">
			  var fso, f1, ts, s=" ";
			  var ForReading = 1;     
			  fso = new ActiveXObject("Scripting.FileSystemObject");     
			  ts = fso.OpenTextFile("<%=path %>", ForReading);
			  while(!ts.AtEndOfStream)
				{
				s += ts.ReadLine()+" ";
				}
			  window.returnValue = s;		      
			  ts.Close();
			  
			  function gohis(){
					document.sitechform.action="temporaryPhone.jsp";
					document.sitechform.submit();
				}		  
		  </script>
	</HEAD>
	<BODY>
		<form name="sitechform" action="" target=""><BR><BR><BR>
  	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
			<tr align="center">
				<td>导入成功</td>
			</tr>
			<tr align="center">
				<td>&nbsp;</td>
			</tr>
			<tr align="center">
				<td><input type="button" class="b_foot" value="上一步" onClick="gohis();">&nbsp;<input type="button" class="b_foot" value="关闭" onClick="window.close();"></td>
			</tr>
		</table>
	  </form>
	</BODY>	
</HTML>

