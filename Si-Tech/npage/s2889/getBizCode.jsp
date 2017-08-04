<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>

<%
	String opName = "定制业务代码";
	String workNo   = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String bizLabel = WtcUtil.repNull((String)request.getParameter("biz_label"));
	String accModel = WtcUtil.repNull((String)request.getParameter("accModel"));
	System.out.println("# from getBizCode.jsp -> bizLabel = "+bizLabel);
		System.out.println("# from getBizCode.jsp -> accModel = "+accModel);
	String op_name = "定制业务代码";
	
	String sqlStr = "";
	/* 接收输入参数 */ 
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<base target="_self">
<title><%=op_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<script language="JavaScript"> 

onload=function(){
	
	var vBizLabel = "<%=bizLabel%>";
	if(vBizLabel == "MAS"){
	  
	   if("<%=accModel%>"=="02"){
			 $("#yebs").find("option[value!='1']").remove();
			}else{
	    $("#yebs").find("option[value!='M']").remove();
	    }
	}else if(vBizLabel == "ADC"){
	   
	    if("<%=accModel%>"=="02"){
			 $("#yebs").find("option[value='1']").remove();
			}else{
	    $("#yebs").find("option[value='M']").remove();
	    }
	}else{
		$("#yebs").empty();
	}
	changeBizMode();
}

//
function createBizCode()
{	
	var myPacket = new AJAXPacket("getNextBizStr.jsp","正在获取业务代码，请稍候...");
	var firstSel = "";
	for(i = 0 ; i < document.form1.yebs.length ; i ++){
		if(document.form1.yebs.options[i].selected){
			firstSel = document.form1.yebs.options[i].value;	
		}
	}
	var secondSel = "";
	for(i = 0 ; i < document.form1.hybm.length ; i ++){
		if(document.form1.hybm.options[i].selected){
			secondSel = document.form1.hybm.options[i].value;	
		}
	}
	var thirdSel = "";
	for(i = 0 ; i < document.form1.txnl.length ; i ++){
		if(document.form1.txnl.options[i].selected){
			thirdSel = document.form1.txnl.options[i].value;	
		}
	}
	var fourthSel = "";
	for(i = 0 ; i < document.form1.yelb.length ; i ++){
		if(document.form1.yelb.options[i].selected){
			fourthSel = document.form1.yelb.options[i].value;	
		}
	}

	var yelx = $("#yelx").val();

	var selBizCode="";
	if("<%=accModel%>"=="02"){
		selBizCode = firstSel+"08"+secondSel+thirdSel+yelx;
	}else{
		selBizCode = firstSel+"HL"+secondSel+thirdSel+yelx;
	}
	document.all.vSelBizCode.value=selBizCode;
	//alert(selBizCode);
	myPacket.data.add("bizCodeAdd",selBizCode);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}


function doProcess(packet){
  //RPC 返回处理
   
		var maxNo = packet.data.findValueByName("nott");
		var newMaxNo = StrAdd(1,maxNo,1);
		var remainNo = document.all.vSelBizCode.value+newMaxNo;
		document.form1.retBizCode.value = remainNo;
		return;
}

function doSubmit(){
    if(document.form1.yebs.length == 0){
	    rdShowMessageDialog("该集团不能进行业务申请！");
			return;
	  }
    if(document.all.retBizCode.value.length == 0){
        rdShowMessageDialog("请点击【获取业务代码】再确认！");
        return;
    }
    
    if(document.all.retBizCode.value.length > 10){
        rdShowMessageDialog("业务代码长度错误！",0);
        return;
    }
	 
    /* add by qidp @ 2009-12-08 */
    var _bizTypeL = {
        "value": $("#bizTypeL").val(),
        "text" : $("#bizTypeL").find("option:selected").text()
    }
    var _bizTypeS = {
        "value": $("#yelb").val(),
        "text" : $("#yelb").find("option:selected").text()
    }
    /* end of add */
    
    
    
   var _bizYelx = $("#yelx").val();
   var _bizHybm = "";
 var _bizhybm = $("#hybm option").map(function(){return $(this).val();}).get().join("|")

   
	 window.opener.form1.bussId.value = document.all.retBizCode.value;
	 window.opener.form1.accessModel.disabled=true;
	 window.opener.changeBizCode();	
	 window.opener.getBizType(_bizTypeL,_bizTypeS,_bizYelx,_bizhybm);
	 window.close();

}

function StrAdd(AddType, SrcStr, Value)
{
	//AddType 0值加1， 1:模加1
	var BaseStr ="0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	var S = "";
	var CurPos = 0, PrePos = 0, SrcLen=0,BaseLen=0, Index=0;
	var isCarry = 0;

	SrcLen= SrcStr.length;
	BaseLen=BaseStr.length;
	isCarry = Value % BaseLen;

	for(  CurPos = SrcLen - 1; CurPos >= 0; CurPos --)
	{
		if (isCarry != 0)
		{
			Index = BaseStr.indexOf(SrcStr.charAt(CurPos)) + isCarry;
			if (Index < -1)
			{
				return "";
			}
			if (Index > BaseLen - 1)
			{
				isCarry = 1;
				S = BaseStr.charAt(Index - BaseLen) + S;
			}
			else
			{
				isCarry = 0;
				S = SrcStr.substring(0, CurPos) + BaseStr.charAt(Index) + S;
				break;
			}
			if (CurPos == 0 && AddType == 0) S = BaseStr.charAt(0) + S;
		}
		else
		{
			break;
		}
		
	}

	return S;
}

function changeBizMode(){
    var vBizMode = $("#yebs").val();
    
    var packet = new AJAXPacket("fgetBizTypeL.jsp","请稍后...");
    packet.data.add("bizMode" ,vBizMode);
    core.ajax.sendPacket(packet,doChangeBizMode,false);
    packet = null;
}

