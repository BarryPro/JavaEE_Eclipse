<%
	String opName = "新建群组";
%>
<%@ page contentType="text/html;charset=GBK"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<%
System.out.println("--------------------------------showGroup.jsp--------------------------------------");
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));	
	String offerName = WtcUtil.repNull(request.getParameter("offerName"));
	String groupTypeId = WtcUtil.repNull(request.getParameter("groupTypeId"));
	String groupInfo = WtcUtil.repNull(request.getParameter("groupInfo"));
	String opType = WtcUtil.repNull(request.getParameter("opType"));
	String brandID = WtcUtil.repNull(request.getParameter("brandID"));
System.out.println("222222222groupInfo========="+groupInfo);	
System.out.println("opType========="+opType);
	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	String groupDesc = WtcUtil.repNull(request.getParameter("groutDesc"));
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); //当前时间
	String grpInstId = "";
	if(opType.equals("set")){
%>
	<wtc:service name="sDynSqlCfm" outnum="3">
	  <wtc:param value="27"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%


for(int iii=0;iii<result.length;iii++){
				for(int jjj=0;jjj<result[iii].length;jjj++){
					System.out.println("---------------------result["+iii+"]["+jjj+"]=-----------------"+result[iii][jjj]);
				}
		}
		
		
System.out.println("# retCode = "+retCode);
System.out.println("# retMsg  = "+retMsg);
	if(retCode.equals("000000") && result.length > 0){
		grpInstId = result[0][0];
System.out.println("grpInstId===------------------->======"+grpInstId);				
	}
}	
if(groupInfo != null && !("".equals(groupInfo))){
    String InstIdTemp = groupInfo.substring(0,groupInfo.indexOf("$"));
    System.out.println("InstIdTemp = "+InstIdTemp);
    InstIdTemp = InstIdTemp.substring(InstIdTemp.indexOf("~")+1,InstIdTemp.length());
    System.out.println("InstIdTemp = "+InstIdTemp);
    grpInstId = InstIdTemp;
}
	
	
String groupTypeName = "";	
String sqlStr = "select  GROUP_TYPE_NAME,group_type_desc from GROUP_TYPE  where  GROUP_TYPE_ID ='"+groupTypeId+"'";
System.out.println("sqlStr------------"+sqlStr);
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%
	if(retCode.equals("000000") && rows.length > 0){
		groupTypeName = rows[0][0];
	}
	
	System.out.println("---------------groupDesc----------------"+groupDesc);
%>	
<wtc:utype name="sQGrpAttrDet" id="retVal" scope="end">
	<wtc:uparam value="<%=groupTypeId%>" type="LONG"/>   
</wtc:utype>

<%
    int detLen = retVal.getUtype("2").getSize();
		String returnCode = retVal.getValue(0);
	  sb.append(verson_title).append(root_element);
		if((returnCode.equals("0"))){
		for(int i=0;i<retVal.getUtype("2").getSize();i++){
 
		sb.append("<field "+"order='"+i+"'"+"  dataType='"+retVal.getUtype("2."+i).getValue(2)+"'>");
		sb.append("<info_code>"+retVal.getUtype("2."+i).getValue(0)+"</info_code>");
		sb.append("<info_name>"+retVal.getUtype("2."+i).getValue(1).trim()+"</info_name>");
		sb.append("<read_only>"+retVal.getUtype("2."+i).getValue(3)+"</read_only>");
		sb.append("<data_length>"+retVal.getUtype("2."+i).getValue(4)+"</data_length>");
		sb.append("<data_preci>"+retVal.getUtype("2."+i).getValue(5)+"</data_preci>");
		sb.append("<data_remark>"+retVal.getUtype("2."+i).getValue(6).trim()+"</data_remark>");
		sb.append("<use_line>"+retVal.getUtype("2."+i).getValue(7)+"</use_line>");
		sb.append("<info_obj>"+retVal.getUtype("2."+i).getValue(8).trim()+"</info_obj>");
		sb.append("<option_flag>"+retVal.getUtype("2."+i).getValue(10).trim()+"</option_flag>");
		sb.append("<doc_flag>"+retVal.getUtype("2."+i).getValue(11).trim()+"</doc_flag>");
		sb.append("<show_length>"+retVal.getUtype("2."+i).getValue(12).trim()+"</show_length>");
		sb.append("<default_value>"+retVal.getUtype("2."+i).getValue(13).trim()+"</default_value>");
		sb.append("</field>");
		}
	}
	
	sb.append(root_element1);
