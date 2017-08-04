<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/xsl.tld" prefix="xsl" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/product/product.js"></script>
<%
	String offerId = WtcUtil.repNull(request.getParameter("offerId"));	
	String offerName = WtcUtil.repNull(request.getParameter("offerName"));
	String groupTypeId = WtcUtil.repNull(request.getParameter("groupTypeId"));
	String groupInfo = WtcUtil.repNull(request.getParameter("groupInfo"));
	String opType = WtcUtil.repNull(request.getParameter("opType"));
	String brandID = WtcUtil.repNull(request.getParameter("brandID"));
System.out.println("222222222groupInfo========="+groupInfo);	
System.out.println("brandID========="+brandID);	


	String verson_title = "<?xml version=\"1.0\" encoding=\"gb2312\"?>";
	String root_element = "<info>";
	String root_element1 = "</info>";
	StringBuffer sb = new StringBuffer(80);
	
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date()); //当前时间
	String grpInstId = "";
	if(opType.equals("set")){
%>
	<wtc:service name="sDynSqlCfm" outnum="3">
	  <wtc:param value="27"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	if(retCode.equals("000000") && result.length > 0){
		grpInstId = result[0][0];
System.out.println("grpInstId===------------------->======"+grpInstId);				
	}
}	
	
String groupTypeName = "";	
String sqlStr = "select  GROUP_TYPE_NAME from GROUP_TYPE  where  GROUP_TYPE_ID ='"+groupTypeId+"'";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
  <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
<%
	if(retCode.equals("000000") && rows.length > 0){
		groupTypeName = rows[0][0];
	}
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
		//sb.append("<default_value>"+retVal.getUtype("2."+i).getValue(13).trim()+"</default_value>");
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
<html>
<SCRIPT type=text/javascript>
var memberInfoHash = new Object(); 	//群成员信息	
var memberTypeIdHash = new Object();

$().ready(function(){
	getMebAttr();		//取成员属性
	getMemberId();	//取成员ID
	
	$("#newMember,#mebAttribute,#membertitle,#div_button,#newMemberInfo").css("display","none");
	
	var groupInfo = "<%=groupInfo%>";
	var temp = groupInfo.split("/");
	var groupArr = (temp[0]+"$").split("$");	
	if(typeof(groupArr) != "undefined" && groupArr != ""){
		$.each(groupArr,function(i,n){			
			var temp1 = n.split("~");
			if(typeof(temp1[0]) != "undefined"&&typeof(temp1[1]) != "undefined"){
				$("[name='"+temp1[0]+"']").val(temp1[1].trim());
			}
		});
	}
	
	var memberArray = [];
	if(temp.length > 1 && temp[1] != ","){
		 memberArray = temp[1].split("_");
		 
	}	
	if(typeof(memberArray) != "undefined" && memberArray != ""){
		$.each(memberArray,function(i,n){
			if(n != ""){				
				var memberInfo = n.split("$");
				memberInfoHash[memberInfo[0]] = n;
				$("#newMemberInfo").append("<tr><td><input type='checkbox' id='"+memberInfo[0]+"' checked>"+memberInfo[1]+"</td><td>"+memberTypeIdHash[memberInfo[3]]+"</td><td>正常</td><td>"+memberInfo[5]+"</td><td>"+memberInfo[6]+"</td></tr>");
			}
		});
		$("#newMemberInfo").css("display","");
	}

	$("#groupInfo :input").not(":button").each(chkDyAttribute);
	$("#groupInfo :input").not(":button").keyup(function stopSpe(){
					var b=this.value;
					if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
			});
});	

