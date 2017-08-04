

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%
	String groupName = WtcUtil.repNull(request.getParameter("groupName"));
	StringBuffer sqlStr = new StringBuffer();
	sqlStr.append("select GROUP_ID,GROUP_DESC from group_instance ");
	sqlStr.append("where group_type_id = 2 and GROUP_DESC like '%");
	sqlStr.append(groupName);
	sqlStr.append("%' and state='A' and exp_date>sysdate");
%>
<wtc:pubselect name="sPubSelect" outnum="2">
	<wtc:sql><%=sqlStr.toString()%></wtc:sql> 
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
System.out.println("####################################取得的群组数量===="+result.length);
%>

<%
 			if(retCode.equals("000000")){
 				if (result.length < 1)
					{
%>
				<script language="JavaScript">
					  rdShowMessageDialog("查询记录不存在");
				</script>
<%
				}else{
%>
		 
 			<table>
 				<tr>
	 				<th>选择</th>
	 				<th>群组标识</th>
	 				<th>群组名称</th>
 				</tr>
<%					
					for(int i=0;i<result.length;i++){
%>
 				<tr>
	 				<td><input type="radio" name="radio" onclick="haveChose(event)"><span style="display:none"><%=result[i][0]%></span></td>
	 				<td><%=result[i][0]%></td>
	 				<td><%=result[i][1]%></td>
 				</tr>
<%					
						}
%>
</table>
<%						
					}
 				}else{
%>
				<script language="JavaScript">
					  rdShowMessageDialog("查询记录出错");
				</script>
<%
	}
%>
 			
