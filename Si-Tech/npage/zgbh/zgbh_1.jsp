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
		String opCode = "zgbh";
		String opName = "��ͥ��Աδ���˲�ѯ";
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
 
function doqry()
{
	var phone_no = document.all.phone_no.value;
	var s_flag = document.all.s_flag.value;
	if(phone_no=="")
	{
		rdShowMessageDialog("�������ѯ����!")
		return false;
	}
	else
	{
		var checkPwd_Packet = new AJAXPacket("sphone_check.jsp","���ڽ��к���У�飬���Ժ�......");
		checkPwd_Packet.data.add("phone_no",phone_no);
		checkPwd_Packet.data.add("s_flag",s_flag);
		core.ajax.sendPacket(checkPwd_Packet);
		checkPwd_Packet=null;
	}
	
}
 


 function doclear() {
 		frm.reset();
 }
   
  
 function sel1()
 {
	document.all.s_flag.value="1";
 }
 function sel2()
 {
	document.all.s_flag.value="2";
 }
 function inits()
 {
	 sel1();
 }
 function doProcess(packet)
 {
	var s_return_flag   = packet.data.findValueByName("s_return_flag");
	//alert("s_return_flag is "+s_return_flag);
	//s_return_flag="0";
	if(s_return_flag=="1")
	{
		rdShowMessageDialog("��������ϵУ��ʧ��!");
		return false;
	}
	else
	{
		 document.frm.action="zgbh_2.jsp";
		 document.frm.submit();
	}	
 }
 </script> 
 
<title>������BOSS-��ͨ�ɷ�</title>
</head>
<BODY onload="inits()">
<form action="" method="post" name="frm">
		
		<%@ include file="/npage/include/header.jsp" %>   
  	 
	
 <div class="title">
			<div id="title_zi">��ѡ���ѯ��ʽ</div>
		</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td class="blue" width="15%">��ѯ��ʽ</td>
                  <td colspan="3"> 
                  	<q vType="setNg35Attr">
                    <input name="busyType1" id="busyType1" type="radio" onClick="sel1()" checked value="1"  >
                    �������� 
                    </q>
                    <q vType="setNg35Attr">
                    <input name="busyType1" type="radio" onClick="sel2()" value="2"  >
                    �������� 
                    </q>
                 <input type="hidden" name="s_flag">    
			 		</td>
                 </tr>   
                </tbody> 
              </table>
              <table cellspacing="0" >
                <tr> 
                  <td  class="blue" width="15%">�û�����</td>
                  <td> 
                    <input type="text" name="phone_no" size="20" maxlength="20" style="ime-mode:disabled"  onKeyPress="return isKeyNumberdot(0)" onKeyDown="if(event.keyCode==13) getpasswd();" index="5"  >
                  </td>
                  <td nowrap> </td>
                  <td> 
                   </td>
 				</tr>

				 
				
				 
				 

              </table>
         
        
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="�˻���Ϣ��ѯ" onclick="doqry()" >
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