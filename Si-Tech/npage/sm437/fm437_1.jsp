<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ(hejwa)[2016/11/29 16:21:46]------------------
 
 
 -------------------------��̨��Ա��[liyang]--------------------------------------------
 
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

	String currentDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
%> 
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept" /> 
<%	
	String custName = "";
	String pp_name  = "";
	String id_type  = "";
	String id_iccid = "";
	
	/*
          ��ѯ�ͻ���Ϣ��������
  */
   String paraAray[] = new String[9];
   paraAray[0] = loginAccept;
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
        
	String custMailStr       = "";
	String custMailSql       = "select cust_address from dInvoiceMsg a where a.phone_no=:phoneNo";
	String custMailSql_param = "phoneNo="+activePhone;        
%>   	
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=custMailSql%>" />
		<wtc:param value="<%=custMailSql_param%>" />	
	</wtc:service>
	<wtc:array id="result_CustMail" scope="end"   />

<%
	if(result_CustMail.length>0){
		custMailStr = result_CustMail[0][0];
	}
%>		
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}


//��ѯ�ͻ�������Ϣ
function go_Cfm(){
			var inter_type = $("#inter_type").val();
			if(inter_type=="1"){
				if($("#cust_email").val().trim()==""){
					rdShowMessageDialog("��������������");
					return;
				}
			}
			
			if(inter_type=="3"){
				if($("#ipt_iTotalDate").val().trim()==""){
						rdShowMessageDialog("��������������");
						return;
				}
			}
	
		var ipt_iTotalDate = Number($("#ipt_iTotalDate").val())+"";//ȥ��01 ���ڵ�0
		
    var packet = new AJAXPacket("fm437_Cfm.jsp","���Ժ�...");
        packet.data.add("opCode","<%=opCode%>");//
        packet.data.add("phoneNo","<%=activePhone%>");//
        packet.data.add("inter_type",$("#inter_type").val());//
        packet.data.add("cust_email",$("#cust_email").val());//
        packet.data.add("ipt_iTotalDate",ipt_iTotalDate);//
        
    core.ajax.sendPacket(packet,doGetAjaxInfo);
    packet =null;
}
//��ѯ�ͻ�������Ϣ�ص�
function doGetAjaxInfo(packet){
    var error_code = packet.data.findValueByName("code");//���ش���
    var error_msg =  packet.data.findValueByName("msg");//������Ϣ

    if(error_code!="000000"){//���÷���ʧ��
      rdShowMessageDialog(error_code+":"+error_msg);
	    return;
    }else{//�����ɹ�
	    rdShowMessageDialog("�����ɹ�",2);
    	reSetThis();
    }
}

function set_show_info(){
	$("#tr_main").hide();
	$("#tr_date").hide();
	
	var inter_type = $("#inter_type").val();
	if(inter_type=="1"){
		$("#tr_main").show();
	}
	
	if(inter_type=="3"){
		$("#tr_date").show();
	}
	
}

$(document).ready(function(){
	set_show_info();
});
</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi"><%=opName%></div></div>


<table cellSpacing="0">
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
	<tr>
		
			<td class="blue">�ӿ�����</td>
		  <td colspan="3">
		  	<select id="inter_type" name="inter_type" onchange="set_show_info()">
				    <option value="1">ʡ���������ó�������</option>
				    <option value="2">ʡ������ȡ����������</option>
				</select>
		  </td>
		  

	</tr>

	
	<tr id="tr_main">
	    <td class="blue">�����ַ</td>
		  <td colspan="3">
			    <input type="text" name="cust_email" id="cust_email" value="<%=custMailStr%>" v_must="1"  v_type="email" onblur="checkElement(this)"/> 
			    <font class="orange">*</font>
		  </td>
	 
	</tr>  
	
	<tr id="tr_date">
		  <td class="blue" >��������</td>
		  <td colspan="3">
		  	<input type="text" name="ipt_iTotalDate" id="ipt_iTotalDate" value="01"  v_must="1"  onclick="WdatePicker({dateFmt:'dd',autoPickDate:true,onpicked:function(){}})" />  
				<font class="orange">����ÿ�¼��ս�������</font>
		  </td>
	</tr>
			
</table>




<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="ȷ��" onclick="go_Cfm()"            />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>