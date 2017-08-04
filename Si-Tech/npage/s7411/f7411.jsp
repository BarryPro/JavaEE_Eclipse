<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-------------------------------------------->
<!---日期   2009-03-10                    ---->
<!---作者   zhangjx                        ---->
<!---功能   动力100业务包配置管理                  ---->
<!---wuxy   2009-05 		  														---->
<!-------------------------------------------->
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp"%>

<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

	
	
	String opCode="7420";
	String opName="动力100业务包配置管理";
	
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String regionCode = (String)session.getAttribute("regCode");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String workNo = baseInfoSession[0][2];
	String orgCode = baseInfoSession[0][16];
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	String iFlag = WtcUtil.repNull((String)request.getParameter("flag"))==null?"":WtcUtil.repNull((String)request.getParameter("flag"));
    String iOprType = "";
    if("select".equals(iFlag)){
        iOprType = WtcUtil.repNull((String)request.getParameter("oprType"));
    }
%>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
	<Script Language="JavaScript" src="../comm/PublicDate.js"></script>
	<title><%=opName%></title>
	<META content=no-cache http-equiv=Pragma>
  <META content=no-cache http-equiv=Cache-Control>
<script language="javascript" type="text/javascript">

var startIndex = 0;
var endIndex = 8;
var dynTbIndex=1;	//用于动态表数据的索引位置,开始值为1.考虑表头
var oprType_Add = "a";
onload=function(){
    var vFlag = "<%=iFlag%>";
    if(vFlag == "select"){
        $("#opr_type").val("<%=iOprType%>");
    }
    
    var opr = $("#opr_type").val();
	document.frm.offer_id.value = "";
    document.frm.offer_name.value = "";
    document.frm.eff_date.value = "";
    
	if(opr == "D" || opr == "Q"){
		document.getElementById("booking_vc").style.display="none";
	}else{	
		document.getElementById("booking_vc").style.display="block";
	}
	
	if(opr == "A"){
	    $("#motive_type").prepend("<option value='' id='motiveTypeOp'>---- 请选择 ----</option>");
	    document.frm.motive_type[0].selected=true;
	}else{
	    if(document.getElementById("motiveTypeOp")){
	        $("#motiveTypeOp").remove();
	    }
	    $("#btnQry").hide();
	}
	
	if(opr == "U"){
	    motiveTypeChg();
	}
}
function oprChange(obj){
    window.location.href="f7411.jsp?flag=select&oprType="+obj.value;
    return;
}

function oneTok(str,tok,loc)
{
   	var temStr=str;
	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       	temLen=temStr.length;
       	temLoc=temStr.indexOf(tok);
       	temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  	return temStr;
	else
      	return temStr.substring(0,temStr.indexOf(tok));
}

//判断是否选择了重复记录
function verifyUnique(mode_code)
{
	var tmp_mode_code="";
	var op_type = oprType_Add;
	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
	{
		tmp_mode_code = document.all.R2[a].value;
		if( op_type == oprType_Add)
		{		      
		  	if(mode_code == tmp_mode_code)
		  	{
		  		return false;
		  	}
		}
	}
    return true;
}

//删除不需要的记录
function dynDelRow()
{
	for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
	{
    if(document.all.R0[a].checked == true)
    {
      	document.all.dyntb.deleteRow(a+1);
      	break;
    }
	}
	document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
}


