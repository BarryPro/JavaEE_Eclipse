<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)[2017/6/5 星期一 14:27:09]------------------
 
 
 -------------------------后台人员：[yuwd]--------------------------------------------
 
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

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>
function reSetThis(){
	location = location ;
}

function set_busi_type(){
	
	if($("#busi_type").val()=="1"){
		 
		
	}else{
		location = "fm489_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}

function set_op_type(){
		if($("#op_type").val()=="A"){
			$("#type1_add").show();
			$("#type1_del").hide();
		}else{
			$("#type1_add").hide();
			$("#type1_del").show();
		}
}

function getFileExt(obj){
	    var pos = obj.lastIndexOf(".");
	    return obj.substring(pos+1);
}
	
	
function go_Cfm(){
			if (form1.uploadfile_1.value.length < 1) {
				rdShowMessageDialog("请上传文件!");
				document.form1.uploadfile_1.focus();
				return false;
			}
			var fileVal = getFileExt($("#uploadfile_1").val());
			if ("txt" == fileVal) {
				//扩展名是txt
			} else {
				rdShowMessageDialog("上传文件的扩展名不正确,只能是后缀为txt类型文件！", 0);
				return false;
			}
			
			$("#form1").attr("encoding", "multipart/form-data");
			document.form1.action = "fm489_type1_uploadCfm.jsp" ;
			document.form1.submit();
		
		
}

</SCRIPT>
</HEAD>	
<BODY>
<FORM id="form1" name="form1" action="" method="post"> 
	<input type="hidden" id="opCode" name="opCode" value="<%=opCode%>" />
	<input type="hidden" id="opName" name="opName" value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">业务类型</td>
		  <td  width="35%">
		  	<select id="busi_type" name="busi_type" onchange="set_busi_type()"  style="width:300px">
				    <option value="1" selected>超和卡副卡</option>
				    <option value="2">美丽乡村专属资费权限配置</option>
				</select>
		  </td>
		  <td class="blue" width="15%">操作类型</td>
		  <td >
		  	<select id="op_type" name="op_type" onchange="set_op_type()">
				    <option value="A">增加</option>
				    <option value="D">删除</option>
				</select>
		  </td>
	</tr>
</table>


	<table cellSpacing="0">
		<tr>
			<td width="15%"  class="blue">选择文件</td>
			<td>
					<input type="file" id="uploadfile_1" name="uploadfile_1"/>
			</td>
		</tr>
		
		<tr id="type1_add">
			<td colspan="2">
				每一行一条记录，数据使用竖线分隔，不能有回车换行、空格等字符<br>
				group_id|主卡价格|副卡价格|工号代码<br>
				如果工号代码是#，代表此价格所有工号都可以办理<br>
				如：<br>
				10013|18|18|#<br>
				10013|18|18|#<br>
				10013|18|18|#<br>
				<br>
				最后一行请以回车符结尾<br>
				<font class="orange">不能超过500条记录</font> 
			</td>
		</tr>
		
		<tr id="type1_del" style="display:none">
			<td colspan="2">
				每一行一条记录，数据使用竖线分隔，不能有回车换行、空格等字符<br>
				删除的导入字为：group_id|主卡价格|副卡价格|工号代码<br>
				如果工号代码是#，则主卡价格、副卡价格下的所有记录都删除，如：<br>
				10013|18|18|# <br>
				10013|18|18|# <br>
				10013|18|18|# <br>
				<br>
				如果主卡价格和副卡价格都是#，此工号的所有记录都删除。如：<br>
				10013|#|#|aaaaxp <br>
				10013|#|#|aaaaxp <br>
				10013|#|#|aaaaxp <br>
				<br>
				如果主卡价格、副卡价格、工号代码都是非#，则删除指定的记录如：<br>
				10013|18|18|aaaaxp<br>
				10013|18|18|aaaaxp<br>
				10013|18|18|aaaaxp<br>
				<br>
				最后一行请以回车符结尾<br>
				<font class="orange">不能超过500条记录</font> 
			</td>
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