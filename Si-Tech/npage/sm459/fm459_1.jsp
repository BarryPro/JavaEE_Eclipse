<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/2/28 20:21:43]------------------
 关于调整融合资费考核口径的请示
 
 -------------------------后台人员：[chenlina]--------------------------------------------
 
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

function go_query_unitProId(){
    var packet = new AJAXPacket("fm459_Qry.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("ipt_unitId",$("#ipt_unitId").val());//
        packet.data.add("sel_opType",$("#sel_opType").val());//
    core.ajax.sendPacket(packet,do_query_unitProId);
    packet =null;
}

function do_query_unitProId(packet){
    var error_code = packet.data.findValueByName("code");//返回代码
    var error_msg =  packet.data.findValueByName("msg");//返回信息


    if(error_code!="000000"){//调用服务失败
      rdShowMessageDialog(error_code+":"+error_msg);
      
      $("#div_iVpmnIdNo").hide();
	    $("#upgMainTab tr").remove();
	    
	    return;
	   
    }else{//操作成功
    	
    	$("#div_iVpmnIdNo").show();
    	$("#upgMainTab tr").remove();
    	
    	var iVpmnIdNoVal =  packet.data.findValueByName("iVpmnIdNoVal");//返回信息
    	$("#span_iVpmnIdNo").text(iVpmnIdNoVal);
    	var retArray =  packet.data.findValueByName("retArray");
    	
    	
    	
    	var trObjdStr = "";
    	for(var i=0;i<retArray.length;i++){
    		trObjdStr += "<tr>"+
									 		"	<td>"+
									 		"		<input type=\"radio\" name=\"idradio\" value=\""+retArray[i][0]+"\" />"+retArray[i][0]+
									 		"	</td>"+
											"</tr>";
    	}
    	if(trObjdStr!=""){
				$("#upgMainTab").append(trObjdStr);
			}
    }
}


function go_Cfm(){
		
		var iRHIdNoVal = $("#upgMainTab").find("input[type='radio']:checked").val();
		
		if(iRHIdNoVal=="undefined"||typeof(iRHIdNoVal)=="undefined"){
			rdShowMessageDialog("请选择要操作的智能V网产品");
			return;
		}
    var packet = new AJAXPacket("fm459_Cfm.jsp","请稍后...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("iVpmnIdNoVal",$("#span_iVpmnIdNo").text().trim());//
        packet.data.add("iRHIdNoVal",iRHIdNoVal);//
        packet.data.add("sel_opType",$("#sel_opType").val());//
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
	    <td class="blue" width="15%">集团编码</td>
		  <td width="35%">
		  	<input type="text" id="ipt_unitId" name="ipt_unitId" v_must="0" v_type="string" value=""   />
		  	<input type="button" class="b_text" value="查询"   onclick="go_query_unitProId()" />
		  </td>
		  
		  <td class="blue" width="15%">操作类型</td>
		  <td width="35%">
		  	<select id="sel_opType" name="sel_opType" onchange="">
				    <option value="0">绑定</option>
				    <option value="1">解绑</option>
				</select>
		  </td>
	</tr>
</table>
<div class="title" id="div_iVpmnIdNo" style="display:none"><div id="title_zi">智能网产品（<span id="span_iVpmnIdNo"></span>）对应的融合通信产品ID列表</div></div>
<table cellSpacing="0" id="upgMainTab">
	 	
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