//针对查询结果显示在界面上
function DoGetQry(cfmpacket){
	var retCode = unescape(cfmpacket.data.findValueByName("retCode"));
	var retMsg = unescape(cfmpacket.data.findValueByName("retMsg"));
	if(retCode=="000000"){
		frm.offer_name.value = cfmpacket.data.findValueByName("offer_name");
		frm.eff_date.value = cfmpacket.data.findValueByName("eff_date");
		frm.exp_date.value = cfmpacket.data.findValueByName("exp_date");
		frm.offer_id.value = cfmpacket.data.findValueByName("offer_id");
		
		$("#exp_date").attr("readonly",false);
		
		var motivePriceCodeStr = cfmpacket.data.findValueByName("motivePriceCodeStr");
		var motivePriceNameStr = cfmpacket.data.findValueByName("motivePriceNameStr");
		var motivePriceCheckStr = cfmpacket.data.findValueByName("motivePriceCheckStr");

		var motivePriceCodeArr = motivePriceCodeStr.split("~");
		var motivePriceNameArr = motivePriceNameStr.split("~");
		var motivePriceCheckArr = motivePriceCheckStr.split("~");
		
		var motivePriceLen = motivePriceCodeArr.length-1;
		$("#motive_price_num").val(motivePriceLen);
		var arr = new Array(motivePriceLen);
		
		for(var i=0;i<motivePriceLen;i++){
		    var chkLabel = "";
		    if(motivePriceCheckArr[i] == "1"){
		        chkLabel = " checked ";
		    }else if(motivePriceCheckArr[i] == "0"){
		        chkLabel = "";
		    }
    	    arr[i] = "<input type='checkbox' name='motive_price' value='"+motivePriceCodeArr[i]+"' "+chkLabel+" >"+motivePriceNameArr[i]+"<input type='hidden' name='motive_srv' value='"+motivePriceCodeArr[i]+"' />";
		}
		$("#motive_price_span").empty();
      	$(arr.join("")).appendTo("#motive_price_span");
      	if(motivePriceLen > 0){
          	$("#motive_price_tr").show();
        }
            
		var result_product = cfmpacket.data.findValueByName("result_product");
		frm.result_length.value = result_product.length;
		for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
    	{
            document.all.dyntb.deleteRow(a+1);
    	}
    	document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
		for(var n = 0;n < result_product.length;n++){	
			smode_code = result_product[n][0];	
			product_code = result_product[n][1];
			product_name = result_product[n][2];
			product_type = result_product[n][3];
			product_note = result_product[n][4];			
			product_discount = result_product[n][5];	
			if(smode_code!="")
			{
			    queryAddAllRow1(smode_code,product_code,product_name,product_type,product_note,product_discount);
		    }
		}
	}else{
		rdShowMessageDialog("错误信息："+retMsg+" 错误代码："+retCode,0);
		$("#offer_id").val("");
		window.location.href="f7411.jsp?flag=select&oprType="+$("#opr_type").val();
		return false;
	}
} 	

function queryAddAllRow1(smode_code,product_code,product_name,product_type,product_note,product_discount){
	var opr_type = frm.opr_type.value;
	dyntb.style.display="";

//	alert("["+smode_code+"]["+product_code+"]["+product_name+"]["+product_type+"]["+product_note+"]");
	var tr1=dyntb.insertRow();	//注意：插入的必须与下面的在一起,否则造成空行
	tr1.id="tr"+dynTbIndex;
	if(opr_type=="U"){
		tr1.insertCell().innerHTML = '<input id=R0 type=checkBox onClick="dynDelRow()" ></input>';
	}
	if(opr_type=="A"){
		tr1.insertCell().innerHTML = '<input id=R0 type=checkBox disabled onClick="dynDelRow()" ></input>';
	}
	
	if(opr_type=="Q" || opr_type=="D"){
		tr1.insertCell().innerHTML = '<input id=R0 type=checkBox disabled onClick="dynDelRow()" checked ></input>';
	}
    tr1.insertCell().innerHTML = '<input id=R1 type=hidden value="'+ smode_code.substring(0,2)+'" readOnly>'+smode_code+'</input>';       
    tr1.insertCell().innerHTML = '<input id=R2 type=hidden value="' + product_code + '" readOnly>'+product_code+'</input>';         
    tr1.insertCell().innerHTML = '<input id=R3 type=hidden value="'+ product_name+'"  readOnly>'+product_name+'&nbsp;</input>';   
	if(product_type.trim()=="0")
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>主产品&nbsp;</input>'; 
    } 
    else if(product_type.trim()=="1") 
    {
    	tr1.insertCell().innerHTML = '<input id=R4 type=hidden value="'+ product_type+'"  readOnly>附属产品&nbsp;</input>'; 
    }    
    
    if(product_discount.trim()=="Y"||product_discount.trim()=="Y|")
    {
     tr1.insertCell().innerHTML = '<input type=hidden name=R6 id=R6id'+dynTbIndex+' value="'+product_discount+'" /><input name=R6'+dynTbIndex+' type=radio value=Y checked onClick=\'doDiscountClick('+dynTbIndex+',"Y")\'/>是&nbsp;<input name=R6'+dynTbIndex+' type=radio value=N  onClick=\'doDiscountClick('+dynTbIndex+',"N")\'/>否'; 
    } 
    else if(product_discount.trim()=="N"||product_discount.trim()=="N|")
    {
     tr1.insertCell().innerHTML = '<input type=hidden name=R6 id=R6id'+dynTbIndex+' value="'+product_discount+'" /><input name=R6'+dynTbIndex+' type=radio value=Y  onClick=\'doDiscountClick('+dynTbIndex+',"Y")\'/>是&nbsp;<input name=R6'+dynTbIndex+' type=radio value=N checked  onClick=\'doDiscountClick('+dynTbIndex+',"N")\'/>否'; 
    }
    
	tr1.insertCell().innerHTML = '<input id=R5 type=hidden value="'+ product_note+'" readOnly>'+product_note+'</input>';  
	dynTbIndex++;
	document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
}
	

