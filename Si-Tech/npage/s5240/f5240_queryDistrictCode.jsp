   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = "产品发布";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	 
String regionCode = (String)session.getAttribute("regCode");	
	String region_code = request.getParameter("region_code");
	String retToField = request.getParameter("retToField");
	
String[][] retListString1 =new String[][]{};
	String sqlStr1 ="select district_code,district_name from sDisCode where region_code='"+region_code+"'";
	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	if(result_t.length>0)
	retListString1 = result_t;
	
%>

<html>
<head>
<title>区县查询</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>
<body>
<form name="frm" method="POST" >
<%@ include file="/npage/include/header_pop.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table  id="tab1" border="0" cellspacing="0">
	<tr >
		<td height="26" align="center" class="blue">
			选择
		</td>
		<td  align="center" class="blue">
			代码
		</td>
		<td align="center" class="blue">
			名称
		</td>
	</tr>
</table>
<table   cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 " class="b_foot">
			      &nbsp;
			      <input type="button" name="back" onClick="doClose();" value=" 关闭 " class="b_foot">
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

<script>
	  
		<%for(int i=0;i < retListString1.length;i++){ %>
			var str='<input type="hidden" name="sel_code" value="<%=retListString1[i][0]%>">';
			str+='<input type="hidden" name="sel_name" value="<%=retListString1[i][1]%>">';

						
			var rows = document.getElementById("tab1").rows.length;
			var newrow = document.getElementById("tab1").insertRow(rows);
			newrow.bgColor="#f5f5f5";
			newrow.height="20";
			newrow.align="center";
			newrow.insertCell(0).innerHTML ='<input type="checkbox" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择代码！");
				return false;
			}
			var selCodeArr = document.getElementsByName("sel_code");
			var selNameArr = document.getElementsByName("sel_name");
			var numArr = document.getElementsByName("num");

            var retCodes = new Array();
			var j=0;
			for(i=0;i<numArr.length;i++)
			{
			    if(numArr[i].checked)
				{
				    retCodes[j]=selCodeArr[i].value;
					j++;
				}
			}

			if(j>0)
			{
			}
			else{
				rdShowMessageDialog("您没有选择地区代码！");
				return false;
			}

            var retInfo=retCodes+"|";
			var retToField = "<%=retToField%>";

			var chPos_field = retToField.indexOf("|");
            var chPos_retStr;
            var valueStr;
            var obj;
            while(chPos_field > -1)
            {
               obj = retToField.substring(0,chPos_field);
               chPos_retInfo = retInfo.indexOf("|");
               valueStr = retInfo.substring(0,chPos_retInfo);
               window.opener.document.all(obj).value = valueStr;
               retToField = retToField.substring(chPos_field + 1);
               retInfo = retInfo.substring(chPos_retInfo + 1);
               chPos_field = retToField.indexOf("|");        
             }

			 window.close();
		}
	
	function doClose(){
		window.close();
	}

function doQuery(){
	var smCodeCond = document.all.smCodeCond.value;
    var modeTypeCond = document.all.modeTypeCond.value;
	var modeTypeNameCond = document.all.modeTypeNameCond.value;
	this.location="f5238_queryModeType.jsp?queryFlag=Y&retToField=<%=retToField%>&region_code=<%=region_code%>"+"&smCodeCond="+smCodeCond+"&modeTypeCond="+modeTypeCond+"&modeTypeNameCond="+modeTypeNameCond;
}

function doReset(){
	document.all.smCodeCond.value="";
	document.all.smNameCond.value="";
	document.all.modeTypeCond.value="";
	document.all.modeTypeNameCond.value="";
}

/**查询品牌**/
function querySmCode()
{
    var pageTitle = "品牌查询";
    var fieldName = "品牌代码|品牌名称|";
    var sqlStr ="select sm_code,sm_name from sSmCode  where region_code='<%=region_code%>' order by sm_code ";
	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "smCodeCond|smNameCond|";
    if(!PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)) return false;

	return true;
}
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/page/public/fPubSimpSel.jsp";
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