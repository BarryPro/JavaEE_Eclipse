<%
/**********************************
	zhangyan@2013/8/14 10:48:10
***********************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
String logacc = sLoginAccept;
String chnSrc = "01";
String opCode =request.getParameter("opCode");
String opName = request.getParameter("opName");
String workNo = (String)session.getAttribute("workNo");
String passwd = (String)session.getAttribute("password");
String regCode = (String)session.getAttribute("regCode");

String ip_Addr = ( String )session.getAttribute( "ipAddr" );
String org_code = ( String )session.getAttribute( "orgCode" );
String sm_code = "va";
%>    
<HTML xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
	<TITLE><%=opName%></TITLE>
	<SCRIPT language = "javascript" type = "text/javascript" src = "/npage/public/zalidate.js"></SCRIPT>
</HEAD>
<BODY>
<FORM  NAME = "frm" ACTION = "" METHOD = "POST" >
<%@ include file="/npage/include/header.jsp" %>	
<DIV ID = "Operation_Table">
	<DIV ID = "d0" NAME = "d0" STYLE = "display:none">
		<DIV class = "title" >
			<DIV id = "title_zi"><%=opName%></DIV>
		</DIV>
		<TABLE>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >操作类型:</TD>
				<TD WIDTH = '25%'>
					<input name=op_type id="op_type" type="radio" value="a" checked >增加&nbsp;&nbsp;
					<input name=op_type id="op_type" type="radio" value="d">删除	
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >计费编号:</TD>
				<TD WIDTH = '25%'>
					<input name=boss_vpmn_code class="button" id="boss_vpmn_code" size="20"  
						v_type=string v_must=1 v_name="计费编号：" ch_name="计费编号" index="2">
					<font color="#FF0000">*</font>   
				</TD>    
			</TR>
			<TR>
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >集团编码:</TD>
				<TD WIDTH = '25%'>
					<input name=unit_id class="button" id="unit_id" size="20" maxlength="10" 
						v_type="0_9" v_must=1 v_name="集团ID" index="3"  ch_name="集团编码"  >
					<input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" 
						onKeyUp="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value=查询>
					<font color="#FF0000">*</font>   
				</TD>    
				<TD WIDTH = '25%' ALIGN = 'CENTER' class = 'blue' >集团名称:</TD>
				<TD WIDTH = '25%'>
					<input class="button" name="grp_name" size="20" readonly v_must=1 v_type=string 
						v_name="客户名称" index="4"  ch_name="集团名称" >
					<font color="#FF0000">*</font>
				</TD>    
			</TR>
			<TR>
				<TD COLSPAN = '4' ALIGN = 'CENTER' ID = 'footer'>
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '确认' onClick = 'doCfm()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '重置' onClick = 'doRet()' />   
					<INPUT TYPE = 'BUTTON' ID = '' NAME= '' CLASS = 'b_foot' VALUE = '关闭' onClick = 'removeCurrentTab();' />
				</TD>
			</TR>        
		</TABLE>
	</DIV>
	<DIV ID = 'queryDiv' ></DIV>
	<INPUT TYPE = 'HIDDEN' ID = 'logacc' NAME = 'logacc' VALUE = '<%=logacc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'chnSrc' NAME = 'chnSrc' VALUE = '<%=chnSrc%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opCode' NAME = 'opCode' VALUE = '<%=opCode%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'opName' NAME = 'opName' VALUE = '<%=opName%>'/>
	<INPUT TYPE = 'HIDDEN' ID = 'del_pho1' NAME = 'del_pho1' VALUE = ''/>
	
	<INPUT TYPE = 'HIDDEN' ID = 'del_pho2' NAME = 'del_pho2' VALUE = ''/>	
	
	<input type="hidden" name="belong_code"  value="">
	<input type="hidden" name="unit_name"  value="">
	<input type="hidden" name="group_id"  value="">
	<input type="hidden" name="op_code"  value="3673">
	<input type="hidden" name="OrgCode"  value="<%=org_code%>">
	<input type="hidden" name="WorkNo"   value="<%=workNo%>">
	<input type="hidden" name="ip_Addr"  value=<%=ip_Addr%>>
	<input type="hidden" name="sm_code"  value=<%=sm_code%>>		
</DIV>
<%@ include file="/npage/include/footer_new.jsp" %>
</FORM>
<SCRIPT>
var stepNum = 0;
$( document ).ready(
	function ()
	{
		$( "#d0" ).show( "300" );
		stepNum = stepNum + 1;
	}
);

function doRet()
{
	document.frm.action = "#";
	document.frm.submit();	
}

function doCfm ()
{
	if ( fn_notNull ( document.all.unit_id )!= 0 ) return ;
	if ( fn_forInt ( document.all.unit_id ) != 0 ) return ;
	if ( fn_notNull ( document.all.boss_vpmn_code )!= 0 ) return ;
	if ( fn_notNull ( document.all.grp_name )!= 0 ) return ;

	page = "s3673_2.jsp";
	frm.action=page;	
	frm.method="post";
	frm.submit();	
}

function getInfo_Cust()
{
	var pageTitle = "集团客户选择";
	var fieldName = "集团ID|集团名称|归属地|归属组织|";
	var sqlStr = "";
	var selType = "S";    //'S'单选；'M'多选
	var retQuence = "4|0|1|2|3|";
	var retToField = "unit_id|unit_name|belong_code|group_id|";
	
	if ( fn_notNull ( document.all.unit_id )!= 0 ) return ;
	if ( fn_forInt ( document.all.unit_id ) != 0 ) return ;
	
	if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var path = "f3673_cust_sel.jsp";
	path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
	path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
	path = path + "&selType=" + selType;
	path = path + "&opName=<%=opName%>";
	
    path = path + "&logacc=" + "0";  
    path = path + "&chnSrc=" + "01";  
    path = path + "&opCode=" + "<%=opCode%>";  
    path = path + "&workNo=" + "<%=workNo%>";  
    path = path + "&passwd=" + "<%=passwd%>";  
    
    path = path + "&phoneNo=" + "";  
    path = path + "&usrPwd=" + "";  
    path = path + "&unitId=" + $("#unit_id").val();
    path = path + "&icustid=" + "";
    path = path + "&idIccId=" + "";
    
    path = path + "&bizCodAdd=" + "";
    path = path + "&oprCode=" + "<%=opCode%>";
    path = path + "&svcNo=" + "";
    path = path + "&grpId=" + "";
    path = path + "&regCode=" + "";
    
    path = path + "&startPos=" + "1";
    path = path + "&endPos=" + "26";
    path = path + "&qryType=" + "2";
    path = path + "&pntType=" + "";
    path = path + "&accType=" + "";
    path = path + "&smCode=" + "";
    
    path = path + "&vpmnNo=" + "";
    path = path + "&cnocNo=" + "";
    path = path + "&other=" + "";
    path = path + "&opNote=" + "";

retInfo = window.open(path,"newwindow","height=450, width=800,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
	getvaluecust(retIfo);
	return true;
}

function getvaluecust(retInfo)
{
	var retToField = "unit_id|unit_name|belong_code|group_id|";
	
	if(retInfo ==undefined)
	{
		return false;
	}

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
	document.all.grp_name.value = document.all.unit_name.value;
}

</SCRIPT>
</BODY>
</HTML>