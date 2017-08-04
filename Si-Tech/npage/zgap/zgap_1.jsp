<%
/********************
version v1.0
������: si-tech
add by zhangleij
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%@ page import="java.text.*"%>

<%

    String getopCode=request.getParameter("opCode");
    String getopName=request.getParameter("opName");
    System.out.println("-----------getopCode="+getopCode);
    System.out.println("-----------getopName="+getopName);
    String opCode="zgap";
    String opName="�����û���ϸ��ѯ";
  	String workNo =  (String)session.getAttribute("workNo");
  	String workname = (String)session.getAttribute("workName");
    String belongName = (String)session.getAttribute("orgCode");
    String regionCode = belongName.substring(0,2);
    
        
  	Date date = new Date();
    String todayyearmonth = new java.text.SimpleDateFormat("yyyyMM").format(date);
    
%>
<HEAD>
<TITLE>������BOSS-��ϸ�ʵ���ѯ</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">

function docheck() {
    var todayym = "<%=todayyearmonth%>";
    var billym = document.form.bill_ym.value;
    var todaymonth = parseInt(todayym.substring(0,4)*12) + parseInt(todayym.substring(4,6));
    var billmonth = parseInt(billym.substring(0,4)*12) + parseInt(billym.substring(4,6));
    
 if (document.form.contract_no.value.length == 0) {
    rdShowMessageDialog("��ͬ�Ų���Ϊ�գ�");
    return false;
  } else if (document.form.contract_no.value.length < 11){
    rdShowMessageDialog("��ͬ�Ų���С��11λ��");
    return false;
  }

  if (isValidYYYYMM(document.form.bill_ym.value) != 0) {
        rdShowMessageDialog("�������¸�ʽ����! <br>ӦΪ��YYYYMM ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (billym > todayym) {
        rdShowMessageDialog("�������²��ܴ��ڵ�ǰ����! ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (todaymonth - billmonth > 5) {
        rdShowMessageDialog("�������²������ڵ�ǰ����ǰ�����! ");
      document.form.bill_ym.focus();
      return false;
  }
  
  if (document.form.con_pwd.value.length == 0) {
    rdShowMessageDialog("���벻��Ϊ�գ�");
    return false;
  } else if (document.form.con_pwd.value.length < 6){
    rdShowMessageDialog("���벻��С��6λ��");
    return false;
  }

 	checkConPwd();
        
}

function checkConPwd() {
		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
		checkPwd_Packet.data.add("custType", "03");						//01:�ֻ����� 02 �ͻ�����У�� 03�ʻ�����У��
		checkPwd_Packet.data.add("phoneNo", document.form.contract_no.value);		//�ƶ�����,�ͻ�id,�ʻ�id
		checkPwd_Packet.data.add("custPaswd", document.form.con_pwd.value);			//�û�.�ͻ�.�ʻ�����
		checkPwd_Packet.data.add("idType", "");							//en ����Ϊ���ģ�������� ����Ϊ����
		checkPwd_Packet.data.add("idNum", "");							//����
		checkPwd_Packet.data.add("loginNo", "<%=workNo%>"); //����
		core.ajax.sendPacket(checkPwd_Packet, doSubmit);
		checkPwd_Packet=null;
}

function doSubmit(packet) 
{
		var retResult = packet.data.findValueByName("retResult");
		var msg = packet.data.findValueByName("msg");
		if (retResult != "000000") {
			rdShowMessageDialog(" ����У��ʧ��! ");
			document.form.con_pwd.value = "";
      return false;
		} 
		else 
		{
			 form.submit();
		}
}

</script>

</HEAD>
<BODY>
    <FORM action="zgap_2.jsp" method=post name="form">
        <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
            <div id="title_zi">�����û���ϸ��ѯ</div>
        </div>
        <table cellspacing="0">
            <tr>
                <td class="blue" width="8%" align="right">��ͬ��</td>
                <td width="18%"><input type="text" name="contract_no" maxlength="20" class="button"
                    onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *</font></td>
                <td class="blue" width="8%" align="right">����</td>
                <td width="18%"><input type="password" name="con_pwd" maxlength="6" class="button"
                    onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *</font></td>
                <td class="blue" width="8%" align="right">��������</td>
                <td width="40%"><input type="text" name="bill_ym" value="<%=todayyearmonth%>" maxlength="6"
                    class="button" onKeyPress="return isKeyNumberdot(0)"> <font class="orange"> *
                        �ɲ�ѯ��ǰ�¼�ǰ����µ������û���ϸ��Ϣ</font></td>
            </tr>
        </table>

        <table width="100%" border=0 align=center cellpadding="4" cellspacing=1>
            <tbody>
                <tr>
                    <td align=center width="100%" id="footer"><input class="b_foot" name=sure type="button"
                        value="��ѯ" onclick="docheck()"> &nbsp; <input class="b_foot" name=reset type=reset
                        value="�ر�" onclick="removeCurrentTab()"></td>
                </tr>
            </tbody>
        </table>
        <%@ include file="/npage/include/footer_simple.jsp"%>
    </FORM>
</BODY>
</HTML>
