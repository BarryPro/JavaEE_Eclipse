<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK" %> 
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
    /*
     * ����:
     * �汾:
     * ����: 2010-4-14 9:24
     * ����: lijy
     * ��Ȩ: si-tech
     * update:lvjc
    */
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.flushBuffer();
    String workNo = (String) session.getAttribute("workNo");
    String workName = (String) session.getAttribute("workName");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
    String ip_Addr = (String) session.getAttribute("ipAddr");
    String password = (String) session.getAttribute("password");
    System.out.println("password============="+password);
    String opCode = request.getParameter("opCode") == null ? "4991" : request.getParameter("opCode");
    String opName = request.getParameter("opName") == null ? "���������" : request.getParameter("opName");
%>
<%
 		String printAccept="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		printAccept = seq;
%>
<HEAD><TITLE><%=opName%>
</TITLE>
    <SCRIPT type=text/javascript>
        /*��֤��½����*/
        function doValidatePwdJs() {
            if (!checkElement(f4991.oldpassword)) return false;
            if (!checkElement(f4991.cfmLogin)) return false;
            if (document.f4991.WideAreaInfo.disabled == false)
            {
                rdShowMessageDialog("���Ȼ�ȡ����ʺŵ������Ϣ", 1);
                return false;
            }
            /* ʹ���µļ��� */
            encryptPwd($('#oldpassword').val());
						if($("#cfmPwdEncryptFlag").val() != "1"){
							rdShowMessageDialog("�������û�м��ܣ����ɼ�������ҵ��",0);
							return false;
						}else{
							$("#cfmPwdEncryptOld").val($("#cfmPwdEncrypt").val());
						}
            /* ʹ���µļ��� */
            $('#doValidatePwd').attr('disabled', true);
            var myPacket = new AJAXPacket("f4991_doValidatePwd_ajax.jsp", "����У���û�����......");
            myPacket.data.add("oldpassword", $("#cfmPwdEncryptOld").val());
            myPacket.data.add("id_no", $('#id_no').val());
            myPacket.data.add("opCode", $('#opCode').val());
            core.ajax.sendPacket(myPacket, doProcesspassword);//�첽
            myPacket = null;
        }

        function doProcesspassword(packet) {
            var retCode = unescape(packet.data.findValueByName("retCode"));
            var retMsg = unescape(packet.data.findValueByName("retMsg"));
            var retRes = unescape(packet.data.findValueByName("retRes"));
            if (retCode == "000000" || retCode == "0")
            {
                if (retRes == "OK")
                {
                    rdShowMessageDialog("����ʺ�������֤�ɹ���", 2);
                    $('#commitBut').attr('disabled', false);
                    $('#oldpassword').attr('readonly', true);
                    $('#doValidatePwd').attr('disabled', true);
                }
                else {
                    rdShowMessageDialog("��֤ʧ��,�������������룡", 0);
                    $('#commitBut').attr('disabled', true);
                    $('#oldpassword').attr('readonly', false);
                    $('#doValidatePwd').attr('disabled', false);
                    return false;
                }
            }
            else {
                rdShowMessageDialog("�������:'" + retCode + "'������Ϣ:'" + retMsg + "'", 0);
                $('#commitBut').attr('disabled', true);
                $('#doValidatePwd').attr('disabled', false);
                return false;
            }
        }

        /*�ύ����*/
        function commitJsp() {
            if (!check(f4991)) {
                return false;
            }
           // if (!checkElement(f4991.newpassword) || !checkElement(f4991.vCfmPwd)) return false;
	          if(f4991.newpassword.value.length==0){
	          	rdShowMessageDialog("������������", 0);
	          }
	          if(!forNonNegInt(document.f4991.newpassword)){
							return;
						}
						if(document.f4991.cfmPwd.value.trim().len()==0){
							rdShowMessageDialog("У�����벻��Ϊ��!");
							return;				
						}
						if(!forNonNegInt(document.f4991.cfmPwd)){
							return;
						}
						if(document.f4991.newpassword.value!=document.f4991.cfmPwd.value){
							rdShowMessageDialog("������������벻һ�£�");
							return;
						}
						/* ʹ���µ�������� */
						encryptPwd(document.f4991.cfmPwd.value);
						if($("#cfmPwdEncryptFlag").val() != "1"){
							rdShowMessageDialog("�������û�м��ܣ����ɼ�������ҵ��",0);
							return false;
						}else{
							$("#cfmPwdEncryptNew").val($("#cfmPwdEncrypt").val());
						}
						/* ʹ���µ�������� */
            document.all.vSystemNote.value = "����Ա<%=workNo%>�����" + $('#cfmLogin').val() + "����<%=opName%>����";
            var vOpNote = document.all.vOpNote.value.trim();
            if (vOpNote.length == 0)
            {
                document.all.vOpNote.value = document.all.vSystemNote.value;
            }
            $('#commitBut').attr('disabled', true);
            if($("#opType").val() == "DD"){
	    				showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
	    			}else{
	    				if (rdShowConfirmDialog('ȷ��Ҫ���п����������') == 1){
	    					conf();
	    				}else{
	    					$('#commitBut').attr('disabled', true);
	    				}
	    			}
}
function encryptPwd(pwd){
	var getEncryptPwd_Packet = new AJAXPacket("/npage/public/pubBroadEncrypt.jsp","������ܣ����Ժ�......");
	getEncryptPwd_Packet.data.add("encryptType","encrypt");
	getEncryptPwd_Packet.data.add("password",pwd);
	core.ajax.sendPacket(getEncryptPwd_Packet,doEncryptPwdBack);
	getEncryptPwd_Packet = null;
}
function doEncryptPwdBack(packet){
	var retcode = packet.data.findValueByName("retcode");
	var retmsg = packet.data.findValueByName("retmsg");
	var returnPwd = packet.data.findValueByName("returnPwd");
	if(retcode != "000000"){
		rdShowMessageDialog("�������ʧ��",0);
		$("#cfmPwdEncryptFlag").val("0");
	}else{
		$("#cfmPwdEncrypt").val(returnPwd);
		$("#cfmPwdEncryptFlag").val("1");
	}
}
/**��ӡ�Ի���**/

