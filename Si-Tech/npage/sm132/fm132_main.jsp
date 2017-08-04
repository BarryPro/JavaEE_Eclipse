<%
  /*
   * 功能: 校园信息录入 m132
   * 版本: 1.0
   * 日期: 2014/6/27
   * 作者: 
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
    
  String regionCode = (String)session.getAttribute("regCode");
  String loginNo = (String)session.getAttribute("workNo");
	String noPass = (String)session.getAttribute("password");
	String phoneNo = (String)request.getParameter("activePhone");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
	<script src="../public/json2.js" type="text/javascript"></script>   
	<script language="JavaScript">
		function printCommit(){
			var uploadFile = $("#uploadFile").val();
			/*执行上传文件操作，上传文件后调用服务*/
			if(uploadFile == ""){
				rdShowMessageDialog("请选择批量导入文件！");
				$("#uploadFile").focus();
				return false;
			}
			
			var formFile=uploadFile.lastIndexOf(".");
			var beginNum=Number(formFile)+1;
			var endNum=uploadFile.length;
			formFile=uploadFile.substring(beginNum,endNum);
			formFile=formFile.toLowerCase(); 
			if(formFile!="txt"){
				rdShowMessageDialog("上传文件格式只能是txt，请重新选择文件！",1);
				document.all.uploadFile.focus();
				return false;
			}
			
			/*准备上传*/
			//document.frm.target="hidden_frame";
			$("form").attr("encoding", "multipart/form-data");
			$("form").attr("ENCTYPE", "multipart/form-data");
	    document.frm.submit();
			return true;
		}
		
	</script> 
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
</head>
<BODY>
<form name="frm" method="post" action="/npage/sm132/fm132_Upload.jsp" >
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<input type="hidden" name="opName" value="<%=opName%>">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<table cellspacing="0">           
    <tr>
			<td width="20%" class="blue">导入文件</td>
			<td width="80%" colspan="3">
				<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">
				文件格式说明
			</td>
      <td colspan="3"> 
          &nbsp;
					一.所导入文件必须为文本文件（后缀.txt）<br>&nbsp;
					二.一次最多操作100条<br>&nbsp;
					三.上传文件文本格式为：“身份证号码|客户名称|学校名称|专业名称|住址”，文件内容示例如下：<br>&nbsp;
          <font class='orange'>
          	&nbsp;&nbsp; 230103198401011234|小王|黑龙江大学|土木工程|黑龙江省哈尔滨市南岗区红旗大街100号
          </font>
          <b>
          <br>&nbsp;注：格式中的每一项均不允许存在空格,且每条数据都需要回车换行。上传文件格式为txt文件。
          </b> 
      </td>
	 	</tr>
		<tr> 
			<td align="center" id="footer" colspan="4"> 
				<input type="button" name="qryBtn"  class="b_foot" value="确定" onclick="printCommit()">
				&nbsp;
				<input type="button" name="closeBtn1" class="b_foot" value="关闭" onclick="removeCurrentTab()">
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>