<%
/********************
 
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  
       
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>



//查询动态展示IMEI号码列表
function go_query(){
	if($("#sInLoginAccept").val().trim()==""){
		rdShowMessageDialog("请输入流水");
		return;
	}
	
	var packet = new AJAXPacket("f1246_query_plresult.jsp","正在执行,请稍后...");
			packet.data.add("sInLoginAccept",$("#sInLoginAccept").val().trim());//opcode
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}
//查询动态展示IMEI号码列表，回调
function do_query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			var phone_type = packet.data.findValueByName("phone_type");
		
			
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<div class="title"><div id="title_zi">查询条件</div></div>
<TABLE cellSpacing="0"  >
    <tr>
        <td class="blue" width="20%">流水</td>
        <td  ><input type="input" id="sInLoginAccept"/>
        	<input type="button" class="b_foot" value="查询" onclick="go_query()"  />
        	</td>
    </tr>
</table>

<div class="title"><div id="title_zi">结果列表</div></div>
<TABLE cellSpacing="0"  id="upgMainTab">
    <tr>
        <th width="20%">服务号码</th>
        <th>处理结果</th>
    </tr>
</table>
 

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="返回" onclick="history.go(-1)"  /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>