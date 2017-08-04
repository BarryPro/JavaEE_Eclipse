<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 人工转自动-转业务咨询维护结点数据
　 * 版本: 1.0.0
　 * 日期: 2009/08/07
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient"%>
<%@page import="java.util.HashMap"%>
<%@ include file="/npage/callbosspage/public/hashlisttoarray.jsp" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String sceid =  request.getParameter("sceid");
String accesscode =  request.getParameter("accesscode"); 
String ycitycode =  request.getParameter("citycode"); 
String digitcode =  request.getParameter("digitcode");
String[][] rows = new String[][]{};  
String[][] citycode = new String[][]{}; 
 
		HashMap pMap=new HashMap();
				pMap.put("vsceid", sceid);
 		List queryList =(List)KFEjbClient.queryForList("query_k189_modifysceTrans",pMap);     
    	rows = getArrayFromListMap(queryList ,0,12);  
 
  		List queryList1 =(List)KFEjbClient.queryForList("query_k189_modifysceTrans_2",pMap);     
    	citycode = getArrayFromListMap(queryList1 ,0,2);  
 
%>

 
	
<html>
<head>
<title>修改业务咨询结点数据</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  * 
  */
function modifysceTrans(){
	 
		 //add  by yinzx 20091120 备注输入过长 错误
			var	obj_note_value= document.all.messegecontent.value ;
	 		var note_length=obj_note_value.replace(/[^\x00-\xff]/g,"**").length;
	 		if(note_length>1350)
	 		{
	 			rdShowMessageDialog("输入的短信内容长度过长，请重新输入！");
	 			return false;
			}	
			
	var xinval="";
	var yinval="";
  
	for(var i=0;i<6;i++)
	{
			 xinval+=$("input")[i].value+",";
			 
  }
  xinval+= $("textarea")[0].value;
   
  for(var i=0;i<1;i++)
	{
			 yinval+=$("select")[i].value+",";
  }
   
	var packet = new AJAXPacket("k189_sceTrans_rpc.jsp","...");
	packet.data.add("retType","modifysceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("addvalyin" ,yinval);
	packet.data.add("sceid" ,"<%=sceid%>");
	packet.data.add("accesscode" ,"<%=accesscode%>");
	packet.data.add("citycode" ,"<%=ycitycode%>");
	packet.data.add("digitcode" ,"<%=digitcode%>");


	
	core.ajax.sendPacket(packet,doProcessmodsceTrans,true);
	packet=null;
}

/**
  *返回处理函数
  */
function doProcessmodsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("修改业务咨询结点数据成功！");	
		opener.document.location.replace("k189_Main.jsp");	
    closeWin();
   
	} else {
		rdShowMessageDialog("修改业务咨询结点数据失败！");

	}
}

// 清除表单记录
function genid(){
		var ACCESSCODE = document.getElementById("ACCESSCODE").value;
  	var city_code = document.getElementById("city_code").value;
  	var user_class = document.getElementById("user_class").value;
  	var DIGITCODE = document.getElementById("DIGITCODE").value;
  	
  		document.sitechform.ID.value = ACCESSCODE + city_code+user_class+DIGITCODE;
  		document.sitechform.SUPERID.value = document.sitechform.ID.value.substr( 0,document.sitechform.ID.value.length -1);

}

// 清除表单记录
function cleanValue(){
  
}

function closeWin(){
	window.close();
}

function initValue(){

}

</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">修改业务咨询结点数据</div></div>
		<table>
		 
			<tr>
  				<td class="blue">特定流程标志 </td>
  				<td width="70%">
            <input id="TYPEID" name="TYPEID" size="20" type="text"    value="<%=rows[0][2] %>">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">流程的中文名 </td>
  				<td width="70%">
  					<input id="SERVICENAME" name="SERVICENAME" size="20" type="text"    value="<%=rows[0][3] %>">
	  			</td>
			</tr>
			<tr>
  				<td class="blue">接入码 </td>
  				<td width="70%">
  					<input id="ACCESSCODE" name="ACCESSCODE" size="20" type="text"    value="<%=rows[0][4] %>"  readonly >
	  			</td>
			</tr>
			<tr>
  				<td class="blue">地市代码 </td>
  				<td width="70%">
  					<select id="city_code" name="city_code"   readonly   >
		         <%
      			    for(int i=0;i<citycode.length;i++)
      					{
      						String flag="";
      						if(rows[0][5].trim().equals(citycode[i][0].trim()))
      						{
      						
      							flag="selected";
      							out.println("<option value="+citycode[i][0].trim()+" "+flag+">"+citycode[i][1]+"</option>");      	
      						}
      	
      										
      					}
      				%>	
         </select>
	  			</td>
			</tr>
			 
		  <tr>
  				<td class="blue">按键路由 </td>
  				<td width="70%">
  					<input id="DIGITCODE" name="DIGITCODE" size="20" type="text"    value="<%=rows[0][7] %>" >
	  			</td>
			</tr>
			<tr>
  				<td class="blue">后续码 </td>
  				<td width="70%">
  					<input id="TRANSCODE" name="TRANSCODE" size="20" type="text"    value="<%=rows[0][9] %>" readonly>
	  			</td>
			</tr>
	 
			
			<tr>
  				<td class="blue">短信内容 </td>
  				<td width="70%">
  					<textarea id="messegecontent" name="messegecontent" cols="40" rows="8"  value="" ><%=rows[0][10] %></textarea>
	  			</td>
			</tr>
			<tr>
  				<td class="blue">是否显示 </td>
  				<td width="70%">
  					<input id="VISIABLE" name="VISIABLE" size="20" type="text"    value="<%=rows[0][11] %>">
	  			</td>
			</tr>
			<tr >
  				<td colspan="2" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="保存" onClick="modifysceTrans()">
   			 	<!--	<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()"> -->
   					<input name="close" type="button" class="b_text" id="close" value="关闭" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
</script>