function showPrtDlg(printType, DlgMessage, submitCfm)
{
    //��ʾ��ӡ�Ի���
    var h = 215;
    var w = 400;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var mode_code = "";
    var fav_code = "";
    var area_code="";
    var sysAccept = "<%=printAccept%>";
    var pType="subprint";
    var printStr = printInfo(printType);
    var billType="1";
    var phoneNo = $('#phone_no').val();
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret = window.showModalDialog(path, "", prop);
    if (typeof(ret) != "undefined")
    {
        if ((ret == "confirm") && (submitCfm == "Yes"))
        {

            if (rdShowConfirmDialog('ȷ��Ҫ���п����������') == 1) conf();
            else $('#commitBut').attr('disabled', true);
        }
        if (ret == "continueSub")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ���п����������') == 1) conf();
            else $('#commitBut').attr('disabled', true);
        }
        if (ret == "cancel")
        {
            if (rdShowConfirmDialog('ȷ��Ҫ���п����������') == 1) conf();
            else $('#commitBut').attr('disabled', true);
        }
    }
    else
    {
        if (rdShowConfirmDialog('ȷ��Ҫ���п����������') == 1) conf();
        else $('#commitBut').attr('disabled', true);
    }
}

function printInfo(printType)
{
    var retInfo = "";
		var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		cust_info += "����ʺţ�"+$("#cfmLogin").val()+"|";
		cust_info += "�ͻ�������"+$("#custName").val().trim()+"|";
		
		opr_info += "����ҵ�����ƣ����ÿ����¼����" + "       ������ˮ��"+"<%=printAccept%>"+"|";		
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;	    
}

        
        function conf()
        {
            document.all.commitBut.disabled = true;
            document.f4991.action = "f4991_CfmSub.jsp";
            f4991.submit();
        }
        /*��ѯ�ͻ���Ϣ*/
        function select_cust()
        {
            if (!checkElement(f4991.idIccid))
                return false;
            var path = "f4991_getCustInfo.jsp?idIccid=" + f4991.idIccid.value;
            retInfo = window.open(path, "newwindow", "height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
        }
        function getWideAreaInfo_Ajax()
        {
            if (!checkElement(f4991.cfmLogin)) return false;
            $('#WideAreaInfo').attr('disabled', true);
            var myPacket = new AJAXPacket("f4991_wideAreaInfo_Ajax.jsp", "���ڻ�ȡ����ʺ���Ϣ......");
            myPacket.data.add("cfmLogin", $('#cfmLogin').val());
            core.ajax.sendPacket(myPacket, doProcessCfmLogin);//�첽
            myPacket = null;
        }

        function doProcessCfmLogin(packet)
        {
            var retCode = unescape(packet.data.findValueByName("retCode"));
            var retMsg = unescape(packet.data.findValueByName("retMsg"));
            var idIccid = unescape(packet.data.findValueByName("idIccid"));
            var phone_no = unescape(packet.data.findValueByName("phone_no"));
            var custName = unescape(packet.data.findValueByName("custName"));
            var id_no = unescape(packet.data.findValueByName("id_no"));
            var sm_name = unescape(packet.data.findValueByName("sm_name"));
            var sm_code = unescape(packet.data.findValueByName("sm_code"));
            var vModeName = unescape(packet.data.findValueByName("vModeName"));
            var vModeCode = unescape(packet.data.findValueByName("vModeCode"));
            var run_name = unescape(packet.data.findValueByName("run_name"));
            var run_code = unescape(packet.data.findValueByName("run_code"));
            var vOweFee = unescape(packet.data.findValueByName("vOweFee"));
            var vAttrName = unescape(packet.data.findValueByName("vAttrName"));
            var vCustAttr = unescape(packet.data.findValueByName("vCustAttr"));
            var attname = unescape(packet.data.findValueByName("attname"));
            var attcode = unescape(packet.data.findValueByName("attcode"));
            var vDetailAddr = unescape(packet.data.findValueByName("vDetailAddr"));
            if (retCode == "000000" || retCode == "0")
            {
                $('#idIccid').val(idIccid);
                $('#custName').val(custName);
                $('#phone_no').val(phone_no);
                $('#id_no').val(id_no);
                $('#sm_name').val(sm_name);
                $('#sm_code').val(sm_code);
                $('#vModeName').val(vModeName);
                $('#run_name').val(run_name);
                $('#run_code').val(run_code);
                $('#vOweFee').val(vOweFee);
                $('#vAttrName').val(vAttrName);
                $('#vCustAttr').val(vCustAttr);
                $('#attname').val(attname);
                $('#attcode').val(attcode);
                $('#vDetailAddr').val(vDetailAddr);
                $('#idIccid').attr('readonly', true);
                $('#cfmLogin').attr('readonly', true);
                $('#WideAreaInfo').attr('disabled', true);
                $('#select_custbutton').attr('disabled', true);
                checkOpType();
            }
            else {
                rdShowMessageDialog("�������:'" + retCode + "'������Ϣ:'" + retMsg + "'", 0);
                $('#WideAreaInfo').attr('disabled', false);
                $('#commitBut').attr('disabled', true);
                return false;
            }
        }
        function checkOpType()
        {
            if ($('#opType').val() == 'UU')
            {
                $('#oldPassTr').attr('style', 'display:""');
            }
            else
            {
                $('#oldPassTr').attr('style', 'display:none');
                if (document.f4991.WideAreaInfo.disabled == true) $('#commitBut').attr('disabled', false);
                else $('#commitBut').attr('disabled', true);
            }
        }
        function formReset()
        {
            $('#idIccid').attr('readonly', false);
            $('#cfmLogin').attr('readonly', false);
            $('#WideAreaInfo').attr('disabled', false);
            $('#select_custbutton').attr('disabled', false);
            $('#doValidatePwd').attr('disabled', false);
            $('#commitBut').attr('disabled', true);
            $("input[type='text']").val('');
            $("input[type='password']").val('');
            $('#oldpassword').attr('readonly', false);
            $('#opCode').val('<%=opCode%>');
        }
        function doSelCust()
        {
            if (!checkElement(f4991.idIccid) || $('#idIccid').val() == "") return false;
            var path = "f4991_getCustInfo.jsp?idIccid=" + $('#idIccid').val();
            retInfo = window.open(path, "newwindow", "height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
        }
    </SCRIPT>
</HEAD>
<body>
<FORM method=post name="f4991">
    <input type="hidden" id="opCode" name="opCode" value='<%=opCode%>' readonly>
    <input type="hidden" name="sm_code" id="sm_code" readonly>
    <input type="hidden" name="vModeCode" id="vModeCode" readonly>
    <input type="hidden" id="run_code" name="run_code" readonly>
    <input type="hidden" id="vCustAttr" name="vCustAttr" readonly>
    <input type="hidden" id="attcode" name="attcode" readonly>
    <input type="hidden" id="vAttrName" name="vAttrName" readonly>
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">�û�����</div>
    </div>
    <table cellSpacing="0">
        <tr>
            <td width="15%" class="Blue">֤������</td>
            <td width="35%">
                <input type="text" id="idIccid" name="idIccid" v_must=0 v_type="string" v_minlength="1" v_maxlength="20"
                       onblur="checkElement(this)" onKeyup="if(event.keyCode==13) doSelCust();">
                <font class="orange">*</font>
                <input name="select_custbutton" type=button onClick="doSelCust();" class="b_text" style="cursor:hand"
                       id="select_custbutton" value="��Ϣ��ѯ">
            </td>
			<td width="15%" class="Blue">֤������</td>
			<td width="35%">
			    <input type="text" id="idName" name="idName" readonly>
			</td>
        </tr>
        <tr>
            <td width="15%" class="Blue">����ʺ�</td>
            <td width="35%">
                <input type="text" id="cfmLogin" name="cfmLogin" v_must=1 v_minlength=1 v_maxlength=25 v_type="string"
                       onblur="checkElement(this)">
                <font class="orange">*</font>
                <input name="WideAreaInfo" type=button onClick="getWideAreaInfo_Ajax();" class="b_text"
                       style="cursor:hand"
                       id="WideAreaInfo" value="��ѯ">
            </td>
            <td width="15%" class="Blue">�ͻ�����</td>
            <td width="35%">
                <input type="text" id="custName" name="custName" readonly>
            </td>
        </tr>
    </table>
        <input type="hidden" id="phone_no" name="phone_no" >
        <input type="hidden" id="id_no" name="id_no" >
        <input type="hidden" name="sm_name" id="sm_name" >
        <input type="hidden" name="vModeName" id="vModeName" >
        <input type="hidden" id="run_name" name="run_name" >
        <input type="hidden" id="vOweFee" name="vOweFee" >
        <input type="hidden" id="attname" name="attname" size="75%" >
        <input type="hidden" id="vDetailAddr" name="vDetailAddr" />

    </br>
    <div class="title">
        <div id="title_zi"><%=opName%>
        </div>
    </div>
    <table cellspacing="0">
        <tr>
            <td width="15%" class="Blue">��������</td>
            <td width="35%" colspan='3'>
                <select name='opType' id='opType' onchange="checkOpType()">
                    <option value='UU'>�޸�����</option>
                    <option value='DD'>��λ����</option>
                </select>
            </td>
        </tr>
        <tr id='oldPassTr' style="">
            <td width="15%" class="Blue">�û�������</td>
            <td width="35%" colspan='3'>
                <input type=password name="oldpassword" id='oldpassword' pwd2='oldpassword' size="21" maxlength='6'
                       v_must=1 v_minlength=6 v_maxlength=6 v_type="pwd"
                       onblur="checkElement(this)">
                <font class="orange">*</font>
                <input name="doValidatePwd" type=button onClick="doValidatePwdJs();" class="b_text" style="cursor:hand"
                       id="doValidatePwd" value="��֤">
            </td>
        </tr>
        <tr>
        	<jsp:include page="/npage/common/pwd_2.jsp">
        <jsp:param name="width1" value="12%"  />
        <jsp:param name="width2" value="38%"  />
        <jsp:param name="pname" value="newpassword" />
        <jsp:param name="pcname" value="cfmPwd" />
        </jsp:include>
        <jsp:include page="/npage/common/pwd_comm.jsp"/>
        </tr>
        <tr>
            <td class="Blue" width="15%">
                ϵͳ��ע
            </td>
            <td colspan='3'>
                <input type="text" size="60" name="vSystemNote" id='vSystemNote' v_maxlength="60" v_type="string"
                       maxlength="60" index="9"
                       onblur="checkElement(this)" readonly>
        </tr>
        <tr>
            <td class="Blue" width="11%">�û���ע</td>
            <td width="89%" colspan='3'>
                <input type="text" size="60" name="vOpNote" id='vOpNote' v_maxlength="60" v_type="string" maxlength="60"
                       index="9" onblur="checkElement(this)">
            </td>

        </tr>
        <TR>
            <TD id="footer" align=center colspan='4'>
                <input class="b_foot" name="commitBut" id='commitBut' onmouseup="commitJsp()"
                       onKeyUp="if(event.keyCode==13)commitJsp()"
                       type=button value="ȷ��&��ӡ" disabled>
                <input class="b_foot" name="resetForm" type=button value="���" onclick='formReset()'>
                <input class="b_foot" name=back onClick="parent.removeTab(<%=opCode%>)" type=button value="�ر�">
            </TD>
        </TR>
    </table>
<input type="hidden" name="printAccept" id="printAccept" value="<%=printAccept%>" />
<input type="hidden" name="cfmPwdEncrypt" id="cfmPwdEncrypt" />
<input type="hidden" name="cfmPwdEncryptFlag" id="cfmPwdEncryptFlag" value="0" />
<input type="hidden" name="cfmPwdEncryptOld" id="cfmPwdEncryptOld" />
<input type="hidden" name="cfmPwdEncryptNew" id="cfmPwdEncryptNew" />
    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>