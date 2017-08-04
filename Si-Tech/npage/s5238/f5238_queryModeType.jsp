<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-18
********************/
%>
              
<%
  String opCode = "5238";
  String opName = "个人产品配置";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 
	
<%@page contentType="text/html;charset=gb2312"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String[][] result = new String[][]{};
	 
	String regionCode = (String)session.getAttribute("regCode");
	
	String region_code = request.getParameter("region_code");
	String retToField = request.getParameter("retToField");
	String queryFlag = request.getParameter("queryFlag")==null?"":request.getParameter("queryFlag");
	String smCodeCond = request.getParameter("smCodeCond")==null?"":request.getParameter("smCodeCond");
	String modeTypeCond = request.getParameter("modeTypeCond")==null?"":request.getParameter("modeTypeCond");
	String modeTypeNameCond = request.getParameter("modeTypeNameCond")==null?"":request.getParameter("modeTypeNameCond");
	String sqlStr1="";
	String whereStr=" and 1=1 ";

    if(!(queryFlag.equals("Y")))
	{
	    whereStr = " and 1=1 ";
	}
    if(!(smCodeCond.equals("")))
	{
	    whereStr = whereStr +  " and sm_code='"+smCodeCond+"'";
	}

	whereStr = whereStr + " and mode_type like '%"+modeTypeCond+"%'";
	whereStr = whereStr + " and type_name like '%"+modeTypeNameCond+"%'";

	sqlStr1 ="select mode_type,type_name from sBillModeType where region_code='"+region_code+"'";
	sqlStr1 = sqlStr1+whereStr;
	//retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
	%>
	
	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t2" scope="end"/>
	
	<%
	System.out.println("----------code------------"+code);
	System.out.println("----------msg------------"+msg);
		
	String[][] retListString1 = new String[][]{};
	if(result_t2.length>0&&code.equals("000000"))
	retListString1 = result_t2;
%>



<head>
<title>资费类型查询</title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">


</head>
<body>
<form name="frm" method="POST" >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">选择操作类型</div>
	</div>
<table id="mainThree" cellspacing="0" >
    <tr>	    
		<TD   class="blue">业务品牌</TD>
	  	<TD   colspan=3>
		  <input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=2 v_name="品牌代码"  name=smCodeCond value="<%=smCodeCond%>" maxlength=10 size="10" readonly Class="InputGrey">
	  	  <input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="品牌代码"  name=smNameCond value="" maxlength=20 readonly Class="InputGrey">
		  <input  type="button" class="b_text" name="query_smcode" onclick="querySmCode()" value="选择">
		</TD>
	</tr>
	<tr>	    
		<TD  class="blue">资费类型</TD>
	  	<TD>
		  <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=10 v_name="资费类型"  name=modeTypeCond maxlength=10 value="" >
		</TD>
		<TD  class="blue">类型名称</TD>
	  	<TD>
		    <input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=25 v_name="类型名称"  name=modeTypeNameCond maxlength=25 value="" >
		</TD>
	</tr>
	<tr>
		<td colspan=4 id="footer">
		    <div align="center">
			  <input type="button" name="commit" onClick="doQuery();" value=" 查询 " class="b_foot" >
			  &nbsp;
			  <input type="button" name="back" onClick="doReset();" value=" 重置 " class="b_foot" >
		    </div>
		</td>
	</tr>
</table>
<table  id="tab1" cellspacing="0">
	<tr >
		<th align="center">
			选择
		</th>
		<th  align="center">
			类型代码
		</th>
		<th align="center">
			类型名称
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td id="footer">
				<div align="center">
			      <input type="button" name="commit" onClick="doCommit();" value=" 确定 " class="b_foot"/>
			      &nbsp;
			      <input type="button" name="back" onClick="window.close();" value=" 关闭 " class="b_foot"/>
		    </div>
		</td>
	</tr>
</table>
<%@ include file="/npage/include/footer_simple.jsp" %>
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
			newrow.insertCell(0).innerHTML ='<input type="radio" name="num" value="<%=i%>">'+str;
		  newrow.insertCell(1).innerHTML = '<%=retListString1[i][0]%>';
		  newrow.insertCell(2).innerHTML = '<%=retListString1[i][1]%>';
		<%}%>
		</script>
<script>
	  

		function doCommit(){
			if("<%=retListString1.length%>"=="0"){
				rdShowMessageDialog("您没有选择代码！");
				return false;
			}
			var selCodeArr = document.getElementsByName("sel_code");
			var selNameArr = document.getElementsByName("sel_name");
			var numArr = document.getElementsByName("num");

			var a=-1;
			for(i=0;i<numArr.length;i++){
			  if(numArr[i].checked){
			      a=i;
				  break;
			  }
			}
            var retInfo=selCodeArr[a].value+"|"+selNameArr[a].value+"|";
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

