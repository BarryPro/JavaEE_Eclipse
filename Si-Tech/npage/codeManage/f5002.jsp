<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.agent.MakeSelect"%>

<jsp:useBean id="makeSelect" class="com.sitech.boss.agent.MakeSelect" scope="page" />
<jsp:useBean id="s5010" class="com.sitech.boss.s5010.viewBean.S5010Impl" />


<%
	String opCode = "5002";
	String opName = "营业点代码管理";		
	
		
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");	
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String loginNo =(String)session.getAttribute("workNo");
	String loginName =  (String)session.getAttribute("workName");	  
	String orgCode =  (String)session.getAttribute("orgCode");
	String ip_Addr =  (String)session.getAttribute("ipAddr");	  
	String regionCode = (String)session.getAttribute("regCode");
	String vDisCode = orgCode.substring(2,4);	   
	String regionName = otherInfoSession[0][5];
	System.out.println("regionName==========="+regionName);
	int	LISTROWS=16;
	
%>

<%
	
	String[][] districtCodeData = new String[][]{};
	String[][] innetTypeData = new String[][]{};

	int isGetDataFlag = 1;	
	String errorMsg ="";
	String tmpStr="";	
	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
	//1.SQL 区县代码
	
	insql.delete(0,insql.length());
	insql.append("select trim(district_code),district_code||'-->'||trim(district_name) from  sDisCode ");
	insql.append(" where region_code='"+ regionCode +"'");
	insql.append(" order by district_code ");
	
	//al = s5010.getCommONESQL(insql.toString(),2,0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=insql.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="districtCodeData1"  scope="end"/>
<%
	districtCodeData=districtCodeData1;
	if( districtCodeData == null ){
		isGetDataFlag = 2;
		break dataLabel;
	}		
	//districtCodeData = (String[][])al.get(1);

	//3.SQL 网点类型
	insql.delete(0,insql.length());
	insql.append("select trim(innet_code),trim(innet_code)||'-->'||trim(innet_name) from sInnetType ");
	insql.append(" order by innet_code  ");
	//al = s5010.getCommONESQL(insql.toString(),2,0);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:sql><%=insql.toString()%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="innetTypeData1"  scope="end"/>
<%
	innetTypeData=innetTypeData1;
	if( innetTypeData == null ){
		isGetDataFlag = 4;
		break dataLabel;
	}		
	//innetTypeData = (String[][])al.get(1);	
	isGetDataFlag = 0;
 	break;
 }	
 
	 errorMsg = "取数据错误:"+Integer.toString(isGetDataFlag);	    
	 
%>

<%if( isGetDataFlag != 0 ){%>
	<script language="JavaScript">
		rdShowMessageDialog("<%=errorMsg%>",0);
		window.close();
		window.opener.focus();
	</script>
<%}%>
<%

String LabelString="dbsys";
String[] resultList;
     
String sqlString = "select class_code,class_name from schnclass a "
				+"where a.parent_class_code = '1' and class_code not in('1') and exists (select 1 from schnclass b where a.class_code = b.parent_class_code "
				+"and b.denorm_level = '1') "
				+" order by TO_NUMBER(class_code);"
				+"select class_code,replace(lpad(' ',root_distance,'>'),'>','> ')||class_name,parent_class_code from schnclass a "
				+"where denorm_level = '1' and class_code not in ('6') "
				+"and not exists (select 1 from schnclass b where a.class_code = b.parent_class_code and b.denorm_level = '1') "
				+" order by TO_NUMBER(class_code);";
System.out.println("sqlString---->"+sqlString);			
String[][] initParms={
	{"2","CodeName","firstClass","","onChange=\"changeFirstClass(this)\""},
	{"3","SpecialTable","classCodeArr","","classCodeIndex|classNameIndex|parentClassCodeIndex|"}
};
resultList=makeSelect.makeSelect(LabelString,sqlString,initParms);
if (!resultList[resultList.length-1].equals("OK")){
	throw new Exception(resultList[resultList.length-1]);
}
int firstClass=0;

