   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-9
********************/
%>
              
<%
  String opCode = "3200";
  String opName = "VPMN���ſ���";
%>              
<%
  /*begin diling add for �ж��Ƿ����Ż������Ȩ��@2012/11/6 */
  String sm_code = request.getParameter("sm_code");
  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
	String[] favStr = new String[temfavStr.length];
	String sele1disabledFlag = "disabled";
	boolean operFlag = false;
	for(int i = 0; i < favStr.length; i ++) {
		favStr[i] = temfavStr[i][0].trim();
	}
	if (WtcUtil.haveStr(favStr, "a367")) {
		operFlag = true;
	}
	
	if(operFlag&&"vp".equals(sm_code)){
	  sele1disabledFlag = "";
	}
	
	 /*end diling add @2012/11/6 */
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	


<%@ page contentType="text/html;charset=GBK"%>

<%
		String iFlags = request.getParameter("flags");
		if (iFlags != null)
		{
			if (iFlags.length() < 36)
			{
				/*LGZ ADD ����������ʱ��֧��>23������*/
				iFlags = iFlags + "00000000000000000000000000000000000000000000";
			}
		}
%>

<html>
<head>
<title>���ſ��������Ź��ܴ����޸�</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">

<script language="JavaScript">	
	function save_to(){
	
		var str="";
		for(i=0;i<document.frm.elements.length;i++){
			if(document.frm.elements[i].name.substring(0,6)=="select"){
				str = str + document.frm.elements[i].value;
			}
		}
	
		//alert(str);
		window.returnValue=str;
		window.close(); 
	}

	function quit(){
		window.close(); 
	}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">     
	