function doProcess(packet){
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode == "000000"){
			var memberId = packet.data.findValueByName("memberId");
			$("input[name='memberId']").val(memberId);
		}
		else{
				rdShowMessageDialog(errorMsg);
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
		if(!checksubmit(gropFm)) return false ;
		
		var sysTime = document.gropFm.sysTime;
		var begTime = document.gropFm.effectDate;
		var endTime = document.gropFm.expireDate;
		var systemValue = compareDates(sysTime,begTime);
		if(systemValue==1){
			rdShowMessageDialog("生效时间不能小于当前时间");
			return false;
			}
		var value=compareDates(begTime,endTime);
		if(value==1){
			rdShowMessageDialog("生效时间不能大于失效时间");
			return false;
		}
		
		var str = "";
		str += "grpInstId"+"~"+$("#grpInstId").val()+"$";
		str += "groupTypeId"+"~"+$("#groupTypeId").val()+"$";
		str += "groupDesc"+"~"+$("#groupDesc").val()+"$";
		str += "effectDate"+"~"+$("#effectDate").val()+"$";
		str += "expireDate"+"~"+$("#expireDate").val()+"$";
		str += "groupTypeName"+"~"+$("#groupTypeName").val()+"$";
		$("#groupInfo :input").not("button,[type='hidden']").each(function(){
				str += this.name+"~"+this.value+" $"; //群组属性
		});
		
		str += "/";		//分隔群组信息和成员信息
		
		var memberArr = "";														//装入群组成员信息,成员信息之间以"_"分隔
		$("#newMemberInfo :checked").each(function(){
				memberArr += memberInfoHash[this.id]+"$";
				memberArr += "_";
		});
		str += memberArr;
		window.returnValue = str;
		window.close();
}