%>
<%=makeSelect.getScript()%>

<html>
<head>
<title>营业点代码管理</title>
<script language="JavaScript">
	var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";
onload=function()
{		
	init();	
}

	//---------1------RPC处理函数------------------
function doProcess(packet)
{
	var errorCode = packet.data.findValueByName("errorCode");
	var errorMsg = packet.data.findValueByName("errorMsg");
	//alert("errorCode:["+errorCode+"]");
	if(errorCode != "0000")
	{
		rdShowMessageDialog("["+errorCode+"]:"+errorMsg,0);
		return;
	}
	var typecode = packet.data.findValueByName("typecode");
	if(typecode == "getTown")
	{
		var values = packet.data.findValueByName("values");
		var names = packet.data.findValueByName("names");
		fillDropDown(document.all.stownCode,values,names);
		return;
	}
	if(typecode == "getTownMsg")
	{
		var values = packet.data.findValueByName("values");
		
		if(values.length == 12)
		{
			with(document.all)
			{
				townName.value      = values[0];
				innetType.value     = values[1];
				docFlag.value       = values[2];
				feeType.value       = values[3];
				loginTown.value     = values[4];
				townAddress.value   = values[5];
				townPhone.value     = values[6];
				contactPerson.value = values[7];
				contactPhone.value  = values[8];
				contactId.value     = values[9];
				firstClass.value    = values[10];
				changeFirstClass();
				classCode.value     = values[11];
			}   
		}       
		return; 
	}
}

function changeFirstClass()
{
	var args=changeFirstClass.arguments[0];
	var funcStr="";

	with (document.forms[0])		
	{
		for( i = 0; i < classCodeArr[classCodeIndex].length; i++)
		{
			if( classCodeArr[parentClassCodeIndex][i] == firstClass.value)
			{
				funcStr += "<option value=\""+classCodeArr[classCodeIndex][i]+"\">"+classCodeArr[classNameIndex][i]+"</option>";
			}
		}
	}
	document.all.classArr.innerHTML = "<select name=\"classCode\">"	+funcStr+ "</select>";
}
                
function fillDropDown(obj,_value,_text){
    obj.options.length = 0;
    var option1 = new Option('--请选择--','');
    obj.add(option1);
    for(var i=0; i<_value.length;i++)
    {
      var option = new Option(_text[i],_value[i]);
      obj.add(option);
   }
}
function clearoption(obj){
    obj.options.length = 0;
}

function init()
{
	chg_opType();
	chg_districtCode();
	changeFirstClass();
}
	
function chg_opType()
{
	with(document.frm)
	{
		var op_type = opType[opType.selectedIndex].value;
		if( op_type == oprType_Add )
		{
			showAdd.style.display="";
			//showOther.style.display="none";				
		}
		else
		{
			showAdd.style.display="none";
			//showOther.style.display="";				
		}
		enabledInput();
		//chg_districtCode();
		if( op_type == oprType_Add )
		{
			clearInput();
		}
	}
}

function enabledInput()
{
	with(document.frm)
	{
		var op_type = opType[opType.selectedIndex].value;
		if( (op_type == oprType_Add) || (op_type == oprType_Upd))
		{
			townName.disabled =  false;
			innetType.disabled =  false;
			feeType.disabled =  false;
			docFlag.disabled =  false;
			townAddress.disabled =  false;
			loginTown.disabled =  false;
			townPhone.disabled =  false;
			contactPerson.disabled =  false;
			contactPhone.disabled =  false;
			contactId.disabled =  false;
			firstClass.disabled = false;
			classCode.disabled = false;
		}
		else
		{
			townName.disabled =  true;
			innetType.disabled =  true;
			feeType.disabled =  true;
			docFlag.disabled =  true;
			townAddress.disabled =  true;
			loginTown.disabled =  true;
			townPhone.disabled =  true;
			contactPerson.disabled =  true;
			contactPhone.disabled =  true;
			contactId.disabled =  true;		
			firstClass.disabled = true;
			classCode.disabled = true;
		}						
	}
}
	
