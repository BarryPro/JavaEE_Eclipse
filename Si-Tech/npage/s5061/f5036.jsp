<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-12-18 :14:25
********************/
%>
<%@ page contentType="text/html;charset=gbk"%>  
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<html>
<head>




<%@ include file="/npage/common/pwd_comm.jsp" %>

<%
	
 
	String loginNo = (String)session.getAttribute("workNo");
  String regionCode =(String)session.getAttribute("regCode");
  
  String prtSql = "";
  prtSql="select region_name from sregioncode where region_code='"+regionCode+"'";
  %>
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
   <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=prtSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
  <%
  String paraStr=sysAcceptl;
  String regionName = "";
  if(result_t.length>0&&result_t[0][0]!=null)
	regionName = result_t[0][0];
 
	List al = null;
	String[][] smCodeData = new String[][]{};

	//主资费
	String[][] modeCodeData = new String[][]{};
	//sfav1860Cfg表中已经配制资费
	String[][] modeCode1860Data = new String[][]{};

	int		isGetDataFlag = 1;	//0:正确,其他错误. add by yl.
	String errorMsg ="";
	String tmpStr="";

	StringBuffer  insql = new StringBuffer();
	
dataLabel:
	while(1==1){	
		//1.SQL 查询主资费
		insql.delete(0,insql.length());
 
			//insql.append("select trim(a.mode_code),a.mode_code||'-->'||a.mode_name from sbillmodecode a where a.mode_flag = '0' ");
			//insql.append(" and a.region_code='"+ regionCode +"' order by a.mode_code");
			insql.append("SELECT trim(a.offer_id),a.offer_id||'-->'||a.offer_name");
			insql.append("    FROM product_offer a, region b, sregioncode c      ");
			insql.append("   WHERE a.offer_id = b.offer_id                       ");
			insql.append("     AND c.GROUP_ID = b.GROUP_ID                       ");
			insql.append("     AND c.region_code = '01'                          ");
			insql.append("     AND a.offer_type = '10'                           ");
			insql.append("ORDER BY a.offer_id                                    ");
 
	%>
	
   <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=insql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>	
	
	<%	
		 
		modeCodeData = result_t;
	
		//1.SQL 查询1860主资费
		insql.delete(0,insql.length());
		//insql.append("select trim(a.MODE_CODE)||trim(a.FAV_TYPE),nvl(trim(a.FAV_CHAR),'NULL') from sfav1860cfg a, sbillmodecode b where trim(a.MODE_CODE) = trim(b.MODE_CODE) ");
		insql.append("select trim(a.MODE_CODE)||trim(a.FAV_TYPE),nvl(trim(a.FAV_CHAR),'NULL') from sfav1860cfg a,product_offer b where trim(a.mode_code) = trim(to_char(b.offer_id)) ");
		insql.append(" and a.region_code='"+ regionCode +"'");
		
 
		isGetDataFlag = 0;
 		break;
 }	
 %>



<title><%=opName%></title>


</head>
<script language=javascript>
function showWorldMsg()
{
     if( document.all.r_cus[0].checked){}
}
</script>
<script language=javascript>
 
function replaceSpacialCharacter(source)
{
	source = source.replace("#","%23");
	source = source.replace("&","%26");
	source = source.replace("+","%2b");
	source = source.replace("?","%3f");
	source = source.replace("_","%5f");
	source = source.replace('"',"%22");
	source = source.replace("'","%27");
	return source;
}
 
function call_funcQuery()
{
  var mode_code = (document.all.modecode.value).trim();
  mode_code =  replaceSpacialCharacter(mode_code);
  var req_url = "post5036.jsp";
  var myPacket = new AJAXPacket(req_url,"正在查询资费代码信息，请稍候......");
	myPacket.data.add("region_code",(document.all.region_code.value).trim());
	myPacket.data.add("modeCode",mode_code);
	myPacket.data.add("feeType",(document.all.feeType.value).trim());
	myPacket.data.add("typecode","call_funcQuery");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}


 //--------4---------doProcess函数----------------
