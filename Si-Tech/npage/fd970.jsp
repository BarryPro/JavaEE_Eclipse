<%
/*****************************
 * ģ�����ƣ��������Ӽ����������
 * ����汾��version 1.0 4890
 * �� �� ��: SI-TECH
 * ��    ��: yuanqs
 * ����ʱ��: 2011-06-28
 *****************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);

	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	System.out.println("# ---------------powerRight = ["+powerRight+"] ---------------");
	System.out.println("# ---------------regionCode = ["+regionCode+"] ---------------");


	String opCode = request.getParameter("opCode");
	System.out.println(opCode+"=========yuanqs=");
	String opName = request.getParameter("opName");
	System.out.println(opName+"=========yuanqs=");

	String note = "";
	if ("d970".equals(opCode)) {
		note = "ע���������Ӻ���ʱ,ÿ������һ���������ף�3-12λ���ִ���������00��ͷ��һ�β���������ͬʱ�������ͺ��ף�����\"|\"��Ϊ�ָ���,�������һ������Ҳ����\"|\"��Ϊ������ÿ�����50�����������Ϊ���룬��13823700000|�����ʾ���ú�����Ϊ���ŵ�������룻�������Ϊ���ף��磺0755287|�����ʾ�Ըú��׿�ͷ�ĺ��붼����Ϊ�ü��ŵ�������롣���ڹ̶��绰Ҫ�����볤;���ţ�����07558765432�����ֻ�����ǰ��������0��";
	} else {
		note = "ע������ɾ���������ʱ,ÿ������һ���������ף�����Ϊ���ִ���һ�β���������ͬʱ�������ͺ��ף�����\"|\"��Ϊ�ָ���,�������һ������Ҳ����\"|\"��Ϊ������ÿ�����50������13823700000|0755287|���ڹ̶��绰Ҫ�����볤;���ţ�����07558765432�����ֻ�����ǰ��������0��";
	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title><%=opName%></title>
</head>
<body>
<form name="form1" method="post">
<input type="hidden" id="op_code" name="op_code" value="<%=opCode%>">
<input type="hidden" id="op_name" name="op_name" value="<%=opName%>">

<%@ include file="/npage/include/header.jsp"%>
<div class="title">
    <div id="title_zi">������Ϣ</div>
</div>
<table cellSpacing=0>
<tr>
    <td class="blue" nowrap>֤������</td>
    <td>
        <input type="text" id="iccid" name="iccid" value="" v_type="string" v_must="1" size="20" maxlength="20" />
        <font class="orange">*</font>
        <input name="getCustomerBtn" type="button" class="b_text" onclick="getVpmnGrp()" id="getCustomerBtn" value="��ѯ" />
    </td>
    <td class="blue">���ű��</td>
    <td>
        <input name="unitId" id="unitId" v_type="string" v_must="1" size="20" maxlength="20">
        <font class="orange">*</font>
    </td>
</tr>
<tr>
    <td class="blue">���������ű���</td>
    <td>
        <input name="vpmnGrpNo" id="vpmnGrpNo" v_type="string" v_must="1" size="20" maxlength="20">
        <font class=orange>*</font>
    </td>
    <td class="blue">��������</td>
    <td>
        <input name="unitName" id="unitName" v_type="string" v_must="1" size="20" maxlength="60" readonly class="InputGrey">
    </td>
</tr>
</table>
</div>

<div id="Operation_Table" class="closeInfo" style="display:none;">
<div class="title">
	<div id="title_zi">�������������Ϣ</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" nowrap>����</td>
        <td>
        	<textarea id='phoneNoOut' name="phoneNoOut" cols=50 rows=5></textarea>
        </td>
        <td>
        <font class="orange">
        	<%=note%>
		</font>
        </td>
    </tr>
</table>
</div>

<div id="Operation_Table">
<table cellspacing="0">
    <tr id="footer">
        <td colspan="4">
            <input class="b_foot" name="nextBtn" id="nextBtn" type="button" value="��һ��" disabled onclick="nextStep()" />
            <input class="b_foot" name="submitBtn" id="submitBtn" type="button" value="ȷ��"  onclick="refMain()" style="display:none;" />
            <input class="b_foot" name="resetBtn" id="resetBtn" type="button" value="����" onclick="resetPage()" />
            <input class="b_foot" name="closeBtn" id="closeBtn" type="button" value="�ر�" onClick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>
</form>
<script language="JavaScript">
	/*yuanqs add 2011/7/1 16:57:35 resetPage */
	function resetPage() {
		var opCode = document.all.op_code.value;
		if ("d970" == opCode) {
			window.location='fd970.jsp?opCode=d970&opName=�������Ӽ����������';
		} else {
			window.location='fd970.jsp?opCode=e009&opName=����ɾ�������������';
		}

	}
	function doProcess(packet){

		var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode");
        var retMessage = packet.data.findValueByName("retMessage");
        self.status="";

		if(retType == "getCloseNo"){
            var vCloseNo = packet.data.findValueByName("retnewId");
            if(retCode=="000000"){
    			$("#closeNo").val(vCloseNo);
            } else {
    			rdShowMessageDialog("��ȡ�պ�Ⱥ��ʧ�ܣ�������룺"+retCode+",������Ϣ��"+retMessage,0);
    			return false;
            }
         }
	}

	/* ��ȡvpmn������Ϣ */
	function getVpmnGrp(){
	    var vIccid = $("#iccid").val();
	    var vUnitId = $("#unitId").val();
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    if(vIccid.trim() == "" && vUnitId.trim() == "" && vVpmnGrpNo.trim() == ""){
	        rdShowMessageDialog("֤�����롢���ű�š����������ű�������������һ����",0);
	        $("#iccid").focus();
	        return;
	    }
        var pageTitle = "������Ϣ��ѯ";
        var fieldName = "֤������|���ű��|���������ű���|��������|";
        /* yuanqs add 2011/6/28 14:25:24 �޸�sql */
        //var sqlStr="sqlStr =select b.id_iccid,a.Unit_id,a.BOSS_VPMN_CODE,a.unit_name from dgrpcustmsg a,dcustdoc b where a.cust_id = b.cust_id and b.region_code='" + '<%=regionCode%>' + "'";
        
				var sqlStr = "";
        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "4|0|1|2|3|";
        var retToField = "iccid|unitId|vpmnGrpNo|unitName|";
        PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,vIccid,vUnitId,vVpmnGrpNo);
    }

    function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,vIccid,vUnitId,vVpmnGrpNo){
        var path = "/npage/sd970/fd970SimpSel.jsp";
        path = path + "?retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;
        path = path + "&vIccid=" + vIccid;
        path = path + "&vUnitId=" + vUnitId;
        path = path + "&vVpmnGrpNo=" + vVpmnGrpNo;
        retInfo = window.showModalDialog(path,"","dialogHeight:440px;dialogWidth:650px;");
        if(typeof(retInfo)=="undefined")
        {   return false;   }
        var chPos_field = retToField.indexOf("|");
        var chPos_retStr;
        var valueStr;
        var obj;
        while(chPos_field > -1)
        {
            obj = retToField.substring(0,chPos_field);
            chPos_retInfo = retInfo.indexOf("|");
            valueStr = retInfo.substring(0,chPos_retInfo);
            document.all(obj).value = valueStr;
            retToField = retToField.substring(chPos_field + 1);
            retInfo = retInfo.substring(chPos_retInfo + 1);
            chPos_field = retToField.indexOf("|");

        }

        $("#iccid,#unitId,#vpmnGrpNo").attr("readOnly",true);
        $("#iccid,#unitId,#vpmnGrpNo").addClass("InputGrey");
        $("#nextBtn").attr("disabled",false);
    }

	function PubSimpSel2(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "/npage/public/fPubSimpSel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;
        retInfo = window.showModalDialog(path,"","dialogHeight:440px;dialogWidth:650px;");
        if(typeof(retInfo)=="undefined")
        {   return false;   }
        var chPos_field = retToField.indexOf("|");
        var chPos_retStr;
        var valueStr;
        var obj;
        while(chPos_field > -1)
        {
            obj = retToField.substring(0,chPos_field);
            chPos_retInfo = retInfo.indexOf("|");
            valueStr = retInfo.substring(0,chPos_retInfo);
            document.all(obj).value = valueStr;
            retToField = retToField.substring(chPos_field + 1);
            retInfo = retInfo.substring(chPos_retInfo + 1);
            chPos_field = retToField.indexOf("|");
        }
        if($("#opType").val() == "03"){//ɾ��
            $("#feeIndex").find("option:not(:selected)").remove();
        }
    }

	/* ��ȡ�պ�Ⱥ�� */
	function getCloseNo(){
        var getCloseNo_Packet = new AJAXPacket("ajax_getCloseNo.jsp","���ڻ�ñպ�Ⱥ�ţ����Ժ�......");
    	getCloseNo_Packet.data.add("retType","getCloseNo");
        getCloseNo_Packet.data.add("region_code","<%=regionCode%>");
        getCloseNo_Packet.data.add("idType","0");
        getCloseNo_Packet.data.add("oldId","0");
        core.ajax.sendPacket(getCloseNo_Packet);
        getCloseNo_Packet=null;
	}

	/* ��һ�� */
	function nextStep(){
		/*yuanqs add 2011/7/1 17:03:24*/
		var opCode = document.all.op_code.value;

	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    if(vVpmnGrpNo.trim() == ""){
	        rdShowMessageDialog("���������ű���Ϊ�գ�������������",0);
	        if ("d970" == opCode) {
				window.location='fd970.jsp?opCode=d970&opName=�������Ӽ����������';
			} else {
				window.location='fd970.jsp?opCode=e009&opName=����ɾ�������������';
			}
	        return false;
	    }

	    $("#opType").find("option:not(:selected)").remove();
	    var vOpType = $("#opType").val();

	    $(".closeInfo").show();
	    $("#nextBtn").hide();
	    $("#submitBtn").show();

	    if(vOpType == "01"){//����
	        $("#getCloseNoBtn").show();
	        $("#selectCloseNoBtn").hide();
	    }else if(vOpType == "02"){//�޸�
	        $("#getCloseNoBtn").hide();
	        $("#selectCloseNoBtn").show();
	    }else if(vOpType == "03"){//ɾ��
	        $("#getCloseNoBtn").hide();
	        $("#selectCloseNoBtn").show();
	        $("#closeNo,#closeName,#maxUserNum").attr("readOnly",true);
	        $("#closeNo,#closeName,#maxUserNum").addClass("InputGrey");
	        $("#submitBtn").val("ɾ��");
	    }
	}

	/* �ύ */
	function refMain(){
	    var vCfmMsg = "ȷ���ύ��";
	    if(!check(form1)){
            return false;
        }else{
            if(rdShowConfirmDialog(vCfmMsg)==1){
                form1.action="fd970Cfm.jsp";
            	form1.method="post";
            	form1.submit();
            }
        }
	}
</script>
</body>
</html>
