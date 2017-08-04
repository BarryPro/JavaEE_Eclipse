<%
/*****************************
 * 模块名称：智能网闭合群综合查询
 * 程序版本：version 1.0
 * 开 发 商: SI-TECH
 * 作    者: shengzd
 * 创建时间: 2010-05-12
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
	String passwd = WtcUtil.repNull((String)session.getAttribute("password"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = "4889";
	String opName = "智能网闭合群综合查询";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>智能网闭合群综合查询</title>
</head>
<body>
<form name="form1" method="post">

<%@ include file="/npage/include/header.jsp"%>
<div class="title">
    <div id="title_zi">集团信息</div>
</div>
<table cellSpacing=0>
    <tr>
    <td class="blue" width="15%">查询类型</td>
    <td colspan="3">
        <input type="radio" name="opType" value="01" onclick="changeType('01')" checked />闭合群信息
        <input type="radio" name="opType" value="02" onclick="changeType('02')" />成员信息
    </td>
</tr>
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
<tr id="closeInfo" style="display:none;">
    <td class="blue" nowrap>闭合群号</td>
    <td>
        <input type="text" id="closeNo" name="closeNo" value="" readOnly class="InputGrey" />
        <input type="button" id="selectCloseNoBtn" name="selectCloseNoBtn" value="选择" onclick="selectCloseNo()" class="b_text" disabled />
    </td>
    <td class="blue" nowrap>闭合群名称</td>
    <td>
        <input type="text" id="closeName" name="closeName" value="" readOnly class="InputGrey" />
    </td>
</tr>
</table>

<table cellspacing="0">
    <tr id="footer">
        <td colspan="4">
            <input class="b_foot" name="queryBtn" id="queryBtn" type="button" value="查询" onClick="doQuery()" />
            <input class="b_foot" name="resetBtn" id="resetBtn" type="button" value="重置" onclick="window.location='f4889.jsp'" />
            <input class="b_foot" name="closeBtn" id="closeBtn" type="button" value="关闭" onClick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>

<div id="CloseGrpArea">
<div id="Operation_Table" class="vpmnCloseInfo" style="display:none;">
<div class="title">
	<div id="title_zi">智能网侧闭合群信息</div>
</div>
<table cellspacing="0" id="vpmnCloseInfo">
</table>
</div>

<div id="Operation_Table" class="bossCloseInfo" style="display:none;">
<div class="title">
	<div id="title_zi">BOSS侧闭合群信息</div>
</div>
<table cellspacing="0" id="bossCloseInfo">
</table>
</div>
</div>

<div id="CloseMebArea">
<div id="Operation_Table" class="vpmnMemberInfo" style="display:none;">
<div class="title">
	<div id="title_zi">智能网平台侧闭合群成员信息</div>
</div>
<table cellspacing="0" id="vpmnMemberInfo">
</table>
</div>
</div>
</form>
<script language="JavaScript">
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
        var sqlStr=" ";
        if(vIccid.trim() != ""){
        }
        if(vUnitId.trim() != ""){
        }
        if(vVpmnGrpNo.trim() != ""){
        }

        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "4|0|1|2|3|";
        var retToField = "iccid|unitId|vpmnGrpNo|unitName|";
        PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    }

    function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
        var path = "f4889_qry_custmsg.jsp";
        path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
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
    /* 选择闭合群号 */
	function selectCloseNo(){
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    var vUnitId = $("#unitId").val();
	    var vIccid = $("#iccid").val();
	    params = vUnitId+"|"+vVpmnGrpNo+"|";
        var pageTitle = "闭合群信息查询";
        var fieldName = "闭合群号|闭合群名称|";
        var sqlStr="90000168 ";

        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "2|0|1|";
        var retToField = "closeNo|closeName|";
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
    }
    
    /* 切换查询类型 */
    function changeType(opType){
        if(opType == "01"){
            $("#closeInfo").hide();
            $("#CloseGrpArea").show();
            $("#CloseMebArea").hide();
        }else if(opType == "02"){
            $("#closeInfo").show();
            $("#CloseMebArea").show();
            $("#CloseGrpArea").hide();
        }
    }
    
    /* 查询 */
    function doQuery(){
        var vOpType = getRadiosVal(document.all.opType);
        var vVpmnGrpNo = $("#vpmnGrpNo").val();
        var vCloseNo = $("#closeNo").val();
        
        if(vOpType == "01"){//查询闭合群信息
            if(vVpmnGrpNo == ""){
                rdShowMessageDialog("智能网集团编码为空，不满足查询条件！",0);
                return false;
            }
            queryVpmnClose();
            queryBossClose();
            $(".vpmnCloseInfo").show();
            $(".bossCloseInfo").show();
            $(".vpmnMemberInfo").hide();
        }else if(vOpType == "02"){//查询成员信息
            if(vVpmnGrpNo == ""){
                rdShowMessageDialog("智能网集团编码为空，不满足查询条件！",0);
                return false;
            }
            if(vCloseNo == ""){
                rdShowMessageDialog("请选择要查询成员的闭合群号！",0);
                $("#selectCloseNoBtn").focus();
                return false;
            }
        
            queryVpmnMember();
            $(".vpmnCloseInfo").hide();
            $(".bossCloseInfo").hide();
            $(".vpmnMemberInfo").show();
        }
    }
    
    /* 查询BOSS侧闭合群信息 */
    function queryBossClose(){
        var vVpmnGrpNo = $("#vpmnGrpNo").val();
        var vUnitId = $("#unitId").val();
        
        var packet = new AJAXPacket("queryBossClose.jsp","正在查询BOSS侧闭合群信息，请稍后...");
        packet.data.add("retType","queryBossClose");
        packet.data.add("vpmn_grp_no",vVpmnGrpNo);
        packet.data.add("unit_id",vUnitId);
        core.ajax.sendPacket(packet);
        packet =null;
    }
    
    /* 查询智能网侧闭合群信息 */
    function queryVpmnClose(){
        var vOpType = getRadiosVal(document.all.opType);
        var vUnitId = $("#unitId").val();
        var vVpmnGrpNo = $("#vpmnGrpNo").val();
        
        var packet = new AJAXPacket("queryVpmnClose.jsp","正在查询智能网侧闭合群信息，请稍后...");
        packet.data.add("retType","queryVpmnClose");
        packet.data.add("op_type",vOpType);
        packet.data.add("unit_id",vUnitId);
        packet.data.add("vpmn_grp_no",vVpmnGrpNo);
        core.ajax.sendPacket(packet);
        packet =null;
    }
    
    /* 查询智能网侧闭合群成员信息 */
    function queryVpmnMember(){
        var vOpType = getRadiosVal(document.all.opType);
        var vUnitId = $("#unitId").val();
        var vVpmnGrpNo = $("#vpmnGrpNo").val();
        var vCloseNo = $("#closeNo").val();
        
        var packet = new AJAXPacket("queryVpmnMember.jsp","正在查询智能网侧闭合群成员信息，请稍后...");
        packet.data.add("retType","queryVpmnMember");
        packet.data.add("op_type",vOpType);
        packet.data.add("vpmn_grp_no",vVpmnGrpNo);
        packet.data.add("unit_id",vUnitId);
        packet.data.add("close_no",vCloseNo);
        core.ajax.sendPacket(packet);
        packet =null;
    }
    
    function doProcess(packet){
		var retType = packet.data.findValueByName("retType");
        var retCode = packet.data.findValueByName("retCode"); 
        var retMessage = packet.data.findValueByName("retMessage"); 
        self.status="";
		
		if(retType == "queryBossClose"){
		    if(retCode != "000000"){
		        rdShowMessageDialog("查询BOSS侧闭合群信息失败！错误代码："+retCode+",错误信息："+retMessage,0);
		        return false;
		    }
            var bossCloseArr = packet.data.findValueByName("bossCloseArr");
            
            var temLength = bossCloseArr.length;
            var arr = new Array(temLength+1);
            arr[0] = "<tr><th>闭合群号</th><th>闭合群名称</th><th>费率索引</th><th>最大用户数</th><th>当前用户数</th></tr>";
    		for(var i = 0 ; i < temLength ; i ++){
    			arr[i+1] = "<tr><td>"+bossCloseArr[i][0]+"</td><td>"+bossCloseArr[i][1]+"</td><td>"+bossCloseArr[i][2]+"</td><td>"+bossCloseArr[i][3]+"</td><td>"+bossCloseArr[i][4]+"</td></tr>";
    		}
    		$("#bossCloseInfo").empty();
          	$(arr.join("")).appendTo("#bossCloseInfo");
        }else if(retType == "queryVpmnClose"){
            if(retCode != "000000"){
		        rdShowMessageDialog("【错误代码】"+retCode+"<br>【错误信息】"+retMessage+"！",0);
		        return false;
		    }
            var vpmnCloseArr = packet.data.findValueByName("vpmnCloseArr");
            
            var temLength = vpmnCloseArr.length;
            var arr = new Array(temLength+1);
            arr[0] = "<tr><td colspan=5><font color=red>&nbsp;&nbsp;&nbsp;&nbsp;注意：该部分展示的是“智能网集团编码”对应的闭合群信息，而不是“集团编码”对应的闭合群信息！</font></td></tr><tr><th>闭合群号</th><th>闭合群名称</th><th>费率索引</th><th>最大用户数</th><th>当前用户数</th></tr>";
    		for(var i = 0 ; i < temLength ; i ++){
    			arr[i+1] = "<tr><td>"+vpmnCloseArr[i][0]+"</td><td>"+vpmnCloseArr[i][1]+"</td><td>"+vpmnCloseArr[i][2]+"</td><td>"+vpmnCloseArr[i][3]+"</td><td>"+vpmnCloseArr[i][4]+"</td></tr>";
    		}
    		$("#vpmnCloseInfo").empty();
          	$(arr.join("")).appendTo("#vpmnCloseInfo");
        }else if(retType == "queryVpmnMember"){
            if(retCode != "000000"){
		        rdShowMessageDialog("【错误代码】"+retCode+"<br>【错误信息】"+retMessage+"！",0);
		        return false;
		    }
            var vpmnMemberArr = packet.data.findValueByName("vpmnMemberArr");
            
            var temLength = vpmnMemberArr.length;
            var arr = new Array(temLength+1);
            arr[0] = "<tr><th>短号码</th><th>真实号码</th><th>用户姓名</th><th>证件号码</th><th>描述信息</th></tr>";
    		for(var i = 0 ; i < temLength ; i ++){
    			arr[i+1] = "<tr><td>"+vpmnMemberArr[i][0]+"</td><td>"+vpmnMemberArr[i][1]+"</td><td>"+vpmnMemberArr[i][2]+"</td><td>"+vpmnMemberArr[i][3]+"</td><td>"+vpmnMemberArr[i][4]+"</td></tr>";
    		}
    		$("#vpmnMemberInfo").empty();
          	$(arr.join("")).appendTo("#vpmnMemberInfo");
        }
	}
</script>
</body>
</html>


