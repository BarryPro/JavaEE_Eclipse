<%
/********************
 
 -------------------------创建-----------何敬伟(hejwa) 2015/3/18 17:10:31-------------------
核心业务逻辑设计：
1、新增行业应用流量包查询功能，该功能在boss前台使用同时也提供给客服系统使用。查询条件：手机号码
查询结果：赠送集团编码、地市、区县、集团客服电话（可能为空）、流量包资费名称，流量包个数、资费开始时间，资费结束时间，操作人电话，操作时间，操作渠道（网站或集团客户流量平台）
2、查询功能不需要提供手机号码的服务密码，查询记录为当前生效以及预约生效的流量包资费信息，同时按照资费生效时间倒叙排列展示。
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
 
//查询集团信息查询
function doQuery(){
	
	if($("#phoneNo").val().trim()==""){
		rdShowMessageDialog("请输入手机号码");
		return;
	}
	
	var packet = new AJAXPacket("fm248_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//
			core.ajax.sendPacket(packet,doAjaxGetAndroidCrmUpgList);
			packet = null; 
}
//查询集团信息查询，回调
function doAjaxGetAndroidCrmUpgList(packet){
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
												 "<td>"+retArray[i][0]+"</td>"+ 
												 "<td>"+retArray[i][1]+"</td>"+ 
												 "<td>"+retArray[i][2]+"</td>"+ 
												 "<td>"+retArray[i][3]+"</td>"+ 
												 "<td>"+retArray[i][4]+"</td>"+ 
												 "<td>"+retArray[i][5]+"</td>"+ 
												 "<td>"+retArray[i][6]+"</td>"+ 
												 "<td>"+retArray[i][7]+"</td>"+ 
												 "<td>"+retArray[i][8]+"</td>"+ 
												 "<td>"+retArray[i][9]+"</td>"+ 
												 "<td>"+retArray[i][10]+"</td>"+ 
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
<div class="title"><div id="title_zi">查询条件</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="11%">手机号码</td>
		  <td width="22%">
			    <input type="text" name="phoneNo" id="phoneNo" value="" maxlength="11" /> <font class="orange">*</font>
		  </td>
	</tr>
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">集团信息查询结果</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>赠送集团编码</th>
        <th>地市</th>
        <th>区县</th>
        <th>集团客服电话</th>	
        <th>流量包资费名称</th>
        <th>每月获赠流量包个数</th>	
        <th>资费开始时间</th>	
        <th>资费结束时间</th>	
        <th>操作人电话</th>	
        <th>操作时间</th>	
        <th>操作渠道</th>	
    </tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>