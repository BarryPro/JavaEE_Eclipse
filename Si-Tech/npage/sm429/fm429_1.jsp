<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2016/11/8 20:27:33]------------------
 ���ڹ�������ҵ�������Ż�ҵ��֧��ϵͳ�����֪ͨ
 
 -------------------------��̨��Ա��[jianglei]--------------------------------------------
 
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

	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_iccid = "";
	
	/*
          ��ѯ�ͻ���Ϣ��������
  */
   String paraAray[] = new String[9];
   paraAray[0] = "";
   paraAray[1] = "01";
   paraAray[2] = opCode;
   paraAray[3] = workNo;
   paraAray[4] = password;
   paraAray[5] = activePhone;
   paraAray[6] = "";
   paraAray[7] = "";
   paraAray[8] = "ͨ��phoneNo[" + activePhone + "]��ѯ�ͻ���Ϣ";
%>


	
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="40" >
      <wtc:param value="<%=paraAray[0]%>"/>
      <wtc:param value="<%=paraAray[1]%>"/>
      <wtc:param value="<%=paraAray[2]%>"/>
      <wtc:param value="<%=paraAray[3]%>"/>
      <wtc:param value="<%=paraAray[4]%>"/>
      <wtc:param value="<%=paraAray[5]%>"/>
      <wtc:param value="<%=paraAray[6]%>"/>
      <wtc:param value="<%=paraAray[7]%>"/>
      <wtc:param value="<%=paraAray[8]%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>
<wtc:array id="result_t2" scope="end" />

<%

 

String custBrandName = "";
        if("000000".equals(retCode2)){
            if(result_t2.length>0){
                    custName = result_t2[0][5];
                    pp_name  = result_t2[0][38];
                    id_type  = result_t2[0][12];
                    id_iccid = result_t2[0][13];
                    
              if (pp_name.equals("gn")) {
								custBrandName = "ȫ��ͨ";
							} else if (pp_name.equals("zn")) {
								custBrandName = "������";
							} else if (pp_name.equals("dn")) {
								custBrandName = "���еش�";
							} 
							
            }
        }else{
%>
            <script language="JavaScript">
                    rdShowMessageDialog("���û����������û���״̬��������");
                    removeCurrentTab();
            </script>
<%              
        }
        

String  offer_info_sql = "select a.ProId,a.Fee ,b.offer_name from DBCUSTADM.SGPRSMODE a ,product_offer b where a.offer_id=b.offer_id  and a.offer_id!='58137'  and a.offer_id!='58136' order by b.offer_name  ";
System.out.println("-------hejwa--------------offer_info_sql----------->"+offer_info_sql);

String  quit_offer_sql = " select a.prodid, a.prodinstid, b.offer_name  "+
												 " 	  from dbcustadm.dGPRSMsg a, DBCUSTADM.SGPRSMODE c, product_offer b  "+
												 " 	 where a.prodid = c.proid  "+
												 " 	   and c.offer_id = b.offer_id  and a.prodtype = '01'  and a.expiretime > to_char(sysdate, 'yyyymmddhh24miss')"+
												 " 	   and a.phone_no = :phone_no  and b.offer_id!='58136'";

System.out.println("-------hejwa--------------quit_offer_sql----------->"+quit_offer_sql);
												 
String  query_offer_sql = " select a.prodid, a.prodinstid, b.offer_name  "+
												 " 	  from dbcustadm.dGPRSMsg a, DBCUSTADM.SGPRSMODE c, product_offer b  "+
												 " 	 where a.prodid = c.proid  "+
												 " 	   and c.offer_id = b.offer_id  "+
												 " 	   and a.phone_no = :phone_no  and b.offer_id!='58136'";
												 
												 												 
String  quit_offer_prm = "phone_no="+activePhone;
%>   	


  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=offer_info_sql%>" />
	</wtc:service>
	<wtc:array id="result_Offer" scope="end" />
		
  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=quit_offer_sql%>" />
		<wtc:param value="<%=quit_offer_prm%>" />	
	</wtc:service>
	<wtc:array id="result_QuitOffer" scope="end" />		
		
  <wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=query_offer_sql%>" />
		<wtc:param value="<%=quit_offer_prm%>" />	
	</wtc:service>
	<wtc:array id="result_QueryOffer" scope="end" />				
		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//�ֻ�����
var COM_OPCODE = "";