//查询子产品信息
function queryproduct(){
		
	//alert(subsm_code);
	var subsm_code = frm.subsm_code.value;
	if(subsm_code == "**"){
		rdShowMessageDialog("请选择子产品品牌！");
		$("#subsm_code").focus();
		return false;
	}	

    var opr_type = frm.opr_type.value;
    if(opr_type != "D" && opr_type != "Q"){
		if($("#offer_id").val() == ""){
		    rdShowMessageDialog("请选择资费代码！");
		    $("#btnQry").focus();
		    return false;
		}
	}

	var selected_num = 0;

	var path = "fpubproduct_sel.jsp";
	path = path + "?subsm_code=" + subsm_code;

	path = path + "&regionCode=" + "<%=regionCode%>";
	path = path + "&selected_num=" + selected_num;
	var retInfo = window.open(path,"newwindow","height="+screen.availHeight+", width=900"+screen.availWidth+",top=0,left=0,scrollbars=yes, resizable=yes,location=no, status=yes");
	return true;
}

function getproduct(retInfo){
	var subsm_code = frm.subsm_code.value;
	var subsm_name = frm.subsm_code.options[frm.subsm_code.selectedIndex].text;
	var product_code = "";
    var product_name = "";
    var product_note = "";
    var product_price = "";
    var product_srv = "";
    var product_srvname = "";
    var product_type="";
    var product_discount="";
    //产品套餐信息
    var motive_price = "";
    var mode_code = "";
    var mode_name = "";
    var motive_srvname = "";
    
	if(typeof(retInfo) != "undefined" && retInfo != ""){
		document.getElementById("dyntb").style.display="block";
		product_code = oneTok(retInfo,"~",1);
		product_name = oneTok(retInfo,"~",2);
		product_note = oneTok(retInfo,"~",3);
		product_type=oneTok(retInfo,"~",4);
		product_discount=oneTok(retInfo,"~",5);
		queryAddAllRow(subsm_code,subsm_name,product_code,product_name,product_type,product_note,product_discount);
	}
}

function queryAddAllRow(subsm_code,subsm_name,product_code,product_name,product_type,product_note,product_discount){
	var flag = false;
	flag = verifyUnique(product_code);
	if(flag == false){
		rdShowMessageDialog("已经有一条相同的子产品代码");
	  	return false;
	}
	//alert("1:"+product_type);
	var tr1=dyntb.insertRow();	//注意：插入的必须与下面的在一起,否则造成空行
	tr1.id="tr"+dynTbIndex;
    tr1.insertCell().innerHTML = '<input name=R0 type=checkBox onClick="dynDelRow()"></input>';  
    tr1.insertCell().innerHTML = '<input name=R1 type=hidden value="'+ subsm_code+'" readOnly>'+subsm_name+'</input>';       
    tr1.insertCell().innerHTML = '<input name=R2 type=hidden value="' + product_code + '" readOnly>'+product_code+'</input>';         
    tr1.insertCell().innerHTML = '<input name=R3 type=hidden value="'+ product_name+'"  readOnly>'+product_name+'&nbsp;</input>';
    if(product_type.trim()=="0"||product_type.trim()=="0|")
    {
     tr1.insertCell().innerHTML = '<input name=R4 type=hidden value="'+ product_type+'"  readOnly>主产品&nbsp;</input>'; 
    } 
    else if(product_type.trim()=="1"||product_type.trim()=="1|")
    {
     tr1.insertCell().innerHTML = '<input name=R4 type=hidden value="'+ product_type+'"  readOnly>附属产品&nbsp;</input>'; 
    }  
         
    if(product_discount.trim()=="Y"||product_discount.trim()=="Y|")
    {
     tr1.insertCell().innerHTML = '<input type=hidden name=R6 id=R6id'+dynTbIndex+' value="'+product_discount+'" /><input name=R6'+dynTbIndex+' type=radio value=Y checked onClick=\'doDiscountClick('+dynTbIndex+',"Y")\'/>是&nbsp;<input name=R6'+dynTbIndex+' type=radio value=N  onClick=\'doDiscountClick('+dynTbIndex+',"N")\'/>否'; 
    } 
    else if(product_discount.trim()=="N"||product_discount.trim()=="N|")
    {
     tr1.insertCell().innerHTML = '<input type=hidden name=R6 id=R6id'+dynTbIndex+' value="'+product_discount+'" /><input name=R6'+dynTbIndex+' type=radio value=Y  onClick=\'doDiscountClick('+dynTbIndex+',"Y")\'/>是&nbsp;<input name=R6'+dynTbIndex+' type=radio value=N checked  onClick=\'doDiscountClick('+dynTbIndex+',"N")\'/>否'; 
    }
    
    tr1.insertCell().innerHTML = '<input name=R5 type=text class="InputGrey" value="'+ product_note+'" readOnly></input>' ;

	dynTbIndex++;
	document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
}

