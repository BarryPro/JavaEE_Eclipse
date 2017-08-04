<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 营业厅状态实时展示 
   * 版本: 1.0
   * 日期: 2010/11/30
   * 作者: wanglm
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%  
    String opCode="b899";
	String opName="营业厅状态实时展示";
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String[][] result = (String[][])request.getAttribute("result"); 
%>     
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>营业厅状态实时展示</TITLE>
</HEAD>

<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">营业厅状态实时展示</div>
    </div>
    <table cellSpacing="0">
    	<th>业务类型</th>
    	<th>服务人数</th>
    	<th>等待人数</th>
    	<th>等待时间</th>
    	<th>平均服务时间</th>
    	<th>开放台席数</th>
    	<th>繁忙状态</th>
    	<th>展示时间</th>
    	<%
    	    for(int i=0;i<result.length;i++){
    	%>
    	<tr>
    	  <td><%=result[i][0]%></td>	
    	  <td><%=result[i][2]%></td>	
    	  <td><%=result[i][4]%></td>	
    	  <td><%=result[i][5]%></td>
    	  <td><%=result[i][7]%></td>
    	  <td><%=result[i][9]%></td>
    	  <td><%=result[i][12]%></td>	
    	  <td><%=result[i][13]%></td>
    	</tr>
    	<%
    	  }
    	%>
    	<tr>
			<td colspan="8" align="center" id="footer">
			<input class="b_foot" name="re"    type="button" onClick="javascript:history.go(-1);" value="返回"/>
			<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="关闭"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			