<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2016/11/3 15:54:39------------------
集团专线端到端系统工作流和工号问题优化需求
 
 
 -------------------------后台人员：zhangzhea--------------------------------------------
 
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


//查询动态展示IMEI号码列表
function go_Query(){
	if($("#unit_id").val().trim()==""){
		rdShowMessageDialog("请输入集团id");
		return;
	}
 	var pactket = new AJAXPacket("fm420_Query.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("unit_id",$("#unit_id").val().trim());
			pactket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
//查询动态展示IMEI号码列表，回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
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


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">集团id</td>
		  <td>
		  	<input type="text" id="unit_id" name="unit_id"   v_type="string"  onblur = "checkElement(this)"  />
		  	&nbsp;
		  	<input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
		  </td>
	</tr>
	
</table>

    
<div class="title"><div id="title_zi"><%=opName%>-查询结果列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="25%">商机代码</th>
        <th width="25%">操作工号</th>
        <th width="25%">子工作流商机代码</th>
        <th width="25%">子工作流操作工号</th>	
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