//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//
function go_Query(){
	if($("#sel_q_accept").val()==""){
		rdShowMessageDialog("��ѡ���ѯ��ˮ");
		return;
	}
	
 	var pactket = new AJAXPacket("fm429_Query.jsp","���ڽ��в�ѯ�����Ժ�......");
			pactket.data.add("opCode","m431");
			pactket.data.add("phoneNo","<%=activePhone%>");
			pactket.data.add("sel_q_accept",$("#sel_q_accept").val());
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

/*			
8	MSISDN			1	String	V32		�ֻ�����				�ƶ��û��ն˺��룬������+86�����ֻ����롣
9	UserType		1	String	F2		�û�����				00 �C �����û�01 �C �����û�
10	GroupName		��	String	V256	��������				UserTypeΪ01ʱ��д����ʹ�ú�����д
11	ProvCode		1	String	F3		ʡ����					�û�����ʡ�������¼ʡ�����
12	oprTIMSI		1	String	F14		������ϵ��ѯ����ʱ��	������ϵ��ѯ����ʱ���ʽ�磺YYYYMMDDHHmmSS
13	ProdInstID		1	String	V32		��Ʒ������ˮ��			�û�������Ʒ������һ��Ψһ�Ķ�����ˮ��
14	ProdID			1	String	V32		��ƷID					��ƷID
15	ProdType		1	String	F2		��Ʒ����				00 �C һ���Բ�Ʒ 01 �C �����Բ�Ʒ
16	ProdStat		?	String	F2		��Ʒ״̬				00 �C δ���δ����01 �C δ����ѹ���02 �C �Ѽ������ʹ��03 �C �Ѽ��ʹ�����04 �C ���˶�05 �C �������˶�
17	Efftime			1	String	V32		������Чʱ��			��Ʒ�ɹ�������ʱ���ʽ�磺YYYYMMDDHHmmSS
18	expireTIMSI		1	String	F14		��������ʱ��			�û������ڶ�������ʱ��ǰʹ�ø�ʽ�磺YYYYMMDDHHmmSS
19	Activetime		��	String	F14		��Ʒ����ʱ��			ProdType��Ʒ����ȡֵΪ01ʱ����д�û��״�ʹ�õ�ʱ�䣬�����û�������Ϣʱû�и�ʱ��ġ���ʽ�磺YYYYMMDDHHmmSS
20	Deadlinetime	��	String	F14		��ƷʧЧʱ��			ProdType��Ʒ����ȡֵΪ01ʱ����д��Ʒ��Դʹ����ϵ�ʱ���ʽ�磺YYYYMMDDHHmmSS
21	feeaccessMod	1	String	V256	��������				�����������ɹ������нڵ�ʹ�ú��ֻ���Ӣ����д�磺���ŵȣ�
*/
			
			for(var i=0;i<retArray.length;i++){
					var j_UserType = "δ֪";
					if(retArray[i][9].trim()=="00"){
						j_UserType = "�����û�";
					}
					if(retArray[i][9].trim()=="01"){
						j_UserType = "�����û�";
					}
					
					var j_ProdType = "δ֪";
					if(retArray[i][15].trim()=="00"){
						j_ProdType = "һ���Բ�Ʒ";
					}
					if(retArray[i][15].trim()=="01"){
						j_ProdType = "�����Բ�Ʒ";
					}
					
					var j_ProdStat = "δ֪";
					if(retArray[i][16].trim()=="00"){
						j_ProdStat = "δ���δ����";
					}
					if(retArray[i][16].trim()=="01"){
						j_ProdStat = "δ����ѹ���";
					}
					if(retArray[i][16].trim()=="02"){
						j_ProdStat = "�Ѽ������ʹ��";
					}
					if(retArray[i][16].trim()=="03"){
						j_ProdStat = "�Ѽ��ʹ�����";
					}
					if(retArray[i][16].trim()=="04"){
						j_ProdStat = "���˶�";
					}
					if(retArray[i][16].trim()=="05"){
						j_ProdStat = "�������˶�";
					}
					
				  //�����һ���ռ�¼��չʾ�����񷵻�����Ϊ���ַ���������Ľ�����߼���ɾ��
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][8]+"</td>"+ //
														 "<td>"+j_UserType+"</td>"+ //
														 "<td>"+retArray[i][10]+"</td>"+ //
														 "<td>"+retArray[i][11]+"</td>"+//
														 "<td>"+retArray[i][12]+"</td>"+//
														 "<td style='word-break:break-all'>"+retArray[i][13]+"</td>"+//
														 "<td style='word-break:break-all'>"+retArray[i][14]+"</td>"+//
														 "<td>"+j_ProdType+"</td>"+//
														 "<td>"+j_ProdStat+"</td>"+//
														 "<td>"+retArray[i][17]+"</td>"+//
														 "<td>"+retArray[i][18]+"</td>"+//
														 "<td>"+retArray[i][19]+"</td>"+//
														 "<td>"+retArray[i][20]+"</td>"+//
														 "<td>"+retArray[i][21]+"</td>"+//
												 "</tr>";
			}
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#div_show_result").show();
			$("#tab_show_result tr:gt(0)").remove();
			$("#tab_show_result tr:eq(0)").after(trObjdStr);
			
	}else{
			$("#div_show_result").hide();
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
	}
}


