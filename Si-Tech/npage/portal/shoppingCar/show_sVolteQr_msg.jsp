<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[]------------------
 
 
 -------------------------后台人员：[]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml" >
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

  String msg        = WtcUtil.repNull(request.getParameter("msg"));
  String flag_m286  = WtcUtil.repNull(request.getParameter("flag_m286"));
%>  

<%@ page contentType="text/html;charset=GBK"%>
<HTML  style="overflow-y:hidden;overflow-x:hidden;  width:80%;height:80%"><HEAD><TITLE></TITLE>
<SCRIPT language=JavaScript>
	
$(document).ready(function(){
	var flag_m286 = "<%=flag_m286%>";
if("Y"==flag_m286){
	$("#tab_show_href").show();
}else{
	$("#tab_show_href").hide();
}
});	


function go_panrent_func(){
	window.returnValue="Y";  
	window.close();
}

</SCRIPT>
</HEAD>	
<BODY >
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header_pop.jsp" %>	


	<table>
		<tr>
			<td align="center"><%=msg%></td>
		</tr>
  </table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
			<input type="button" class="b_foot" value="关闭" onclick="window.close()"  /> 
	 	</td>
	</tr>
</table>


	<table id="tab_show_href">
		<tr>
			<td align="center" class="blue">
				<div style="color:blue;text-decoration:underline;"><a href="javascript:void(0)" onclick="go_panrent_func()"> volte开户</a></div>
			</td>
		</tr>
  </table>
  
<%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</BODY>
</HTML>