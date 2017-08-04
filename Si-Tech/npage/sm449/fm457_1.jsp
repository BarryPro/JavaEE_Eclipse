<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[]------------------
 
 
 -------------------------后台人员：[]--------------------------------------------
 
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
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">购卡手机号码</td>
		  <td width="35%" >
			     <input type="text" id="" name="" v_must="0" v_type="string"  onblur = "checkElement(this)"  />
			     <input type="button" class="b_text" value="查询" onclick="go_Query()"          />
		  </td>
		  
		  <td class="blue" width="15%">证件号码</td>
		  <td width="35%">
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">购卡数量</td>
		  <td width="35%">
		  </td>
		  <td class="blue" width="15%">购卡金额</td>
		  <td width="35%">
		  </td>
	</tr>

	<tr>
	    <td class="blue" width="15%">购卡时间</td>
		  <td width="35%">
		  </td>
		  <td class="blue" width="15%">操作工号</td>
		  <td width="35%">
		  </td>
	</tr>
	
		
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		
	 		<input type="button" class="b_foot" value="打印发票" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>