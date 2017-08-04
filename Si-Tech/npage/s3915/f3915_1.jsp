<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.23
 模块: MAS/ADC业务暂停/恢复功能
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>MAS/ADC业务暂停/恢复功能</TITLE>
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	String opCode  =request.getParameter("opCode");
	String opName  =request.getParameter("opName");
	
%>

</HEAD>

<body>
<SCRIPT language="JavaScript">
	var params = "";
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var theFirstRetToField=retToField;
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    注意：sql的校验，防止sql注射
    使用window.open实现新窗口的打开，否则opener不生效.
    可通过opener.arg4.values=''赋值
    */
    var path = "/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    path += "&params="+params;
    
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
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
} 
function doCheck()
{	
	if(document.frm.condText.value=="")
	{	
		rdShowMessageDialog("请输入查询条件！");
		document.frm.condText.select();
		return false;
	}
	else
	{
	    var pageTitle = "集团查询";
	    var fieldName = "集团编号|集团名称|集团地址|客户ID|VPMN代码|"; 
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "2|0|1|";
	    var retToField = "unitId|condText|";
		var sqlStr="";
		if (document.frm.queryType.value=="0")
		{
			document.frm.unitId.value=document.frm.condText.value;
			//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
			window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="1")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000171";
		}
		if (document.frm.queryType.value=="2")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000172";
		}
		if (document.frm.queryType.value=="1" || document.frm.queryType.value=="2")
		{
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
			if (document.frm.unitId.value!="")
				//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
				window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="3")
		{
			//window.location="f5082_dCustGrp.jsp?phoneNo=" + document.frm.condText.value;
			window.location="f3915_dCustGrp.jsp?phoneNo=" + document.frm.condText.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
		if (document.frm.queryType.value=="4")
		{
			params = document.frm.condText.value+"|";
			sqlStr ="90000173";
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
			if (document.frm.unitId.value!="")
				//window.location="f5082_2.jsp?unitId=" + document.frm.unitId.value;
				window.location="f3915_2.jsp?unitId=" + document.frm.unitId.value+"&opCode=<%=opCode%>&opName=<%=opName%>";
		}
	}
	return true;
}

</SCRIPT>
 
<FORM method=post name="frm" >
	<%@ include file="/npage/include/header.jsp" %>   
  	<input type="hidden" name="opCode" value="<%=opCode%>">
  	<input type="hidden" name="opName" value="<%=opName%>">
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

	<TABLE cellSpacing="0">
        <TR> 
          <TD class="blue">查询条件</TD>
          <TD>
           <select align="left" name=queryType>
              <option value="0">集团编号</option>
              <option value="1">集团名称</option>
              <option value="2">VPMN代码</option>
              <!--option class="button" value="3">手机号码</option-->
              <option value="4">证件号码</option>
            </select> 
		  </TD>
          <TD class="blue"> 条件信息</TD>
          <TD>
          	<input type="text" name="condText" size="20" maxlength="60" onKeyDown="if(event.keyCode==13){ doCheck();return false}">
          	<input type="button" class="b_text" name="Button1" value="查询" onclick="doCheck()">
          	<input type="hidden" name="unitId" value="">
          </TD>
        </TR>
    </TABLE>

	<script>
		x = screen.availWidth;
		y = screen.availHeight;
		window.innerWidth = x;
		window.innerHeight = y;
	</script>  
	<!------------------------>
	<TABLE cellSpacing="0">
	  <tr> 
	    <td id="footer">
	      &nbsp; <input class="b_foot" name=reset  type=reset onClick="" value=清除>
	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
	      &nbsp; 
	    </td>
	  </tr>
	</table>
	<%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