function clearInput()
{
	with(document.frm)
	{
		townName.value = "";
		townAddress.value = "";
		loginTown.value = "";
		townPhone.value = "";
		contactPerson.value = "";
		contactPhone.value = "";
		contactId.value = "";	
		atownCode.value = "";
	}		
}

function chg_districtCode()
{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	if( op_type == oprType_Add )
	{
		document.frm.atownCode.value = "";
		clearInput();	
		return false;		
	}
	with(document.frm)
	{
		stownCode.length = 0;
		areaCode.length = 0;
		newareaCode.length = 0;
		if (districtCode.selectedIndex >= 0)
		{
			var myPacket = new AJAXPacket("f5002_rpc.jsp","正在获取数据，请稍候......");
			myPacket.data.add("typecode","getTown");
			myPacket.data.add("regionCode","<%=regionCode%>");
			myPacket.data.add("disCode",districtCode.options[districtCode.selectedIndex].value);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
		}
	}
}

function chg_stownCode()
{
	with(document.frm)
	{
		clearInput();	  	
		if ( (districtCode.selectedIndex >= 0) && (stownCode.selectedIndex > 0 ) )
		{
	
			var distCode = districtCode[districtCode.selectedIndex].value;
			var townCode = stownCode[stownCode.selectedIndex].value;

			var myPacket = new AJAXPacket("f5002_rpc.jsp","正在获取数据，请稍候......");
			myPacket.data.add("typecode","getTownMsg");
			myPacket.data.add("regionCode","<%=regionCode%>");
			myPacket.data.add("disCode",distCode);
			myPacket.data.add("townCode",townCode);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
	 	}	
	}
}

function call_atownCodeQry()
{
    var pageTitle = "网点代码查询";               
    var fieldName = "网点代码|网点名称";
	var sqlStr ="";
	var distCode = document.frm.districtCode[document.frm.districtCode.selectedIndex].value;
	//var vAreaCode = document.frm.areaCode[document.frm.areaCode.selectedIndex].value;
				 
	sqlStr ="select town_code,town_name from stownCode "+
			" where region_code='" + "<%=regionCode%>" +"'" +
			" and district_code='"+<%=vDisCode%>+"'"+
			" order by town_code ";
	
    var selType = "S";    //'S'单选；'M'多选      
    var retQuence = "0|1";             
    var retToField = "atownCode|";
    
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 	
}

function judge_valid()
{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;

	if( op_type == oprType_Add )
	{	
		if(!checkElement(document.frm.atownCode)) return false;	
	}
	
	if( (op_type == oprType_Add) || (op_type == oprType_Upd) )
	{
		if(!checkElement(document.frm.townName)) return false;
		if(!checkElement(document.frm.loginTown)) return false;
		if( document.frm.townPhone.value.length > 0 ){	
			if(!checkElement(document.frm.townPhone)) return false;	
		}		
		if( document.frm.contactPhone.value.length > 0 ){	
			if(!checkElement(document.frm.contactPhone)) return false;	
		}	
		if( document.frm.contactId.value.length > 0 ){	
			if(!checkElement(document.frm.contactId)) return false;	
		}	
	}				
	return true;
}

function DoList()
{
	//if (IList.style.visibility != "hidden")
	if (IList.style.display != "none")
	{
		//IList.style.visibility="hidden";
		IList.style.display = "none";
	}
	else
	{
		//IList.style.visibility="visible";
		IList.style.display = "";
	}
}

function resetJsp()
{
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;

	if( op_type == oprType_Add )
	{	
	document.frm.atownCode.value = "";
	clearInput();
	}	
	
}