//根据成员类型取得成员属性
function getMebAttr(){
		var mebTypeId = document.gropFm.memberTypeId.value;
		var packet = new AJAXPacket("/npage/sqp008/getNewMebAttr.jsp","请稍后...");
		packet.data.add("mebTypeId",mebTypeId);
		core.ajax.sendPacketHtml(packet,getNewMeb,true);
		packet =null;
}
//根据成员类型取得成员属性的回调函数
function getNewMeb(packet){
	$("#mebAttribute").html(packet);
	
	$("#mebAttribute :input").not(":button").each(chkDyAttribute);
	$("#mebAttribute :input").not(":button").keyup(function stopSpe(){
					var b=this.value;
					if(/[^0-9a-zA-Z\u4E00-\u9FA5]/.test(b)) this.value=this.value.replace(/[^0-9a-zA-Z\u4E00-\u9FA5]/g,'');
			});
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
	if(!checksubmit(gropFm)) return false ;
	
			var sysTime = document.gropFm.sysTime;
		var begTime = document.gropFm.effectDate;
		var endTime = document.gropFm.expireDate;
		var systemValue = compareDates(sysTime,begTime);
		if(systemValue==1){
			rdShowMessageDialog("生效时间不能小于当前时间");
			return false;
			}
		var value=compareDates(begTime,endTime);
		if(value==1){
			rdShowMessageDialog("生效时间不能大于失效时间");
			return false;
		}
	
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
					str += this.name.substring(2)+"~"+this.value+" $";	//成员属性
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
	var brandID = $("#brandID").val();
	if(serviceNo != ""){
		var packet = new AJAXPacket("getIdNo.jsp","请稍后...");
		packet.data.add("phoneNo",serviceNo);
		packet.data.add("brandId",brandID);
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
</SCRIPT>	
<body>
<div id="operation">
<FORM name="gropFm" action="" method=post>
<%@ include file="/npage/include/header.jsp" %>	
<div id="operation_table">	
<DIV class="title"><div class="text">新建群组</div></DIV>	

<div class="input">
<table>
	<tr> 
		<th>销售品ID：</th>
		<td><%=offerId%></td>
		<th>销售品名称：</th>
		<td><%=offerName%></td>
	</tr>
	<tr> 
		<th>群组标识：</th>
		<td><input type="text" name="grpInstId" id="grpInstId" value="<%=grpInstId%>" readonly /></td>
		<th>群组类型：</th>
		<td><input type="text" id="groupTypeName" value="<%=groupTypeName%>" readonly /></td>
	</tr>
	<tr> 
		<th><span class="red">*生效时间：</span></th>
		<td>
			<input name="effectDate"  id="effectDate" value="<%=dateStr%>"  class="required yyyyMMdd" v_format="yyyyMMdd" maxlength="8">
		</td>
		<th><span class="red">*失效时间：</span></th>
		<td>
			<input class="required yyyyMMdd" v_format="yyyyMMdd" name="expireDate" id="expireDate" value="20501231" maxlength="8">
		</td>
	</tr>
	<tr> 

		<th>群组权限：</th>

		<td colspan="3"><input type="text" id="grpAttr" value="00000000000000000000" readonly /></td>

	</tr>
	<tr> 
		<th><span class="red">*群组描述：</span></th>
		<td colspan="3">
		<textarea class="required haveSpe" name="groupDesc" id="groupDesc" rows="5" cols="60" maxlength="250"></textarea>
		</td>		
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

<div id="membertitle"><DIV class="title"><div class="text">新建群组成员</div></DIV></DIV>		
<table id="newMember">
	<tr> 
		<th><span class="red">*成员号码：</span></th>
		<td><input type="text" name="serviceNo" id="serviceNo" value="" class="required" onchange="getIdNo()">
		<input type="hidden" name="brandID" id="brandID" value="<%=brandID %>" class="">
		</td>
		<th>成员权限：</th>
		<td><input type="text" id="grpMebAttr" value="00000000000000000000" readonly /></td>
	</tr>
	<%
	String retTypeCode = retTypeVal.getValue(0);
	String retTypeMsg = retTypeVal.getValue(1);
	%>
	<tr> 
		<th><span class="red">*成员类型：</span></th>
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
		<th><span class="red">*成员角色：</span></th>
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
		<th><span class="red">*生效时间：</span></th>
		<td>
			<input name="membereffectDate"  id="membereffectDate" value="<%=dateStr%>"  class="required yyyyMMdd" v_format="yyyyMMdd" maxlength="8">
	    <input type="hidden" name="sysTime"  id="sysTime" value="<%=dateStr%>"  class="required yyyyMMdd" v_format="yyyyMMdd" maxlength="8">
		</td>
		<th><span class="red">*失效时间：</span></th>
		<td>
			<input class="required yyyyMMdd" v_format="yyyyMMdd" name="memberexpireDate" id="memberexpireDate" value="20501231" maxlength="8">
		</td>
	</tr>
	<tr> 
		<th><span class="red">*成员描述：</span></th>
		<td colspan="3">
		<textarea class="required haveSpe" name="memberDesc" id="memberDesc" rows="5" cols="60" maxlength="250"></textarea>
		</td>
	</tr>
</table>

<div id="mebAttribute">
</div>
	
<div id="div_button" align="center">		
	<input class="b_text" name=query11  type=button onClick="saveMember()" value="保存">
	&nbsp; 
	<input class="b_text" name=back onClick="hidMemberDiv()" type=button value="取消">
</div>	
	
</div>

<div class="list">
	<table id="newMemberInfo">
		<tr>
			<th>成员号码</th>
			<th>成员类型</th>
			<th>状态</th>
			<th>生效时间</th>
			<th>失效时间</th>
		</tr>	
	</table>
</div>

</div>

<div id="operation_button">
	<input class="b_foot" name=query  type=button onClick="saveTo()" value="确认">
	&nbsp; 
	<input class="b_foot" name=back onClick="window.close()" type=button value="返回">
	&nbsp; 
	<input class="b_foot_long" name=back onClick="newMemberDiv()" type=button value="添加群组成员">
</div>

<input type="hidden" name="groupTypeId" id="groupTypeId" value="<%=groupTypeId%>" />
<input type="hidden" name="memberId" id="memberId" />
<input type="hidden" name="memberObjectId" id="memberObjectId" value="0" />
<%@ include file="/npage/include/footer.jsp"%>
</FORM>
</DIV>
</BODY>
</HTML>