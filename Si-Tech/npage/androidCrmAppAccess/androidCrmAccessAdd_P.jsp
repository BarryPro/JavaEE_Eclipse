<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2015-1-14 10:56:56
 批量新增配置
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<head>
<%
   String input_group_id 	  = request.getParameter("input_group_id");
   String input_group_name	= request.getParameter("input_group_name");
   String opCode    = request.getParameter("opCode");
	 String opName    = "批量添加android版CRM接入终端";
	 
%>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>批量新增配置</title>
<script type="text/javascript" >

function checkfile_v2(){
	//选择文件
	
	$("#feefile").click();
	var filepath = $("#feefile").val();
	
	if(filepath==""||typeof(filepath)=="undefined"){//浏览文件后未选中文件直接关闭或点取消按钮
		return;
	}else{
		var filetype = filepath.substring(filepath.lastIndexOf(".")+1,filepath.length);
		if("txt" != filetype){
			 rdShowMessageDialog("请选择txt文本文件");
			 $("#facefile").val("");
		}else{
			 $("#facefile").val(filepath);
		}
	}
}

function doAdd(){
		document.frm.action = "androidCrmAccessAddCfm_P.jsp?input_group_id=<%=input_group_id%>&opCode=<%=opCode%>&opName=<%=opName%>";
   	document.frm.submit();
}

function twClose(){
	window.location = "androidCrmAccessMain.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
}
</script>
</head>
<body>
<form  name="frm"  method="POST" ENCTYPE="multipart/form-data">
	<%@ include file="/npage/include/header.jsp" %>
				<div class="title">
					<div id="title_zi">批量新增接入配置</div>
				</div>
				<table cellspacing="0">
					<tr>
						<td class="blue" style="text-align:left">
							<font class="orange">
								选择txt文本文件如“批量添加.txt”，文本中字段意义：<br>
								IMEI号,机主姓名,允许登陆开始日期,允许登陆结束日期,允许登陆开始时间,允许登陆结束时间,手机号码
								<br>
								<br>
								txt文件内容示例<br>
								862949024658283|张飞|2014-02-17|2015-02-17|08:00:00|23:36:59|13904512001
								<br>
								866416010106863|关羽|2014-10-29|2015-10-29|08:00:00|18:00:00|13904512002
								<br>
								355287257870778|赵云|2014-01-07|2015-01-07|08:00:00|18:00:00|13904512003

							</font>
						</td>
					</tr>
				</table>
				
				<div class="title">
					<div id="title_zi">
						选择上传的文件
					</div>
				</div>
			
				<table cellspacing="0">
					<tr>
						<td width="70%">
							<input type="file" id="feefile"  name="feefile" size="100" />
						</td>	
					</tr>
					<tr>
						<td class="blue" style="text-align:center"  >
							
							<input class="b_foot" name="add"   type=button value="确定" onclick="doAdd()"   />
						  	&nbsp; 
						  <input class="b_foot" name="close" type=button value="返回" onclick="twClose()"  />
						</td>
					</tr>
				</table>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
