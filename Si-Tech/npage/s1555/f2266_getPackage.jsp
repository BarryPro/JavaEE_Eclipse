<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opName = "促销品统一付奖";
		response.setHeader("Pragma","No-Cache");
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0);
		String phoneNo = request.getParameter("phoneNo");
		/* 包代码 */
		String packageCode = request.getParameter("packageCode");
		String num = request.getParameter("num");
		String isCard = request.getParameter("isCard");
		String isPackage = request.getParameter("isPackage");
		String resname = request.getParameter("resname");
		String ressum = request.getParameter("ressum");
		System.out.println("=====f2266_getPackage====" + phoneNo + " | " + packageCode + " |resname:" + resname);
		System.out.println("=====f2266_getPackage====isCard:" + isCard + " |isPackage:" + isPackage);
		String regCode = (String)session.getAttribute("regCode");
		String showName = "手机充值卡卡号";
    String  inParams [] = new String[2];
    inParams[0] = "SELECT CASE "
               +" WHEN a.res_type LIKE 'w%' THEN "
               +" 'WLAN充值卡卡号' when a.res_type like 'd%' then '手机充值卡卡号' when a.res_type like 'l%' then '流量卡充值卡卡号'  "
               +" ELSE "
               +" '卡折卡号' "
               +" END "
               +" FROM dbgiftrun.RS_PROGIFT_PT_INFO a "
               +" WHERE a.res_Code =:rescode  ";
    //inParams[1] = "rescode=10001450";
    inParams[1] = "rescode="+packageCode;
%>
  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
    <wtc:param value="<%=inParams[0]%>"/>
    <wtc:param value="<%=inParams[1]%>"/> 
  </wtc:service>  
  <wtc:array id="ret"  scope="end"/>
<%
  if("000000".equals(retCode1)){
    if(ret.length>0){
      showName = ret[0][0];
    }
  }
%>

<html>
	<head>
		<title>促销品统一付奖</title>
	</head>
