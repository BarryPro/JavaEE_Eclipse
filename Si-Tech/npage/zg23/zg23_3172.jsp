<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %> 
<%@ page import="java.util.*" %>
<%
String opCode = "zg23";
String opName = "��ֵ˰רƱ��������";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var phone_no = document.frm.phone_no.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("������һ��֧���˻�����!");
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("../zg12/zg12_check.jsp","���ڽ��в�ѯ�����Ժ�......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("flag","A");//1=���ֻ������ѯ A=��һ��֧��
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
} 

	
function doProcess(packet)
{
	var s_zf = packet.data.findValueByName("s_zf"); 
	var s_tax_no = packet.data.findValueByName("s_tax_no"); 
	var s_qry_flag= packet.data.findValueByName("s_qry_flag"); 
	var s_contract_no = packet.data.findValueByName("s_contract_no");
	var s_contract_name= packet.data.findValueByName("s_contract_name");
	var s_flag = packet.data.findValueByName("s_flag");
	var s_flag_new="";//N�������½ӿڲ�ѯ�ֵܷ� O���Ͻӿ����ܷ�
	var s_zf_flag="";//�жϲ�ѯ�����ܵ� ���Ƿֵ� Y D N
	var oCustId = packet.data.findValueByName("oCustId");
	//alert("s_flag is "+s_flag+" and oCustId is "+oCustId+" and s_qry_flag is "+s_qry_flag+" and s_tax_no is "+s_tax_no);
	//alert("s_zf is "+s_zf);
	if(s_flag=="Y")
	{
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		//alert("1");
		//1.��ѯcust_id ���û�ȥѡ
		returnValue = window.showModalDialog('../zg12/getContractByCustId.jsp?cust_id='+oCustId+"&tax_no="+s_tax_no+"&qry_flag=1","",prop);
		//alert(returnValue);
		document.frm.tax_contract_no.value=returnValue.split(",")[6];
		document.frm.tax_name.value=returnValue.split(",")[2];
		document.frm.tax_no1.value=returnValue.split(",")[1];
		document.frm.tax_address.value=returnValue.split(",")[3];
		document.frm.tax_phone.value=returnValue.split(",")[4];
		document.frm.tax_khh.value=returnValue.split(",")[5];
		document.frm.action="zg23_2.jsp?s_flag=0&phone_no="+document.all.phone_no.value;
		//alert("test?"+document.frm.action);
		document.frm.submit();
	}
	else
	{
			alert("˰��ǼǺ��벻���ڣ�����������!");
			return false;
	}	
	
}

 
 
  function doclear() {
 		frm.reset();
 }


 function inits()
 {
	 //document.getElementById("query_id").disabled=true;
	
 }
 function sel1()
 {
	window.location.href='zg23_1.jsp';
 }
 function sel2()
 {
	 window.location.href='zg23_tax.jsp';
 }
 function sel3()
 {
	 window.location.href='zg23_3172.jsp';
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <div class="title">
        <div id="title_zi">��ѡ���ѯ��ʽ</div>
    </div>
	
	<table cellspacing="0">
        <tbody>
            <tr>
                <td class="blue" width="15%">��ѯ��ʽ</td>
                <td colspan="3">
                	<q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel1()" value="1" >
                    ���ֻ������ѯ
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType2" type="radio" onClick="sel2()" value="2">
                    ����˰��ʶ������ѯ
                    </q>
					<q vType="setNg35Attr">
                    <input name="busyType3" type="radio" onClick="sel3()" value="3" checked>
                    һ��֧��רƱ����
                    </q>
                     
                </td>
            </tr>
        </tbody>
    </table>

	 
  <table cellSpacing="0">	 
	 <tr>
		<td class="blue" width="15%">һ��֧���˻�����</td>
		 
		<td colspan="3">
			<input type="text" name="phone_no" maxlength=20  onKeyPress="return isKeyNumberdot(0)" >
		</td>
	 </tr>
<input type="hidden" name="tax_contract_no">
<input type="hidden" name="tax_name">
<input type="hidden" name="tax_no1">
<input type="hidden" name="tax_address">
<input type="hidden" name="tax_phone">
<input type="hidden" name="tax_khh">
  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="����չʾpay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="����" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="����" onclick="doImport()" >	
           <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
          &nbsp;
		    <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
			  -->
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>