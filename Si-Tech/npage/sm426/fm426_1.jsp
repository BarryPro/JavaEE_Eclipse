<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)2016/11/3 13:31:53------------------
 ����5����Ѯ���ſͻ���CRM��BOSS�;���ϵͳ����ĺ�--1�����ڽ���ʡ������ר�߶���������BOSSǨ����ESOPϵͳ������
 
 -------------------------��̨��Ա��wuxy--------------------------------------------
 
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
	
	String sql_region_list = "select��a.region_code,a.region_name from sregioncode a where a.use_flag='Y' order by a.region_code";
	
	
%> 
  <wtc:service name="TlsPubSelCrm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql_region_list%>" />
	</wtc:service>
	<wtc:array id="result_region_list" scope="end" />
		
		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

 
function go_Query(){
	if($("#qry_val").val().trim()==""){
		rdShowMessageDialog("�������ѯֵ");
		return;
	}
 	var pactket = new AJAXPacket("fm426_GetList.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("qry_val",$("#qry_val").val().trim());
			pactket.data.add("qry_type",$("#qry_type").val());
			pactket.data.add("opCode","<%=opCode%>");
			core.ajax.sendPacket(pactket,do_Query);
			pactket2=null;
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_Query(packet){
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
														 "<td><input type='checkbox'  /></td>"+ //
														 "<td>"+retArray[i][0]+"</td>"+ //
														 "<td>"+retArray[i][1]+"</td>"+ //
														 "<td>"+retArray[i][2]+"</td>"+ //
														 "<td>"+retArray[i][3]+"</td>"+ //
														 "<td>"+retArray[i][4]+"</td>"+ //
														 "<td>"+retArray[i][5]+"</td>"+ //
														 "<td>"+retArray[i][6]+"</td>"+ //
														 "<td>"+retArray[i][7]+"-"+retArray[i][8]+"</td>"+ //
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


function go_set_selWorkNo(bt){
	var sel_region_code = $(bt).val();
	
	if(sel_region_code==""){
		$("#sel_workNo option").remove();
		return;
	}
	
	var pactket = new AJAXPacket("fm426_getWorkNoByRegion.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("sel_region_code",sel_region_code);
			core.ajax.sendPacket(pactket,do_set_selWorkNo);
			pactket2=null;
}


function do_set_selWorkNo(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg  = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			$("#sel_workNo option").remove();
			
			for(var i=0; i<retArray.length; i++){
				$("#sel_workNo").append("<option value='"+retArray[i][0]+"'>"+retArray[i][1]+"</option>");
			}
			
	}
}

function go_Cfm(){
	if($("#sel_workNo").val()==""||$("#sel_workNo").val()==null){
		rdShowMessageDialog("��ѡ�񹤺�");
		return;
	}
	
	var iProdOrderStr = "";
	
	
	$("#upgMainTab").find("input[type='checkbox']:checked").each(function(){
		iProdOrderStr = iProdOrderStr +$(this).parent().parent().find("td:eq(4)").html().trim()+"|";
	});
	
	if(iProdOrderStr.length==0){
		rdShowMessageDialog("��ѡ�񶩵�");
		return;
	}
	if(iProdOrderStr.split("|").length>11){
		rdShowMessageDialog("ѡ�񶩵����ܳ���10����¼");
		return;
	}
 	var pactket = new AJAXPacket("fm426_Cmf.jsp","���ڽ��е��ӹ���״̬�޸ģ����Ժ�......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("iProdOrderStr",iProdOrderStr);
			pactket.data.add("sel_workNo",$("#sel_workNo").val());
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket2=null;	
}
function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){
		rdShowMessageDialog("�����ɹ�",2);
		reSetThis();
	}else{
		rdShowMessageDialog("����ʧ�ܣ�"+code+"��"+msg,0);
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
	    <td class="blue" width="15%">��ѯ����</td>
		  <td width="35%">
			    <select id="qry_type" name="qry_type" onchange="">
					    <option value="1">EC���ſͻ�����</option>
					    <option value="2">��Ʒ������</option>
					    <option value="3">��Ʒ������</option>
					    <option value="4">��Ʒ������ϵ����</option>
					    <option value="5">��Ʒ������ϵ����</option>
					</select>
		  </td>
		  <td class="blue" width="15%">��ѯֵ</td>
		  <td>
			    <input type="text" id="qry_val" name="qry_val" v_type="string"  onblur = "checkElement(this)" maxlength="32" value="" />
			    &nbsp;
			    <input type="button" class="b_foot" value="��ѯ" onclick="go_Query()"          />
		  </td>
	</tr>

</table>


<div class="title"><div id="title_zi">�����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
    		<th >ѡ��</th>
        <th >EC���ſͻ�����</th>
        <th >EC���ſͻ�����</th>
        <th >��Ʒ������</th>
        <th >��Ʒ������</th>	
        <th >��Ʒ������ϵ����</th>
        <th >��Ʒ������ϵ����</th>	
        <th >��������ʱ��</th>	
        <th >�ѷ��乤��</th>	
    </tr>
</table>

<table cellSpacing="0" >
	<tr>
	    <td class="blue" width="15%">ѡ�����</td>
		  <td width="35%">
		  	<select id="sel_region" name="sel_region" onchange="go_set_selWorkNo(this)">
				    <option value="">--��ѡ��--</option>
<%
						for(int i=0; i<result_region_list.length; i++){					
%>				
								<option value="<%=result_region_list[i][0]%>"><%=result_region_list[i][1]%></option>
<%
						}
%>    
				</select>
		  </td>
		  <td class="blue" width="15%">ѡ�񹤺�</td>
		  <td width="35%">
		  	<select id="sel_workNo" name="sel_workNo">
				</select>
		  </td>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>