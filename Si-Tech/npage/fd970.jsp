<%
/*****************************
 * 模块名称：批量增加集团网外号码
 * 程序版本：version 1.0 4890
 * 开 发 商: SI-TECH
 * 作    者: yuanqs
 * 创建时间: 2011-06-28
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
		note = "注：批量增加号码时,每行输入一个号码或号首，3-12位数字串，不能以00开头，一次操作中允许同时输入号码和号首，请用\"|\"作为分隔符,并且最后一个号码也请用\"|\"作为结束。每次最多50个。若输入的为号码，如13823700000|，则表示将该号码作为集团的网外号码；若输入的为号首，如：0755287|，则表示以该号首开头的号码都将作为该集团的网外号码。对于固定电话要求输入长途区号（比如07558765432）；手机号码前面则不能输0。";
	} else {
		note = "注：批量删除网外号码时,每行输入一个号码或号首，必须为数字串。一次操作中允许同时输入号码和号首，请用\"|\"作为分隔符,并且最后一个号码也请用\"|\"作为结束。每次最多50个。如13823700000|0755287|对于固定电话要求输入长途区号（比如07558765432）；手机号码前面则不能输0。";
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
    <div id="title_zi">集团信息</div>
</div>
<table cellSpacing=0>
<tr>
    <td class="blue" nowrap>证件号码</td>
    <td>
        <input type="text" id="iccid" name="iccid" value="" v_type="string" v_must="1" size="20" maxlength="20" />
        <font class="orange">*</font>
        <input name="getCustomerBtn" type="button" class="b_text" onclick="getVpmnGrp()" id="getCustomerBtn" value="查询" />
    </td>
    <td class="blue">集团编号</td>
    <td>
        <input name="unitId" id="unitId" v_type="string" v_must="1" size="20" maxlength="20">
        <font class="orange">*</font>
    </td>
</tr>
<tr>
    <td class="blue">智能网集团编码</td>
    <td>
        <input name="vpmnGrpNo" id="vpmnGrpNo" v_type="string" v_must="1" size="20" maxlength="20">
        <font class=orange>*</font>
    </td>
    <td class="blue">集团名称</td>
    <td>
        <input name="unitName" id="unitName" v_type="string" v_must="1" size="20" maxlength="60" readonly class="InputGrey">
    </td>
</tr>
</table>
</div>

<div id="Operation_Table" class="closeInfo" style="display:none;">
<div class="title">
	<div id="title_zi">集团网外号码信息</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" nowrap>号码</td>
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
            <input class="b_foot" name="nextBtn" id="nextBtn" type="button" value="下一步" disabled onclick="nextStep()" />
            <input class="b_foot" name="submitBtn" id="submitBtn" type="button" value="确定"  onclick="refMain()" style="display:none;" />
            <input class="b_foot" name="resetBtn" id="resetBtn" type="button" value="重置" onclick="resetPage()" />
            <input class="b_foot" name="closeBtn" id="closeBtn" type="button" value="关闭" onClick="removeCurrentTab()" />
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
			window.location='fd970.jsp?opCode=d970&opName=批量增加集团网外号码';
		} else {
			window.location='fd970.jsp?opCode=e009&opName=批量删除集团网外号码';
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
    			rdShowMessageDialog("获取闭合群号失败！错误代码："+retCode+",错误信息："+retMessage,0);
    			return false;
            }
         }
	}

	/* 获取vpmn集团信息 */
	function getVpmnGrp(){
	    var vIccid = $("#iccid").val();
	    var vUnitId = $("#unitId").val();
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    if(vIccid.trim() == "" && vUnitId.trim() == "" && vVpmnGrpNo.trim() == ""){
	        rdShowMessageDialog("证件号码、集团编号、智能网集团编码请至少输入一个！",0);
	        $("#iccid").focus();
	        return;
	    }
        var pageTitle = "集团信息查询";
        var fieldName = "证件号码|集团编号|智能网集团编码|集团名称|";
        /* yuanqs add 2011/6/28 14:25:24 修改sql */
        //var sqlStr="sqlStr =select b.id_iccid,a.Unit_id,a.BOSS_VPMN_CODE,a.unit_name from dgrpcustmsg a,dcustdoc b where a.cust_id = b.cust_id and b.region_code='" + '<%=regionCode%>' + "'";
        
				var sqlStr = "";
        var selType = "S";    //'S'单选；'M'多选
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
        if($("#opType").val() == "03"){//删除
            $("#feeIndex").find("option:not(:selected)").remove();
        }
    }

	/* 获取闭合群号 */
	function getCloseNo(){
        var getCloseNo_Packet = new AJAXPacket("ajax_getCloseNo.jsp","正在获得闭合群号，请稍候......");
    	getCloseNo_Packet.data.add("retType","getCloseNo");
        getCloseNo_Packet.data.add("region_code","<%=regionCode%>");
        getCloseNo_Packet.data.add("idType","0");
        getCloseNo_Packet.data.add("oldId","0");
        core.ajax.sendPacket(getCloseNo_Packet);
        getCloseNo_Packet=null;
	}

	/* 下一步 */
	function nextStep(){
		/*yuanqs add 2011/7/1 17:03:24*/
		var opCode = document.all.op_code.value;

	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    if(vVpmnGrpNo.trim() == ""){
	        rdShowMessageDialog("智能网集团编码为空，不符合条件！",0);
	        if ("d970" == opCode) {
				window.location='fd970.jsp?opCode=d970&opName=批量增加集团网外号码';
			} else {
				window.location='fd970.jsp?opCode=e009&opName=批量删除集团网外号码';
			}
	        return false;
	    }

	    $("#opType").find("option:not(:selected)").remove();
	    var vOpType = $("#opType").val();

	    $(".closeInfo").show();
	    $("#nextBtn").hide();
	    $("#submitBtn").show();

	    if(vOpType == "01"){//新增
	        $("#getCloseNoBtn").show();
	        $("#selectCloseNoBtn").hide();
	    }else if(vOpType == "02"){//修改
	        $("#getCloseNoBtn").hide();
	        $("#selectCloseNoBtn").show();
	    }else if(vOpType == "03"){//删除
	        $("#getCloseNoBtn").hide();
	        $("#selectCloseNoBtn").show();
	        $("#closeNo,#closeName,#maxUserNum").attr("readOnly",true);
	        $("#closeNo,#closeName,#maxUserNum").addClass("InputGrey");
	        $("#submitBtn").val("删除");
	    }
	}

	/* 提交 */
	function refMain(){
	    var vCfmMsg = "确认提交吗？";
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
