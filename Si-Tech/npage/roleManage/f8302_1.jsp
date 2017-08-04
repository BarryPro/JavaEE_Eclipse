<%
/********************
 version v2.0
������: si-tech
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
	String opName = "������Ȩ";
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
  	agt_info="1";/*1�������,0��������*/
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
		alert("�˹���û��������ȨȨ��!");
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
<title>������Ȩ</title>
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
		var myPacket = new AJAXPacket("f8302_rpc.jsp","���ڻ�ȡ���ݣ����Ժ�......");
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
		var myPacket = new AJAXPacket("f8302_rpc.jsp","���ڻ�ȡ���ݣ����Ժ�......");
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
			rdShowMessageDialog("�������ֻ�ܰ�����Ȩ!");
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
    var option1 = new Option('--��ѡ��--','');
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
			showTip(fileNumberObj[0],"�������ļ����");
			return false;
		}
		if(0 == fileNameObj.val().trim().len()){
			showTip(fileNameObj[0],"�������ļ�����");
			return false;
		}
	}else{
		fileNumberObj.val("");
		fileNameObj.val("");
	}
  if(document.all.sopcode.value==""){
  		rdShowMessageDialog("��ѡ����Ȩҵ��");
		return;
  }
	if(document.all.agt_bz.value=="0")
	{
		if(document.all.login_no.value==""){
			rdShowMessageDialog("��ѡ�񹤺�");
			return;
		}
		if(document.all.op_type.value=="0")
		{
			if(document.all.begin_time.value.length!=17)
			{
				rdShowMessageDialog("��������ȷ�Ŀ�ʼʱ��!");
				return;
			}
			if(document.all.end_time.value.length!=17)
			{
				rdShowMessageDialog("��������ȷ�Ľ���ʱ��!");
				return;
			}
		
		}
		
	}
	if(document.all.agt_bz.value=="1")
	{
		if(document.all.agt_login.value==""){
			rdShowMessageDialog("��ѡ�񹤺�!");
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
		<div id="title_zi">������Ȩ</div>
	</div>
	<table cellspacing="0" >
		<tr id="agt_dis"> 
			<td class="blue" >����</td>
			<td > 
				<SELECT id="district_code" name="district_code"   onchange="districtChange();" v_name="��������">  
					<option value ="">--��ѡ��--</option>
					<%for(int i = 0 ; i < districtStr.length ; i ++){%>
					<option value="<%=districtStr[i][0]%>"><%=districtStr[i][1]%></option>
					<%}%>
				</select>
			</td>
			<td class="blue" >Ӫҵ��</td>
			<td >
				<select name="stownCode" class="button" id="stownCode" onchange="townchange();"></select>
			</td>
		</tr>
		<tr id="agt_no"> 
			<td class="blue" >����</td>
			<td > 
				<select name="agt_login" class="button" id="agt_login" ></select>
				<font color="#FF0000">*</font>
			</td>
			<td class="blue">����ģ������</td>
			<td >
				<input name="blurSearchOne" id="blurSearchOne" value="�������ѯ����"
				 onFocus="frm.blurSearchOne.value='';clearResults();" 
			 	  onkeyup="blurSearchFunc('agt_login','blurSearchOne')" />
			</td>
		</tr>
		<tr id="zy_no"> 
			<td class="blue" >����</td>
			<td> 
				<SELECT id="login_no" name="login_no"   v_name="����">  
				<option value="">---��ѡ��--- </option>
				<%for(int i = 0 ; i < loginStr.length ; i ++){%>
				<option value="<%=loginStr[i][0]%>"><%=loginStr[i][0]%>--><%=loginStr[i][1]%></option>
				<%}%>
				</select> 
				<font color="#FF0000">*</font>
			</td>
			<td class="blue">
				����ģ������
			</td>
			<td>
				<input name="blurSearch" id="blurSearch" value="�������ѯ����"
				 onFocus="frm.blurSearch.value='';clearResults();" 
			 	  onkeyup="blurSearchFunc('login_no','blurSearch')" />
			</td>
		</tr>
		<tr> 
			<td class="blue" >��Ȩҵ��</td>
			<td colspan="3"> 
				<SELECT id="sopcode" name="sopcode"  v_name="��Ȩҵ��"> 
				<option value="">---��ѡ��--- </option> 
				<%for(int i = 0 ; i < opcodeStr.length ; i ++){%>
				<option value="<%=opcodeStr[i][0]%>"><%=opcodeStr[i][1]%></option>
				<%}%>
				</select> 
			</td>
		</tr>
		<tr id="zy_opcode"> 
			<td class="blue" >��Ȩ��ʽ </td>
			<td colspan="3">
			<select name="op_type" onchange="optypechg()">
			<option value="1"> ���� </option>
			<option value="0"> ��ʱ��� </option>
			</select>
			</td>
		</tr>	
		<tr bgcolor="F5F5F5" id="zy_time"> 
			<td class="blue" >��ʼʱ��</td>
			<td >
				<input type="text"  v_format="date_time"  class="button" 
					v_name="��ʼʱ��"  name="begin_time" value="<%=dateStr%>" 
					size="18" maxlength="17"></td>
			<td class="blue" >����ʱ��</td>
			<td>
				<input type="text"  v_format="date_time"  class="button" 
					v_name="����ʱ��"  name="end_time" value="<%=endStr%>" 
					size="18" maxlength="17">
			</td>
		</tr>	
		<tr id="zy_note">
			<td colspan="4">
				<font color="#FF0000">ע:ʱ���ʽΪ:YYYYMMDD HH24:MI:SS ʱ���Ϊ���ߵ������ߵ�֮��</font>
			</td>	
		</tr>
		<tr id="cs_cs"> 
			<td class="blue" >��Ȩ����</td>
			<td colspan="3"> 
			<input type="text" name="op_count" readonly value="1">
			</td>
		</tr>	
		<tr>
			<td class="blue" >��Ȩԭ��</td>
			<td colspan="3">
				<input type="text" name="grantReason" id="grantReason" maxlength="255" 
					size="100" v_must="1" v_type="string" onblur="checkElement(this)" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr>
			<td class="blue" >�Ƿ���������ļ�</td>
			<td colspan="3">
				<select name="checkFile" id="checkFile" onchange="checkFileChg()">
					<option value="1">��</option>
					<option value="0">��</option>
				</select>
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr id="fileObj">
			<td class="blue" >�ļ����</td>
			<td>
				<input type="text" name="fileNumber" id="fileNumber" maxlength="50" />
				<font color="#FF0000">*</font>
			</td>
			<td class="blue" >�ļ�����</td>
			<td>
				<input type="text" name="fileName" id="fileName" maxlength="100" />
				<font color="#FF0000">*</font>
			</td>
		</tr>
		<tr> 
			<td colspan="4"> 
				<div align="center"> 
				<input name="confirm" type="button" class="b_foot" index="2" value="�ύ" onClick="printCommit()"  >
				&nbsp; 
				<input name="confirm" type="button" class="b_foot" index="2" value="ɾ��" onClick="deleteCommit()"  >
				&nbsp;
				<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�">
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