//
function go_Cfm(opcode,opTypeCode){

	var j_prodId = "";
	if($("#sel_optype").val()=="m429"){
		if($("#sel_prodId").val()==""){
			rdShowMessageDialog("��ѡ�񶩹��ʷ�");
			return;
		}
		j_prodId = $("#sel_prodId").val();
	}else if($("#sel_optype").val()=="m430"){
		if($("#sel_q_prodId").val()==""){
			rdShowMessageDialog("��ѡ���˶��ʷ�");
			return;
		}
		alert("888888");
		j_prodId = $("#sel_q_prodId").val();
	}else{
		go_Query();
		return;
	}
	
	
 	var pactket = new AJAXPacket("fm429_Cfm.jsp","���ڽ��в�ѯ�����Ժ�......");
 			pactket.data.add("opTypeCode",$("#sel_optype").find("option:selected").attr("v_opTypeCode"));
			pactket.data.add("opCode",$("#sel_optype").val());
			pactket.data.add("phoneNo","<%=activePhone%>");
			pactket.data.add("prodId",j_prodId);
			
			core.ajax.sendPacket(pactket,do_Cfm);
			pactket=null;
}
// �ص�
function do_Cfm(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//
		rdShowMessageDialog("Ԥ��������ɹ�",2);
		reSetThis();
	}else{
		rdShowMessageDialog("Ԥ�������ʧ�ܣ�"+code+"��"+msg,0);
	}
}


function set_offer_show(){
	$("#div_show_result").hide();
	
	if($("#sel_optype").val()=="m429"){
		$("#tr_show1").show();
		$("#tr_show2").hide();
		$("#tr_show3").hide();
	}  
	
	if($("#sel_optype").val()=="m430"){
		$("#tr_show1").hide();
		$("#tr_show2").show();
		$("#tr_show3").hide();
	}
	
	if($("#sel_optype").val()=="m431"){
		$("#tr_show1").hide();
		$("#tr_show2").hide();
		$("#tr_show3").show();
	}
	
}


$(document).ready(function(){
	$("#sel_optype").val("<%=opCode%>");
	set_offer_show();
});

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
	<tr>
			<td class="blue" width="15%">��������</td>
	    <td class="blue" colspan="3">
	    	<select id="sel_optype" name="sel_optype" onchange="set_offer_show()">
				    <option v_opTypeCode="01" value="m429" selected >����</option>
				    <option v_opTypeCode="02" value="m430">�˶�</option>
				    <option v_opTypeCode="03" value="m431">��ѯ</option>
				</select>
	    </td>
	</tr>
		
	<tr>
	    <td class="blue" width="15%">�ֻ�����</td>
		  <td width="35%">
			    <%=activePhone%>
		  </td>
		  <td class="blue" width="15%">�ͻ�����</td>
		  <td>
			    <%=custName%>
		  </td>
	</tr>
	<tr id="tr_show1">
	    <td class="blue">�����ʷ�</td>
		  <td colspan="3">
		  	<select id="sel_prodId" name="sel_prodId" style="width:400px">
				    <option value="">--��ѡ��--</option>
				    <%
				    for(int i=0;i<result_Offer.length;i++){
				    %>
				    		<option value="<%=result_Offer[i][0]%>"><%=result_Offer[i][2]%>-><%=result_Offer[i][1]%>Ԫ</option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>
	
	<tr id="tr_show2" style="display:none">
	    <td class="blue">�˶��ʷ�</td>
		  <td colspan="3">
		  	<select id="sel_q_prodId" name="sel_q_prodId" style="width:400px">
				    <option value="">--��ѡ��--</option>
				    <%
				    for(int i=0;i<result_QuitOffer.length;i++){
				    %>
				    		<option value="<%=result_QuitOffer[i][0]%>"><%=result_QuitOffer[i][2]%></option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>

	
	<tr id="tr_show3" style="display:none">
	    <td class="blue">��ѯ��ˮ</td>
		  <td colspan="3">
		  	<select id="sel_q_accept" name="sel_q_accept" style="width:400px">
				    <option value="">--��ѡ��--</option>
				    <%
				    for(int i=0;i<result_QueryOffer.length;i++){
				    %>
				    		<option value="<%=result_QueryOffer[i][1]%>" ><%=result_QueryOffer[i][1]%>--><%=result_QueryOffer[i][2]%></option>
				    <%	
				   	}
				    %>
				</select>
		  </td>
	</tr>

</table>


<div id="div_show_result" style="display:none">
<div class="title"><div id="title_zi">��ѯ����б�</div></div>
<TABLE cellSpacing="0" id="tab_show_result">
    <tr>
				<th>�ֻ�����</th>
				<th>�û�����</th>
				<th>��������</th>
				<th>ʡ����</th>
				<th>������ϵ��ѯ����ʱ��</th>
				<th>��Ʒ������ˮ��</th>
				<th>��ƷID</th>
				<th>��Ʒ����</th>
				<th>��Ʒ״̬</th>
				<th>������Чʱ��</th>
				<th>��������ʱ��</th>
				<th>��Ʒ����ʱ��</th>
				<th>��ƷʧЧʱ��</th>
				<th>��������</th>
    </tr>
</table>
</div>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 	</td>
	</tr>
</table>


<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>