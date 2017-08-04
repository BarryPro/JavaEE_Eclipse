<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2013-12-6 13:59:00
********************/
%>
              
<%
		String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
	String regionCode = (String)session.getAttribute("regCode");
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
$(document).ready(function(){
});

//解除绑定
function delBond(imeiNo){
      if(rdShowConfirmDialog('确认解除该绑定关系么？')!=1) return;
	var packet = new AJAXPacket("androidCrmAccessDelBondCfm.jsp","正在执行,请稍后...");
			packet.data.add("imeiNo",imeiNo);
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doDelBond);
			packet = null; 
}
function doDelBond(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("解绑成功",2);
		qryFunc();
	}else{
		rdShowMessageDialog("操作失败"+code+"："+msg,0);
	}
}

//删除记录
function del(imeiNo){
      if(rdShowConfirmDialog('确认删除接入终端记录吗？')!=1) return;
	var packet = new AJAXPacket("androidCrmAccessDelCfm.jsp","正在执行,请稍后...");
			packet.data.add("imeiNo",imeiNo);
			packet.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(packet,doDel);
			packet = null; 
}
function doDel(packet){
	var code = packet.data.findValueByName("code"); 
	var msg = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		rdShowMessageDialog("删除成功",2);
		qryFunc();
	}else{
		rdShowMessageDialog("操作失败"+code+"："+msg,0);
	}
}

function addFunc(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("请选择组织节点");
			return;
	}

	window.location = "androidCrmAccessAdd.jsp?opCode=<%=opCode%>&opName=<%=opName%>&input_group_name="+$("#input_group_name").val()+"&input_group_id="+$("#input_group_id").val();
} 

function addFuncP(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("请选择组织节点");
			return;
	}
 
	window.location = "androidCrmAccessAdd_P.jsp?opCode=<%=opCode%>&opName=<%=opName%>&input_group_name="+$("#input_group_name").val()+"&input_group_id="+$("#input_group_id").val();
}

function selGroupid(){
	var path = "common/grouptree.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
function retGroupInfo(retGroupId,retGroupName){
	$("#input_group_name").val(retGroupName);
	$("#input_group_id").val(retGroupId);
	if(typeof(retGroupId)!="undefined"&&retGroupId.trim()!=""){
		qryFunc();
	}
}
//修改
function upd(imeiNo,astatus,bDate,eDate,bTime,eTime,custName,phoneNo){
	//alert("imeiNo = "+imeiNo+"\n"+"astatus = "+astatus+"\n"+"bDate = "+bDate+"\n"+"eDate = "+eDate+"\n"+"bTime = "+bTime+"\n"+"eTime = "+eTime);
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("请选择组织节点");
			return;
	}
	var h=400;
	var w=880;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var gourl = "androidCrmAccessUpd.jsp?opCode=<%=opCode%>"+
																			"&input_group_name="+$("#input_group_name").val()+
																			"&imeiNo="+imeiNo+
																			"&astatus="+astatus+
																			"&bDate="+bDate+
																			"&eDate="+eDate+
																			"&bTime="+bTime+
																			"&eTime="+eTime+
																			"&custName="+custName+
																			"&phoneNo="+phoneNo+
																			"&input_group_id="+$("#input_group_id").val();
	var ret=window.showModalDialog(gourl,"",prop);
	if(typeof(ret)!="undefined"){
		if(ret=="2"){
			//添加成功，更新列表
			qryFunc();
		}
	}
	
}

//查询鉴权列表
function qryFunc(){
	if($("#input_group_id").val()==""){
			rdShowMessageDialog("请选择组织节点");
			return;
	}
	
	var packet = new AJAXPacket("androidCrmAccessList.jsp","正在执行,请稍后...");
			packet.data.add("input_group_id",$("#input_group_id").val());
			packet.data.add("imeiNo",$("#imeiNo").val().trim());
			core.ajax.sendPacket(packet,doQryFunc);
			packet = null; 
}

