<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa) 2015-7-10 14:13:47-------------------
 ������ҵ��ͨ�Ż�����
 ��Ҫ����һ������ 2��TAB��������������ѯ������Ϣչʾ����ȷ�ϣ����÷���
 -------------------------��̨��Ա������--------------------------------------------
 update 2017-01-20 ���������������Ż������� �����������빦�� liangyl
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
<head><title><%=opName%></title>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script language=JavaScript>

$(function(){
	batchBut();
})
//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

//��ѯ��̬չʾIMEI�����б�
function go_query(){
	
	var packet = new AJAXPacket("fm277_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneIn").val());// 
			core.ajax.sendPacket(packet,do_query);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				 var td_4 = "";
				 if(retArray[i][4]=="01"){//01��ͨ����ʾ��ͣ��ť
				 	td_4 = "<input type='button' class='b_text' value='��ͣ' onclick='go_offer_upg(\""+retArray[i][5]+"\",\"m277\")' >";
				 }else if(retArray[i][4]=="04"){//04��ͣ����ʾ�ָ���ť
				 	td_4 = "<input type='button' class='b_text' value='�ָ�' onclick='go_offer_upg(\""+retArray[i][5]+"\",\"m278\")' >";
				 }
														 
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+//
														 "<td>"+td_4+"</td>"+//
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

//��ͣ
function go_offer_upg(param,opcode){
		var packet = new AJAXPacket("fm277_3.jsp","����ִ��,���Ժ�...");
				packet.data.add("opCode",opcode);//opcode
				packet.data.add("param",param);// 
				packet.data.add("phoneNo",$("#phoneIn").val());// 
				core.ajax.sendPacket(packet,do_offer_upg);
				packet = null; 
}

function do_offer_upg(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){
		 rdShowMessageDialog("�����ɹ�",2);
		 reSetThis();
	}else{
		 rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
	}
}

function batchBut(){
	var opType = $("input[type='radio'][name='opType']:checked").val();
	if(opType=="1"){
		$("#phoneInTr").show();
		$("div[id='title_zi']").eq(1).show();
		$("#upgMainTab").show();
		$("#footerTr").show();
		
		$("#batchFileTr").hide();
		$("#operTr").hide();
		$("#promptTr").hide();
		$("#footer2Tr").hide();
	}
	else if(optype="2"){
		$("#phoneInTr").hide();
		$("div[id='title_zi']").eq(1).hide();
		$("#upgMainTab").hide();
		$("#footerTr").hide();
		
		$("#batchFileTr").show();
		$("#operTr").show();
		$("#promptTr").show();
		$("#footer2Tr").show();
	}
}

function doCfm(){
	if($("#batchFile").val().length<1){
		rdShowMessageDialog("���ϴ��ļ�!");
		$("#batchFile")[0].focus();
		return false;
	}
	//var fileVal = getFileName($("#feefile").val());
	var fileVal = getFileExt($("#batchFile").val());
	if("txt" == fileVal){
		//��չ����txt
	}else{
		rdShowMessageDialog("�ϴ��ļ�����չ������ȷ,ֻ���Ǻ�׺Ϊtxt�����ļ���",0);
		return false;
	}
	$("#importBut").attr("disabled",true);
	$("#msgFORM").attr("action","fm277Cfm.jsp");
	$("#msgFORM").submit();
}

function getFileExt(obj)
{
    var pos = obj.lastIndexOf(".");
    return obj.substring(pos+1);
}

</script>
</head>	
<body>
<form id="msgFORM" name="msgFORM" action="" method="post" enctype="multipart/form-data"> 
<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>
<table cellspacing="0">
	<tr>
		<td class="blue" width="50%" colspan="2">ҳ�����</td>
	    <td class="blue" colspan="2">
			<input type="radio" name="opType" value="1" checked="checked" onclick="batchBut()"/>��������
			<input type="radio" name="opType" value="2" onclick="batchBut()"/>��������
	    </td>
	</tr>
	<tr id="operTr" style="display: none">
	    <td class="blue" width="30%">��������</td>
		<td>
			<select id="operType" name="operType">
				<option value="m277">��ͣ</option>
				<option value="m278">�ָ�</option>
			</select>
		</td>
		<td class="blue" width="30%">ҵ�����</td>
		<td>
		   <select id="busiType" name="busiType">
				<option value="I00010100035">GPRS���������Ʒ</option>
				<option value="I00010100085">����ͨ�ŷ���</option>
			</select>
		</td>
	</tr>
	<tr id="phoneInTr">
	    <td class="blue" width="30%" colspan="2">�ֻ�����</td>
		<td colspan="2">
		   <input type="text" name="phoneIn" id="phoneIn" value="<%=activePhone%>" readonly="readonly" class="InputGrey" /> 
		</td>
	</tr>
	<tr id="batchFileTr" style="display: none;">
	  	<td class="blue" width="30%" colspan="2"><font id="leadLable">�����ļ�</font></td>
		<td colspan="2">
	    	<input type="file" id="batchFile" name="batchFile"/> 
	  	</td>
	</tr>
	<tr id="promptTr" style="display: none;">
		<td align="left" colspan="4">
		<font id="prompt" color="red">
		���ϴ�txt�ļ�,�ļ���ÿ������ռһ��,һ����ർ��500���ֻ�����,��ʽ��: <br/>
		1064804510001|<br/>
		14704510001|
		</font></td>
	</tr>
</table>

<div class="title"><div id="title_zi">�ʷ��б�</div></div>
<table cellspacing="0" id="upgMainTab">
    <tr>
        <th width="15%">�ʷѱ���</th>
        <th width="20%">�ʷ�����</th>
        <th width="25%">��ʼʱ��</th>
        <th width="25%">����ʱ��</th>	
        <th >����</th>
    </tr>
</table>
<table cellspacing="0">
	 <tr id="footerTr">
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="go_query()"/>
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"/> 
	 	</td>
	</tr>
	<tr id="footer2Tr" style="display: none">
		<td id="footer">
		 	<input type="button" id="importBut" class="b_foot" value="�����ύ" onclick="doCfm()"/> 
		 	<input type="button" class="b_foot" value="����" onclick="reSetThis()"/> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"/> 
	 	</td>
 	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>