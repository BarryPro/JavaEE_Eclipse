<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * ����: �޸�
�� * �汾: v1.0
�� * ����: 2013/10/17
�� * ����: wangjxc
�� * ��Ȩ: sitech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
	<%
		String opCode = request.getParameter("opCode");
		String UpCustId = request.getParameter("UpCustId");
		String queryflag = request.getParameter("queryflag");
		String workNo = (String)session.getAttribute("workNo");
		String passWord = (String)session.getAttribute("passWord");
		String groupId = (String)session.getAttribute("groupId");
		String regionCode=(String)session.getAttribute("regCode");
		
		String opName = "��˰������չʾ";
	%>
<wtc:service name="sQryTaxpay" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="18">
	  <wtc:param value="<%=UpCustId%>"/>
</wtc:service>
<wtc:array id="retList"  scope="end"/>	
<%	
	String acctchment_name="";
	String acctchment_list="";
	String file_name="";
	String source_file="";
	String taxpayer_type = retList[0][2];
	String bill_type = retList[0][3];

if(retList.length>0)
{
	System.out.println("retList.length========================"+retList.length);
	for(int i=0;i<retList.length;i++)
	{
		acctchment_name = retList[i][12];
		acctchment_list = retList[i][14];
		file_name=acctchment_name+"*"+acctchment_list;
		System.out.println("file_name========================"+file_name);
		if(i==0)
		{
   			source_file=file_name;
   			System.out.println("source_file11111111111========================"+source_file);
  		}
  		else
  		{
   			source_file=source_file+"|"+file_name;
   			System.out.println("source_file2222222========================"+source_file);
  		}
  		
	}
	
}				
%>		

	

<html xmlns="http://www.w3.org/1999/xhtml">
<script type="text/javascript" src="/npage/public/pubScript.js"></script>	
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<head>
	<title>��˰��������Ϣչʾ</title>
	<script language="JavaScript">
			  var modi_save_name=new Array();
		var index=0;
		$(document).ready(function(){
			var source_file="<%=source_file%>";
			$("#source_file_name").val(source_file);
			if(source_file!=""){
				var filearray=source_file.split("|");
				for(var i=0;i<filearray.length;i++){
					modi_save_name[index]=filearray[i];
					index++;
				}
				showModiFile();
			}
			
		});
		
		
		
		
		function ApproveCom(CheckFlag)
		{
			
			if(!check(frmo003Upt))return false;
			var taxpayerId = $("#taxpayer_id").val();
			var taxpayerType = $("#taxpayer_type").val();		
			var billType = $("#bill_type").val();
			var unitName = $("#unit_name").val();
			var address = $("#unit_address").val();
			var phoneNo = $("#phone_no").val();
			var bankName = $("#bank_name").val();
			var bankAccount = $("#bank_account").val();
			var valid_date = $("#valid_date").val();
			var expire_date = $("#expire_date").val();
			var reg = new RegExp("[- :]","gi"); 
			valid_date = valid_date.replace(reg,"")+"000000";
			expire_date = expire_date.replace(reg,"")+"235959";
			var remark = $("#remark").val();
			if(modi_save_name.length>0){
				  list_name = modi_save_name[0];
				for(var i=1;i<modi_save_name.length;i++){
					list_name = list_name+"|"+modi_save_name[i];
				 }
			  }
			var packet = new AJAXPacket("fo003_ajax_doTaxpayerUpt.jsp","���Ժ�...");
			packet.data.add("taxpayerId",taxpayerId);
			packet.data.add("taxpayerType",taxpayerType);
			packet.data.add("billType",billType);
			packet.data.add("unitName",unitName);
			packet.data.add("address",address);
			packet.data.add("phoneNo",phoneNo);
			packet.data.add("bankName",bankName);
			packet.data.add("bankAccount",bankAccount);
			packet.data.add("valid_date",valid_date);
			packet.data.add("expire_date",expire_date);
			packet.data.add("remark",remark);
			packet.data.add("list_name",list_name);
			packet.data.add("UpCustId",'<%=UpCustId%>');
			core.ajax.sendPacket(packet,doUptTaxpayer,true);
	  		packet = null;
		}
		
		function doUptTaxpayer(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000")
			{
				rdShowMessageDialog("�޸Ĳ�����ɣ�",2);
				window.close();
				window.opener.doQueryApprove();
			} 
			else
			{
				rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
			}
		}	
		
		function getModiFilePath(filePath,file_name,source_name,info)
		{
	 		var retInfo = info.split("|");
	 	  	var flag = retInfo[0];//0:�ϴ��ɹ���-1��ʧ��
	 	  	if(flag == "0")
	 	  	{
	 	  		$("#m_file_path").val(filePath);
	 	  		source_name=unescape(source_name);
	 	  		modi_save_name[index]=source_name+"*"+file_name;
	 	  		index++;
	 	  		rdShowMessageDialog("�ϴ��ɹ���",2);
				showModiFile();
	 	  	}
	 	  	else if(flag == "-1")
	 	  	{
	 	  	  	rdShowMessageDialog("�ϴ�ʧ�ܣ�",0);
	 	  	}
	 	}	
	 	
	 	function showModiFile()
	 	{
	 		var list_name = modi_save_name[0];
			for(var i=1;i<modi_save_name.length;i++)
			{
				list_name = list_name+"|"+modi_save_name[i];
			}
			if(list_name==undefined)
			{
				$("#showModiFileDiv").html("");
				return;
			}
	 		var packet = new AJAXPacket("fo003_ajax_showFile.jsp");
	 		packet.data.add("list_name",list_name);
	 		core.ajax.sendPacketHtml(packet,doShowModiFile);
			packet=null;
	 	}
	 	
	 	function doShowModiFile(packet){
	 		$("#showModiFileDiv").html(packet);
	 	}
		
		
	
	</script>
