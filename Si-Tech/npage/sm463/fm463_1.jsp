
<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------duming 2017.4.5------------------
 关于对生僻字入网建立标签及增加一证多名提示的函
 
 
 -------------------------后台人员：xiahk--------------------------------------------
 
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
 



function go_Cfm(){
	
    var packet = new AJAXPacket("fm463_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo",$("#phoneNo").val());//
        packet.data.add("phone_type",$("#phone_type").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
	
}

function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息
    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg,0);
	    return;
    }else{//操作成功
    	rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}


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
	    <td class="blue" width="15%">号码类型</td>
		  <td width="35%" colspan="3">
		  	<select id="phone_type" name="phone_type" >
				    <option value="1">手机号码</option>
				    <option value="2">宽带账号</option>
				</select>
		  </td>
	</tr>
		
	<tr>
	    <td class="blue" width="15%">用户号码</td>
		  <td width="35%">
			    <input type="text"  name="phoneNo" id="phoneNo"   value="" />
		  </td>
		  
		  
	</tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确定" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
<%@ include file="/npage/include/public_smz_check.jsp" %>
</FORM>
</BODY>
</HTML>