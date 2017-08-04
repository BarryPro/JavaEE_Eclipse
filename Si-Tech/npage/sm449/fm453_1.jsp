<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2017/2/8 13:25:25-----------------
 关于下发电子化有价卡业务全网改造方案及上线计划的通知
 
 
 -------------------------后台人员：liyang--------------------------------------------
 
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

var COM_OPCODE = "";


$(document).ready(function(){
	$("#radio_<%=opCode%>").click();
	
});

function pub_set_radio(bt){
	$(bt).prev().click();
	
}
function show_p_div(bt,check_opcode){
	COM_OPCODE = check_opcode;
}

function go_Cfm(){
		if(!check(msgFORM)) return false;
    var packet = new AJAXPacket("ajaxGetServRe.jsp","请稍后...");
        packet.data.add("opCode",COM_OPCODE);//
        packet.data.add("ipt_BeginCardNo",$("#ipt_BeginCardNo").val());//
        packet.data.add("ipt_EndCardNo",$("#ipt_EndCardNo").val());//
    core.ajax.sendPacket(packet,do_Cfm);
    packet =null;
}
function do_Cfm(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息

    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//操作成功
	    rdShowMessageDialog("操作成功",2);
    	reSetThis();
    }
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<!----------------------------------------------公共部分-----------------开始----------------------------->
<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio" id="radio_m453"  value="m453" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m453')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m453·电子卡锁定</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m454"  value="m454" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m454'),sm454_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m454·电子卡解锁</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_m455"  value="m455" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'m455'),sm455_go_getImeiList()" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">m455·电子卡延期</span>
		
		</td>
	</tr>
</table>


<table cellSpacing="0">
	<tr>
		<td width="25%" class="blue">开始卡号：</td>
		<td><input type="text" id="ipt_BeginCardNo" name="ipt_BeginCardNo" v_must="1" v_type="string"  onblur = "checkElement(this)"  size="50"   /></td>
	</tr>
	<tr>
		<td width="25%" class="blue">结束卡号：</td>
		<td><input type="text" id="ipt_EndCardNo" name="ipt_EndCardNo" v_must="1" v_type="string"  onblur = "checkElement(this)"  size="50" /></td>
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
</FORM>
</BODY>
</HTML>