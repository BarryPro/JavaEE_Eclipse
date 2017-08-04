<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/2/7 15:46:09]------------------
 关于下发电子化有价卡业务全网改造方案及上线计划的通知
 
 -------------------------后台人员：[liyang]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

	
	
%> 
 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}

function go_Query(){
	if(""==$("#ipt_CardNo").val().trim()){
		rdShowMessageDialog("请输入电子卡卡号");
	}
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
  
	<tr >
	    <td class="blue">电子卡卡号</td>
		  <td colspan="3">
					<input type="text" id="ipt_CardNo" name="ipt_CardNo"  />	
					<input type="button" class="b_foot" value="查询" onclick="go_Query()"            />		    
		  </td>
	</tr>
	 
</table>

<div class="title"><div id="title_zi">查询结果列表</div></div>
<table cellSpacing="0">
	<tr>
		<th>卡号</th>
		<th>面额</th>
		<th>卡业务类型</th> 
		<th>卡业务属性</th>
		<th>激活时间</th>
		<th>卡有效期</th>
		<th>卡状态</th>
		<th>充值号码</th>
		<th>被充值号码</th>
		<th>充值时间</th>
		<th>充值交易流水号</th>
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>