function doQryFunc(packet){
	var code = packet.data.findValueByName("code"); 
	var msg  = packet.data.findValueByName("msg"); 
	if(code=="000000"){
		var retArray  = packet.data.findValueByName("retArray"); 
		$("#accesMainTab tr:gt(0)").remove();
		var trObjdStr = "";
		var dataStr = "";
		for(var i=0;i<retArray.length;i++){
			 if(retArray[i][3]=="1970-01-01"&&retArray[i][4]=="1970-01-01"){
			 	dataStr = "无限制";
			 }else{
			 	dataStr = retArray[i][3]+"--"+retArray[i][4];
			 }
			 var disablStr = "";
			 if(retArray[i][10]==""){
			 		disablStr = "disabled='true'";
			 }else{
			 		disablStr = "";
			 }
			trObjdStr += "<tr>"+
									 "<td>"+retArray[i][0]+"</td>"+
									 "<td>"+retArray[i][11]+"</td>"+
									 "<td>"+retArray[i][9]+"</td>"+
									 "<td>"+retArray[i][2]+"</td>"+
									 "<td>"+dataStr+"</td>"+
									 "<td>"+retArray[i][5]+"--"+retArray[i][6]+"</td>"+
									 "<td>"+retArray[i][7]+"</td>"+
									 "<td>"+
									 		"<input type='button' class='b_text' value='修改' onclick='upd(\""+retArray[i][0]+"\",\""+retArray[i][2]+"\",\""+retArray[i][3]+"\",\""+retArray[i][4]+"\",\""+retArray[i][5]+"\",\""+retArray[i][6]+"\",\""+retArray[i][9]+"\",\""+retArray[i][11]+"\")'>"+
									 		"<input type='button' class='b_text' value='删除' onclick='del(\""+retArray[i][0]+"\")'>"+
									 		"<input type='button' class='b_text' value='解绑' onclick='delBond(\""+retArray[i][0]+"\")' "+disablStr+">"+
									 "</td>"+
									 "</tr>";
		}
		$("#accesMainTab tr:eq(0)").after(trObjdStr);
	}else{
		rdShowMessageDialog("查询失败"+code+"："+msg,0);
		$("#input_group_name").val("");
		$("#input_group_id").val("");
	}
}

function resetThisPage(){
	location = location;
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="prodCfm" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
	<input type="hidden" name="opCode" value=<%=opCode%>>
	<input type="hidden" name="opName" value=<%=opName%>>
<div class="title"><div id="title_zi"><%=opName%></div></div>
<TABLE cellSpacing=0>
	<tr>
		<td class="blue" width="20%">组织节点</td>
		<td class="blue" width="30%">
			
			<input type="text"   id="input_group_name" name="input_group_name"  readOnly class="InputGrey" size="40" />
			<input type="hidden" id="input_group_id"   name="input_group_id"   />
			<input type="button"  value="选择" class="b_text" onclick="selGroupid()"/>
		</td>
		 
		  <td class="blue" width="20%">IMEI号码</td>
		 <td width="30%"><input type="text" id="imeiNo" name="imeiNo" maxLength="15"></td>
	</tr>
</table>

<div class="title"><div id="title_zi">终端接入列表</div></div>
<TABLE cellSpacing="0" id="accesMainTab" >
	<tr>
		<th width="14%">IMEI号</th>
		<th width="10%">手机号码</th>
		<th width="12%">机主姓名</th>
		<th width="6%">状态</th>	
		<th width="18%">允许登陆日期</th>	
		<th width="18%">允许登陆时间</th>	
		<th width="18%">创建日期</th>	
		<th>操作</th>	
	</tr>
 
</table>
<TABLE cellSpacing=0>
	 <tr>
	 	<td id="footer">
	 		<input type="button" value="查询" class="b_foot" onclick="qryFunc()">
	 		<input type="button" value="新增" class="b_foot" onclick="addFunc()">
	 		<input type="button" value="批量新增" class="b_foot" onclick="addFuncP()">
	 		<input type="button" value="重置" class="b_foot" onclick="resetThisPage()">
			<INPUT class=b_foot onclick="removeCurrentTab()" type=button value=关闭> 
	 	</td>
	</tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>