function doChangeBizMode(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeL").empty();
      	$(arr.join()).appendTo("#bizTypeL");
      	
      	changeBizTypeL();
	}
    else
    {
        rdShowMessageDialog("获取业务大类失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
		return false;
    }
}

function changeBizTypeL(){
    var vBizMode = $("#yebs").val();
    var vBizTypeL = $("#bizTypeL").val();
    
    var packet = new AJAXPacket("fgetBizTypeS.jsp","请稍后...");
    packet.data.add("bizMode" ,vBizMode);
    packet.data.add("bizTypeL" ,vBizTypeL);
    core.ajax.sendPacket(packet,doChangeBizTypeL,false);
    packet = null;
}

function doChangeBizTypeL(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#yelb").empty();
      	$(arr.join()).appendTo("#yelb");
	}
    else
    {
        rdShowMessageDialog("获取业务小类失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
		return false;
    }
}

</script>
</head>

<body>
<form name="form1"  method="post">
<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">查定制业务代码</div>
	</div>	
	 
  	<TABLE cellspacing="0">
    <TBODY>
		<tr>
			<input type=hidden name=vSelBizCode value="">
			<TD class="blue">类别标识</TD>
			<TD>	<select name="yebs" id="yebs" onChange="changeBizMode()">
				<%
							String sqlstr1 = "";
							String accModelTmp = accModel;
							if("02".equals(accModelTmp)){
							sqlstr1 = "select case BIZMODE  when 'M' then 1 when 'A' then 2 when 'Q' then 3 when 'T' then 9 end BIZMODE, case BIZMODE when 'M' then 1 when 'A' then 2 when 'Q' then 3 when 'T' then 9 end || '->' || BIZMODENAME from SBIZMODECODE";
							}else {
							sqlstr1 = "select BIZMODE ,BIZMODE || '->' || BIZMODENAME from SBIZMODECODE";
				}%>			
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
					<wtc:sql><%=sqlstr1%></wtc:sql>
					</wtc:qoption>
					</select>
		
			
				<font color="orange">*</font>
			</TD>
		</tr>
		
		<tr>	
			<TD class="blue">行业编码</TD>
			<TD>
				<select name="hybm"   id="hybm">
				<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select bizHYMode, bizHYMode||'->'||bizHYName from sBizHYCode where new_flag=1</wtc:sql>
				</wtc:qoption>
				</select>
				<font color="orange">*</font>	
			</TD>
		</tr>

		<tr>	
			<TD class="blue">通信能力</TD>
			<TD>
				<select name="txnl" >
				<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql>select ableCode, ableCode||'->'||ableName from sNetAbleCode</wtc:sql>
				</wtc:qoption>
				</select>
				<font color="orange">*</font>
			</TD>
		</tr>
	    <tr>	
			<TD class="blue">业务大类</TD>
			<TD>				
	  			<select name="bizTypeL" id="bizTypeL" onChange="changeBizTypeL()">
	  			
	  			<!--chendx 20100612 区分ADC与MAS类的业务大类和小类的具体内容-->					
					<%
							String sql = "";
							String bizLabelTmp = bizLabel;
							if("ADC".equals(bizLabelTmp)){
							sql = "select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='AD'";
							}else if("MAS".equals(bizLabelTmp)){
							sql = "select distinct main_type,main_type||'->'||main_name from sbiztypecode where sm_code='ML'";
					}%>
					
	  			<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql><%=sql%></wtc:sql>
					</wtc:qoption>
					</select>
					<font color="orange">*</font>							
			</TD>
		</tr>
		<tr>	
			<TD class="blue">业务小类</TD>
			<TD>
	  		<select name="yelb" id="yelb">
	  				
	  		<!--chendx 20100612 区分ADC与MAS类的业务大类和大类的具体内容-->					
				<%
							String sqlstr = "";
							if("ADC".equals(bizLabelTmp)){
							sqlstr = "select biztype,biztype||'->'||biztypename from sbiztypecode where sm_code='AD' and main_type='01'";
							}else if("MAS".equals(bizLabelTmp)){
							sqlstr = "select biztype,biztype||'->'||biztypename from sbiztypecode where sm_code='ML' and main_type='01'";
				}%>
					
	  		<wtc:qoption name="sPubSelect" outnum="2">
				<wtc:sql> <%=sqlstr%></wtc:sql>
				</wtc:qoption>
				</select>
				<font color="orange">*</font>							
			</TD>
		</tr>
		
		<tr>	
			<TD class="blue">业务类型</TD>
			<TD>
	  		<select name="yelx" id="yelx">
	   				<option value="51" >内部管理类</option>
	   				<option value="52" >外部服务类</option>
	   				<option value="53" >营销推广类</option>
	   				<option value="54" >公共类</option>
				</select>
				<font color="orange">*</font>							
			</TD>
		</tr>
	  				
		<tr>
			<TD class="blue">业务代码</TD>
			<TD>
   				<input type=text class="InputGrey" v_minlength=10 name=retBizCode maxlength=10 value="" readonly/>
				<font color="orange">*</font>
				<input type=button class="b_text" name=creatNo value="获取业务代码" onclick="createBizCode()">
			</TD>
		</tr>		
    </TBODY>
  	</TABLE>
	          	
    <TABLE  cellSpacing="0">
	  <TR>
		<TD id="footer" align="center">
 	    <input name="nextButton" type="button" class="b_foot" value="确  定" onClick="doSubmit()" >
 	    <input name="reset" type="button" class="b_foot" value="关  闭" onClick="window.close()" >
		</TD>
	  </TR>
    </TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>		
 </form>
</body>
</html>