function commitJsp()
{
	getAfterPrompt();
	var tmpStr="";
	var op_type = document.frm.opType[document.frm.opType.selectedIndex].value;
	var procSql = "";
	
	if( op_type == oprType_Qry )
	{
		rdShowMessageDialog("查询不能确认!");
		return false;					
	}
		
	if( !judge_valid() )
	{
		return false;
	}

	//2.对form的隐含字段赋值
	document.frm.opCode.value="5002";

		
	//4.提交页面
	 procSql = " prc_5002_cfm('" + document.all.opType.value+ "'";
	 if( op_type == oprType_Add ){
	 	procSql = procSql + ",'" + document.all.atownCode.value+ "'";
	 	tmpStr = "增加 " + ",营业点代码:"+document.frm.atownCode.value+"";
	 }else{
	 	procSql = procSql + ",'" + document.all.stownCode.value+ "'";
	 	tmpStr = "修改 " + ",营业点代码:"+document.frm.stownCode.value+"";
	 }
	 procSql = procSql + ",'" + document.all.regionCode.value+ "'";
	 procSql = procSql + ",'" + document.all.districtCode.value+ "'";
	 procSql = procSql + ",'" + document.all.townName.value+ "'";
	 procSql = procSql + ",'" + document.all.innetType.value+ "'";
	 
	 procSql = procSql + ",'" + document.frm.firstClass.value+ "'";
	 procSql = procSql + ",'" + document.frm.classCode.value+ "'";
	 
	 procSql = procSql + ",'" + document.all.docFlag.value+ "'";
	 procSql = procSql + ",'" + document.all.feeType.value+ "'";
	 procSql = procSql + ",'" + document.all.loginTown.value+ "'";
	 procSql = procSql + ",'" + document.all.townAddress.value+ "'";
	 procSql = procSql + ",'" + document.all.townPhone.value+ "'";
	 procSql = procSql + ",'" + document.all.contactPerson.value+ "'";
	 procSql = procSql + ",'" + document.all.contactPhone.value+ "'";
	 procSql = procSql + ",'" + document.all.contactId.value+ "'";
	 
	  
	 procSql = procSql + ",'" + document.frm.loginNo.value + "'";
	 procSql = procSql + ",'" + document.frm.opCode.value + "'";
	 procSql = procSql + ",'" + document.frm.IpAddr.value + "'";
	 
	 document.frm.opNote.value =  tmpStr;
	 procSql = procSql + ",'" + document.frm.opNote.value + "'";
	 if( op_type == oprType_Add ){
	 	procSql = procSql + ",'" + document.frm.areaCode.value + "'";	 	
	 }else{
	 	procSql = procSql + ",'" + document.frm.newareaCode.value + "'";
	 }

	//8.提交页面
	document.frm.confirm.disabled = true;
	page = "f5002_confirm.jsp?procSql="+procSql;
	frm.action=page;
	frm.method="post";
	frm.submit();
					 		

}

