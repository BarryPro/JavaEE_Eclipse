<%
  /*
   * ����:R_CMI_HLJ_xueyz_2014_1381243@���ڹ��ֹ�˾��������ҵ��BOSSϵͳ�����Ż�����ʾ-17.��������ǿ�ع���
   * �汾: 1.0
   * ����:2014/03/21 17:20:13
   * ����: gaopeng
   * ��Ȩ: si-tech
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
			sOpName = "����ǿ��";
		}
		if("BN".equals(opType)){
			sOpName = "����ǿ��";
		}
%>
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
			/*����ǿ��ǿ��չʾ*/
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
	
			if ( 1==force_type )												    /*�߶�*/
			{
				document.form1.force_reason.value="�߶�";   
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
			else if ( 2==force_type )											    /*Υ��ͣ��*/
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
			else if ( 3==force_type )											    /*����*/
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
			}else if ( 4==force_type||5==force_type )											     /*����ʵ��ͣ�����͡������������š�*/
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
			else																	/*��ѡ��*/
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
				/*����У�麯��*/
				
				/*����ǿ��У��---У��ǿ������*/
				if("BK"=="<%=opType%>"){
					//ǿ������
					if(!checkElement(document.all.bat_open_day)){
						return false;
					}
					/*1~365��*/
					if(document.all.bat_open_day.value <= 0 || document.all.bat_open_day.value > 365){
						rdShowMessageDialog("ǿ������������1~365��֮�ڣ�",1);
						return false;
					}
					
				}
				/*����ǿ��У��---ͨ�� ǿ������ У��*/
				if("BN"=="<%=opType%>"){
					var force_type_sel = $("select[name='force_type_sel']").find("option:selected").val();
					/*��ѡ��*/
					if(force_type_sel == 0){
						rdShowMessageDialog("��ѡ��ǿ�����ͣ�",1);
						return false;
					}
					/*�߶�*/
					if(force_type_sel == 1){
						/*ǿ��ԭ��*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*ǿ���жϱ�׼*/
						if(!checkElement(document.all.force_judgement)){
							return false;
						}
						/*��ص��߶����ʱ��*/
						if(!checkElement(document.all.largeticket_time)){
							return false;
						}
						/*�߶���ķ���*/
						if(!checkElement(document.all.largeticket_fee)){
							return false;
						}
						/*����������*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*��������ϵ�绰 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*��ע*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
						
					}
					/*Υ��ͣ��*/
					if(force_type_sel == 2){
						/*ǿ��ԭ��*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*��Ͻ�־�*/
							if(!checkElement(document.all.suboffice)){
							return false;
						}
						/*��Ͻ�־ֵ绰*/
							if(!checkElement(document.all.suboffice_phone)){
							return false;
						}
						/*�ļ����*/
							if(!checkElement(document.all.document_number)){
							return false;
						}
						/*��������*/
							if(!checkElement(document.all.document_date)){
							return false;
						}
						/*����������*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*��������ϵ�绰 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*��ע*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
					
					}
					/*����*/
					if(force_type_sel == 3){
						/*ǿ��ԭ��*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*��ϵ������*/
						if(!checkElement(document.all.contact_name)){
							return false;
						}
						/*��ϵ�˵绰*/
						if(!checkElement(document.all.contact_phone)){
							return false;
						}
						/*��ע*/
						if(!checkElement(document.all.sysnote)){
							return false;
						}
					}
					
					/*����*/
					if(force_type_sel == 4||force_type_sel == 5){
						/*ǿ��ԭ��*/
						if(!checkElement(document.all.force_reason)){
							return false;
						}
						/*����������*/
						if(!checkElement(document.all.operator_name)){
							return false;
						}
						/*��������ϵ�绰 */
						if(!checkElement(document.all.operator_phone)){
							return false;
						}
						/*�ļ����*/
						if(!checkElement(document.all.document_number1)){
							return false;
						}else{
							document.all.document_number.value=document.all.document_number1.value;
						}
					}
					
				}
				
				/*ִ���ϴ��ļ��������ϴ��ļ�����÷���*/
				if($("#uploadFile").val() == ""){
					rdShowMessageDialog("��ѡ�����������ļ���");
					$("#uploadFile").focus();
					return false;
				}
				var formFile=document.all.uploadFile.value.lastIndexOf(".");
				var beginNum=Number(formFile)+1;
				var endNum=document.all.uploadFile.value.length;
				formFile=document.all.uploadFile.value.substring(beginNum,endNum);
				formFile=formFile.toLowerCase(); 
				if(formFile!="txt"){
					rdShowMessageDialog("�ϴ��ļ���ʽֻ����txt��������ѡ����������Ϣ�ļ���",1);
					document.all.uploadFile.focus();
					return false;
				}
				else
					{
						$("#sure").attr("disabled","disabled");
						/*׼���ϴ�*/
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
			<td class="blue">�������� </td>
			<td nowrap colspan = "3">
				<input type="radio" name="phoneType" value="0"   style="cursor:hand" onclick="set_show_fileHit(1)" checked /> 
				<span style="cursor:hand" onclick="pub_set_radio(this)">�ֻ�����</span>
				&nbsp;
				&nbsp;
				<input type="radio" name="phoneType" value="1"   style="cursor:hand" onclick="set_show_fileHit(2)" /> 
				<span style="cursor:hand" onclick="pub_set_radio(this)">����˺�</span>
			</td>
		</tr>
		
		<tr id="bat_open">
			<td class="blue">����ǿ������ </td>
			<td nowrap colspan = "3">
				<input type="text" name="bat_open_day" v_must="1" v_type="0_9" max_length="3" value=""/><font color = "red"> * </font>
			</td>
		</tr>
		<tr>
			<td width="20%" class="blue">�����ļ�</td>
			<td width="80%" colspan="3">
				<input type="file" id="uploadFile" name="uploadFile" v_must="1"  
					style='border-style:solid;border-color:#7F9DB9;border-width:1px;font-size:12px;' />&nbsp;<font color="red">*</font>
			</td>
		</tr>
		<tr id =  "type_row">
			<td class="blue">ǿ������ </td>
			<td nowrap colspan = "3">
				<input type = "hidden" name = "force_type" id = "force_type" value = "">
				<select name = "force_type_sel" onchange = "show_detail()" >
					<option value = "0">---��ѡ��---</option>
					<option value = "1"> �߶� </option>
					<option value = "2"> Υ��ͣ�� </option>
					<option value = "3"> ���� </option>
					<option value = "4"> ��ʵ��ͣ�� </option>
					<option value = "5"> ������������ </option>
				</select>
				<font color = "red"> * </font>
			</td>		
		</tr>	
		<tr  id = "reason_row" style ="display:none" >
		<td class="blue">ǿ��ԭ�� </td>
		<td nowrap colspan = "3">
			<textarea name = "force_reason" v_must="1" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr   id ="judge_row"  style ="display:none" >
		<td class="blue">ǿ���жϱ�׼ </td>
		<td nowrap colspan = "3">
			<textarea name = "force_judgement" v_must="1" cols = "100" ></textarea>
			<font color = "red">*</font>
		</td>		
	</tr>			
	<tr id = "ticket_row"  style ="display:none" >
		<td class="blue">��ص��߶����ʱ�� </td>
		<td nowrap >
			<input type="text"  name = "largeticket_time" v_must="1" maxlength = "20" 
				size = "30" id = "largeticket_time" readonly>
			<img id = "largeticket_time_sel" onclick="WdatePicker({el:'largeticket_time',startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})" 
		 		src="/njs/plugins/My97DatePicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
			<font color = "red">*</font>
		</td>		
		<td class="blue">�߶���ķ��� </td>
		<td nowrap >
			<input type="text" v_must="1"   name = "largeticket_fee" v_type="money" maxlength = "10"  
				size = "30" >
			<font color = "red">*</font>
		</td>			
	</tr>		
	<tr id = "office_row"  style ="display:none" >
		<td class="blue">��Ͻ�־�</td>
		<td colspan="3">
			<input name="suboffice"  v_must="1" size="100" maxlength = "30">
			<font color = "red">* (30��������)</font>
		</td>
	</tr>
	<tr id = "office_phone_row"  style ="display:none" >
		<td class="blue">��Ͻ�־ֵ绰</td>
		<td colspan="3">
			<input name="suboffice_phone" v_type="phone" v_must="1" size="20" maxlength = "30">
			<font color = "red">* </font>
		</td>
	</tr>	
	<tr id = "doc_row" style ="display:none" >
		<td class="blue">�ļ���� </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_number" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">�������� </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_date"  
				v_type="date"  onblur="checkElement(this);"  size = "10"  >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "doc_row45" style ="display:none" >
		<td class="blue">�ļ���� </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "document_number1" maxlength = "15" 
				size = "60">
			<font color = "red">*</font>
		</td>	
		<td class="blue">&nbsp; </td>
		<td class="blue">&nbsp; </td>
	</tr>	
	<tr id = "contact_row"  style ="display:none" >
		<td class="blue">��ϵ������ </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "contact_name" maxlength = "10" 
				size = "15">
			<font color = "red">*</font>
		</td>	
		<td class="blue">��ϵ�˵绰 </td>
		<td nowrap >
			<input type="text"  v_must="1" v_type="phone" name = "contact_phone" maxlength = "20" 
				size = "30" >
			<font color = "red">*</font>
		</td>		
	</tr>	
	<tr id = "operator_row"  style ="display:none" >
		<td class="blue">���������� </td>
		<td nowrap >
			<input type="text" v_must="1"  name = "operator_name" size = "15"  maxlength = "5"  ><font color = "red">*</font>
		</td>	
		<td class="blue">��������ϵ�绰 </td>
		<td nowrap >
			<input type="text" v_must="1" v_type="phone"  name = "operator_phone" size = "20" maxlength = "20"   ><font color = "red">*</font>
		</td>		
	</tr>	
	<tr>
		<td class="blue">��ע</td>
		<td colspan="3">
			<input name="sysnote" v_must="1" size="60" maxlength="30" value="<%=loginNo%> ִ�� <%=sOpName%>">
		</td>
	</tr>
	<tr>
			
				<td class="blue">
					�ļ���ʽ˵��
				</td>
        <td colspan="3"> 
        		
        	 
        		
        	<div id="span_phoneHit">
	            �ϴ��ļ��ı���ʽΪ���ֻ�����+�س�������ʾ�����£�<br>
	            <font class='orange'>
	            	&nbsp;&nbsp; 13836141618<br/>
	            	&nbsp;&nbsp; 13836141611<br/>
	            	&nbsp;&nbsp; 13836141612<br/>
	            	&nbsp;&nbsp; 13836141613<br/>
	            	&nbsp;&nbsp; 13836141614<br/>
	            	&nbsp;&nbsp; 13836141615
	            </font>
	            <b>
	            <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,�Ҷ���Ҫ�س����У����һ�в����л��С�<br>
	            	�ı��ļ���ʽΪtxt�ļ�����������200�����ݡ�<br>
	            </b> 
           </div>
            
           
           <div id="span_cfmLoginHit" style="display:none">
	            �ϴ��ļ��ı���ʽΪ������˺�+�س�������ʾ�����£�<br>
	            <font class='orange'>
	            	&nbsp;&nbsp; yd13904512202<br/>
	            	&nbsp;&nbsp; yd13904512203<br/>
	            	&nbsp;&nbsp; ttkd13904512211<br/>
	            	&nbsp;&nbsp; ttkd13904512212
	            </font>
	            <b>
	            <br>&nbsp;&nbsp; ע����ʽ�е�ÿһ�����������ڿո�,�Ҷ���Ҫ�س����У����һ�в����л��С�<br>
	            	�ı��ļ���ʽΪtxt�ļ�����������200�����ݡ�<br>
	            </b> 
           </div>
            	
        </td>
	    </tr>

	<tr> 
		<td align=center colspan="4" id="footer">
			<input class="b_foot" id="sure" name="sure"  type="button" value="ȷ��"  onclick="conf();">
			<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			<input class="b_foot" name=back  onClick="window.location.href='/npage/s1246/f1246_1.jsp?opCode=1246&opName=ǿ�ƿ��ػ�&activePhone=<%=phoneNo%>'" type=button value=����>
		</td>
	</tr>
	</table>
			<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
			<!--��ˮ�� -->
			<input type="hidden" name="printAccept" value="<%=loginAccept%>">
			<!-- �������� -->
			<input type="hidden" name="opCode" value="<%=opCode%>">
			<!-- �������� -->
			<input type="hidden" name="opName" value="<%=opName%>">		
			<input type="hidden" name="opType" value="<%=opType%>"/>
			<input type="hidden" name="i1" value="<%=phoneNo%>"/>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>


</html>