function doProcess(packet)
{
    var vRetPage=packet.data.findValueByName("rpc_page");  
	  
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");

	var fav_char = packet.data.findValueByName("fav_char");
	var fav_call = packet.data.findValueByName("fav_call");
	var fav_save1 = packet.data.findValueByName("fav_save1");
	var fav_type = packet.data.findValueByName("fav_type");
	var typecode = packet.data.findValueByName("typecode");
	
	if(typecode == "call_funcQuery")
	{
		if(retCode == 0){
			document.all.fav_char.value = fav_char;
			document.all.fav_call.value = fav_call;
			document.all.fav_save1.value = fav_save1;
			document.all.feeType.value = fav_type;
			document.all.confirm.disabled=false;
			changeFeeType(false);
		}
		else
		{
			document.all.fav_char.value = "";
			document.all.fav_call.value = "";
			document.all.fav_save1.value = "";	
			//document.all.feeType.value = "0";
			document.all.confirm.disabled=true;
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
		}
		return;
	}
	if(typecode == "getModeList")
	{
		var errorCode = packet.data.findValueByName("errorCode");
		var errorMsg = packet.data.findValueByName("errorMsg");
		if(errorCode != "0000")
		{
			rdShowDialogMessage("["+errorCode+"]:"+errorMsg);
			return;
		}
		else
		{
			var values = packet.data.findValueByName("values");
			var names = packet.data.findValueByName("names");
			clearoption(document.all.modecode);
			fillDropDown(document.all.modecode,values,names);
			document.all.feeType.value = '';
			return;
		}
	}
	
	
    
}

//-------2---------验证及提交函数-----------------

function printCommit(){

	//校验
	if(document.forms[0].opType.value == "")
	{
		rdShowMessageDialog("请选择操作类型!");
		return false;
	}
	if(document.all.modecode.value == "")
	{
		rdShowMessageDialog("请选择资费代码!");
		return false;
	}
	
	if(document.all.feeType.value == "")
	{
		rdShowMessageDialog("请选择优惠类型!");
		return false;
	}

	
	if((document.all.fav_char.value).trim() == "")
	{
		rdShowMessageDialog("优惠对象不能为空!");
		return false;
	}
	
	if((document.all.fav_call.value).trim() == "")
	{
		rdShowMessageDialog("该字段不能为空!");
		document.all.fav_call.focus();
		return false;
	}
	
	if((document.all.fav_save1.value).trim() == "")
	{
		rdShowMessageDialog("该字段不能为空!");
		document.all.fav_save1.focus();
		return false;
	}
	
	

  //打印工单并提交表单
  document.all.t_sys_remark.value="操作信息串:"+document.all.region_code.value+document.all.opType.value+ document.all.modecode.value;
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
	     	f5036.submit();
       }
    return true;
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

