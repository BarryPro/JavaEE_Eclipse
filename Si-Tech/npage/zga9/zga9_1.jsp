<%
/********************
 -------------------------创建-----------张磊(zhangleij) 2015/9/6 10:45:50-------------------

 -------------------------后台人员：chenhu--------------------------------------------
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
	if($("#year_month").val().trim()==""){
		rdShowMessageDialog("请输入查询年月--YYYYMM");
		return;
	}	
	var packet = new AJAXPacket("zga9_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//
			packet.data.add("year_month",$("#year_month").val().trim());//
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
	<tr>
	    <td class="blue" width="11%">查询年月</td>
		  <td width="22%">
			    <input type="text" name="year_month" id="year_month" value="" maxlength="6" /> <font class="orange">*</font>
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

<div class="title"><div id="title_zi">话费红包信息查询结果</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>赠送集团编码</th>
        <th>集团名称</th>	
        <th>地市</th>
        <th>区县</th>
        <th>集团客服电话</th>	
        <th>红包资费名称</th>
        <th>红包个数</th>	
        <th>操作人电话</th>	
        <th>操作时间</th>	
    </tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
