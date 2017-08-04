<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 
   * 版本: 1.0
   * 日期: 2010/11/30
   * 作者: wanglm
   * 版权: si-tech
   * update: hejwa 2013年6月23日13:49:28 营销项目升级 
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%  
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
	String regionCode=(String)session.getAttribute("regCode");
	String[][] result = (String[][])request.getAttribute("result"); 
 
%>     
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>订单状态信息查询</TITLE>
</HEAD>
<script type="text/javascript" language="javascript">
	function gogo(){
	   window.location = "fd008.jsp";	
	}

function showMarkInfo(sysAccept,phoneNo){
		var h=610;
   	var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "showMarkInfo.jsp?sysAccept="+sysAccept+"&opCode=<%=opCode%>&phoneNo="+phoneNo;
		var ret=window.showModalDialog(path,"",prop);
}	
</script>
<body>
	<FORM method="post" name="form1" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    	<div id="title_zi">订单状态信息查询</div>
    </div>
    <table cellSpacing="0">
    	<th>订单行号</th>
    	<th>客户订单号</th>
    	<th>手机号码</th>
    	<th>状态名称</th>
    	<th>受理工号</th>
    	<th>受理流水</th>
    	<th>受理时间</th>
    	<th>更新时间</th>
    	<th>受理业务</th>
    	<%
    	    for(int i=0;i<result.length;i++){
    	%>
    	<tr>
    	  <td><%=result[i][0]%></td>	
				<td><%=result[i][8]%></td>	
    	  <td><%=result[i][1]%></td>	
    	  <td><%=result[i][2]%></td>	
    	  <td><%=result[i][3]%></td>
    	  	<td><a href="#" onclick="showMarkInfo('<%=result[i][4]%>','<%=result[i][1]%>')"><%=result[i][4]%></a></td>
    	  <td><%=result[i][5]%></td>
    	  <td><%=result[i][7]%></td>	
    	  <td><%=result[i][6]%></td>	
    	</tr>
    	<%
    	  }
    	%>
    	<tr>
			<td colspan="10" align="center" id="footer">
				<input class="b_foot" name="re"    type="button" onClick="gogo()" value="返回"/>
				<input class="b_foot" name="back"    type="button" onClick="removeCurrentTab()" value="关闭"/>
			</td>
		</tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
    		
    			