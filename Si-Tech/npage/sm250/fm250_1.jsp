<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015/4/2 15:03:18-------------------

 -------------------------��̨��Ա��haoyy--------------------------------------------
 
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


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

function query(){
	if($("#iUnitId").val().trim()==""){
		rdShowMessageDialog("���伯�ű���");
		return;
	}
	
	 if(forNonNegInt(msgFORM.iUnitId) == false || $("#iUnitId").val().length!=10){
     msgFORM.iUnitId.value = "";
     rdShowMessageDialog("����ID������10λ���֣�");
     return false;
   }
        
	var packet = new AJAXPacket("fm250_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("iUnitId",$("#iUnitId").val().trim());//opcode
			core.ajax.sendPacket(packet,doQuery);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function doQuery(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				trObjdStr += "<tr>"+
												 "<td>"+retArray[i][0]+"</td>"+ 
												 "<td>"+retArray[i][1]+"</td>"+ 
												 "<td>"+retArray[i][2]+"</td>"+ 
												 "<td>"+retArray[i][3]+"</td>"+ 
												 "<td>"+retArray[i][4]+"</td>"+ 
												 "<td>"+retArray[i][5]+"</td>"+ 
												 "<td>"+retArray[i][6]+"</td>"+ 
												 "<td><input type=\"button\" value=\"����\" class=\"b_text\" onclick=\"reversal('"+retArray[i][0]+"','"+retArray[i][1]+"','"+retArray[i][2]+"')\"></td>"+
										 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}

//��������
function reversal(iGrpId,iAcceptCode,iFieldCode){
	var packet = new AJAXPacket("fm250_3.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("iGrpId",iGrpId);
			packet.data.add("iAcceptCode",iAcceptCode);
			packet.data.add("iFieldCode",iFieldCode);
			core.ajax.sendPacket(packet,doReversal);
			packet = null; 
}

function doReversal(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			rdShowMessageDialog("�����ɹ�",2);
			query();
	}else{
		  rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
	}
}
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>


<table cellSpacing="0">
	<tr>
	    <td class="blue" >���ű���</td>
		  <td>
			    <input type="text" name="iUnitId" id="iUnitId" value="" maxlength="10"/> 
		  </td>
	</tr>
</table>


<div class="title"><div id="title_zi">�������б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="10%">��ƷID</th>
        <th width="10%">������ˮ</th>
        <th width="10%">����������</th>
        <th width="20%">����������</th>	
        <th width="10%">��������</th>
        <th width="10%">������</th>
        <th width="20%">����ʱ��</th>
        <th width="10%">����</th>	
    </tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="query()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>