function getModeList()
{
	var op_type = document.forms[0].opType.value;
	if(op_type != "")
	{
		if(op_type == "a")
		{
			document.all.confirm.disabled=false;
			document.all.funcQuery.disabled=true;
		}
		else
		{
			document.all.confirm.disabled=true;
			document.all.funcQuery.disabled=false;
		}
		
		var myPacket = new AJAXPacket("f5036_rpc.jsp","正在获取数据，请稍候......");
		myPacket.data.add("regionCode",document.all.region_code.value);
		myPacket.data.add("opType",op_type);
		myPacket.data.add("typecode","getModeList");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
}
 
 
function changeModeCode()
{
	document.all.feeType.value= "";
	changeFeeType(true);
}

function changeFeeType(clear)
{
	var FeeTypeText = new Array(
					new Array('参数1','','参数2',''),
					new Array('参数1','包年填0','参数2','包年填0'),
					new Array('优惠费用','','包月费用',''),
					new Array('底限费用','','参数2','可以填0'),
					new Array('参数1','可以填0','参数2','可以填0')
					);
	if(clear)
	{
		document.all.fav_call.value = "";
		document.all.fav_save1.value = "";
	}
	var index = document.all.feeType.value;
	if(index == "")
	{
		index = -1;
	}
	index++;
	var fav_call_text = document.getElementById("fav_call_text");
	if(fav_call_text)
	{
		fav_call_text.innerHTML = FeeTypeText[index][0];
	}
	var fav_call_help = document.getElementById("fav_call_help");
	if(fav_call_help)
	{
		fav_call_help.innerHTML = FeeTypeText[index][1];
	}
	var fav_save1_text = document.getElementById("fav_save1_text");
	if(fav_save1_text)
	{
		fav_save1_text.innerHTML = FeeTypeText[index][2];
	}
	var fav_save1_help = document.getElementById("fav_save1_help");
	if(fav_save1_help)
	{
		fav_save1_help.innerHTML = FeeTypeText[index][3];
	}
	
}

 //-->
</script>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
<form action="f5036BackCfm.jsp" method="POST" name="f5036"  onKeyUp="chgFocus(f5036)">
	<%@ include file="/npage/include/header.jsp" %>                         

	<input type="hidden" name="op_code" id="op_code" value="<%=opCode%>">
	<input type="hidden" name="region_code" id="region_code" value="<%=regionCode%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<input type="hidden" name="loginAccept" value="<%=paraStr%>">
	<div class="title">
		<div id="title_zi">客服系统套餐配制</div>
	</div>
        <table cellspacing="0">
              <tr>
            <td class="blue">地市代码</td>
            <td> 
              <input name="regionName" type="text"  id="regionName" value="<%=regionName%>" maxlength="2" readonly>
            </td>           
            <td class="blue">操作类型</td>
            <td><select name="opType"  id="opType" onchange="getModeList()">
            	  <option value="">请选择</option>
                <option value="a">添加</option>
                <option value="m">修改</option>
                <option value="d">删除</option>
              </select> 
              </td>
          </tr>
      	  <tr> 
      	  <td class="blue">优惠类型</td>
            <td><select name="feeType"  id="feeType" onchange="changeFeeType(true)">
            	  <option value="">请选择</option>
                <option value="0">包年</option>
                <option value="1">包月</option>
                <option value="2">底限</option>
                <option value="3">动感地带</option>
             	</select> 
            </td>
            <td class="blue">优惠对象</td>
            <td>
            <input name="fav_char" type="text"  id="fav_char" maxlength="200" size="45">
            </td>
          </tr>
          <tr> 
      		<td class="blue">资费代码</td>
            <td> 
              <select name="modecode"  id="modecode" onchange="changeModeCode()">
              </select>
            </td>
            <td><input name="funcQuery" type="button" id="funcQuery" class="b_text" value="查询" onClick="call_funcQuery()"   disabled ></td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td class="blue"><div id="fav_call_text">参数1</div></td>
            <td> <input name="fav_call" type="text"  id="fav_call" maxlength="15"> <span style="width:50px;" />
            	<div id="fav_call_help"></div>
            </td>
            <td class="blue"><div id="fav_save1_text">参数2</div></td>
            <td> <input name="fav_save1" type="text"  id="fav_save1" > <span style="width:50px;" />
            	<div id="fav_save1_help"></div>
            	</td>
          </tr>         
          <tr> 
            <td valign="top" class="blue"> 
              <div align="left">系统备注</div>
            </td>
            <td colspan="4" valign="top"> 
              <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
            </td>
          </tr>
          <tr> 
            <td colspan="4" height="30"> 
              <div align="center"> 
                <input  type="button" class="b_foot_long" name="confirm" value="打印&确认"  onClick="printCommit()" index="26" disabled >
                <input  type=reset class="b_foot" name=back value="清除" onClick="document.all.confirm.disabled=true;" >
                <input  type="button" class="b_foot" name="b_back" value="返回"  onClick="removeCurrentTab()" index="28">
              </div>
            </td>
          </tr>
        </table>
 <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>

</html>
