<%
/********************
 
 -------------------------����-----------�ξ�ΰ(hejwa) 2015/3/18 17:10:31-------------------
����ҵ���߼���ƣ�
1��������ҵӦ����������ѯ���ܣ��ù�����bossǰ̨ʹ��ͬʱҲ�ṩ���ͷ�ϵͳʹ�á���ѯ�������ֻ�����
��ѯ��������ͼ��ű��롢���С����ء����ſͷ��绰������Ϊ�գ����������ʷ����ƣ��������������ʷѿ�ʼʱ�䣬�ʷѽ���ʱ�䣬�����˵绰������ʱ�䣬������������վ���ſͻ�����ƽ̨��
2����ѯ���ܲ���Ҫ�ṩ�ֻ�����ķ������룬��ѯ��¼Ϊ��ǰ��Ч�Լ�ԤԼ��Ч���������ʷ���Ϣ��ͬʱ�����ʷ���Чʱ�䵹������չʾ��
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
 
//��ѯ������Ϣ��ѯ
function doQuery(){
	
	if($("#phoneNo").val().trim()==""){
		rdShowMessageDialog("�������ֻ�����");
		return;
	}
	
	var packet = new AJAXPacket("fm248_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("phoneNo",$("#phoneNo").val().trim());//
			core.ajax.sendPacket(packet,doAjaxGetAndroidCrmUpgList);
			packet = null; 
}
//��ѯ������Ϣ��ѯ���ص�
function doAjaxGetAndroidCrmUpgList(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
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
												 "<td>"+retArray[i][7]+"</td>"+ 
												 "<td>"+retArray[i][8]+"</td>"+ 
												 "<td>"+retArray[i][9]+"</td>"+ 
												 "<td>"+retArray[i][10]+"</td>"+ 
										 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
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
	    <td class="blue" width="11%">�ֻ�����</td>
		  <td width="22%">
			    <input type="text" name="phoneNo" id="phoneNo" value="" maxlength="11" /> <font class="orange">*</font>
		  </td>
	</tr>
</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="��ѯ" onclick="doQuery()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<div class="title"><div id="title_zi">������Ϣ��ѯ���</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>���ͼ��ű���</th>
        <th>����</th>
        <th>����</th>
        <th>���ſͷ��绰</th>	
        <th>�������ʷ�����</th>
        <th>ÿ�»�������������</th>	
        <th>�ʷѿ�ʼʱ��</th>	
        <th>�ʷѽ���ʱ��</th>	
        <th>�����˵绰</th>	
        <th>����ʱ��</th>	
        <th>��������</th>	
    </tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>