function doDiscountClick(rowno,value){
    $("#R6id"+rowno).val(value);
}

function Submits(){
	var opr_type = frm.opr_type.value;
		if(opr_type != "D" && opr_type != "Q"){
		if (!check(frm)){
			return false;
		}
		if(frm.catalog_item_id.value == "**"){
			rdShowMessageDialog("请选择产品类型！");
			return false;
		}
		if(frm.sm_code.value == "**"){
			rdShowMessageDialog("请选择产品品牌！");
			return false;
		}
		if(frm.motive_type.value=="")
		{
			rdShowMessageDialog("请选择业务大类！");
			return false;
		}
		if(frm.motive_name.value==""){
		    rdShowMessageDialog("业务包名称不能为空！",0);
		    $("#motive_name").focus();
		    return false;
		}
		if(frm.eff_date.value > "<%=dateStr%>"){
		    rdShowMessageDialog("开始时间不能大于当前日期！",0);
		    $("#eff_date").focus();
		    return false;
		}
		if(frm.exp_date.value <= frm.eff_date.value){
		    rdShowMessageDialog("结束时间必须大于开始时间！",0);
		    $("#exp_date").focus();
		    return false;
		}
		if(document.all.addRecordNum.value == 0||document.all.addRecordNum.value == 1){
			rdShowMessageDialog("请至少选择二个子产品！");
			return false;
		}
	}
	
	var motive_price = "";
	var price_length = frm.motive_price_num.value;
	if(price_length == 1){
		if(frm.motive_price.checked == true){
			motive_price = motive_price + frm.motive_price.value + "~";
		}
	}else if(price_length > 1){
		for(var j = 0;j < price_length;j++){
			if(frm.motive_price[j].checked == true){
				motive_price = motive_price + frm.motive_price[j].value + "~";
			}
		}
	}
	
	var offer_id = ""; //资费代码
	var offer_name = "";//资费名称
//	var offer_attr_value = "";//业务包一次办理费用
	var eff_date = "";
	var exp_data = "";
		
	var product_code = "";
	var product_name = "";
	var product_note = "";
	var product_smcode = "";
	var product_srv = "";
	var product_price = "";
	var product_srvname = "";
	var product_type="";
	var product_discount="";
	//产品套餐信息
//    var smotive_price = "";
    var smode_code = "";
    var smode_name = "";
    var i=0;
	
	for(var num = 1;num <= frm.addRecordNum.value;num++){
		
		product_code = product_code + frm.R2[num].value + "~";
		product_name = product_name + frm.R3[num].value + "~";
		product_note = product_note + frm.R5[num].value + "~";
 		product_smcode = product_smcode + frm.R1[num].value + "~";
		product_type = product_type + frm.R4[num].value + "~";
		product_discount = product_discount + frm.R6[num].value + "~";
//		alert(frm.R4[num].value);
		if(frm.R4[num].value=="0")
		{
			i=i+1;
		}
	}
	if(opr_type != "Q"){
		if(opr_type!="D")
		{
			if(i<2)
			{
				rdShowMessageDialog("业务包必须包含两个主产品！");
				return false;
			}
	    }
		
		var cfmpacket = new AJAXPacket("f7411Cfm.jsp", "正在提交,请稍候......");
		cfmpacket.data.add("opr_type", opr_type);
		cfmpacket.data.add("catalog_item_id", frm.catalog_item_id.value);
		cfmpacket.data.add("sm_code", frm.sm_code.value);
		cfmpacket.data.add("motive_type", frm.motive_type.value);
		cfmpacket.data.add("type_name", frm.motive_type.options[frm.motive_type.selectedIndex].text);
		cfmpacket.data.add("offer_id", frm.offer_id.value);
		cfmpacket.data.add("offer_name", frm.offer_name.value);
		cfmpacket.data.add("eff_date", frm.eff_date.value);
		cfmpacket.data.add("exp_date", frm.exp_date.value);
		cfmpacket.data.add("login_no", "<%=workNo%>");
		cfmpacket.data.add("org_code", "<%=orgCode%>");
		cfmpacket.data.add("product_code", product_code);
		cfmpacket.data.add("product_name", product_name);
		cfmpacket.data.add("product_note", product_note);
		cfmpacket.data.add("product_smcode", product_smcode);
		//cfmpacket.data.add("product_srv", product_srv);
		cfmpacket.data.add("product_type", product_type);
		cfmpacket.data.add("product_discount",product_discount);
		cfmpacket.data.add("addRecordNum", frm.addRecordNum.value);
		//cfmpacket.data.add("motive_code1",frm.motive_code1.value);
		cfmpacket.data.add("motive_code",$("#motive_code").val());
		cfmpacket.data.add("motive_name",$("#motive_name").val());
		cfmpacket.data.add("motive_price",motive_price);
		cfmpacket.data.add("motiveExtCode",$("#motiveExtCode").val());
		core.ajax.sendPacket(cfmpacket,DoGetCfm,false);
		cfmpacket=null;
	}else{
		var path = "fmotiveconfig_sel.jsp";
		path = path + "?offer_id=" + frm.offer_id.value;
		var retInfo = window.open(path,"newwindow","height="+screen.availHeight+", width="+screen.availWidth+",top=0,left=0,scrollbars=yes, resizable=yes,location=no, status=yes");
		return true;
	}
}