<script language="javascript">
	var isCardVal = "<%=isCard%>";
	/******为备注赋值********/
	function setOpNote()
	{
		var opNoteObj = $("#opNote")
		if(opNoteObj.val() == "")
		{
			opNoteObj.val("用户"+$("#phoneNo").val()+"领奖");
		}
		return true;
	}
	function getAwardInfo(){
		//调用公共js得到奖品
    var pageTitle = "促销品代码查询";
    //弹出窗口显示的列、列名
    var fieldName = "选择|促销品代码|促销品名称|数量|";
					
		var getAwardSql = "90000108";  	
  	
		//alert(getAwardSql);
		var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|1|2|";//返回字段
    var retToField = "awardNo|awardInfo|";//返回赋值的域
    if(PubSimpSel(pageTitle,fieldName,getAwardSql,selType,retQuence,retToField));
	}
	function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
	{
			var params = "<%=packageCode%>|"; 
	    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
	    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	    path = path + "&selType=" + selType+ "&params=" + params;
	    retInfo = window.showModalDialog(path);
	    if(retInfo ==undefined)
	    {
	    	return false;
	    }
	    var chPos_field = retToField.indexOf("|");
	    var chPos_retStr;
	    var valueStr;
	    var obj;
	    var iRec = 0;
	    while(chPos_field > -1)
	    {
	        iRec = iRec+1;
	        obj = retToField.substring(0,chPos_field);
	        chPos_retInfo = retInfo.indexOf("|");
	        valueStr = retInfo.substring(0,chPos_retInfo);
			if (iRec ==2)
			{			
				document.all(obj).value = valueStr;
	       	}
	       	else
	       	{
	            document.all(obj).value = valueStr;
	       	}
	        retToField = retToField.substring(chPos_field + 1);
	        retInfo = retInfo.substring(chPos_retInfo + 1);
	        chPos_field = retToField.indexOf("|");
	    }
	    
		return true;
	}
	function reValue(){
		/*确定，返回*/
		setOpNote();
		document.all.confirm.disabled = true;
		var awardNoObj = $("#awardNo");
		if(awardNoObj.val()=="" )
		{
			rdShowConfirmDialog("请选择促销品!");
			awardNoObj[0].focus();
			return false;
		}
		if("Y" == isCardVal){
			if($("#card_no").val() == ""){
				rdShowConfirmDialog("请查询<%=showName%>!");
				return false;
			}
		}
		var cardnoadd="";  
		if(isCardVal =="Y") {
		cardnoadd = $("#card_no").val();
		}else {
			cardnoadd="N";
		}
		var retvalue = "<%=num%>" + "%" 
						+ "<%=packageCode%>" + "|" + awardNoObj.val() + "%"
						+ $("#awardInfo").val() + "%"
						+ $("#opNote").val() 		+ "%"
						+  cardnoadd+"%"
						+ $("#cardType").val() + "%"
						+ $("#cardNum").val() + "%";
		window.returnValue = retvalue;
    window.close();
	}
	function checkCardState(){
	   //alert(isCardVal);
		if("Y" == isCardVal){
			/* 存在有价卡 */
			$("#checkCardNo").show();
			var myPacket = new AJAXPacket("fGetCardInfo.jsp", "查询奖品类别明细,请稍等...");
			myPacket.data.add("res_code","<%=packageCode%>");
			myPacket.data.add("oldNewFlag","1");
			myPacket.data.add("isPackage","<%=isPackage%>");
	    core.ajax.sendPacket(myPacket);
	    myPacket = null;
		}
	}
	function doProcess(packet){
		var result = packet.data.findValueByName("result");
		//alert(result);
		if(result == "true")
		{
			document.forms[0].cardType.value = packet.data.findValueByName("card_type");
			document.forms[0].cardNum.value = packet.data.findValueByName("card_num");
			document.all.checkCardNo.style.display = "block";
		}
		else
		{
		    document.frm.card_no.value="N";
		}
	}
	function checkCard(){
		document.all.confirm.disabled = false;
		var prop="dialogHeight:300px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		card_num = parseInt(document.forms[0].cardNum.value);
		if(card_num == -1){
			card_num = document.forms[0].ressum.value;
		}
		card_type = document.forms[0].cardType.value;
		var libaodaima = document.forms[0].awardNo.value;
		var ret = window.showModalDialog("./f2266_query_card.jsp?card_num="+card_num+"&card_type="+card_type+"&libaodaima="+libaodaima,"",prop);
		if(ret){
			document.all.card_no.value = ret;
		}
		else
		{
			//do Nothing
		}
	}
	$(document).ready(function(){
		checkCardState();
		if("1" != "<%=isPackage%>" && "Y" == "<%=isCard%>"){
			/* 不是礼品包，是有价卡礼品 */
			$("#awardNo").val("<%=packageCode%>");
			$("#awardInfo").val("<%=resname%>");
			$("#awardInfoQuery").attr("disabled","true");
		}
	});
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
		<tr id = "selectaward" style="display:" >
			<td class="blue">奖品名称</td>
			<td colspan="3">
				<input type="text" name="awardNo" id="awardNo" size="8" maxlength="8" v_must=1 readonly>
				<input type="text" name="awardInfo" id="awardInfo" size="30" v_must=1 v_name=奖品名称  onchange="changeResCode()" readonly>&nbsp;&nbsp;
				<font class="orange">*</font>
			  <input name="awardInfoQuery" id="awardInfoQuery" 
			   type=button class="b_text"  style="cursor:hand" 
			    onClick="getAwardInfo()" value=查询>
			</td>
    </tr>
    <tr id = "checkCardNo" style="display:none;" >
			<td class="blue"><%=showName%></td>
			<td nowrap>
				<input id="card_no"  type="text" name="card_no" size="40" value=""  readonly >
				<font color="orange">*</font>
				<input  type="button" name="card_no_qry" class="b_text" value="查询" onClick="checkCard()">
				<input type="hidden" name="cardType" id="cardType">
				<input type="hidden" name="cardNum" id="cardNum">
			</td>
    </tr>
    <tr id="OpNoteTr" style="display:">
    	<td class="blue">备注</td>
      <td colspan="3">
      	<input name="opNote" type="text" id="opNote" class="button" 
      	 size="60" maxlength="60" onFocus="setOpNote();" readonly>
    	</td>
    </tr>
    </table>
    <table cellspacing="0">
    <tr id="checkConfirm" style="display:">
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >
					&nbsp;
				<input name="reset" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>
	<input type="hidden" id="phoneNo" name="phoneNo" value="<%=phoneNo%>">
	<input type="hidden" name="ressum" value="<%=ressum%>">
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
