<%
/*****************************
 * ģ�����ƣ��������պ�Ⱥ��Ա����
 * ����汾��version 1.0
 * �� �� ��: SI-TECH
 * ��    ��: shengzd
 * ����ʱ��: 2010-05-13
 *****************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=GBK"%>
<%
	response.setHeader("Pragma", "No-Cache");
	response.setHeader("Cache-Control", "No-Cache");
	response.setDateHeader("Expires", 0);
	String passwd = WtcUtil.repNull((String)session.getAttribute("password"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = "4891";
	String opName = "�������պ�Ⱥ��Ա����";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>�������պ�Ⱥ��Ա����</title>
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
    <td class="blue" width="15%">��������</td>
    <td colspan="3">
        <select name="opType" id="opType">
            <option value="01">01 -> ��ӱպ�Ⱥ��Ա</option>
            <option value="02">02 -> �޸ıպ�Ⱥ��Ա</option>
            <option value="03">03 -> ɾ���պ�Ⱥ��Ա</option>
        </select>
        <font class='orange'>*</font>
    </td>
</tr>
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
<tr>
    <td class="blue" nowrap>�պ�Ⱥ��</td>
    <td>
        <input type="text" id="closeNo" name="closeNo" value="" readOnly class="InputGrey" />
        <input type="button" id="selectCloseNoBtn" name="selectCloseNoBtn" value="ѡ��" onclick="selectCloseNo()" class="b_text" disabled />
    </td>
    <td class="blue" nowrap>�պ�Ⱥ����</td>
    <td>
        <input type="text" id="closeName" name="closeName" value="" readOnly class="InputGrey" />
    </td>
</tr>
<tr>
    <td class="blue" nowrap>��������</td>
    <td>
        <input type="text" id="feeIndex" name="feeIndex" value="" readOnly class="InputGrey" />
    </td>
    <td class="blue" nowrap>����û���</td>
    <td>
        <input type="text" id="maxUserNum" name="maxUserNum" value="" readOnly class="InputGrey" />
    </td>
</tr>
</table>
</div>

<div id="Operation_Table" class="MemberClass" style="display:none;">
<div class="title">
	<div id="title_zi">�պ�Ⱥ��Ա</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" nowrap>��������</td>
        <td colspan="3">
            <select name="noType" id="noType">
                <option value="1">01 -> ��ʵ����</option>
                <option value="0">02 -> �̺�</option>
            </select>
            <font class="orange">*</font>
        </td>
    </tr>
    <tr>
        <TD class=blue>����</TD>
        <TD>
            <textarea cols=30 rows=8 name="multi_phoneNo" id="multi_phoneNo" style="overflow:auto" /></textarea>
        </TD>
        <TD colspan='2' class="orange">
            ˵������������֮���á�|�����������ܽ��̺ź���ʵ���������롣
            <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;����֮�䲻���ظ���һ�β��ܳ���50����
            <br>&nbsp;���磺<br><font color=black>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000001|<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000002|<br>
            	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;13900000003|<br></font>
        </TD>
    </tr>
    <!--tr id="noticeTr" style="display:none;"><td colspan="4"><span id="notice" style="color:red;"></span></td></tr-->
</table>

<div id="noticeTr" style="display:none;"><br>
<div class="title">
    <div id="title_zi">��Ϊ��Աѡ���µıպ�Ⱥ��</div>
</div>
    <table cellspacing="0">
<tr>
    <td class="blue" nowrap>�պ�Ⱥ��</td>
    <td>
        <select name="newClose" id="newClose" onchange="changeNewClose();">

        </select>
    </td>
    <td class="blue" nowrap>�պ�Ⱥ����</td>
    <td>
        <input type="text" id="closeName2" name="closeName2" value="" readOnly class="InputGrey" />
    </td>
</tr>
<tr>
    <td class="blue" nowrap>��������</td>
    <td>
        <input type="text" id="feeIndex2" name="feeIndex2" value="" readOnly class="InputGrey" />
    </td>
    <td class="blue" nowrap>����û���</td>
    <td>
        <input type="text" id="maxUserNum2" name="maxUserNum2" value="" readOnly class="InputGrey" />
    </td>
</tr>
</table>
</div>
</div>

<div id="Operation_Table">
<table cellspacing="0">
    <tr id="footer">
        <td colspan="4">
            <input class="b_foot" name="nextBtn" id="nextBtn" type="button" value="��һ��" disabled onclick="nextStep()" />
            <input class="b_foot" name="submitBtn" id="submitBtn" type="button" value="ȷ��"  onclick="refMain()" style="display:none;" />
            <input class="b_foot" name="resetBtn" id="resetBtn" type="button" value="����" onclick="window.location='f4891.jsp'" />
            <input class="b_foot" name="closeBtn" id="closeBtn" type="button" value="�ر�" onClick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>
</form>
<script language="JavaScript">
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
        var sqlStr= "";
        //var sqlStr="select b.id_iccid,a.Unit_id,a.BOSS_VPMN_CODE,a.unit_name from dgrpcustmsg a,dcustdoc b where a.cust_id = b.cust_id ";
        if(vIccid.trim() != ""){
           // sqlStr += " and b.id_iccid = '"+vIccid+"'";
        }
        if(vUnitId.trim() != ""){
            //sqlStr += " and a.Unit_id = "+vUnitId;
        }
        if(vVpmnGrpNo.trim() != ""){
           // sqlStr += " and a.BOSS_VPMN_CODE = '"+vVpmnGrpNo+"'";
        }

        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "4|0|1|2|3|";
        var retToField = "iccid|unitId|vpmnGrpNo|unitName|";
        PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    }

    function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "f4891_qry_cust.jsp";
        path = path + "?sqlStr=" +"" + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;  
        
        path = path + "&logacc=" + "0";  
        path = path + "&chnSrc=" + "01";  
        path = path + "&opCode=" + "<%=opCode%>";  
        path = path + "&workNo=" + "<%=workNo%>";  
        path = path + "&passwd=" + "<%=passwd%>";  
        
        path = path + "&phoneNo=" + "";  
        path = path + "&usrPwd=" + "";  
        path = path + "&unitId=" + $("#unitId").val();
        path = path + "&icustid=" + "";
        path = path + "&idIccId=" + $("#iccid").val();
        
        path = path + "&bizCodAdd=" + "";
        path = path + "&oprCode=" + "<%=opCode%>";
        path = path + "&svcNo=" + "";
        path = path + "&grpId=" + "";
        path = path + "&regCode=" + "";
        
        path = path + "&startPos=" + "";
        path = path + "&endPos=" + "";
        path = path + "&qryType=" + "2";
        path = path + "&pntType=" + "";
        path = path + "&accType=" + "";
        path = path + "&smCode=" + "";
        
        path = path + "&vpmnNo=" + $("#vpmnGrpNo").val();
        path = path + "&cnocNo=" + "";
        path = path + "&other=" + "";
        path = path + "&opNote=" + "";
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
        $("#selectCloseNoBtn").attr("disabled",false);
    }
    var params ="";
    /* ѡ��պ�Ⱥ�� */
	function selectCloseNo(){
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    var vUnitId = $("#unitId").val();
	    var vIccid = $("#iccid").val();
	    params = vUnitId+"|"+vVpmnGrpNo+"|";
	    //alert(params);
    	if(vUnitId.trim() == ""){
    	    rdShowMessageDialog("���ű��Ϊ�գ��������ѯ������",0);
	        window.location = "f4891.jsp";
	        return false;
	    }
	    if(vVpmnGrpNo.trim() == ""){
    	    rdShowMessageDialog("���������ű���Ϊ�գ��������ѯ������",0);
	        window.location = "f4891.jsp";
	        return false;
	    }
	    
        var pageTitle = "�պ�Ⱥ��Ϣ��ѯ";
        var fieldName = "�պ�Ⱥ��|�պ�Ⱥ����|��������|����û���|";
        var sqlStr="90000170";

        var selType = "S";    //'S'��ѡ��'M'��ѡ
        var retQuence = "4|0|1|2|3|";
        var retToField = "closeNo|closeName|feeIndex|maxUserNum|";
        PubSimpSel2(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
	}
	
	function PubSimpSel2(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "/npage/public/fPubSimpSel.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
        path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
        path = path + "&selType=" + selType;  
        path += "&params="+params;
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
        $("#nextBtn").attr("disabled",false);
    }
    
    /* ��һ�� */
    function nextStep(){
        var vOpType = $("#opType").val();
        
        $("#getCustomerBtn").attr("disabled",true);
        $("#opType").find("option:not(:selected)").remove();
        $(".MemberClass").show();
            $("#nextBtn").hide();
            $("#submitBtn").show();
            
        if(vOpType == "01" || vOpType == "03"){//��� && ɾ��
            $("#noticeTr").hide();
            $("#selectCloseNoBtn").attr("disabled",true);
        }else if(vOpType == "02"){//�޸�
            //$("#noticeTr").show();
            $("#selectCloseNoBtn").attr("disabled",true);
            
            var myPacket    = new AJAXPacket("f4891getInfo.jsp","���ڻ�ȡ�պ�Ⱥ�б���Ϣ�����Ժ�......");
            var vOldUnitId  = document.getElementById('unitId').value.trim();
            var vOldCloseNo = document.getElementById('closeNo').value.trim();
            if(vOldUnitId == ""){
				     	rdShowMessageDialog("��¼���ԱĿǰ�������ļ�����Ϣ��",0);
				     	return false;
		        }
		        if(vOldCloseNo == ""){
				     	rdShowMessageDialog("��ѡ���ԱĿǰ�������ıպ�Ⱥ��",0);
				     	return false;
		        }
		        myPacket.data.add("vOldCloseNo",vOldCloseNo);
	         	myPacket.data.add("vOldUnitId",vOldUnitId);
		        myPacket.data.add("verifyType","getNewClose"); 
            core.ajax.sendPacket(myPacket);
            myPacket=null;
        }
    }
    
    /* ȷ�� */
    function refMain(){
        var vOpType = $("#opType").val();
        var vPhoneNo = $("#multi_phoneNo").val();
        
        if(vPhoneNo.trim() == ""){
            rdShowMessageDialog("�����������Ϣ��",0);
            return false;
        }
        /* �滻�ı�����Ļس�Ϊ"" begin */
        vPhoneNo = vPhoneNo.replace(new RegExp("\n","gm"),"");
        $("#multi_phoneNo").val(vPhoneNo);
         /*�滻�ı�����Ļس�Ϊ"" end */

	    var vCfmMsg = "";
	    if(vOpType == "02"){
	        vCfmMsg = "ȷ���޸ıպ�Ⱥ��Ա��Ϣ��";
	    }else if(vOpType == "03"){
	        vCfmMsg = "ȷ��ɾ���պ�Ⱥ��Ա��Ϣ��";
	    }else{
	        vCfmMsg = "ȷ���ύ�պ�Ⱥ��Ա��Ϣ��";
	    }
	    
	    if(!check(form1)){
            return false;
        }else{
            if(rdShowConfirmDialog(vCfmMsg)==1){
                form1.action="f4891Cfm.jsp";
            	form1.method="post";
            	form1.submit();
            }
        }
    }
    
    function doProcess(packet){
        var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode"); 
        var retMessage = packet.data.findValueByName("retMessage"); 

        var error_code = packet.data.findValueByName("errorCode");
        var error_msg  = packet.data.findValueByName("errorMsg");
        var verifyType = packet.data.findValueByName("verifyType");
        var backArrMsg = packet.data.findValueByName("backArrMsg");    
        //alert(verifyType); 
        self.status="";
        if(verifyType=="getNewClose"){
        if(backArrMsg==""){
          rdShowMessageDialog("�ü���û�пɹ���Ա����ıպ�Ⱥ��",1);
        }else{
            var optionArr = backArrMsg;
            var temLength = optionArr.length;
            var arr = new Array(temLength);
            for(var i = 0 ; i < temLength ; i ++){
                arr[i] = "<option value='"+optionArr[i][0]+"'>"+optionArr[i][1]+"</option>";
            }
            $("#newClose").empty();
            $(arr.join("")).appendTo("#newClose");
            changeNewClose();
        }
			    $("#noticeTr").show();
		}
        if(verifyType=="NewClose"){
        if(backArrMsg==""){
          rdShowMessageDialog("�޸ñպ�Ⱥ��Ϣ��",0);
        }else{
          var temp = backArrMsg+"";
				
          var vCloseName  = temp.split(",")[0];
          var vFeeIndex   = temp.split(",")[1];
          var vMaxUserNum = temp.split(",")[2];
          //alert(vCloseName +' - '+vFeeIndex +' - '+ vMaxUserNum);
          $("#closeName2").val(vCloseName);
          $("#feeIndex2").val(vFeeIndex);
          $("#maxUserNum2").val(vMaxUserNum);
			}	
		}
	}

function changeNewClose(){
	  //alert(1);
		var myPacket  = new AJAXPacket("f4891getInfo.jsp","���ڻ�ȡ�պ�Ⱥ��Ϣ�����Ժ�......");				      			    
		//alert(2);
		var vvUnitId  = document.getElementById('unitId').value.trim();
		var vNewClose = document.getElementById('newClose').value.trim();
		if(vvUnitId == ""){
				     	rdShowMessageDialog("��¼���ԱĿǰ�������ļ�����Ϣ��",0);
				     	return false;
		}//alert(3);
		myPacket.data.add("vNewClose",vNewClose);
		myPacket.data.add("verifyType","NewClose");
		//alert(4);
		core.ajax.sendPacket(myPacket);
		//alert(5);
		myPacket=null;
	}
</script>
</body>
</html>
