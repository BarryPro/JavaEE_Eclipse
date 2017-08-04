<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015/4/2 15:03:18-------------------

 -------------------------后台人员：haoyy--------------------------------------------
 
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
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>


//重置刷新页面
function reSetThis(){
	  location = location;	
}

function query(){
	if($("#iUnitId").val().trim()==""){
		rdShowMessageDialog("请输集团编码");
		return;
	}
	
	 if(forNonNegInt(msgFORM.iUnitId) == false || $("#iUnitId").val().length!=10){
     msgFORM.iUnitId.value = "";
     rdShowMessageDialog("集团ID必须是10位数字！");
     return false;
   }
        
	var packet = new AJAXPacket("fm250_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("iUnitId",$("#iUnitId").val().trim());//opcode
			core.ajax.sendPacket(packet,doQuery);
			packet = null; 
}
//查询动态展示IMEI号码列表，回调
function doQuery(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				trObjdStr += "<tr>"+
												 "<td>"+retArray[i][0]+"</td>"+ 
												 "<td>"+retArray[i][1]+"</td>"+ 
												 "<td>"+retArray[i][2]+"</td>"+ 
												 "<td>"+retArray[i][3]+"</td>"+ 
												 "<td>"+retArray[i][4]+"</td>"+ 
												 "<td>"+retArray[i][5]+"</td>"+ 
												 "<td>"+retArray[i][6]+"</td>"+ 
												 "<td><input type=\"button\" value=\"冲正\" class=\"b_text\" onclick=\"reversal('"+retArray[i][0]+"','"+retArray[i][1]+"','"+retArray[i][2]+"')\"></td>"+
										 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

//冲正函数
function reversal(iGrpId,iAcceptCode,iFieldCode){
	var packet = new AJAXPacket("fm250_3.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("iGrpId",iGrpId);
			packet.data.add("iAcceptCode",iAcceptCode);
			packet.data.add("iFieldCode",iFieldCode);
			core.ajax.sendPacket(packet,doReversal);
			packet = null; 
}

function doReversal(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg  = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			rdShowMessageDialog("冲正成功",2);
			query();
	}else{
		  rdShowMessageDialog("冲正失败，"+code+"："+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" >集团编码</td>
		  <td>
			    <input type="text" name="iUnitId" id="iUnitId" value="" maxlength="10"/> 
		  </td>
	</tr>
</table>


<div class="title"><div id="title_zi">流量包列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="10%">产品ID</th>
        <th width="10%">购买流水</th>
        <th width="10%">流量包代码</th>
        <th width="20%">流量包名称</th>	
        <th width="10%">购买数量</th>
        <th width="10%">购买金额</th>
        <th width="20%">购买时间</th>
        <th width="10%">操作</th>	
    </tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="query()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>