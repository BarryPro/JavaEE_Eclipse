<%
/********************
 version v2.0
开发商: si-tech
********************/
%>

<%
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache");
  response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>


<%
	String opCode = "8302";
	String opName = "主动授权";
  String loginNo = (String)session.getAttribute("workNo");
  String regionCode = (String)session.getAttribute("regCode");
  String work_group_id = (String)session.getAttribute("workGroupId");
 
  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd HH:mm:ss").format(new java.util.Date()); 
  String endStr  = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date())+ " 19:00:00";
 System.out.println("dateStr="+dateStr);
%>
<%
	String agt_info="";
	comImpl co=new comImpl();
	String rowpowersql="select total_date from sroleopcode where region_code='"+regionCode+"' and op_type='4'";
	System.out.println("rowpowersql====="+rowpowersql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1">
		<wtc:sql><%=rowpowersql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end"/>
<%
	String[][] rowpowerStr = result1;
    
	String regiongroupsql = " select  group_id from dchngroupmsg where boss_org_code='"+regionCode+"'||'99999'";
  System.out.println("regiongroupsql====="+regiongroupsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2">
		<wtc:sql><%=regiongroupsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result2" scope="end"/>
<%
  String[][] regionGroupStr = result2;
  
	String districtsql = " select a.group_id,a.group_id||'-- >'||group_name  from dChnGroupMsg a,dbresadm.dChnGroupInfo b  "+
					" where a.group_id=b.group_id   and b.parent_group_id='"+regionGroupStr[0][0]+"' and b.denorm_level=1 Order By a.group_id ";
  System.out.println("districtsql====="+districtsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode3" retmsg="retMsg3">
		<wtc:sql><%=districtsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result3" scope="end"/>
<%
  String[][] districtStr = result3;
  
/*String agtloginsql=" select count(*) from  dChnGroupMsg a,sChnClass b "+
				" where a.group_id='"+regionGroupStr[0][0]+"' and a.is_active='Y' "+
				 " and a.class_code=b.class_code and b.class_type='2'";
				*/
/*String agtloginsql=" select count(*) from  dChnGroupMsg a,sChnClass b,dloginmsg c "+
				" where  a.class_code=b.class_code and a.group_id=c.group_id and b.class_type='2' and c.login_no='"+loginNo+"' ";
*/	
String agtloginsql=" select count(*) from  srolelogintown "+
				" where login_no='"+loginNo+"' and op_code='8176' ";
System.out.println("agtloginsql====="+agtloginsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode4" retmsg="retMsg4">
		<wtc:sql><%=agtloginsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result4" scope="end"/>
<%
  String[][] agtloginStr = result4;
  if(Integer.parseInt(agtloginStr[0][0])>0){
  	agt_info="1";/*1社会渠道,0自有渠道*/
}else{
	
    
	/*agtloginsql=" select count(*) from   dChnGroupMsg a,sChnClass b,dloginmsg c,sLoginRoalRelation d "+
				" where a.class_code=b.class_code and a.group_id=c.group_id and b.class_type<>'2' "+
				" and c.login_no='"+loginNo+"'  and c.login_no=d.login_no and d.role_code='"+rowpowerStr[0][0]+"'" ; 
	*/
	agtloginsql=" select count(*) from   srolelogintown "+
				" where login_no='"+loginNo+"' and op_code='9618' " ; 

	System.out.println("agtloginsql====="+agtloginsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode5" retmsg="retMsg5">
		<wtc:sql><%=agtloginsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result5" scope="end"/>
<%
    agtloginStr = result5;
    System.out.println("agtloginStr[0][0]agtloginStr[0][0]agtloginStr[0][0]="+agtloginStr[0][0]);
    if(Integer.parseInt(agtloginStr[0][0])>0){
		agt_info="0";
	}else{
		System.out.println("aaaaaaaaaaaaaaaaaa");
	%>
	<script>
		alert("此工号没有主动授权权限!");
		window.close();
	</script>
	<%
	}
	}
	
String opcodesql="select a.op_code,b.function_name from sroleopcode a,sfunccode b where a.op_code=b.function_code "+
          " and a.region_code='"+regionCode+"' and a.op_type='"+agt_info+"'"; 
  /*String opcodesql="select a.op_code,b.function_name from sroleopcode a,sfunccode b where a.op_code=b.function_code "+
          " and a.region_code='14' and a.op_type='"+agt_info+"'"; */
   System.out.println("opcodesql====="+opcodesql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode6" retmsg="retMsg6">
		<wtc:sql><%=opcodesql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result6" scope="end"/>
<%
  String[][] opcodeStr = result6;
/*String loginsql="select a.login_no,a.login_name from dloginmsg a,sLoginRoalRelation b where group_id= '"+work_group_id+"' and vilid_flag='1' and a.login_no=b.login_no and b.role_code !='"+rowpowerStr[0][0]+"'";
  */
  String loginsql="select a.login_no,a.login_name from dloginmsg a where a.group_id='"+work_group_id+"' and vilid_flag='1' and not exists (select 'x' "+
                  " from srolelogintown c where a.login_no=c.login_no and op_code='9618')";
  System.out.println("loginsql====="+loginsql);
%>
	<wtc:pubselect name="sPubSelect" outnum="2" routerKey="region" 
			routerValue="<%=regionCode%>" retcode="retCode7" retmsg="retMsg7">
		<wtc:sql><%=loginsql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result7" scope="end"/>
<%
  String[][] loginStr = result7;
%>

<head>
<title>主动授权</title>
<script language=javascript>
  onload=function()
  {	
  	 visableop();
  	 optypechg();
  }  
   function doProcess(packet){
 
 		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		//alert(errorCode);
		if(errorCode != "0000")
		{
			alert("["+errorCode+"]:"+errorMsg);
			return;
		}
		//document.all.login_no.disabled=true;
		var typecode = packet.data.findValueByName("typecode");
		if(typecode == "getTown")
		{
			var values = packet.data.findValueByName("values");
			//alert(values);
			var names = packet.data.findValueByName("names");
			fillDropDown(document.all.stownCode,values,names);
			return;
		}
		if(typecode == "getLogin")
		{
			//alert("sssssssssss");
			var values = packet.data.findValueByName("values");
			//alert(values);
			var names = packet.data.findValueByName("names");
			//alert(names);
			fillDropDown(document.all.agt_login,values,names);
			return;
		}
	
 }
  </script>
<script language="JavaScript">
<!--
var plan_code ;
bind_values1 = new Array() ;
notes = new Array() ;
function districtChange()
{
	
	document.all.stownCode.length = 0;
	document.all.agt_login.length = 0;
	if (document.all.district_code.selectedIndex >= 0)
	{
		var myPacket = new AJAXPacket("f8302_rpc.jsp","正在获取数据，请稍候......");
		//alert(document.all.district_code.options[document.all.district_code.selectedIndex].value);
		myPacket.data.add("typecode","getTown");
		myPacket.data.add("disGroup",document.all.district_code.options[document.all.district_code.selectedIndex].value);
		myPacket.data.add("loginno","<%=loginNo%>");
		core.ajax.sendPacket(myPacket);
		myPacket=null;
	}
}
function townchange()
{
	document.all.agt_login.length = 0;
	if (document.all.district_code.selectedIndex >= 0 && document.all.stownCode.selectedIndex >= 0)
	{
		var myPacket = new AJAXPacket("f8302_rpc.jsp","正在获取数据，请稍候......");
		//alert(document.all.district_code.options[document.all.district_code.selectedIndex].value);
		myPacket.data.add("typecode","getLogin");
		myPacket.data.add("disGroup",document.all.stownCode.options[document.all.stownCode.selectedIndex].value);
		core.ajax.sendPacket(myPacket);
	}
}
function optypechg()
{ //alert(document.all.op_type.value);
	if(document.all.op_type.value=="0"){
		if("<%=agt_info%>"=="1"){
			rdShowMessageDialog("社会渠道只能按次授权!");
			document.all.op_type.value="1";
			return ;
		}
		document.all.zy_time.style.display = "";
		document.all.zy_note.style.display = "";
		document.all.cs_cs.style.display = "none";
	}else{
		document.all.zy_time.style.display = "none";
		document.all.cs_cs.style.display = "";
		document.all.zy_note.style.display = "none";
	}
}
function visableop()
{
	//alert(<%=agt_info%>);
	document.all.agt_bz.value="<%=agt_info%>";
	if("<%=agt_info%>"=="0"){
		document.all.zy_no.style.display = "";
		document.all.zy_note.style.display = "";
		document.all.zy_time.style.display = "";
		document.all.agt_no.style.display = "none";
		document.all.agt_dis.style.display="none";
		
	}else
	{
		document.all.zy_no.style.display = "none";
		document.all.zy_note.style.display = "none";
		document.all.zy_time.style.display = "none";
		document.all.agt_no.style.display = "";
		document.all.agt_dis.style.display="";
	}
	
}
function fillDropDown(obj,_value,_text){
    obj.options.length = 0;
    var option1 = new Option('--请选择--','');
    obj.add(option1);
    //alert(_value.length);
    for(var i=0; i<_value.length;i++)
    {
      var option = new Option(_text[i],_value[i]);
      obj.add(option);
   }
}


function printCommit(){
	
	if(!check(frm))
  {
    return false;
  }
  var chooseVal = $("#checkFile").val();
  var fileNumberObj = $("#fileNumber");
	var fileNameObj = $("#fileName");
	if("1" == chooseVal){
		if(0 == fileNumberObj.val().trim().len()){
			showTip(fileNumberObj[0],"请输入文件编号");
			return false;
		}
		if(0 == fileNameObj.val().trim().len()){
			showTip(fileNameObj[0],"请输入文件名称");
			return false;
		}
	}else{
		fileNumberObj.val("");
		fileNameObj.val("");
	}
  if(document.all.sopcode.value==""){
  		rdShowMessageDialog("请选择授权业务");
		return;
  }
	if(document.all.agt_bz.value=="0")
	{
		if(document.all.login_no.value==""){
			rdShowMessageDialog("请选择工号");
			return;
		}
		if(document.all.op_type.value=="0")
		{
			if(document.all.begin_time.value.length!=17)
			{
				rdShowMessageDialog("请输入正确的开始时间!");
				return;
			}
			if(document.all.end_time.value.length!=17)
			{
				rdShowMessageDialog("请输入正确的结束时间!");
				return;
			}
		
		}
		
	}
	if(document.all.agt_bz.value=="1")
	{
		if(document.all.agt_login.value==""){
			rdShowMessageDialog("请选择工号!");
			return;
		}
	}
	document.frm.action="f8302_2.jsp";
 	frm.submit();
	
}
 
function checkFileChg(){
	var chooseVal = $("#checkFile").val();
	if("1" == chooseVal){
		$("#fileObj").show();
	}else{
		$("#fileObj").hide();
	}
}

//-->
</script>

</head>


<body>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">主动授权</div>
	</div>
	<table cellspacing="0" >
		<tr id="agt_dis"> 
			<td class="blue" >区县</td>
			<td > 
				<SELECT id="district_code" name="district_code"   onchange="districtChange();" v_name="区县名称">  
					<option value ="">--请选择--</option>
					<%for(int i = 0 ; i < districtStr.length ; i ++){%>
					<option value="<%=districtStr[i][0]%>"><%=districtStr[i][1]%></option>
					<%}%>
				</select>
			</td>
			<td class="blue" >营业厅</td>
			<td >
				<select name="stownCode" class="button" id="stownCode" onchange="townchange();"></select>
			</td>
		</tr>
		<tr id="agt_no"> 
			<td class="blue" >工号</td>
			<td > 
				<select name="agt_login" class="button" id="agt_login" ></select>
				<font color="#FF0000">*</font>
			</td>
			<td class="blue">工号模糊搜索</td>
			<td >
				<input name="blurSearchOne" id="blurSearchOne" value="请输入查询条件"
				 onFocus="frm.blurSearchOne.value='';clearResults();" 
			 	  onkeyup="blurSearchFunc('agt_login','blurSearchOne')" />
			</td>
		</tr>
		<tr id="zy_no"> 
			<td class="blue" >工号</td>
			<td> 
				<SELECT id="login_no" name="login_no"   v_name="工号">  
				<option value="">---请选择--- </option>
				<%for(int i = 0 ; i < loginStr.length ; i ++){%>
				<option value="<%=loginStr[i][0]%>"><%=loginStr[i][0]%>--><%=loginStr[i][1]%></option>
				<%}%>
				</select> 
				<font color="#FF0000">*</font>
			</td>
			<td class="blue">
				工号模糊搜索
			</td>
			<td>
				<input name="blurSearch" id="blurSearch" value="请输入查询条件"
				 onFocus="frm.blurSearch.value='';clearResults();" 
			 	  onkeyup="blurSearchFunc('login_no','blurSearch')" />
			</td>
		</tr>
		<tr> 
			<td class="blue" >授权业务</td>
			<td colspan="3"> 
				<SELECT id="sopcode" name="sopcode"  v_name="授权业务"> 
				<option value="">---请选择--- </option> 
				<%for(int i = 0 ; i < opcodeStr.length ; i ++){%>
				<option value="<%=opcodeStr[i][0]%>"><%=opcodeStr[i][1]%></option>
				<%}%>
				</select> 
			</td>
		</tr>
		<tr id="zy_opcode"> 
			<td class="blue" >授权方式 </td>
			<td colspan="3">
			<select name="op_type" onchange="optypechg()">
			<option value="1"> 按次 </option>
			<option value="0"> 按时间段 </option>
			</select>
			</td>
		</tr>	
		<tr bgcolor="F5F5F5" id="zy_time"> 
			<td class="blue" >开始时间</td>
			<td >
				<input type="text"  v_format="date_time"  class="button" 
					v_name="开始时间"  name="begin_time" value="<%=dateStr%>" 
					size="18" maxlength="17"></td>
			<td class="blue" >结束时间</td>
			<td>
				<input type="text"  v_format="date_time"  class="button" 
					v_name="结束时间"  name="end_time" value="<%=endStr%>" 
					size="18" maxlength="17">
			</td>
		</tr>	
		<tr id="zy_note">
			<td colspan="4">
				<font color="#FF0000">注:时间格式为:YYYYMMDD HH24:MI:SS 时间段为早七点至晚七点之间</font>
			</td>	
		</tr>
		<tr id="cs_cs"> 
			<td class="blue" >授权次数</td>
			<td colspan="3"> 
			<input type="text" name="op_count" readonly value="1">
			</td>
		</tr>	
		<tr>
			<td class="blue" >授权原因</td>
			<td colspan="3">
				<input type="text" name="grantReason" id="grantReason" maxlength="255" 
					size="100" v_must="1" v_type="string" onblur="checkElement(this)" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue" >是否具有审批文件</td>
			<td colspan="3">
				<select name="checkFile" id="checkFile" onchange="checkFileChg()">
					<option value="1">是</option>
					<option value="0">否</option>
				</select>
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr id="fileObj">
			<td class="blue" >文件编号</td>
			<td>
				<input type="text" name="fileNumber" id="fileNumber" maxlength="50" />
				<font color="#FF0000">*</font>
			</td>
			<td class="blue" >文件名称</td>
			<td>
				<input type="text" name="fileName" id="fileName" maxlength="100" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				<div align="center"> 
				<input name="confirm" type="button" class="b_foot" index="2" value="提交" onClick="printCommit()"  >
				&nbsp; 
				<input name="confirm" type="button" class="b_foot" index="2" value="删除" onClick="deleteCommit()"  >
				&nbsp;
				<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
				&nbsp; 
				</div>
			</td>
		</tr>
	</table>
	<input type="hidden" name="agt_bz">  
	<%@ include file="../../npage/public/pubSearchText.jsp" %>
	<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>