<%@ include file="/npage/include/header_pop.jsp" %>


	<div class="title">
		<div id="title_zi">���Ź��ܴ����޸�</div>
	</div>
	
	
  <table cellspacing="0" >


    <tr> 
      <td class="blue" nowrap>����ȥ��</td>
      <td>
        <select name="select1" <%=sele1disabledFlag%> >
          <option <% if(iFlags.substring(0,1).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(0,1).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(0,1).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(0,1).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(0,1).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
      <td class="blue" nowrap>��������</td>
      <td>
        <select name="select2"  <%=sele1disabledFlag%> >
          <option <% if(iFlags.substring(1,2).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(1,2).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(1,2).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(1,2).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(1,2).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue"  nowrap>����ȥ��</td>
      <td>
        <select name="select3"  disabled>
          <option <% if(iFlags.substring(2,3).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(2,3).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(2,3).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(2,3).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(2,3).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
      <td class="blue" nowrap>��������</td>
      <td>
        <select name="select4"  disabled>
          <option <% if(iFlags.substring(3,4).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(3,4).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(3,4).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(3,4).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(3,4).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>����ȥ��</td>
      <td>
        <select name="select5"  disabled> 
          <option <% if(iFlags.substring(4,5).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(4,5).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(4,5).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(4,5).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(4,5).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
      <td class="blue" nowrap>��������</td>
      <td>
        <select name="select6"  disabled>
          <option <% if(iFlags.substring(5,6).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(5,6).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(5,6).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(5,6).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(5,6).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>���������ȥ��</td>
      <td>
        <select name="select7" >
          <option <% if(iFlags.substring(6,7).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(6,7).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(6,7).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(6,7).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(6,7).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
      <td class="blue" nowrap>�������������</td>
      <td>
        <select name="select8" >
          <option <% if(iFlags.substring(7,8).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(7,8).equals("1")) out.println(" selected ");%>value="1">�л�</option>
          <option <% if(iFlags.substring(7,8).equals("2")) out.println(" selected ");%>value="2">�л�+ʡ��</option>
          <option <% if(iFlags.substring(7,8).equals("3")) out.println(" selected ");%>value="3">�л�+ʡ��+ʡ��</option>
          <option <% if(iFlags.substring(7,8).equals("4")) out.println(" selected ");%>value="4">�л�+ʡ��+ʡ��+����</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>��������Ȩ��</td>
      <td>
        <select name="select9" >
          <option <% if(iFlags.substring(8,9).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(8,9).equals("1")) out.println(" selected ");%>value="1">ʡ��</option>
          <option <% if(iFlags.substring(8,9).equals("2")) out.println(" selected ");%>value="2">ʡ��+ʡ��</option>
        </select></td>
      <td class="blue" nowrap>��������Ȩ��</td>
      <td>
        <select name="select10" >
          <option <% if(iFlags.substring(9,10).equals("0")) out.println(" selected ");%>value="0">��ֹ</option>
          <option <% if(iFlags.substring(9,10).equals("1")) out.println(" selected ");%>value="1">ʡ��</option>
          <option <% if(iFlags.substring(9,10).equals("2")) out.println(" selected ");%>value="2">ʡ��+ʡ��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>���Ż���Ա</td>
      <td>
        <select name="select11" >
          <option <% if(iFlags.substring(10,11).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(10,11).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
          <option <% if(iFlags.substring(10,11).equals("2")) out.println(" selected ");%>value="2">�ṩ������Ա����������</option>
        </select></td>
      <td class="blue" nowrap>�˹��ܻ�ת��</td>
      <td>
        <select name="select12" >
          <option <% if(iFlags.substring(11,12).equals("0")) out.println(" selected ");%>value="0">��֧��</option>
          <option <% if(iFlags.substring(11,12).equals("1")) out.println(" selected ");%>value="1">֧��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>�պ��û�Ⱥ����</td>
      <td>
        <select name="select13" >
          <option <% if(iFlags.substring(12,13).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(12,13).equals("1")) out.println(" selected ");%>value="1">�ṩ�Ż�Ⱥ</option>
          <option <% if(iFlags.substring(12,13).equals("2")) out.println(" selected ");%>value="2">�ṩ�պ��Ż�Ⱥ</option>
        </select></td>
      <td class="blue" nowrap>��Ϣ����</td>
      <td>
        <select name="select14" >
          <option <% if(iFlags.substring(13,14).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(13,14).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
        </select></td>
    </tr>
<input type="hidden" name="select15" value="<%=iFlags.substring(14,15)%>">
    <tr> 
      <td class="blue" nowrap>Ⱥ�����Ϣ</td>
      <td>
        <select name="select16" >
          <option <% if(iFlags.substring(15,16).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(15,16).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
        </select></td>
      <td class="blue">ͨ���������̲�����Ա�������Ƿ��շ�</td>
      <td>
        <select name="select17" >
          <option <% if(iFlags.substring(16,17).equals("0")) out.println(" selected ");%>value="0">���շ�</option>
          <option <% if(iFlags.substring(16,17).equals("1")) out.println(" selected ");%>value="1">�շ�</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>��Ա�Ƿ���ֱ�Ӻ��л���Ա</td>
      <td>
        <select name="select18" >
          <option <% if(iFlags.substring(17,18).equals("0")) out.println(" selected ");%>value="0">����</option>
          <option <% if(iFlags.substring(17,18).equals("1")) out.println(" selected ");%>value="1">��</option>
        </select></td>
      <td class="blue" nowrap>����Ա���������Ƿ��շ�</td>
      <td>
        <select name="select19" >
          <option <% if(iFlags.substring(18,19).equals("0")) out.println(" selected ");%>value="0">���շ�</option>
          <option <% if(iFlags.substring(18,19).equals("1")) out.println(" selected ");%>value="1">�շ�</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>������Ա�Ƿ�ת����Ӫ�̿ͷ�����</td>
      <td>
        <select name="select20" >
          <option <% if(iFlags.substring(19,20).equals("0")) out.println(" selected ");%>value="0">��ת��</option>
          <option <% if(iFlags.substring(19,20).equals("1")) out.println(" selected ");%>value="1">ת��</option>
        </select></td>
<input type="hidden" name="select21" value="<%=iFlags.substring(20,21)%>">
      <td class="blue" nowrap>���������</td>
      <td>
        <select name="select22" >
          <option <% if(iFlags.substring(21,22).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(21,22).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>���˸��Ѻ����Ƿ����Ż�</td>
      <td>
        <select name="select23" >
          <option <% if(iFlags.substring(22,23).equals("0")) out.println(" selected ");%>value="0">���Ż�</option>
          <option <% if(iFlags.substring(22,23).equals("1")) out.println(" selected ");%>value="1">���Ż�</option>
        </select></td>
      <td class="blue" nowrap>���ŷ�����ʱ�Żݷ���</td>
      <td>
        <select name="select24" >
          <option <% if(iFlags.substring(23,24).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(23,24).equals("1")) out.println(" selected ");%>value="1">�ṩ���ŵǼǷ���</option>
          <option <% if(iFlags.substring(23,24).equals("2")) out.println(" selected ");%>value="2">�ṩ���ŵǼ�С��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>Ԥ��IP����</td>
      <td>
        <select name="select25" >
          <option <% if(iFlags.substring(24,25).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(24,25).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
        </select></td>
      <td class="blue" nowrap>�ƶ��м�ҵ��</td>
      <td>
        <select name="select26" >
          <option <% if(iFlags.substring(25,26).equals("0")) out.println(" selected ");%>value="0">���ṩ</option>
          <option <% if(iFlags.substring(25,26).equals("1")) out.println(" selected ");%>value="1">�ṩ</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>��Ա�ܷ�ʹ�û���绰����</td>
      <td>
        <select name="select27" >
          <option <% if(iFlags.substring(26,27).equals("0")) out.println(" selected ");%>value="0">����</option>
          <option <% if(iFlags.substring(26,27).equals("1")) out.println(" selected ");%>value="1">��</option>
        </select></td>
      <td class="blue">����ʡ���������Ӽ��ż��Ƿ��ʹ�ó��Ų���</td>
      <td>
        <select name="select28" >
          <option <% if(iFlags.substring(27,28).equals("0")) out.println(" selected ");%>value="0">����</option>
          <option <% if(iFlags.substring(27,28).equals("1")) out.println(" selected ");%>value="1">��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>���ų�Աʹ�ú��ָ����ײ�</td>
      <td>
        <select name="select29" >
          <option <% if(iFlags.substring(28,29).equals("0")) out.println(" selected ");%>value="0">��Ա���Ը���ʹ�ò�ͬ�ĸ����ײ�����</option>
          <option <% if(iFlags.substring(28,29).equals("1")) out.println(" selected ");%>value="1">��Աʹ�ü���ͳһ�涨�ĸ����ײ�����</option>
        </select></td>
      <td class="blue" nowrap>�Ƿ�֧������CENTREXҵ��</td>
      <td>
        <select name="select30" >
          <option <% if(iFlags.substring(29,30).equals("0")) out.println(" selected ");%>value="0">��֧��</option>
          <option <% if(iFlags.substring(29,30).equals("1")) out.println(" selected ");%>value="1">֧��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>�ܻ��û����м������û�ʱ������ʾ����</td>
      <td>
        <select name="select31" >
          <option <% if(iFlags.substring(30,31).equals("0")) out.println(" selected ");%>value="0">ʹ�ø��˱�־</option>
          <option <% if(iFlags.substring(30,31).equals("1")) out.println(" selected ");%>value="1">����ʾ��ʵ����</option>
          <option <% if(iFlags.substring(30,31).equals("2")) out.println(" selected ");%>value="2">����ʾ�����ܻ�����</option>
          <option <% if(iFlags.substring(30,31).equals("3")) out.println(" selected ");%>value="3">�ƶ����û���ʾ�ܻ����ֻ����������û���ʾ�ܻ�</option>
        </select></td>
      <td class="blue">PBX�û����м������û�ʱ������ʾ����</td>
      <td>
        <select name="select32" >
          <option <% if(iFlags.substring(31,32).equals("0")) out.println(" selected ");%>value="0">��ʾ�ܻ���</option>
          <option <% if(iFlags.substring(31,32).equals("1")) out.println(" selected ");%>value="1">�ƶ����û���ʾ��ʵ���룬�������û���ʾ�ܻ�</option>
          <option <% if(iFlags.substring(31,32).equals("2")) out.println(" selected ");%>value="2">����ʾ��ʵ����</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>PBX���л���ʹ�ú��ּƷѺ���</td>
      <td>
        <select name="select33" >
          <option <% if(iFlags.substring(32,33).equals("0")) out.println(" selected ");%>value="0">ʹ��PBX��ʵ����</option>
          <option <% if(iFlags.substring(32,33).equals("1")) out.println(" selected ");%>value="1">ʹ�ü��żƷѺ���</option>
          <option <% if(iFlags.substring(32,33).equals("2")) out.println(" selected ");%>value="2">ʹ�ø��˼ƷѺ���</option>
        </select></td>
      <td class="blue" nowrap>�Ƿ�ʹ�ü����ܻ�����</td>
      <td>
        <select name="select34" >
          <option <% if(iFlags.substring(33,34).equals("0")) out.println(" selected ");%>value="0">��ʹ��</option>
          <option <% if(iFlags.substring(33,34).equals("1")) out.println(" selected ");%>value="1">ʹ��AIP�ܻ�</option>
          <option <% if(iFlags.substring(33,34).equals("2")) out.println(" selected ");%>value="2">ʹ�ü����ܻ�ҵ��</option>
        </select></td>
    </tr>
    <tr> 
      <td class="blue" nowrap>�Ƿ�֧�ֲ������ڳ��Ų��Ż�</td>
      <td>
        <select name="select35" >
          <option <% if(iFlags.substring(34,35).equals("0")) out.println(" selected ");%>value="0">��֧��</option>
          <option <% if(iFlags.substring(34,35).equals("1")) out.println(" selected ");%>value="1">֧��</option>
        </select></td>
      <td class="blue" nowrap>һ��IP�����Ƿ�����vpn�Ż�</td>
      <td>
        <select name="select36" >
          <option <% if(iFlags.substring(35,36).equals("0")) out.println(" selected ");%>value="0">���Ż�</option>
          <option <% if(iFlags.substring(35,36).equals("1")) out.println(" selected ");%>value="1">�Ż�</option>
        </select></td>
    </tr>

    <tr> 
       <TD  id="footer"  colspan="4">
          <input type="Button" name="Button" value="����" onClick="save_to()" class="b_foot">&nbsp;&nbsp;
          <input type="Button" name="return" value="����" onClick="quit()" class="b_foot">
       
       </td>
       
       
    </tr>
  </table>

  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
