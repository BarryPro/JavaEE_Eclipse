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
String opCode = "zg31";
String opName = "��ֵ˰רƱ���ݽ���ȷ��";
String workno = (String)session.getAttribute("workNo");
String contextPath = request.getContextPath();
 

%> 
<HTML>
<HEAD>
<script language="JavaScript">
function docheck()
{
	var begin_tm = document.all.begin_tm.value;
	var end_tm = document.all.end_tm.value;
	//var cust_id = document.all.cust_id.value; 
	if(begin_tm=="")
	{
		rdShowMessageDialog("�������ѯ��ʼʱ��!");
		return false;
	}
	else if(end_tm=="")
	{
		rdShowMessageDialog("�������ѯ����ʱ��!");
		return false;
	}
	/*
	else if(cust_id=="")
	{
		rdShowMessageDialog("������ͻ�ID!");
		return false;
	}*/
	else
	{
		/*
		var checkPwd_Packet = new AJAXPacket("../zg24/zg24_Qry.jsp","���ڽ��в�ѯ�����Ժ�......");
		checkPwd_Packet.data.add("tax_number",tax_number);
		checkPwd_Packet.data.add("tax_code",tax_code);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
		*/
		document.frm.action="zg31_2.jsp";
	    document.frm.submit();
	}
	
} 

	
function doProcess(packet)
{
	var tax_number = document.all.tax_number.value;
	var tax_code = document.all.tax_code.value;
	var cust_id = document.all.cust_id.value;
	var s_flag = packet.data.findValueByName("s_flag");
	var s_good_name = packet.data.findValueByName("s_good_name");
	var s_ggxh = packet.data.findValueByName("s_ggxh");
	var s_dw = packet.data.findValueByName("s_dw");
	var s_sl = packet.data.findValueByName("s_sl");
	var s_dj = packet.data.findValueByName("s_dj");
	var s_je = packet.data.findValueByName("s_je");
	var s_tax_rate = packet.data.findValueByName("s_tax_rate");
	var s_se = packet.data.findValueByName("s_se");
 
	
	//alert("s_flag is "+s_flag+" and s_contract_no is "+s_contract_no);
	if(s_flag=="Y")
	{
		document.frm.action="zg27_2.jsp?s_good_name="+s_good_name+"&s_ggxh="+s_ggxh+"&s_dw="+s_dw+"&s_sl="+s_sl+"&s_dj="+s_dj+"&s_je="+s_je+"&s_tax_rate="+s_tax_rate+"&s_se="+s_se+"&tax_number="+tax_number+"&tax_code="+tax_code+"&cust_id="+cust_id;
	    document.frm.submit();
	}
	else
	{
		rdShowMessageDialog("���ַ�Ʊ��Ϣ�����ڣ�����������!");
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

 
  function doExport()
  {
	  
	  document.frm.action="zg12_export.jsp";
	  document.frm.submit();

  }
  function doImport()
  {
	  alert("1");
	  document.frm.action="zg12_import.jsp";
	  document.frm.submit();
  }
  function doTest()
  {
	  alert("1");
	  document.frm.action="zg12_xmltest.jsp";
	  document.frm.submit();
  }
  function do_paynote()
  {
	  alert("?");
	  document.frm.action="zg12_paynote.jsp";
	  document.frm.submit();
  }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	<table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��ѯ��ʼʱ��</td>
      <td> 
        <input class="button"type="text" name="begin_tm" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)" value="20140501" >(YYYYMMDD)
      </td>
    </tr>
	<tr> 
      <td class="blue" width="15%">��ѯ����ʱ��</td>
      <td> 
        <input class="button"type="text" name="end_tm" size="20"  colspan=2  onKeyPress="return isKeyNumberdot(0)" value="20150501" >(YYYYMMDD)
      </td>
    </tr>
	<!--
	<tr> 
      <td class="blue" width="15%">�ͻ�ID</td>
      <td> 
        <input class="button"type="text" name="cust_id" size="20"  colspan=2 value="23002348611"  onKeyPress="return isKeyNumberdot(0)"  >
      </td>
    </tr> 
	 -->
	 


  </table>
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
	  <!--
	  <input type="button" id="test" name="test" class="b_foot" value="����չʾpay_note" onclick="do_paynote()" >
	  <input type="button" id="query_id" name="export" class="b_foot" value="javabeantest" onclick="doTest()" >
		   <input type="button" id="query_id" name="export" class="b_foot" value="����" onclick="doExport()" >	
		   <input type="button" id="imp_id" name="import" class="b_foot" value="����" onclick="doImport()" >	
        -->
      <input type="button" id="query_id" name="query" class="b_foot" value="��ѯ" onclick="docheck()" >
        
	  <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >

	  <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
	  </td>
	   
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>