%>	
<wtc:utype name="sPMQGrpMebType" id="retTypeVal" scope="end">  
</wtc:utype>

<wtc:utype name="sPMQGrpInsRole" id="retInsVal" scope="end">
	<wtc:uparam value="<%=groupTypeId%>" type="LONG"/>
</wtc:utype>
<%

	String str = "grpInstId~"+grpInstId+"$groupTypeId~"+groupTypeId+"$groupDesc~0$effectDate~"+dateStr+"$expireDate~20501231$groupTypeName~"+groupTypeName+"$/0";
	
	System.out.println("str|"+str);
%>
<html>
<SCRIPT type=text/javascript>
var memberInfoHash = new Object(); 	//群成员信息	
var memberTypeIdHash = new Object();

 function fnh1(){
	//getMebAttr();		//取成员属性
	
	//getMemberId();	//取成员ID
	
	$("#newMember,#mebAttribute,#membertitle,#div_button,#newMemberInfo").css("display","none");
	
	$("#operation :input").not(":button").keyup(function stopSpe(){
			var b=this.value;
			if(/[^0-9a-zA-Z\.\@\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
	});
	
	var groupInfo = "<%=groupInfo%>";
	var temp = groupInfo.split("/");
	var groupArr = temp[0].split("$");
	

	if(typeof(groupArr) != "undefined" && groupArr != ""){
		$.each(groupArr,function(i,n){
			var temp1 = n.split("~");
			if(typeof(temp1[1]) != "undefined"){
				if(temp[1].trim().indexOf(",") != -1){
					$("[name='s_"+temp[0]+"'] option").attr("selected",false);
					$.each(temp[1].trim().split(","),function(i,n){
						$("[name='s_"+temp[0]+"'] option[value='"+n+"']").attr("selected",true);
					});
				}else{
					$("[name='s_"+temp[0]+"']").val(temp[1].trim());	
				}	
			}
		});
	}

	var memberArray = [];

	$("#groupInfo :input").not(":button").each(chkDyAttribute);
}

function doProcess(packet){
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode == "000000"){
			var memberId = packet.data.findValueByName("memberId");
			$("input[name='memberId']").val(memberId);
		}
		else{
				rdShowMessageDialog("取成员ID失败!");
				return false;
		}
}

function getMemberId(){
	var packet = new AJAXPacket("getMemberId.jsp","请稍后...");
	core.ajax.sendPacket(packet);
	packet = null;
}

function saveTo()
{		
		if(!check(gropFm)) return false ;
		
		var str = "";
		str += "grpInstId"+"~"+$("#grpInstId").val()+"$";
		str += "groupTypeId"+"~"+$("#groupTypeId").val()+"$";
		str += "groupDesc"+"~"+$("#groupDesc").val()+"$";
		str += "effectDate"+"~"+$("#effectDate").val()+"$";
		str += "expireDate"+"~"+$("#expireDate").val()+"$";
		str += "groupTypeName"+"~"+$("#groupTypeName").val()+"$";
		$("#groupInfo :input").not("button,[type='hidden']").each(function(){
				str += this.name+"~"+$(this).val()+" $"; //群组属性
		});
		
		str += "/";		//分隔群组信息和成员信息
		var memberArr = "";														//装入群组成员信息,成员信息之间以"_"分隔
		$("#newMemberInfo :checked").each(function(){
				memberArr += memberInfoHash[this.id]+"$";
				memberArr += "_";
		});
		str += memberArr;
		window.returnValue = str;
		window.returnValue = window.returnValue+"#"+"0";
		//alert(window.returnValue);
		window.close();
}

//根据成员类型取得成员属性
function getMebAttr(){
		var mebTypeId = document.gropFm.memberTypeId.value;
		var packet = new AJAXPacket("getNewMebAttr.jsp","请稍后...");
		packet.data.add("mebTypeId",mebTypeId);
		core.ajax.sendPacketHtml(packet,getNewMeb,false);
		packet =null;
}
//根据成员类型取得成员属性的回调函数
function getNewMeb(packet){
	$("#mebAttribute").html(packet);
	
	$("#mebAttribute :input").not(":button").each(chkDyAttribute);
}

function newMemberDiv(){
	$("#newMember,#mebAttribute,#div_button,#newMemberInfo").css("display","block");	
	$("#membertitle").css("display","");
}

function hidMemberDiv(){
	$("#newMember,#mebAttribute,#membertitle,#div_button").css("display","none");
	if($("#newMemberInfo tr").length == 1){
		$("#newMemberInfo").css("display","none");
	}
}

function saveMember(){
	if(!check(gropFm)) return false ;
	
	if($("#serviceNo").val() != ""){
		var infoArr = "";
		infoArr += $("#memberId").val()+"$";
		infoArr += $("#serviceNo").val()+"$";
		infoArr += $("#memberDesc").val()+"$";
		infoArr += $("#memberTypeId").val()+"$";
		infoArr += $("#memberRoleId").val()+"$";
		infoArr += $("#membereffectDate").val()+"$";
		infoArr += $("#memberexpireDate").val()+"$";
		infoArr += $("#grpMebAttr").val()+"$";
		infoArr += $("#memberObjectId").val()+"$";
		var str = "";
		$("#mebAttribute :input").not("button,[type='hidden']").each(function(){
					str += this.name.substring(2)+"~"+$(this).val()+" $";	//成员属性
		});
		infoArr += str;
		memberInfoHash[$("#memberId").val()] = infoArr;
		$("#newMemberInfo").append("<tr><td><input type='checkbox' id='"+$("#memberId").val()+"' checked>"+$("#serviceNo").val()+"</td><td>"+$("#memberTypeId :selected").text()+"</td><td>正常</td><td>"+$("#membereffectDate").val()+"</td><td>"+$("#memberexpireDate").val()+"</td></tr>");
		
		$("#newMemberInfo :checkbox").bind("click",deleteRow);
		
		getMemberId();
	}
	else{
		rdShowMessageDialog("请输入成员号码！");	
	}
}

function deleteRow(){
	if(this.checked == false){
		$(this).parent().parent().remove();	
	}	
}

function getIdNo(){
	var serviceNo = $("#serviceNo").val();
	if(serviceNo != ""){
		var packet = new AJAXPacket("getIdNo.jsp","请稍后...");
		packet.data.add("phoneNo",serviceNo);
		packet.data.add("brandId","<%=brandID%>");
		core.ajax.sendPacket(packet,doGetIdNo);
		packet = null;
	}	
}

function doGetIdNo(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	if(errorCode == "000000"){
		var idNo = packet.data.findValueByName("idNo");
		if(typeof(idNo) != "undefined" && idNo != ""){
			$("#memberObjectId").val(idNo);
		}
		else{
			rdShowMessageDialog("非法成员!");
			$("#serviceNo").val("");
			return false;	
		}	
	}
	else{
			rdShowMessageDialog(errorMsg);
			return false;
	}	
}


function setDesc(){
	document.getElementById("groupDesc").innerText=document.getElementById("groupDesc").innerText+"0";
	fnh1();
	saveTo();
	}
</SCRIPT>	
<body onload="setDesc()">
<FORM name="gropFm" action="" method=post>
<%@ include file="/npage/include/header_pop.jsp" %>	
<div class="title">
	<div id="title_zi">新建群组</div>
</div>
<table cellspacing=0>
	<tr> 
		<td class='blue' nowrap>销售品ID</td>
		<td><%=offerId%></td>
		<td class='blue' nowrap>销售品名称</td>
		<td><%=offerName%></td>
	</tr>
	<tr> 
		<td class='blue' nowrap>群组标识</td>
		<td><input type="text" name="grpInstId" id="grpInstId" value="<%=grpInstId%>" readonly /></td>
		<td class='blue' nowrap>群组类型</td>
		<td><input type="text" id="groupTypeName" value="<%=groupTypeName%>" readonly /></td>
	</tr>
	<tr> 
		<td class='orange' nowrap>*生效时间</td>
		<td>
			<input name="effectDate"  id="effectDate" value="<%=dateStr%>"  class="required yyyyMMdd" v_format="yyyyMMdd" maxlength="8">
		</td>
		<td class='orange' nowrap>*失效时间</td>
		<td>
			<input class="required yyyyMMdd" v_format="yyyyMMdd" name="expireDate" id="expireDate" value="20501231" maxlength="8">
		</td>
	</tr>
	<tr> 
		<td class='orange' nowrap>*群组描述</td>
		<td colspan=3>
		<textarea   class="required haveSpe" name="groupDesc" id="groupDesc" maxlength="250"></textarea>
		</td>
	</tr>
	<tr style='display:none'>
		<td class='blue' nowrap>群组权限</td>
		<td><input type="text" id="grpAttr" value="00000000000000000000" readonly /></td>
	</tr>
</table>

<div id="groupInfo">
	<%
	 if(detLen>0)
	{
	%>
		<xsl:apply xmlstr="<%=sb.toString()%>" xsl="/npage/public/transTemplate.xsl"/>
	<%
	}
	%>
		
</div>
</div>
<div id="Operation_Table">

<div id="membertitle">
    <div class="title">
	<div id="title_zi">新建群组成员</div>
</div>
<table id="newMember" cellspacing=0>
	<tr> 
		<td class='orange' nowrap>*成员号码</td>
		<td><input type="text" name="serviceNo" id="serviceNo" value="" class="required" onBlur="getIdNo()"></td>
		<td class='blue' nowrap>成员权限</td>
		<td><input type="text" id="grpMebAttr" value="00000000000000000000" readonly /></td>
	</tr>
	<%
	String retTypeCode = retTypeVal.getValue(0);
	String retTypeMsg = retTypeVal.getValue(1);
	%>
	<tr> 
		<td class='orange' nowrap>*成员类型</td>
		<td>
			   <select name="memberTypeId" id="memberTypeId" onchange="getMebAttr()">
			   <%
			   if(retTypeCode.equals("0")){
			   	int retTypeNum = retTypeVal.getUtype("2").getSize();
		  		for(int i =0;i<retTypeNum;i++){
			   		String location = "2."+i;
				   	%>
				   <option value="<%=retTypeVal.getUtype(location).getValue(0)%>"><%=retTypeVal.getUtype(location).getValue(1)%></option>
			  	<SCRIPT type=text/javascript>
							memberTypeIdHash["<%=retTypeVal.getUtype(location).getValue(0)%>"] = "<%=retTypeVal.getUtype(location).getValue(2)%>";
					</script>
				   <%
						}
			   	}
			   %>
			  </select>
		</td>
		<%
		String retInsCode = retInsVal.getValue(0);
		String retInsMsg = retInsVal.getValue(1);
		%>
		<td class='orange' nowrap>*成员角色</td>
    <td>
			<select name="memberRoleId" id="memberRoleId"">
			<%
			if(retInsCode.equals("0")){
			int retInsNum = retInsVal.getUtype("2").getSize();
			for(int i =0;i<retInsNum;i++){
			String location = "2."+i;
			%>
			<option value="<%=retInsVal.getUtype(location).getValue(0)%>"><%=retInsVal.getUtype(location).getValue(2)%></option>
			<%
					}
				}
			%>
		</select>
	  </td>
	</tr>
	<tr> 
		<td class='orange' nowrap>*生效时间</td>
		<td>
			<input name="membereffectDate"  id="membereffectDate" value="<%=dateStr%>"  class="required yyyyMMdd" v_format="yyyyMMdd" maxlength="8">
		</td>
		<td class='orange' nowrap>*失效时间</td>
		<td>
			<input class="required yyyyMMdd" v_format="yyyyMMdd" name="memberexpireDate" id="memberexpireDate" value="20501231" maxlength="8">
		</td>
	</tr>
	<tr> 
		<td class='orange' nowrap>*成员描述</td>
		<td colspan="3">
		<textarea class="required haveSpe" name="memberDesc" id="memberDesc" maxlength="250" value="<%=groupDesc%>"></textarea>
		</td>
	</tr>
</table>

<div id="mebAttribute">
</div>
	
<div id="footer" align="center">		
	<input class="b_foot" name=query11  type=button onClick="saveMember()" value="保存">
	<input class="b_foot" name=back onClick="hidMemberDiv()" type=button value="取消">
</div>	
</div>
</div>
<div id="Operation_Table">
	<table id="newMemberInfo" cellspacing=0>
		<tr>
			<th>成员号码</th>
			<th>成员类型</th>
			<th>状态</th>
			<th>生效时间</th>
			<th>失效时间</th>
		</tr>	
	</table>


<div id="footer">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
	<!--input class="b_foot_long" name=back onClick="newMemberDiv()" type=button value="添加群组成员"-->
</div>

<input type="hidden" name="groupTypeId" id="groupTypeId" value="<%=groupTypeId%>" />
<input type="hidden" name="memberId" id="memberId" />
<input type="hidden" name="memberObjectId" id="memberObjectId" value="0" />
<%@ include file="/npage/include/footer_pop.jsp"%>
</FORM>
</BODY>
</HTML>