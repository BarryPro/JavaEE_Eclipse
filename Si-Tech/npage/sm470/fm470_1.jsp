<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------duming 2017.4.13------------------
 �����¹̻���Ʒ���ڵ���������ִ����ⱨ���ĺ�  �ں�ͨ����ͣ��ָ�ҵ��
 
 
 -------------------------��̨��Ա��gudd--------------------------------------------
 
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
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 

<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}

//
function tablehide(){
	$(".table tr:gt(0)").hide();
	}
	
function tableshow(){
	$(".table tr:gt(0)").show();
}


function doreturn(param){
	//alert(param);	
	$("#iccid").val(param[0]);//֤������
	$("#unit_name").val(param[1]);//��������
	$("#unit_id").val(param[2]);//���ű���
	$("#id_no").val(param[3]);//��Ʒ����
	$("#user_name").val(param[4]);//��Ʒ����
	$("#account_id").val(param[5]);//��Ʒ�˺�
	if(param[6]=='A'){//ҵ��״̬
		$("#run_code").val("����")
			$("#sel_opType option[value='r']").remove();
	
		}
	if(param[6]=='G'){
		$("#run_code").val("��ͣ");
	
		$("#sel_opType option[value='p']").remove();
		}
	if(param[0]==''){
		rdShowMessageDialog("��ѯʧ��",0);
		reSetThis();
		}
	
		
	}


//
function go_Query(){
	
	if($("#unitid").val().trim()==""){
		rdShowMessageDialog("�����뼯�ű���");
		return;
	}
		var unitid = $("#unitid").val().trim();	
 	 var path = "<%=request.getContextPath()%>/npage/sm470/fm470_Qry.jsp?unitid="+unitid;
	  window.open(path);
}



function go_Cfm(){
		var id_no = $("#id_no").val().trim();
		var sel_opType = $("#sel_opType option:selected").val();
		var opr = "";	
		var run_code ="";
		if("p"==sel_opType){
			opr = "00";
			}
		if("r"==sel_opType){
			opr = "01";
			}
		if("p"==sel_opType){
		run_code = "G";
		}
		if("r"==sel_opType){
			run_code = "A";
		}       
		
	
		
		//alert(run_code);
	
		if(rdShowConfirmDialog("ȷ��Ҫ�ύ��Ϣ��")!=1) return;
		var pactket = new AJAXPacket("fm470_Cfm.jsp","���ڲ��������Ժ�......");
 			
 			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("id_no",id_no);
			pactket.data.add("sel_opType",sel_opType);
			pactket.data.add("opr",opr);
			pactket.data.add("run_code",run_code);
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
		

		
}

//�ص�
function do_Cfm(pactket){
	var code = pactket.data.findValueByName("code");
	var msg  = pactket.data.findValueByName("msg"); 
	var retArray  = pactket.data.findValueByName("retArray"); 

	
	if(code=="000000"){	
		rdShowMessageDialog("�����ɹ�",2);
	}else{
		rdShowMessageDialog("ʧ�ܣ�"+code+"��"+msg,0);
	}
	
	reSetThis();
}



</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0" class="table">
	<tr>
	    <td class="blue" width="15%" >���ű���</td>
			<td colspan="3">
		  <input type="text" id="unitid" name="unitid" value="4510976840"/>
		  <input type="button" class="b_text" value="��ѯ" onclick="go_Query()"/>
		  </td>
	</tr>

	<tr style="display:none">
	    <td class="blue">֤������</td>
		  <td>
			    <input type="text" name="iccid" id="iccid" value=""   /> 
		  </td>
		  <td class="blue" >���ſͻ�����</td>
		  <td>
		  	 <input type="text" name="unit_name" id="unit_name"  value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">����ecid</td>
		  <td>
			    <input type="text" name="unit_id" id="unit_id" value=""   /> 
		  </td>
		  <td class="blue" >��Ʒ����</td>
		  <td>
		  	 <input type="text" name="id_no" id="id_no" value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">��Ʒ����</td>
		  <td>
			    <input type="text" name="user_name" id="user_name" value=""   /> 
		  </td>
		  <td class="blue" >�˻�id</td>
		  <td>
		  	 <input type="text" name="account_id" id="account_id" value=""   /> 
		  </td>
	</tr>
	<tr style="display:none">
	    <td class="blue">ҵ��״̬</td>
		  <td>
			    <input type="text" name="run_code" id="run_code" value=""   /> 
		  </td>
		   <td class="blue">��������</td>
		  <td>
			    <select id="sel_opType" name="sel_opType" >
				    <option id="p" value="p">��ͣ</option>
				    <option id="r" value="r" >�ָ�</option>
				</select>
		  </td>
	</tr>

</table>



<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="�޸�" onclick="go_Cfm()"          />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  />
	 	</td>
	</tr>
</table>
</FORM>
</BODY>
</HTML>