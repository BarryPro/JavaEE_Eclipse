<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-19
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*"%>
<%
	//读取用户session信息
String regionCode = (String)session.getAttribute("regCode");
	
	String login_accept = request.getParameter("login_accept");
	String mode_code = request.getParameter("mode_code");
	String region_code = request.getParameter("region_code");
 	
 	
 	//获取已有信息
    String sqlStr="";

	sqlStr = "select flag_code,op_code from tMidsModeFlagCode where login_accept="+login_accept;

//	retList = callView.sPubSelect("2",sqlStr);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>

<%	
	String[][] result = new String[][]{};

		
	if(code1.equals("000000")&&result_t2.length>0)
		result= result_t2;
%>

<html>
<head>
<base target="_self">
<title>包年小区配置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 

//-----提交配置-----
function doSubmit()
{	
    var flag_codes = new Array();
	var op_codes = new Array();

    var checkbox1Obj = document.getElementsByName("checkbox1");
	var flag_codesObj= document.getElementsByName("flag_codes");
	var op_codesObj= document.getElementsByName("op_codes");
	
    var j=0;

    for(var i=0;i<checkbox1Obj.length;i++)
    {
			if(checkbox1Obj[i].checked)
			{	
				flag_codes[j]=flag_codesObj[i].value;
				op_codes[j]=op_codesObj[i].value;
				j++;
			}	
	}
	document.form1.flag_codes_list.value=flag_codes;
	document.form1.op_codes_list.value=op_codes;
	if(j<1)
	{
	    rdShowMessageDialog("请添加记录！",0);
		return;
	}
	document.form1.action="f5238_opModeFlag_submit.jsp"; 
	document.form1.submit();
}

//组合在下面显示出来
function addModeFlag()
{
	if(document.form1.flag_code.value=="") 
	{
		rdShowMessageDialog("请输入二批代码！",0);
		document.form1.flag_code.focus();
		return;
	}
	if(document.form1.op_code.value=="") 
	{
		rdShowMessageDialog("请输入业务代码！",0);
		document.form1.op_code.focus();
		return;
	}
	
	var rows = document.getElementById("mainFour").rows.length;
	var newrow = document.getElementById("mainFour").insertRow(rows);
	newrow.height="20";
	newrow.align="left";
	
	newrow.insertCell(0).innerHTML ='<input type="checkbox" name="checkbox1" checked onClick="del(this)">';
	newrow.insertCell(1).innerHTML ='<input type="text" name="flag_codes" size="6" class="InputGrey" readonly value="'+ document.form1.flag_code.value +'">';
	newrow.insertCell(2).innerHTML ='<input type="text" name="op_codes" size="6" class="InputGrey" readonly value="'+ document.form1.op_code.value +'">';
}
function del(obj)
{
 if(rdShowConfirmDialog("是否删除此组合？")=="1")
	{
	var args=del.arguments[0];
	var objTD =args.parentElement;
	var objTR =objTD.parentElement;
	var currRowIndex = objTR.rowIndex;
	mainFour.deleteRow(currRowIndex);
	}
	else{
	del.arguments[0].checked=true;	
	}
}

/**查询二批代码**/
function queryFlagCode()
{
    var pageTitle = "二批代码查询";
    var fieldName = "二批代码|名称|";
    var sqlStr ="select detail_code,note from tMidBillModeDetCode  where login_accept=<%=login_accept%> and detail_type='0' ";
	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "1|0|";
    var retToField = "flag_code|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
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
	return true;
}

</script>
</head>

<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	  <form name="form1"  method="post">
	<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">产品（<%=mode_code%>）包年小区配置</div>
	</div>
 
	
	  <input type="hidden" name="flag_codes_list" value="">
	  <input type="hidden" name="op_codes_list" value="">
	  <input type="hidden" name="region_code" value="<%=region_code%>">
 
	  		  	<TABLE  id="mainOne" cellspacing="0" >
	            <TBODY>
				    <tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;配置流水</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="配置流水" name="login_accept" maxlength=8 value="<%=login_accept%>" readonly></input>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;资费代码</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=255 v_name="资费代码" name="mode_code" maxlength=8 value="<%=mode_code%>" readonly></input>
	  					</TD>
	  				</tr>
					<tr >
	  					<TD width="20%" height="22" class="blue">&nbsp;&nbsp;二批代码</TD>
	  					<TD width="80%">
	  						<input type=text  v_type="string" v_must=1 v_minlength=1 v_maxlength=4 v_name="二批代码" name="flag_code" maxlength=4 value="" size="20"></input>
							<input class="b_text" type="button" name="query_flagCode" onclick="queryFlagCode()" value="选择">
	  					</TD>
	  				</tr>
	  				<tr  >
	  					<TD height="22" class="blue">&nbsp;&nbsp;业务代码</TD>
	  					<TD>
	  						<select  name="op_code">
							    <option value="1255">1255</option>
								<option value="1259">1259</option>
							</select>
	  					</TD>
	  				</tr>
					<TR >
	  				    <TD height="30" align="center" colspan="2">
	          				<input name="addButt" type="button" class="b_text" value="添加" onClick="addModeFlag()">
	  					</TD>
	  				</TR>
	            </TBODY>
	          	</TABLE>
				<table id="mainFour" cellspacing="0" >
	  				<tr  height="22">
	  					<Th width="4%">选择</Th>
	  					<Th width="8%">二批代码</Th>
	  					<Th width="8%">业务代码</Th>
	  				</tr>
					<%
					if(result.length>0)
					{
	  					for(int i=0;i<result.length;i++)
						{
					%>
					<tr  height="20"> 
							<td height="20"><input type="checkbox" name="checkbox1" checked onClick="del(this)"></td>
                			<td height="20"> <%=result[i][0]%></td>
                			<td height="20"> <%=result[i][1]%></td>
			    	</tr>
					<%
						}	
					}
					%>
	  			</table>
	          	<TABLE ellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="确定" onClick=" doSubmit()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot" value="取消返回" onClick="window.close();" >
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	  	<%@ include file="/npage/include/footer_pop.jsp" %>
	  </form>
</body>
</html>