function DoGetCfm(cfmpacket){
	var retCode = unescape(cfmpacket.data.findValueByName("retCode"));
	var retMsg = unescape(cfmpacket.data.findValueByName("retMsg"));
	if(retCode=="000000"){
		rdShowMessageDialog("动力100业务包配置操作成功！",2);
		window.location.reload("f7411.jsp?op_code=<%=opCode%>");
		
	}else{
		rdShowMessageDialog("错误信息："+retMsg+"；错误代码："+retCode,0);
		return false;
	}
}

//查询产品资费的已配置信息
function getOfferInfo()
{
    /*
	var catalog_item_id=document.all.catalog_item_id.value ;     //产品类型
    var sm_code=document.all.sm_code.value ;    		   //产品品牌  
    var motive_type=document.all.motive_type.value ;        //业务类型
     
    var path="priceModeTree.jsp?catalog_item_id="+catalog_item_id+"&sm_code="+sm_code+"&motive_type="+motive_type;
    win=window.open(path,'_blank','height=500,width=310,scrollbars=yes');	
    */
    
    var vSmCode = document.frm.sm_code.value;
    if(vSmCode == "")
    {
        rdShowMessageDialog("请首先选择产品品牌！",0);
        $("#sm_code").focus();
        return false;
    }
    
    if(frm.motive_type.value==""){
		rdShowMessageDialog("请选择业务大类！");
		$("#motive_type").focus();
		return false;
	}
    
    var pageTitle = "集团产品选择";
    var fieldName = "";
    var retQuence = "";
    var retToField = "";

    fieldName = "产品代码|产品名称|";
    retQuence = "2|3|4|";
    retToField = "offer_id|offer_name|";

	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选

    if(PubSimpSelProd(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));	
}	

function PubSimpSelProd(pageTitle,fieldName,sqlStr,selType,retQuence,retToField){
    var product_code = document.all.offer_id.value;
	var path = "<%=request.getContextPath()%>/npage/s7411/fpubprod_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	path = path + "&showType=" + "Default";
	path = path + "&op_code=" + document.all.op_code.value;
	path = path + "&sm_code=" + document.all.sm_code.value; 
	path = path + "&product_code=" + product_code; 
	path = path + "&grp_id=" ;
	path = path + "&bizTypeL=" + ($("#motive_type").val()==null?'':$("#motive_type").val());
	path = path + "&bizTypeS=" ;
	path = path + "&biz_code=" ;

    retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	return true;
}

function getValueProd2(retInfo, retInfoDetail){
    var retToField = "";
    var vSmCode = document.frm.sm_code.value;
    retToField = "offer_id|offer_name|";
	if(retInfo ==undefined)      
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
    document.frm.sure.disabled=false;
	document.frm.btnQry.disabled=true;
	
	$("#eff_date").attr("readonly",false).val("<%=dateStr%>");
	$("#exp_date").attr("readonly",false).val("20500101");
	
	$("#motive_type").find("option:not(:selected)").remove();
	getMotivePrice();
	//getOfferInfo2();
}
    