</script>
</head>
<body>
<form name="frm" method="post action=""">	
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">营业点代码管理</div>
	</div>
	<input name="areaCode" type="hidden"  value="00"/>
	<input name="newareaCode"  type="hidden"  value="00"/>
        <table cellspacing="0">
		<tr> 
			<td class="blue">操作类型</td>
			<td>
				<select name="opType"  id="select" onChange="chg_opType()">
					<option value="a">增加</option>
					<option value="u">修改</option>
					<option value="q" selected>查询 
				</select> 
			</td>
			<td class="blue"> 地市代码</td>
			<td>
				<input name="regionName" type="text" id="regionName2" value="<%=regionName%>" maxlength="2" readonly class="InputGrey"> 
			</td>
		</tr>
		<tr> 
			<td class="blue">区县代码</td>
			<td>
				<select name="districtCode"  id="districtCode" onChange="chg_districtCode()">
					<%
					for(int i=0;i<districtCodeData.length; i++){
					out.println("<option class='button' value='"+districtCodeData[i][0]+"'>"+districtCodeData[i][1]+"</option>");
					}
					%>            
				</select> 
			</td>			  
			<td class="blue">网点代码</td>
			<td>
				<select name="stownCode"  id="stownCode" onChange="chg_stownCode()">
				</select>
			</td>		
		</tr>
		  
		<tr  id="showAdd" > 
			<td class="blue">网点代码</td>
			<td>
				<input name="atownCode" type="text"  id="atownCode" maxlength="3" v_must=1 v_type=0_9 v_minlength=3 >
				<input name="atownCodeQry" type="button"  id="atownCodeQry" class="b_text" value="查询" onClick="call_atownCodeQry()">
			</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr > 
			<td class="blue">网点名称</td>
			<td>
				<input name="townName" type="text"  id="townName" maxlength="60" v_must=1 v_type=string v_minlength=1 >
			</td>
			<td class="blue">网点类型</td>
			<td>
				<select name="innetType"  id="innetType">
					<%
					for(int i=0;i<innetTypeData.length; i++){
					out.println("<option class='button' value='"+innetTypeData[i][0]+"'>"+innetTypeData[i][1]+"</option>");
					}
					%>                 
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">
				渠道分类
			</td>
			<td class="lightBlue">
				<%=resultList[firstClass]%>
			</td>
			<td class="blue">
				渠道细分
			</td>
			<td>
				<p id="classArr">
					<select name="classCode">						
					</select>
				</p>
			</td>
		</tr>
		<tr> 
			<td class="blue">费用标志</td>
				<td>
					<select name="feeType"  id=<option value="1">1-->进行费用记录</option>"feeType">
						<option value="1">1-->进行费用记录</option>
						<option value="0">0-->不进行费用记录</option>            
					</select>
				</td>
				<td class="blue">资费处理标志</td>
				<td>
					<select name="docFlag"  id="docFlag">
						<option value="1">1-->是</option>
						<option value="0">0-->否</option>            
					</select>
				</td>
		</tr>
		<tr> 
			<td class="blue">网点地址</td>
			<td>
				<input name="townAddress" type="text"  id="townAddress" maxlength="60">
			</td>
			<td class="blue">网点简称</td>
			<td>
				<input name="loginTown" type="text"  id="loginTown" v_must=1 v_type=string maxlength="2" value = "" v_minlength=2 >
			</td>
		</tr>
		<tr> 
			<td class="blue">网点电话</td>
			<td>
				<input name="townPhone" type="text"  id="townPhone" maxlength="40" v_type=phone  >
			</td>
			<td class="blue">联系人</td>
			<td>
				<input name="contactPerson" type="text"  id="contactPerson" maxlength="60">
			</td>
		</tr>
		<tr> 
			<td class="blue">联系人电话</td>
			<td>
				<input name="contactPhone" type="text"  id="contactPhone" maxlength="30" v_type=phone  >
			</td>
			<td class="blue">联系人身份证</td>
			<td>
				<input name="contactId" type="text"  id="contactId" maxlength="20" v_type=idcard >
			</td>
		</tr>
	</table>
	<table cellspacing="0">
		<tr> 
			<td id="footer">             	
			<input name="confirm" class="b_foot" type="button"  value="确认" onClick="commitJsp()">
			&nbsp; 
			<input name="reset" class="b_foot"  type="button"  value="清除" onClick="resetJsp()">
			&nbsp; 
			<input name="back" class="b_foot" onClick="removeCurrentTab()" type="button"  value="返回">
			&nbsp; </td>
		</tr>	
	</table>
	   
	<table style="display:none" id="IList"   cellSpacing=0>
		 <%
		 	out.println("<tr bgcolor=#E8E8E8 height=30>");
		 	out.println("<th>网点简称</th>");
		 	out.println("<th>网点属性</th>");
		 	out.println("<th>网点代码</th>");
		 	out.println("<th>网点名称</th>");	
		 	out.println("<th>费用标志</th>");
		 	out.println("</tr>");
		 %>
	 </table>

  
  	<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
  	<input type="hidden" name="loginName" id="loginName" value="">
  	<input type="hidden" name="opCode" id="opCode" value="">
  	<input type="hidden" name="orgCode" id="orgCode" value="">
  	<input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
  	<input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">  	  	
	<input type="hidden" name="opNote" id="opNote" value="">

	<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>
