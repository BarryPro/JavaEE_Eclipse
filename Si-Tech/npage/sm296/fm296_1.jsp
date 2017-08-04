<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa)2015-8-5 14:20:07------------------
 
 -------------------------后台人员：chenlin--------------------------------------------
 
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
				    document.msgFORM.action="fm296_2.jsp?opCode=<%=opCode%>&opName=<%=opName%>&upload_type="+$("#upload_type").val();
				    document.msgFORM.submit();
					}
}

function show_text_demo(){
	
	var hit_text = "";
	if($("#upload_type").val()=="1"){
		
		hit_text = "上传文件文本格式为<br>手机号码|经办人姓名|经办人地址|经办人证件|经办人证件号码<br>示例如下<br>"+
		           "13800388300|孙菲菲|黑龙江省哈尔滨汉水路33号|0|230305198505145014<br/>";
		           
	}else if($("#upload_type").val()=="2"){
		
		hit_text = "上传文件文本格式为<br>手机号码|实际使用人姓名|实际使用人地址|实际使用人证件|实际使用人证件号码<br>示例如下<br/>"+
		           "13800388300|孙菲菲|黑龙江省哈尔滨汉水路33号|0|230305198505145014<br/>";
		           
	}else if($("#upload_type").val()=="3"){
		
				hit_text = "上传文件文本格式为<br>手机号码|经办人姓名|经办人地址|经办人证件|经办人证件号码|实际使用人姓名|实际使用人地址|实际使用人证件|实际使用人证件号码<br>示例如下<br/>"+
		           "13800388300|孙菲菲|黑龙江省哈尔滨汉水路33号|0|230305198505145014|孙菲菲|黑龙江省哈尔滨汉水路33号|0|230305198505145015<br/>";

	}else if($("#upload_type").val()=="4"){
		
		hit_text = "上传文件文本格式为<br>手机号码|责任人姓名|责任人地址|责任人证件|责任人证件号码<br>示例如下<br>"+
		           "13800388300|孙菲菲|黑龙江省哈尔滨汉水路33号|0|230305198505145014<br/>";
		           
	}
	
	$("#text_hit_demo").html(hit_text);
}

$(document).ready(function(){
	show_text_demo();
});
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
								    <td class="blue" width="15%" >导入类型</td>
									  <td >
										    <select id="upload_type" name="upload_type" style="width:300px" onchange="show_text_demo()">
										    	<option value="1">导入经办人信息</option>
										    	<option value="2">导入实际使用人信息</option>
										    	<option value="3">导入经办人和实际使用人信息</option>
										    	<option value="4">导入责任人信息</option>
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
					        <td > 
					            证件类型对应关系<br>
					        0 身份证<br>
									<!-- 1 军官证<br> -->
									2 户口簿<br>
									3 港澳通行证<br>
									<!-- 4 警官证<br> -->
									5 台湾通行证<br>
									6 外国公民护照<br>
									<br>
					            <span id="text_hit_demo"></span>
					            <b><br><font class="orange">注意：
					            	<br>&nbsp;&nbsp;姓名不超过30个汉字，                           
												<br>&nbsp;&nbsp;地址不超过100个汉字，                          
												<br>&nbsp;&nbsp;证件类型不超过1个字符，                        
												<br>&nbsp;&nbsp;证件号码不超过20个字符必须是数字、字母和“-”等
												<br>
					            <br>&nbsp;&nbsp; 格式中的每一项均不允许存在空格,且每条数据都需要回车换行。
					            <br>&nbsp;&nbsp; 上传文件格式为txt文件。且最多不超过500条。</font>
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