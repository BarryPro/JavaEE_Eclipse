<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-10-13
********************/
%>
              
<%
  String opCode = "3201";
  String opName = "������VPMN������ѯ";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ include file="../../include/remark.htm" %>

<%
    Logger logger = Logger.getLogger("s3201_1.jsp");
	
%>
<HTML>
<HEAD>
<TITLE>������VPMN������ѯ</TITLE>
<SCRIPT language="JavaScript">
function refMain( qryType ){
	document.all.qryType.value=qryType;

	var phoneNo=document.all.phoneNo.value;
	if(phoneNo=="")
	{
		rdShowMessageDialog("�����������룡");
		return;
	}
	
	frm.submit();
}

function chkUserPwd(){
    var vPwd = document.all.cus_pass.value;
    var vPhoneNo = $("#phoneNo").val();
    
    if(vPhoneNo == ""){
        rdShowMessageDialog("�������������룡",0);
        $("#phoneNo").focus();
        return false;
    }
    
    if(vPwd == ""){
        rdShowMessageDialog("�����������룡",0);
        document.all.cus_pass.focus();
        return false;
    }
    
    var packet = new AJAXPacket("pubCheckPwd.jsp","���Ժ�...");
    packet.data.add("phoneNo" ,vPhoneNo);
    packet.data.add("password" ,vPwd);
    core.ajax.sendPacket(packet,doChkUserPwd,true);
    packet =null;
}

function doChkUserPwd(packet){
    var retCode = packet.data.findValueByName("retCode"); 
    var retMsg = packet.data.findValueByName("retMessage");
    var retResult = packet.data.findValueByName("retResult");
    
    if(retCode == "000000" && retResult == "true"){
        rdShowMessageDialog("����У��ɹ���",2);
        $("#sure").attr("disabled",false);
        return true;
    }else{
        rdShowMessageDialog("����У��ʧ�ܣ�",0);
        document.all.cus_pass.value = "";
        document.all.cus_pass.focus();
        return false;
    }
}
</SCRIPT>
</HEAD>
<BODY>
<FORM action="s3201_2.jsp" method="post" name="frm" >
<%@ include file="/npage/include/header.jsp" %>       
<input type='hidden' name='qryType' id='qryType' value=''>                  
 <div class="title">
		<div id="title_zi">������VPMN������ѯ</div>
	</div>
        <TABLE   cellSpacing=0 >
          <TR >
            <TD class=blue>
              <div align="left" >������� </div>
            </TD>
            <TD colspan='3'>
							<input  name="phoneNo" id="phoneNo" value="" size="20" v_must=1 v_type=string v_name=���Ŵ��� index="1">
							<font class="orange">*</font> 
            </TD>
          </TR>
        </TABLE>
        <TABLE  cellSpacing=0>
          <TBODY>
            <TR >
              <TD align=center id=footer>
			  <input  name="sure" id="sure" type=button value="��Ա�ʷѲ�ѯ" class="b_foot_long"  onclick="refMain('')">
<input id='qryVpmn' name='qryVpmn' type='button' 
								class='b_foot_long' onclick='refMain("s")'value='�̺���Ϣ��ѯ'>			  <input  name="reset1"  onClick="" type=reset class="b_foot"   value="���">
			  <input  name="kkkk"  onClick="removeCurrentTab()" type=button value="�ر�" class="b_foot"  >
			  <input name="internetIp" type="hidden" value="">
			  <input name="terminalIp" type="hidden" value="">
			  <input name="serviceIp" type="hidden" value="">
              </TD>
            </TR>
          </TBODY>
        </TABLE>
       <p>&nbsp;</p>
    </td>
  </tr>
</table>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
			<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