<body>
<form id="frmg645" name="frmo003Upt" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��˰��������Ϣչʾ</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">��˰��ʶ��ţ�</td>
			<td>
					<input type=text name="taxpayer_id" value="<%=retList[0][1]%>" id="taxpayer_id" v_must="1" class="isLengthOf" v_maxlength="255" readonly/>
					<font class=orange>*</font>
			</td>
			<td class="blue">�������ͣ�</td>
			<td>
				<%
				    if("1".equals(taxpayer_type)){
				%>
				   <input  type=text name="taxpayer_type" id="taxpayer_type" value="��ֵ˰һ����˰��" readonly/>
				<%
				    }else if("2".equals(taxpayer_type)){
				%>
					<input  type=text name="taxpayer_type" id="taxpayer_type" value="��ֵ˰С��ģ��˰��" readonly/>
				<%   	
				    }else if("3".equals(taxpayer_type)){
				%>
					<input  type=text name="taxpayer_type" id="taxpayer_type" value="����ֵ˰��˰��" readonly/>
				<%   	
				    }
				%>
				<!-- <option value="1">��ֵ˰һ����˰��</option>
				<option value="2">��ֵ˰С��ģ��˰��</option>
				<option value="3">����ֵ˰��˰��</option> -->
				<font class=orange>*</font>
			</td>
        </tr>
        <tr>
			<td class="blue">��Ʊ���ͣ�</td>
			<td>
				<%
				    if("1".equals(bill_type)){
				%>
				   <input  type=text name="bill_type" id="bill_type" value="Ԥ�淢Ʊ" readonly/>
				<%
				    }else if("2".equals(bill_type)){
				%>
					<input  type=text name="bill_type" id="bill_type" value="�½ᷢƱ" readonly/>
				<%   	
				    }
				%>
				<font class=orange>*</font> 
			</td>
			<td class="blue">��ϵ�绰��</td>
			<td>
					<input type=text name="phone_no" value="<%=retList[0][6]%>" id="phone_no" v_must="1" class="isLengthOf" v_maxlength="255" readonly/>
					<font class=orange>*</font>
			</td>
        </tr>
        <tr>
			<td class="blue">���������У�</td>
			<td>
					<input type=text name="bank_name" value="<%=retList[0][7]%>" id="bank_name" v_must="1" class="isLengthOf" v_maxlength="255" readonly/>
					<font class=orange>*</font>
			</td>
			<td class="blue">�������ʺţ�</td>
			<td>
					<input type=text name="bank_account" value="<%=retList[0][8]%>" id="bank_account" v_must="1" class="isLengthOf" v_maxlength="255" readonly/>
					<font class=orange>*</font>
			</td>
        </tr>
        <tr id="bank_name" name="bank_name" >
							<td class="blue">�������У�</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_name_list" value="" style="width:80%" ><%=retList[0][15]%></textarea>
	  			<font class=orange>*</font>
	  		</td>
	  	</tr>
	  	<tr id="bank_num" name="bank_num" >
	  		<td class="blue">�����ʺţ�</td>
			<td colspan="3">
	  			<textarea rows="3"   id="bank_num_list" value="" style="width:80%" ><%=retList[0][16]%></textarea>
	  			<font class=orange>*</font>
	  		</td>
		</tr>
        <tr>
			<td class="blue">Ӫҵִ����Чʱ�䣺</td>
			<td>
				<input type="text" name="valid_date" id="valid_date" v_must="1" class="Wdate"  v_type="date" value="<%=retList[0][9]%>" readonly/>
				<font class=orange>*</font>
			</td>
			<td class="blue">Ӫҵִ��ʧЧʱ�䣺</td>
			<td>
				<input type="text" name="expire_date" id="expire_date"  v_must="1" class="Wdate"  v_type="date" value="<%=retList[0][10]%>" readonly/>
				<font class=orange>*</font>
			</td>
		</tr>				
		<tr>
			<td class="blue">
			��λ���ƣ�
			</td>
			<td colspan="3">
				<input type="text" id="unit_name" v_must="1" name="unit_name" value="<%=retList[0][4]%>" size="80" class="required isLengthOf" v_maxlength="255" readonly/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">
			��λ��ַ��
			</td>
			<td  colspan="3">
				<input type="text" id="unit_address" name="unit_address" v_must="1" value="<%=retList[0][5]%>" size="80" class="required isLengthOf" v_maxlength="255" maxlength="255" readonly/>
				<font class=orange>*</font>
			</td>
		</tr>
		<tr>
			<td class="blue">��ע:</td>
			<td colspan="3">
				<input type=text name="remark" id="remark" v_must="1" size="80" value="<%=retList[0][11]%>" class="isLengthOf" v_maxlength="128" readonly/>
				<font class=orange>*</font>
			</td>
		</tr>
    </table>
    <!-- <table cellspacing="0">
		<tr>
		<td class="blue">ɨ��֤����
			<select id="card_type11">
				<option value='1' >Ӫҵִ��</option>			
				<option value='2'>˰��Ǽ�֤</option>
				<option value='3'>һ����˰���ʸ�֤��</option>
				<option value='4'>���л���������֤��</option>
			</select>
		<input type="button" id="readByMultisss1" name="readByMultisss1" class="b_text"   value="ɨ��֤��" onClick="readByMultiss(1)" >
		</td>
	</tr>
</table> -->
    					<table>
							<tr>
			      			<!-- <iframe frameborder="0" id="ModifileUpLoadIF" name="ModifileUpLoadIF" width="100%" style="overflow:hidden;border:0;height:33px" src="fo003_modifile.jsp"></iframe>
			      			<input type="hidden" id="m_file_path" name="m_file_path" />
					        -->
					        <div class="title">
								<div class="text">��˰���ʸ���֤�����б�</div>
							</div>
			      			<div id='showModiFileDiv'>
						  
					        </div> 
			      			<input type="hidden" name="source_file_name" id="source_file_name"/>
							</tr>
							
						</table>
						
    <div id="operation_button">
    	<% if("1".equals(queryflag)) { %>
    	<input type="button" class="b_foot"
	value="�޸�" onclick="ApproveCom('1')" />
	<% } %>
</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
