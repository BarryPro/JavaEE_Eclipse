<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2017/1/9 17:08:14]------------------
 �����������¿�ҵ����Ż�����
 
 -------------------------��̨��Ա��[wangzc]--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo     = (String)session.getAttribute("workNo");
  String password   = (String)session.getAttribute("password");
  String regionCode = (String)session.getAttribute("regCode");

%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#ipt_phoneNo").val().trim()==""){
		rdShowMessageDialog("�������ֻ�����");
		return;
	}
	//m239��������ҵ��ͨ״̬��ѯ  ��ӡ�������÷������״̬
 	var pactket = new AJAXPacket("fm444_Qry.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
 	
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("phoneNo",$("#ipt_phoneNo").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
// �ص�
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
						
						var td1 = "";
						var td2 = "";
						var td3 = "";
						var td4 = "";
						for(var i=0;i<retArray.length;i++){
							if("7005"==retArray[i][1]){
								td1 = "<td>"+retArray[i][0]+"</td>";
							}
							if("7006"==retArray[i][1]){
								td2 = "<td>"+retArray[i][0]+"</td>";
							}
							td3 = "<td>"+retArray[i][2]+"</td>";
							td4 = "<td>"+retArray[i][3]+"</td>";
						}								
						
				trObjdStr += "<tr>"+
											td1+
											td2+
											td3+
											td4+
						         "</tr>";
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
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
		  <td class="blue" width="15%">�ֻ�����</td>
		  <td class="blue"  >
		  	<input type="text" class="ipt_phoneNo" value="" id="ipt_phoneNo"   />
		  	 <input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"          />
		  </td>
		 
	</tr>
</table>

<div class="title"><div id="title_zi"><%=opName%>-��ѯ����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="25%">��������</th>
        <th width="25%">��������</th>
        <th width="25%">����ʱ��</th>
        <th  >��ϵ����</th>
    </tr>
</table>

 

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>