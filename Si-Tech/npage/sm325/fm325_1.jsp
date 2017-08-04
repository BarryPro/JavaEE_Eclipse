<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-10-9 15:58:34------------------
 关于合账分享业务业务限制及办理渠道拓展需求的函
 -------------------------后台人员：xiahk--------------------------------------------
 
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

function doCfm(){
	
        /*执行上传文件操作，上传文件后调用服务*/
				if($("#uploadFile").val() == ""){
					rdShowMessageDialog("请选择批量导入文件！");
					$("#uploadFile").focus();
					return false;
				}
        
        var formFile=document.all.uploadFile.value.lastIndexOf(".");
				var beginNum=Number(formFile)+1;
				var endNum=document.all.uploadFile.value.length;
				formFile=document.all.uploadFile.value.substring(beginNum,endNum);
				formFile=formFile.toLowerCase(); 
				if(formFile!="txt"){
					rdShowMessageDialog("上传文件格式只能是txt，请重新选择文件！",1);
					document.all.uploadFile.focus();
					return false;
				}
				else
					{
				    document.msgFORM.action="fm325_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>&upload_type="+$("#upload_type").val();
				    document.msgFORM.submit();
					}
}
 
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action=""  method="POST" ENCTYPE="multipart/form-data"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>

<input type="hidden" id="opCode"  name="opCode" value="<%=opCode%>"  />
<input type="hidden" id="opName"  name="opName" value="<%=opName%>"  />

<table cellSpacing="0">
								<tr>
						 				<td class="blue">操作类型</td>
						 				<td>
						 					<select id="upload_type">
						 							<option value="a">申请</option>
						 							<option value="d">取消</option>
						 					</select>
						 				</td>
								</tr>
								
								<tr>
									<td class="blue">导入文件</td>
									<td  >
										<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
											style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
									</td>
								</tr>
								<tr>
									<td class="blue">
										文件格式说明
									</td>
					        <td>
					            上传文件文本格式为<br>
											主卡号码|副卡号码<br>
											示例如下<br>
											13800388300|13800388300<br>

					            <b><br><font class="orange">注意：
					            <br>&nbsp;&nbsp; 格式中的每一项均不允许存在空格,且每条数据都需要回车换行。
					            <br>&nbsp;&nbsp; 上传文件格式为txt文件。且最多不超过100条。</font>
					            </b> 
					        </td>
	   					 	</tr>
	
</table>
 
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="确认" onclick="doCfm()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>