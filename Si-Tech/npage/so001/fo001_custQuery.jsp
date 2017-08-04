<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团信息查询</TITLE>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.conn.*" %>
<%@ page import="com.sitech.boss.pub.exception.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.wtc.*" %>
<%@ page import="java.util.ArrayList" %>
<%
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String opCode = "5082";
	String opName = "集团信息查询";
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum)
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
    var path = "../../npage/public/fPubSimpSel_n1.jsp";
    path = path + "?sqlStr=" + sqlStr+ "&params=" + params+ "&wtcOutNum=" + wtcOutNum + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
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
	    var retToField = "unitId|";
		
		var param = "";
		var sqlStr = "";
		var wtcOutNum = "";
		    
		var sqlStr="select unit_id, unit_name, unit_addr, cust_id, boss_vpmn_code from dCustDocOrgAdd where ";
		if (document.frm.queryType.value=="0")
		{
			document.frm.unitId.value=document.frm.condText.value;
			window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		if (document.frm.queryType.value=="1")
		{
			
			sqlStr += "unit_name like '%" + document.frm.condText.value + "%'";
			
			
			sqlStr = "51";	
			params = "condText=%"+document.frm.condText.value+"%";
			wtcOutNum = "5";
			
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum);

			if (document.frm.unitId.value!="")
				window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		if (document.frm.queryType.value=="3")
		{
			window.location="fo001_dCustGrp.jsp?phoneNo=" + document.frm.condText.value;
		}
		if (document.frm.queryType.value=="4")
		{
			var sqlStr2="SELECT unit_id, unit_name, unit_addr, a.cust_id, boss_vpmn_code FROM dCustDocOrgAdd a, dcustdoc b WHERE a.cust_id=b.cust_id AND b.id_iccid = '"+document.frm.condText.value+"'";
			
			
			sqlStr = "52";	
			params = "condText="+document.frm.condText.value;
			wtcOutNum = "5";
			
			PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params,wtcOutNum);
			
			if (document.frm.unitId.value!="")
				window.location="fo001_ajax_queryGrpCust.jsp?unitId=" + document.frm.unitId.value;
		}
		
	}
	return true;
}
onload=function()
{
	document.all.condText.focus();
}



</SCRIPT>
 
<FORM method=post name="frm" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团信息查询</div>
</div>
	<TABLE cellSpacing=0>
        <TR> 
          <td class='blue' nowrap>查询条件</TD>
          <TD>
           <select name=queryType>
              <option value="0">集团编号</option>
              <option value="1">集团名称</option>
              <option value="4">证件号码</option>
            </select> 
		  </TD>
          <td class='blue' nowrap>条件信息</TD>
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
	<table cellspacing=0>
	  <tr id="footer"> 
	    <td>
	      <input class="b_foot" name=reset  type=reset onClick="" value=清除>
	      <input class="b_foot" name=back onClick="window.close();" type=button value=关闭>
	    </td>
	  </tr>
	</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
