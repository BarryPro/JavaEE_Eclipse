<%
  /*
   * 功能:R_CMI_HLJ_xueyz_2014_1381243@关于哈分公司申请对相关业务BOSS系统进行优化的请示-17.增加批量强关功能
   * 版本: 1.0
   * 日期:2014/03/21 17:20:13
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("i1");
		System.out.println("gaopengSeeLog============phoneNo="+phoneNo);
		String opType = (String)request.getParameter("opType");
		String loginAccept = getMaxAccept();
		String sOpName = "";
		if("BK".equals(opType)){
			sOpName = "批量强开";
		}
		if("BN".equals(opType)){
			sOpName = "批量强关";
		}
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			/*批量强开强关展示*/
			if("BK"=="<%=opType%>"){
				$("#type_row").hide();
				$("#bat_open").show();
			}else{
				$("#type_row").show();
				$("#bat_open").hide();
			}
			
		});
	function show_detail() 
		{
			var force_type_sel = document.form1.force_type_sel.value;
			document.form1.force_type.value = force_type_sel;
			var force_type = force_type_sel;
			
			document.form1.force_reason.value="";     	
			document.form1.force_judgement.value="";            
			document.form1.largeticket_time.value="";            
			document.form1.largeticket_fee.value="";            
			document.form1.suboffice.value="";               			      
			document.form1.suboffice_phone.value="";   				       
			document.form1.document_number.value="";   
			document.form1.document_number1.value="";  
			document.form1.document_date.value="";              
			document.form1.operator_name.value="";             
			document.form1.operator_phone.value="";                
			document.form1.contact_name.value="";                  
			document.form1.contact_phone.value="";             
	
			if ( 1==force_type )												    /*高额*/
			{
				document.form1.force_reason.value="高额";   
				document.form1.force_reason.readOnly = true;
				document.getElementById("reason_row").style.display = "block";
				document.getElementById("judge_row").style.display = "block";
				document.getElementById("ticket_row").style.display = "block";
				document.getElementById("office_row").style.display = "none";
				document.getElementById("office_phone_row").style.display = "none";
				document.getElementById("doc_row").style.display = "none";
				document.getElementById("doc_row45").style.display = "none";
				document.getElementById("contact_row").style.display = "none";
				document.getElementById("operator_row").style.display = "block";
			}
			else if ( 2==force_type )											    /*违章停机*/
			{
				document.form1.force_reason.value="";   
				document.form1.force_reason.readOnly = false;
				document.getElementById("reason_row").style.display = "block";
				document.getElementById("judge_row").style.display = "none";
				document.getElementById("ticket_row").style.display = "none";
				document.getElementById("office_row").style.display = "block";
				document.getElementById("office_phone_row").style.display = "block";
				document.getElementById("doc_row").style.display = "block";
				document.getElementById("doc_row45").style.display = "none";
				document.getElementById("contact_row").style.display = "none";
				document.getElementById("operator_row").style.display = "block";
			}
			else if ( 3==force_type )											    /*其它*/
			{
				document.form1.force_reason.value="";   
				document.form1.force_reason.readOnly = false;
				document.getElementById("reason_row").style.display = "block";
				document.getElementById("judge_row").style.display = "none";
				document.getElementById("ticket_row").style.display = "none";
				document.getElementById("office_row").style.display = "none";
				document.getElementById("office_phone_row").style.display = "none";
				document.getElementById("doc_row").style.display = "none";
				document.getElementById("doc_row45").style.display = "none";
				document.getElementById("contact_row").style.display = "block";
				document.getElementById("operator_row").style.display = "none";
			}else if ( 4==force_type||5==force_type )											     /*“非实名停机”和“发送垃圾短信”*/
			{
				document.form1.force_reason.value="";   
				document.form1.force_reason.readOnly = false;
				document.getElementById("reason_row").style.display = "block";
				document.getElementById("judge_row").style.display = "none";
				document.getElementById("ticket_row").style.display = "none";
				document.getElementById("office_row").style.display = "none";
				document.getElementById("office_phone_row").style.display = "none";
				document.getElementById("doc_row").style.display = "none";
				document.getElementById("doc_row45").style.display = "block";
				document.getElementById("contact_row").style.display = "none";
				document.getElementById("operator_row").style.display = "block";
			}
			else																	/*请选择*/
			{
				document.form1.force_reason.value="";   
				document.form1.force_reason.readOnly = false;
				document.getElementById("reason_row").style.display = "none";
				document.getElementById("judge_row").style.display = "none";
				document.getElementById("ticket_row").style.display = "none";
				document.getElementById("office_row").style.display = "none";
				document.getElementById("office_phone_row").style.display = "none";
				document.getElementById("doc_row").style.display = "none";
				document.getElementById("doc_row45").style.display = "none";
				document.getElementById("contact_row").style.display = "none";
				document.getElementById("operator_row").style.display = "none";			
			}
		}
		
	
	function conf(){
				/*各种校验函数*/
				
				/*批量强开校验---校验强开天数*/
				if("BK"=="<%=opType%>"){
					//强开天数
					if(!checkElement(document.all.bat_open_day)){
						return false;
					}
					/*1~365天*/
					if(document.all.bat_open_day.value <= 0 || document.all.bat_open_day.value > 365){
						rdShowMessageDialog("强开天数必须在1~365天之内！",1);
						return false;
					}
					
				}
				/*批量强关校验---通过 强关类型 校验*/
				if("BN"=="<%=opType%>"){
					var force_type_sel = $("select[name='force_type_sel']").find("option:selected").val();
					/*请选择*/
					if(force_type_sel == 0){
						rdShowMessageDialog("请选择强关类型！",1);
						return false;
					}
					/*高额*/
					if(force_type_sel == 1){
						/*强关原因*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*强关判断标准*/
						if(!checkElement(document.all.force_judgement)){
							return false;
						}
						/*监控到高额话单的时间*/
						if(!checkElement(document.all.largeticket_time)){
							return false;
						}
						/*高额话单的费用*/
						if(!checkElement(document.all.largeticket_fee)){
							return false;
						}
						/*操作人姓名*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*操作人联系电话 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*备注*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
						
					}
					/*违章停机*/
					if(force_type_sel == 2){
						/*强关原因*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*所辖分局*/
							if(!checkElement(document.all.suboffice)){
							return false;
						}
						/*所辖分局电话*/
							if(!checkElement(document.all.suboffice_phone)){
							return false;
						}
						/*文件编号*/
							if(!checkElement(document.all.document_number)){
							return false;
						}
						/*来文日期*/
							if(!checkElement(document.all.document_date)){
							return false;
						}
						/*操作人姓名*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*操作人联系电话 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*备注*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
					
					}
					/*其他*/
					if(force_type_sel == 3){
						/*强关原因*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*联系人姓名*/
						if(!checkElement(document.all.contact_name)){
							return false;
						}
						/*联系人电话*/
						if(!checkElement(document.all.contact_phone)){
							return false;
						}
						/*备注*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
					}
					
					/*其他*/
					if(force_type_sel == 4||force_type_sel == 5){
						/*强关原因*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*操作人姓名*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*操作人联系电话 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*文件编号*/
						if(!checkElement(document.all.document_number1)){
							return false;
						}else{
							document.all.document_number.value=document.all.document_number1.value;
						}
					}
					
				}
				
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
					rdShowMessageDialog("上传文件格式只能是txt，请重新选择宽带提速信息文件！",1);
					document.all.uploadFile.focus();
					return false;
				}
				else
					{
						$("#sure").attr("disabled","disabled");
						/*准备上传*/
						document.form1.target="hidden_frame";
				    document.form1.encoding="multipart/form-data";
				    document.form1.action="/npage/s1246/f1246Upload.jsp";
				    document.form1.method="post";
				    document.form1.submit();
				    
						return true;
					}
		
	}
	
function set_show_fileHit(flag){
	
	if(flag=="0"){
		$("#span_cfmLoginHit").hide();
		$("#span_phoneHit").show();
	}else{
		$("#span_cfmLoginHit").show();
		$("#span_phoneHit").hide();
	}
}
function pub_set_radio(bt){
	$(bt).prev().click();
}	
</script>
	</head>
<body>
	<form action="" method="post" name="frmaaa" id="frmaaa">
	</form>
	<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=sOpName%></div>
	</div>
	<table>
		<tr>
			<td class="blue">操作类型 </td>
			<td nowrap colspan = "3">
				<input type="radio" name="phoneType" value="0"   style="cursor:hand" onclick="set_show_fileHit(1)" checked /> 
				<span style="cursor:hand" onclick="pub_set_radio(this)">手机号码</span>
				&nbsp;
				&nbsp;
				<input type="radio" name="phoneType" value="1"   style="cursor:hand" onclick="set_show_fileHit(2)" /> 
				<span style="cursor:hand" onclick="pub_set_radio(this)">宽带账号</span>
			</td>
		</tr>
		
		<tr id="bat_open">
			<td class="blue">批量强开天数 </td>
			<td nowrap colspan = "3">
				<input type="text" name="bat_open_day" v_must="1" v_type="0_9" max_length="3" value=""/><font color = "red"> * </font>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">导入文件</td>
			<td width="80%" colspan="3">
				<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr id =  "type_row">
			<td class="blue">强关类型 </td>
			<td nowrap colspan = "3">
				<input type = "hidden" name = "force_type" id = "force_type" value = "">
				<select name = "force_type_sel" onchange = "show_detail()" >
					<option value = "0">---请选择---</option>
					<option value = "1"> 高额 </option>
					<option value = "2"> 违章停机 </option>
					<option value = "3"> 其它 </option>
					<option value = "4"> 非实名停机 </option>
					<option value = "5"> 发送垃圾短信 </option>
				</select>
				<font color = "red"> * </font>
			</td>		
		</tr>	
		<tr  id = "reason_row" style ="display:none" >
		<td class="blue">强关原因 </td>
		<td nowrap colspan = "3">
			<textarea name = "force_reason" v_must="1" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr   id ="judge_row"  style ="display:none" >
		<td class="blue">强关判断标准 </td>
		<td nowrap colspan = "3">
			<textarea name = "force_judgement" v_must="1" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>			
	<tr id = "ticket_row"  style ="display:none" >
		<td class="blue">监控到高额话单的时间 </td>
		<td nowrap >
			<input type="text"  name = "largeticket_time" v_must="1" maxlength = "20" 
				size = "30" id = "largeticket_time" readonly>
			<img id = "largeticket_time_sel" onclick="WdatePicker({el:'largeticket_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
		 		src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>		
		<td class="blue">高额话单的费用 </td>
		<td nowrap >
			<input type="text" v_must="1"   name = "largeticket_fee" v_type="money" maxlength = "10"  
				size = "30" >
			<font color = "red">*</font>
		</td>			
	</tr>		
	<tr id = "office_row"  style ="display:none" >
		<td class="blue">所辖分局</td>
		<td colspan="3">
			<input name="suboffice"  v_must="1" size="100" maxlength = "30">
			<font color = "red">* (30汉字以内)</font>
		</td>
	</tr>
	<tr id = "office_phone_row"  style ="display:none" >
		<td class="blue">所辖分局电话</td>
		<td colspan="3">
			<input name="suboffice_phone" v_type="phone" v_must="1" size="20" maxlength = "30">
			<font color = "red">* </font>
		</td>
	</tr>	
	<tr id = "doc_row" style ="display:none" >
		<td class="blue">文件编号 </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_number" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">来文日期 </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_date"  
				v_type="date"  onblur="checkElement(this);"  size = "10"  >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "doc_row45" style ="display:none" >
		<td class="blue">文件编号 </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_number1" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">&nbsp; </td>
		<td class="blue">&nbsp; </td>
	</tr>	
	<tr id = "contact_row"  style ="display:none" >
		<td class="blue">联系人姓名 </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "contact_name" maxlength = "10" 
				size = "15">
			<font color = "red">*</font>
		</td>	
		<td class="blue">联系人电话 </td>
		<td nowrap >
			<input type="text"  v_must="1" v_type="phone" name = "contact_phone" maxlength = "20" 
				size = "30" >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "operator_row"  style ="display:none" >
		<td class="blue">操作人姓名 </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "operator_name" size = "15"  maxlength = "5"  ><font color = "red">*</font>
		</td>	
		<td class="blue">操作人联系电话 </td>
		<td nowrap >
			<input type="text" v_must="1" v_type="phone"  name = "operator_phone" size = "20" maxlength = "20"   ><font color = "red">*</font>
		</td>		
	</tr>	
	<tr>
		<td class="blue">备注</td>
		<td colspan="3">
			<input name="sysnote" v_must="1" size="60" maxlength="30" value="<%=loginNo%> 执行 <%=sOpName%>">
		</td>
	</tr>
	<tr>
			
				<td class="blue">
					文件格式说明
				</td>
        <td colspan="3"> 
        		
        	 
        		
        	<div id="span_phoneHit">
	            上传文件文本格式为“手机号码+回车键”，示例如下：<br>
	            <font class='orange'>
	            	&nbsp;&nbsp; 13836141618<br/>
	            	&nbsp;&nbsp; 13836141611<br/>
	            	&nbsp;&nbsp; 13836141612<br/>
	            	&nbsp;&nbsp; 13836141613<br/>
	            	&nbsp;&nbsp; 13836141614<br/>
	            	&nbsp;&nbsp; 13836141615
	            </font>
	            <b>
	            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且都需要回车换行，最后一行不能有换行。<br>
	            	文本文件格式为txt文件，最多可输入200行数据。<br>
	            </b> 
           </div>
            
           
           <div id="span_cfmLoginHit" style="display:none">
	            上传文件文本格式为“宽带账号+回车键”，示例如下：<br>
	            <font class='orange'>
	            	&nbsp;&nbsp; yd13904512202<br/>
	            	&nbsp;&nbsp; yd13904512203<br/>
	            	&nbsp;&nbsp; ttkd13904512211<br/>
	            	&nbsp;&nbsp; ttkd13904512212
	            </font>
	            <b>
	            <br>&nbsp;&nbsp; 注：格式中的每一项均不允许存在空格,且都需要回车换行，最后一行不能有换行。<br>
	            	文本文件格式为txt文件，最多可输入200行数据。<br>
	            </b> 
           </div>
            	
        </td>
	    </tr>

	<tr> 
		<td align=center colspan="4" id="footer">
			<input class="b_foot" id="sure" name="sure"  type="button" value="确认"  onclick="conf();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
			<input class="b_foot" name=back  onClick="window.location.href='/npage/s1246/f1246_1.jsp?opCode=1246&opName=强制开关机&activePhone=<%=phoneNo%>'" type=button value=返回>
		</td>
	</tr>
	</table>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
			<!--流水号 -->
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<!-- 操作代码 -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<input type="hidden" name="opType" value="<%=opType%>"/>
			<input type="hidden" name="i1" value="<%=phoneNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