function getOfferInfo2(){
    var vMotiveCode = $("#comm_code").val();
    
    var opr_type = frm.opr_type.value;
    
  	var cfmpacket = new AJAXPacket("f7411Qry.jsp", "正在提交,请稍候......");
    cfmpacket.data.add("motive_code",vMotiveCode);
    cfmpacket.data.add("opr_type",opr_type);
    core.ajax.sendPacket(cfmpacket,DoGetQry,false);
    cfmpacket=null;
}
    
function getmotive_code()
{
	var opr_type = frm.opr_type.value;
	if(opr_type=="A")
	{
		//得到集团用户ID，和个人用户ID一致
    	var getmotivecode_Packet = new AJAXPacket("f7411_getMotiveCode.jsp","正在获得用户ID，请稍候......");
		getmotivecode_Packet.data.add("region_code","<%=regionCode%>");
		getmotivecode_Packet.data.add("retType","MotiveCode");
		core.ajax.sendPacket(getmotivecode_Packet);
		getmotivecode_Packet = null;
	}
	else
	{
		var sm_code = frm.sm_code.value;
		var opr_type = frm.opr_type.value;
		var motive_type = frm.motive_type.value;
		if(sm_code == "**"){
			rdShowMessageDialog("请选择产品品牌！");
			return false;
		}	
	
		var path = "fpubmotive_sel.jsp";
		path = path + "?sm_code=" + sm_code;
		path = path + "&opr_type=G" ;
		path = path + "&motive_type=" + $("#motiveExtCode").val();
		var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
		if(typeof(retInfo) != "undefined" && retInfo != ""){
			frm.motive_code.value = oneTok(retInfo,"|",1);
			frm.motive_name.value = oneTok(retInfo,"|",2);
			//alert(frm.motive_name.value);
			frm.comm_code.value=frm.motive_code.value;
			if(opr_type != "Q"){
    			frm.sure.disabled=false;
    		}
			if(opr_type == "U" || opr_type == "Q" || opr_type == "D"){//查询出产品包对应的已配置的信息
				getOfferInfo2();
			}		
		}	
	}
}

