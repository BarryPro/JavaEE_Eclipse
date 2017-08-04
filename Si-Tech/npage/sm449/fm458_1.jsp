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
	    <td class="blue" width="15%">手机号码</td>
		  <td width="35%">
			     <input type="text" id="ipt_PhoneNo" name="ipt_PhoneNo" v_must="0" v_type="string"  onblur = "checkElement(this)"  />
		  </td>
		  <td class="blue" width="15%">业务流水</td>
		  <td>
			     <input type="text" id="ipt_TransactionID" name="ipt_TransactionID" v_must="0" v_type="string"  onblur = "checkElement(this)"  />
			    
		  </td>
	</tr>
	
	<tr>
	    <td class="blue" width="15%">电子卡卡号</td>
		  <td width="35%" colspan="3">
		  		<input type="text" id="ipt_CardNo" name="ipt_CardNo" v_must="0" v_type="string"  onblur = "checkElement(this)"  />
			    <input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
		  </td>
	</tr>	
	
</table>

<div class="title"><div id="title_zi">查询结果列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>购买时间</th>
        <th>操作工号</th>
        <th>数量</th>
        <th>面值</th>	
        <th>开始卡号</th>
        <th>结束卡号</th>	
        <th>卡类型</th>	
        <th>购买手机号</th>	
        <th>业务流水</th>	
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