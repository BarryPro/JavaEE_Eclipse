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
		String opCode = "zgbe";
		String opName = "רƱ�����ϵ����";
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		String dtime = sdf.format(today.getTime());
    today.add(Calendar.MONTH,-12);
    /*Ĭ�ϣ�12����֮ǰ*/
    String startTime = sdf.format(today.getTime());
	activePhone = request.getParameter("activePhone");	
%>
<HTML>
<HEAD>
<script language="JavaScript">
 
function xnjttj()
{
	/* 
	var prtFlag=0;
	prtFlag=rdShowConfirmDialog("�Ƿ�ȷ���������⼯����Ӳ���?");
	if (prtFlag==1){
		document.frm.action="zg44_2.jsp?unit_id="+document.frm.phoneNo.value+"&contract_name="+document.frm.contract_name.value;
		//alert(document.frm.action);
		document.frm.submit();
	}
	else
	{ 
		return false;	
	}
	*/
	//ajax У�����˰��ʶ������Ƿ�����o001��Ч
	var phoneNo = document.all.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("��������˰��ʶ�����!");
		return false;
	}
	else
	{
		var myPacket = new AJAXPacket("zgbe_check.jsp","�����ύ�����Ժ�......");
		myPacket.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(myPacket,doPosSubInfo3);
		myPacket=null;
	}
	
}
 function doPosSubInfo3(packet)
 {
	 //alert("2");
	 var s_flag =  packet.data.findValueByName("flag1");
	 var s_cust_id =  packet.data.findValueByName("s_cust_id");
	 var s_tax_no = document.all.phoneNo.value;
	 //alert("s_flag is "+s_flag+" and s_cust_id is "+s_cust_id);
	 if(s_flag=="1")
	 {
		 rdShowMessageDialog("����˰��ʶ�������ϵͳ����Ч,��У����Ч��!");
	     return false;
	 }		 
	 else
	 {
		var h=480;
		var w=650;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		returnValue = window.showModalDialog('getCount.jsp?cust_id='+s_cust_id+'&s_tax_no='+s_tax_no,"",prop);
		//alert("2?phone_no="+returnValue);
		document.frm.action="zgbe_2.jsp?phone_no="+returnValue;//չʾ������Ϣ ����staxtailadd�ӿڽ���¼��
		//alert("test?"+document.frm.action);
		document.frm.submit();
	 }	
 } 


 function doclear() {
 		frm.reset();
 }
   
 function sel1() {
 		window.location.href='zgbe_1.jsp';
 }

  
 
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY>
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	<div class="title">
			<div id="title_zi">��ѡ�����÷�ʽ</div>
	</div>
	
	<table cellspacing="0">
      <tbody> 
	 
      <tr> 
        <td class="blue" width="15%">���÷�ʽ</td>
        <td colspan="4"> 
        	<q vType="setNg35Attr">
          <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" value="1" checked>���⼯����� 
        </q>
  
		  
	
     </tr>
	   
    </tbody>
  </table>
	
  <table cellspacing="0">
    <tr> 
      <td class="blue" width="15%">��˰��ʶ�����</td>
      <td> 
        <input class="button"type="text" name="phoneNo" size="24" maxlength="24"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) xnjttj();">
      </td>
      
    </tr>
	 
  </table>

  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="���⼯�����" onclick="xnjttj()" >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick="doclear()" >
          &nbsp;
		      <input type="button" name="return2" class="b_foot" value="�ر�" onClick="removeCurrentTab()" >
      </td>
    </tr>
  </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
 </BODY>
</HTML>