function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
	var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    if(retType == "MotiveCode")
    {
    	if(retCode == "000000")
        {
          var retMotiveCode = packet.data.findValueByName("retnewId");
    	  document.frm.comm_code.value = retMotiveCode;    	  
    	  document.frm.motive_code.value = retMotiveCode;
    	  frm.sure.disabled=false;
        }
        else
        {
                rdShowMessageDialog("没有得到业务包代码,请重新获取！",0);
				return false;
        }
    	
    }
    
    if(retType == "motivePrice"){
        if(retCode == "000000")
        {
    		var backString = packet.data.findValueByName("backString");
         	var temLength = backString.length;
         	$("#motive_price_num").val(backString.length);
    		var arr = new Array(temLength);
    		for(var i = 0 ; i < temLength ; i ++)
    		{
    			arr[i] = "<input type='checkbox' name='motive_price' value='"+backString[i][0]+"'>"+backString[i][1]+"<input type='hidden' name='motive_srv' value='"+backString[i][0]+"' />";
    		}
    		
    		$("#motive_price_span").empty();
          	$(arr.join("")).appendTo("#motive_price_span");
          	if(temLength > 0){
              	$("#motive_price_tr").show();
            }
    	}
        else
        {
            rdShowMessageDialog("获取业务包费用折扣失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
    		return false;
        }
    }
    
    if(retType == "subSmCode"){
        if(retCode == "000000")
        {
    		var backString = packet.data.findValueByName("backString");
         	var temLength = backString.length+1;
    		var arr = new Array(temLength);
    		arr[0] = "<option value='**'>请选择...</option>";
    		for(var i = 0 ; i < temLength-1 ; i ++)
    		{
    			arr[i+1] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
    		}
    		
    		$("#subsm_code").empty();
          	$(arr.join("")).appendTo("#subsm_code");
    	}
        else
        {
            rdShowMessageDialog("获取子产品品牌失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
    		return false;
        }
    }
} 

function motiveTypeChg(){
    var vMotiveType = $("#motive_type").val();
    var vMotiveExtCode = eval("$('#motive_ext_code"+vMotiveType+"').val()");
    $("#motiveExtCode").val(vMotiveExtCode);
    
    var opr_type = frm.opr_type.value;
    if(opr_type == "Q" || opr_type == "D"){
        return;
    }
    
    var getsubsm_code_Packet = new AJAXPacket("f7411_getSubSmCode.jsp","正在获得子产品品牌，请稍候......");
	getsubsm_code_Packet.data.add("motiveExtCode",vMotiveExtCode);
	getsubsm_code_Packet.data.add("retType","subSmCode");
	core.ajax.sendPacket(getsubsm_code_Packet);
	getsubsm_code_Packet = null;
}

function getMotivePrice(){
    var vOfferId = $("#offer_id").val();
    
    var getMotivePrice_Packet = new AJAXPacket("f7411_getMotivePrice.jsp","正在获得业务包费用折扣，请稍候......");
	getMotivePrice_Packet.data.add("region_code","<%=regionCode%>");
	getMotivePrice_Packet.data.add("offerId",vOfferId);
	getMotivePrice_Packet.data.add("retType","motivePrice");
	core.ajax.sendPacket(getMotivePrice_Packet);
	getMotivePrice_Packet = null;
}
</script>
</head>
<body>
	<form action="" method="post" name="frm">
		<input type="hidden" name="yearmonth"  value="<%=dateStr%>">
		<%@ include file="/npage/include/header.jsp" %>
	 	<div class="title">
    	<div id="title_zi"><%=opName%></div>
	 	</div>
		<table cellSpacing="0">
		<tr>
		    <td class="blue" width="15%">操作类型</td>
		    <td width="35%">
		        <select name="opr_type" id="opr_type" v_must="1" onchange="oprChange(this);">
		        	<option value="A">新增</option>
		        	<option value="U">修改</option>
		        	<option value="D">删除</option>
		        	<option value="Q">查询</option>
		        </select>
		    </td>
		    <td class="blue" width="15%"><span style='display:none;'>产品类型</span>&nbsp;</td>
		    <td width="35%">
		        <span style='display:none;'>
		        <select name="catalog_item_id" v_must="1" >
		        <wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>
							select 1,1||'-->'||catalog_item_name from catalog_item where catalog_item_type = 'S' and catalog_item_id='9102'
						</wtc:sql>
					</wtc:qoption>
		        </select>
		        <font color="orange">*</font>
		        </span>&nbsp;
		  	</td>
		</tr>
		<tr>
		    <td class="blue" width="15%">产品品牌</td>
		    <td width="35%">
		        <select name="sm_code" id="sm_code" v_must="1" >
		        	<wtc:qoption name="sPubSelect" outnum="2">
						<wtc:sql>				
							select distinct SM_CODE,SM_CODE||'-->'||SM_NAME from SMOTIVETYPECFG order by SM_CODE
						</wtc:sql>
					</wtc:qoption>
		        </select>
		        <font color="orange">*</font>
		  	</td>		    
		  	<td class="blue" width="15%">业务大类</td>
		    <td>
		        <select name="motive_type" id="motive_type" v_must="1" onChange="motiveTypeChg()">
    <%
        String sqlStrMotive = "select distinct main_type,main_type||'->'||main_name,external_code from sbiztypecode where sm_code='DL' and to_number(external_code)<=800";
    %>
    
    <wtc:pubselect name="sPubSelect" retcode="retCodeMot" retmsg="retMsgMot" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStrMotive%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
    <%
        if("000000".equals(retCodeMot)){
            for(int ii=0;ii<retArr.length;ii++){
            %>
                <option value="<%=retArr[ii][0]%>"><%=retArr[ii][1]%></option>
            <%
            }
            
            for(int ii=0;ii<retArr.length;ii++){
            %>
                <input type='hidden' id='motive_ext_code<%=retArr[ii][0]%>' name='motive_ext_code<%=retArr[ii][0]%>' value='<%=retArr[ii][2]%>' />
            <%
            }
            %>
            <input type='hidden' id='motiveExtCode' name='motiveExtCode' value='<%=retArr[0][2]%>' />
            <%
        }else{
            %>
                <script type="text/javascript">
                    rdShowMessageDialog("查询业务大类失败！",0);
                </script>
            <%
        }
    %>
		        </select>
		        <font color="orange">*</font>
		    </td>
		</tr>
		<tr>
        <td class="blue" width="15%">业务包代码</td>
        <td>
            <input type="text" name="comm_code" id="comm_code" v_type="0_9" v_must="1" readOnly>
            <input type="button" class="b_text" value="获取" onclick="getmotive_code()">
            <font color="orange">*</font>
            <input type="hidden" name="motive_code" id="motive_code" v_must="1">
        </td>
        <td class="blue">业务包名称</td>
	    <td >
	        <input type="text" name="motive_name" id="motive_name" v_type="string" v_must="1" onblur="checkElement(this)">
	        <font color="orange">*</font>
	  	</td>
		</tr>
	    <tr>		
		    <td class="blue" width="15%">资费代码</td>
		    <td>
				<input type="text" name="offer_id" id="offer_id" v_type="0_9" v_must="1" readOnly value="" >
				<input type="button" class="b_text" id="btnQry" value="查询" onclick="getOfferInfo()">
				<font color="orange">*</font>
			</td>
			<td class="blue">资费名称</td>
		    <td >
		        <input type="text" name="offer_name" v_type="string" v_must="1"  readonly value="">
		        <font color="orange">*</font>
		  	</td>
		</tr>	
		<tr id="motive_price_tr" name="motive_price_tr" style="display:none;">
		    <td class="blue">业务包费用折扣</td>
		    <td class="blue" colspan="3" nowrap>
		    	<span id="motive_price_span" name="motive_price_span">
		    	</span>
		        <input type="hidden" name="motive_price_num" id="motive_price_num" value="0">
		    </td>
		</tr>	
		<tr>
		    <td class="blue">开始时间</td>
		    <td>
		        <input type="text" name="eff_date" id="eff_date" v_must="1" readOnly  value="">
		        <font color="orange">*</font>(格式YYYYMMDD)
		    </td>
		    <td class="blue">结束时间</td>
		    <td>
		        <input type="text" name="exp_date" id="exp_date" v_must="1" readOnly value="">
		        <font color="orange">*</font>(格式YYYYMMDD)
		  	</td>
		</tr>
		<tbody id="booking_vc" name="booking_vc" style="display:block;">
		<tr>
		    <td class="blue">子产品品牌</td>
		    <td nowrap>
		        <select name="subsm_code" id="subsm_code" v_must="1">
		        	<option value="**">请选择...</option>
		        </select>
		        <font color="orange">*</font>
		    </td>
		    <td class="blue">子产品代码</td>
		    <td nowrap>
		        <input type="button" class="b_text" value="选择" onclick="queryproduct()">
		        <font color="orange">*</font>&nbsp;&nbsp;&nbsp;&nbsp;已选择记录数
		        <input type="text" name="addRecordNum" size="10" value="0" readOnly>
		    </td>
		</tr>	
		</tbody>
		</table>
		<table cellSpacing="0" id="dyntb" style="display:none;">
		<tr>
			<th nowrap>
				<b>删除</b>
			</th>
			<th nowrap>
				<b>子产品品牌</b>
			</th>
			<th nowrap>
				<b>子产品代码</b>
			</th>
			<th nowrap>
				<b>子产品名称</b>
			</th>
			<th nowrap>
				<b>产品类型</b>
			</th>
			<th nowrap>
				<b>是否享受折扣</b>
			</th>
			<th nowrap>
				<b>子产品注释</b>
			</th>
    	</tr>	
    	<tr id="tr0" style="display:none"> 
            <td>
            	<input type="checkBox" name="R0" value="">
            </td>
            <td>
            	<input type="text" name="R1" value="">
            </td>
            <td>
            	<input type="text" name="R2" value="">
            </td>
            <td>
            	<input type="text" name="R3" value="">
            </td>  
            <td>
            	<input type="text" name="R4" value="">
            </td> 
            <td>
            	<input type="text" name="R6" value="">
            </td> 
            <td>
            	<input type="text" name="R5" value="">
            </td> 
        </tr>
		</table>
		<input type="hidden" name="result_length" value=0>
		<table cellSpacing="0">
		<tr> 
        	<td id="footer" colspan=4> 
           	<input class="b_foot" type=button onclick="Submits()" name="sure" value="确认" disabled>
			<input class="b_foot" type=button onclick="location='f7411.jsp?op_code=<%=opCode%>'" value=清除>
			<input class="b_foot" type=button onClick="parent.removeTab('<%=opCode%>')" value=关闭>
        	</td>
      	</tr>	
		</table>
		<input type='hidden' id='op_code' name='op_code' value='<%=opCode%>' />
		<%@ include file="/npage/include/footer.jsp" %>
	</form>	
</body>
</html>
