<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
	<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
		String opName="角色权限管理";
		String themePath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
		String workNo = (String)session.getAttribute("workNo");
		String orgCode =  (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//角色代码
		String modeSql = "select layout_model_id,layout_model_NAME from DLAYOUTmodel where  IS_EFFECT = '1'";
		String roleModeSql = "select distinct(b.op_role) ,a.LAYOUT_MODEL_ID||'--'||a.Layout_Model_Name from DLAYOUTmodel a ,dlayoutrole_rel b where a.layout_model_id=b.layout_model_id  and b.op_role!='XXXXXX' ";
	%>
	<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
						 		<wtc:param value="<%=modeSql%>" />
					 		</wtc:service>
	<wtc:array id="result_t3" scope="end"/>
		
		
		<wtc:service name="TlsPubSelCrm" outnum="2" routerKey="region" routerValue="<%=regionCode %>">
						 		<wtc:param value="<%=roleModeSql%>" />
					 		</wtc:service>
	<wtc:array id="result_t4" scope="end"/>
	 
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<title><%=opName%></title>
	 
	<script src="<%=request.getContextPath()%>/njs/extend/mztree/MzTreeView12.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript">	
		var roleStr = "";	
function add(){
	var selObj = "<select>";
	<%
	for(int i=0;i<result_t3.length;i++){
	%>
	selObj+= "<option value='<%=result_t3[i][0]%>'><%=result_t3[i][0]%>--<%=result_t3[i][1]%></option>";
	<%
	}
	%>
	selObj += "</select>";
	var inHtmlStr = "<tr>"+
					"<td><input type='text' readOnly ><input type='button' class='b_text' onclick='queryPowerCode(this)' value='选择角色'></td>"+
					"<td>"+selObj+"</td>"+
					"<td><input type='button' class='b_text' onclick='save(this)' value='保存'><input type='button' class='b_text' onclick='del(this)' value='删除'></td>"+
					"</tr>";
	$("#roleTab").append(inHtmlStr);
}	
var btj = "";
function queryPowerCode(bt){
	var path = "/npage/opManage/roleTree/roletree.jsp";
	window.open(path,'_blank','height=600,width=300,scrollbars=yes');
	btj = bt;
}
function setRolefunc(retRoleId,retRoleName,retRoleTypeName,retPowerDes){
	//alert("setRolefunc->\nretRoleId|"+retRoleId+"\nretRoleName|"+retRoleName+"\nretRoleTypeName|"+retRoleTypeName+"\nretPowerDes|"+retPowerDes);
	//alert($(btj).parent().parent().find("td:eq(0)").text());
	$(btj).parent().parent().find("td:eq(0)").text(retRoleId+"~"+retRoleName);
}

 
function compRoleId(retRoleId){
	var retFlag =0;
	 $("#roleTab tr:gt(0)").each(function(){
	 		var roleId  = $(this).find("td:eq(0)").text().trim().split("~")[0];
	 		if(roleId==retRoleId){
	 			
	 			retFlag++;
	 		}
	 		
	 });
	 return retFlag;
}
function delOld(bt){
	var oprole=$(bt).parent().parent().find("td:eq(0)").text();
	var modeid=$(bt).parent().parent().find("td:eq(1)").text().split("--")[0];
	//alert("oprole|"+oprole+"\nmodeid|"+modeid);
	var chkPacket = new AJAXPacket("layoutMRCfm.jsp","正在执行,请稍后...");
		chkPacket.data.add("optype", "del");
		chkPacket.data.add("oprole", oprole.trim());
		chkPacket.data.add("modeid", modeid.trim());
		core.ajax.sendPacket(chkPacket,doSave);
		chkPacket = null;  
}
function save(bt){
	var oprole=$(bt).parent().parent().find("td:eq(0)").text().split("~")[0];
	var modeid=$(bt).parent().parent().find("select").val();
	if(oprole==null||oprole==""){
		rdShowMessageDialog("请选择角色代码",1);
		return;
	}
	if(modeid==null||modeid==""){
		rdShowMessageDialog("请选择模板代码",1);
		return;
	}
	var chkPacket = new AJAXPacket("layoutMRCfm.jsp","正在执行,请稍后...");
		chkPacket.data.add("optype", "save");
		chkPacket.data.add("oprole", oprole.trim());
		chkPacket.data.add("modeid", modeid.trim());
		core.ajax.sendPacket(chkPacket,doSave);
		chkPacket = null;  
}
function doSave(packet){
	var retCode = packet.data.findValueByName("retCode"); 
    var retMsg  = packet.data.findValueByName("retMsg"); 
    if(retCode=="000000"){
    	rdShowMessageDialog("操作成功",2);
    	location=location;
    }else{
    	rdShowMessageDialog("操作失败，"+retCode+"："+retMsg,0);
    }
}
function del(bt){
	$(bt).parent().parent().remove();
}
	</script>

</head>
<body >
	<form method="post" name="frm">
	<%@ include file="/npage/include/header_pop.jsp" %>
	
			<div class="title">
				<div id="title_zi">
					角色配置
				</div>
			</div>
				<table cellspacing="0" id="roleTab">
				<tr>
					<th class="blue" width="35%">
						选择角色
					</th>
					<th class="blue" width="35%">
						选择模板
					</th>
					<th class="blue">
						操作
					</th>
				</tr>
				 <%for(int i=0;i<result_t4.length;i++){
				 	if(!result_t4[i][0].equals("")){
				 %>
				 	<tr>
				 		<td><%=result_t4[i][0]%></td>
				 		<td><%=result_t4[i][1]%></td>
				 		<td><input type="button" value="删除" class="b_text" onclick="delOld(this)"></td>
				 	</tr>
				 <%}}%>
			</table>
	 
			<TABLE cellSpacing=0>       
	            <tr> 
	              <td align=center id="footer"> 
	               	<input type="button" class="b_foot" value="增加" id="doSet" name="doSet" onClick="add()" />
					<input type="button" class="b_foot" value="关闭" id="clears" name="clears" onClick="window.close();" />
	             </td>
	            </tr>
	        </TABLE>

	<%@ include file="/npage/include/footer_pop.jsp" %>
	</form>
</body>
</html>