<%
  /*
   * 功能: 查看选取营业厅的详细信息
   * 版本: 1.8.2
   * 日期: 2011/7/12
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
  String opName = "查看选取营业厅的详细信息";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String groupIds = WtcUtil.repNull(request.getParameter("groupIds"));
	String groupNames = WtcUtil.repNull(request.getParameter("groupNames"));
	String[] group_ids=groupIds.split(",");
	int len=group_ids.length;
	String[] group_names=groupNames.split(",");
%>
<html>
	<head>
		<title>选取营业厅的详细信息</title>
	</head>
<script type="text/javascript">

function reValue()
{
  window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">选取营业厅的详细信息</div>
	</div>
  <table id="dyntb" cellspacing="0">
    		<tr>	  			     		 	
        		<th nowrap align="center">	
        			营业厅代码
        		</th>
       	 	  <th nowrap align="center">
        			营业厅名称
        		</th>     	
      	</tr>
      	<%
      	if(len>0)
      	{
      		for(int i=0;i<len;i++)
      		{
		      	out.println("<tr> <td>"+group_ids[i]+"</td>");
		      	
		      	out.println("<td>"+group_names[i]+"</td></tr>");      		
      		}
      	}

      	%>
   </table>   		
   
    <table cellspacing="0">
    <tr>
    	<td colspan="2" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >
					&nbsp;
				<input name="colse" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>

<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
