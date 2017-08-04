<%
/*****************************
 * 模块名称：智能网闭合群管理
 * 程序版本：version 1.0
 * 开 发 商: SI-TECH
 * 作    者: shengzd
 * 创建时间: 2010-04-20
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
	String powerRight = WtcUtil.repNull((String)session.getAttribute("powerRight"));
	System.out.println("# ---------------powerRight = ["+powerRight+"] ---------------");
	System.out.println("# ---------------regionCode = ["+regionCode+"] ---------------");

	String opCode = "4890";
	String opName = "智能网闭合群管理";
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>智能网闭合群管理</title>
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
    <td class="blue" width="15%">操作类型</td>
    <td colspan="3">
    <select name="opType" id="opType">
    <option value="01">01 -> 创建闭合群</option>
    <option value="02">02 -> 修改闭合群</option>
    <option value="03">03 -> 删除闭合群</option>
    </select>
    <font class='orange'>*</font>
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
</table>
</div>

<div id="Operation_Table" class="closeInfo" style="display:none;">
<div class="title">
	<div id="title_zi">闭合群信息</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" nowrap>闭合群号</td>
        <td>
        	  <input type="text" id="closeNo" name="closeNo" value="" readOnly class="InputGrey" />
            <font class="orange">*</font>
            <input type="button" id="getCloseNoBtn" name="getCloseNoBtn" value="获取" onclick="getCloseNo()" class="b_text" />
        	  <input type="button" id="selectCloseNoBtn" name="selectCloseNoBtn" value="选择" onclick="selectCloseNo()" class="b_text" />
        </td>
        <td class="blue" nowrap>闭合群名称</td>
        <td>
            <input type="text" id="closeName" name="closeName" value="" />
            <font class="orange">*</font>
        </td>
    </tr>
    <tr>
        <td class="blue" nowrap>费率索引</td>
        <td>
            <select name="feeIndex" id="feeIndex">
				<%	
					//wangleic add begin 2011-3-2 02:07PM
					String[][] result33 = null;
					String dateStr1SqlStr33 = new java.text.SimpleDateFormat("yyyy-MM-dd-HH-mm").format(new java.util.Date()); //diling update@2011/10/17 增加分
					String strTime[] = new String[5]; //diling update 
					strTime = dateStr1SqlStr33.split("-");
					
					StringBuffer sqlBufSqlStr33 = new StringBuffer();
					sqlBufSqlStr33.append("  select to_char(a.offer_id),a.offer_id||'-->'||a.offer_name ");
					sqlBufSqlStr33.append("  from  PRODUCT_OFFER A,  REGION C, SREGIONCODE D            ");
					sqlBufSqlStr33.append("  where a.offer_id!=0                                        ");
					sqlBufSqlStr33.append("  and c.offer_id=a.offer_id                                  ");
					sqlBufSqlStr33.append("  and c.group_id=d.group_id                                  ");
					sqlBufSqlStr33.append("  and d.region_code='"+regionCode+"'                         ");
					sqlBufSqlStr33.append("  and a.exp_date>=sysdate                                    ");
					sqlBufSqlStr33.append("  and a.offer_attr_type='VpB0'                               ");
					sqlBufSqlStr33.append("  and to_number(c.right_limit)<="+powerRight+"               ");
					sqlBufSqlStr33.append("  and (                                                      ");
					sqlBufSqlStr33.append(" 	 exists (select 1 from SCLOSEFEEINDEXCONFIG B where b.region_code = d.region_code                      ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[0]+"')>=to_number(b.start_year) or (b.start_year is null) )    ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[0]+"')<=to_number(b.end_year) or (b.end_year is null) )        ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[1]+"')>=to_number(b.start_month) or (b.start_month is null) )  ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[1]+"')<=to_number(b.end_month) or (b.end_month is null) )      ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[2]+"')>=to_number(b.start_day) or (b.start_day is null) )      ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[2]+"')<=to_number(b.end_day) or (b.end_day is null) )          ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[3]+"')>=to_number(b.start_hours) or (b.start_hours is null) )  ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[3]+"')<=to_number(b.end_hours) or (b.end_hours is null) )      ");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[4]+"')>=to_number(b.start_minute) or (b.start_minute is null) )");
					sqlBufSqlStr33.append(" 				 and ( to_number('"+strTime[4]+"')<to_number(b.end_minute) or (b.end_minute is null) )     ");
					sqlBufSqlStr33.append(" 				 and a.offer_id = b.fee_index   ");
					sqlBufSqlStr33.append(" 		 	)   ");
					sqlBufSqlStr33.append("  	or not exists (   ");
					sqlBufSqlStr33.append("  					select 1 from SCLOSEFEEINDEXCONFIG f where a.offer_id = f.fee_index and f.region_code = d.region_code  ");
					sqlBufSqlStr33.append(" 			)         ");
					sqlBufSqlStr33.append("  )                    ");
					sqlBufSqlStr33.append("  order by to_number(a.offer_id) ");
					String sqlStr33 = sqlBufSqlStr33.toString();
					System.out.println("sqlStr33= "+sqlStr33);
					//wangleic add end 2011-3-2 02:23PM
				%>    		
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" 
			retmsg="msg0" retcode="code0" outnum="2">
			<wtc:param value="<%=sqlStr33%>"/>
		</wtc:service>
		<wtc:array id="result0" scope="end" />
			<%
			System.out.println("result0.length= "+result0.length);
			for(int i = 0; i < result0.length; i++){
			%>
			<option value="<%=result0[i][0]%>"><%=result0[i][1]%></option>
			<%
			}
			%>
            </select>
            <font class="orange">*</font>
        </td>
        <td class="blue" nowrap>最大用户数</td>
        <td>
            <input type="text" id="maxUserNum" name="maxUserNum" value="" style="ime-mode:disabled" onKeyPress="return isKeyNumberdot(0)" />
            <font class="orange">*</font>
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
            <input class="b_foot" name="resetBtn" id="resetBtn" type="button" value="重置" onclick="window.location='f4890.jsp'" />
            <input class="b_foot" name="closeBtn" id="closeBtn" type="button" value="关闭" onClick="removeCurrentTab()" />
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp"%>
</form>
<script language="JavaScript">
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
        var sqlStr="";
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
        var path = "f4890_qry_cust.jsp";
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
        $("#nextBtn").attr("disabled",false);
    }
	 var params ="";
	/* 选择闭合群号 */
	function selectCloseNo(){
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    var vUnitId = $("#unitId").val();
	    params = vUnitId+"|"+vVpmnGrpNo+"|";
	    //alert(params);
        var pageTitle = "闭合群信息查询";
        var fieldName = "闭合群号|闭合群名称|费率索引|最大用户数|";
        var sqlStr="90000169";

        var selType = "S";    //'S'单选；'M'多选
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
	    var vVpmnGrpNo = $("#vpmnGrpNo").val();
	    if(vVpmnGrpNo.trim() == ""){
	        rdShowMessageDialog("智能网集团编码为空，不满足闭合群条件！",0);
	        window.location = "f4890.jsp";
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
	    vOpType = $("#opType").val();
	    vCloseNo = $("#closeNo").val();
	    vCloseName = $("#closeName").val();
	    vFeeIndex = $("#feeIndex").val();
	    vMaxUserNum = $("#maxUserNum").val();
	    
	    if(vCloseNo == ""){
	        rdShowMessageDialog("闭合群号不能为空！",0);
	        return false;
	    }
	    
	    if(vOpType == "01" || vOpType == "02"){
	        if(vCloseName == ""){
	            rdShowMessageDialog("闭合群名称不能为空！",0);
	            $("#closeName").focus();
	            return false;
	        }
	        if(vFeeIndex == ""||vFeeIndex == null){	//wangleic 2011-1-10 11:01AM 
	            rdShowMessageDialog("费率索引不能为空,请先配置费率索引！",0);
	            $("#feeIndex").focus();
	            return false;
	        }
	        if(vMaxUserNum == ""){
	            rdShowMessageDialog("最大用户数不能为空！",0);
	            $("#maxUserNum").focus();
	            return false;
	        }
	    }
	    
	    var vCfmMsg = "";
	    if(vOpType == "02"){
	        vCfmMsg = "确认修改闭合群信息吗？";
	    }else if(vOpType == "03"){
	        vCfmMsg = "确认删除闭合群信息吗？";
	    }else{
	        vCfmMsg = "确认提交闭合群信息吗？";
	    }
	    
	    if(!check(form1)){
            return false;
        }else{
            if(rdShowConfirmDialog(vCfmMsg)==1){
                form1.action="f4890Cfm.jsp";
            	form1.method="post";
            	form1.submit();
            }
        }
	}
</script>
</body>
</html>
