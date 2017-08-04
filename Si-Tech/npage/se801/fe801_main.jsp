<%
    /*************************************
    * 功  能: 集团客户密码变更 e801
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-4-26
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>集团客户密码变更查询</TITLE>
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
	String regCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
	String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
%>
</HEAD>

<body>
<SCRIPT language="JavaScript">
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
    //var path = "../../npage/public/fPubSimpSel.jsp";
    var path = "/npage/s3915/f3915Qry.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
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
	    var fieldName = "集团编号|集团名称|集团地址|客户ID|智能网编码|"; 
	    var selType = "S";    //'S'单选；'M'多选
	    var retQuence = "2|0|1|";
	    var retToField = "unitId|";
  		//var sqlStr="select unit_id, unit_name, unit_addr, cust_id, boss_vpmn_code from dCustDocOrgAdd where ";
  		var paramStr = "";
  		if (document.frm.queryType.value=="0") //证件号码
  		{
  			//var sqlStr2="SELECT unit_id, unit_name, unit_addr, a.cust_id, boss_vpmn_code FROM dCustDocOrgAdd a, dcustdoc b WHERE a.cust_id=b.cust_id AND b.id_iccid = '"+document.frm.condText.value+"'";
  			var paramStr2 = "&id_iccid=" + document.frm.condText.value+"&opCode=<%=opCode%>&opName=<%=opName%>&flag=2";
  			PubSimpSel(pageTitle,fieldName,paramStr2,selType,retQuence,retToField);
  			if (document.frm.unitId.value!="")
  				window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
  		}
  		if (document.frm.queryType.value=="1") //集团编号
  		{
  			document.frm.unitId.value=document.frm.condText.value;
  			window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
  		}
  		if (document.frm.queryType.value=="2") //智能网编号
  		{
  			//sqlStr += "boss_vpmn_code='" + document.frm.condText.value + "'";
  			paramStr += "&boss_vpmn_code=" + document.frm.condText.value;
  			paramStr += "&opCode=<%=opCode%>&opName=<%=opName%>&flag=1";
  			PubSimpSel(pageTitle,fieldName,paramStr,selType,retQuence,retToField);
  			if (document.frm.unitId.value!="")
  				window.location="fe801_ajax_queryInfo.jsp?unitId=" + document.frm.unitId.value;
    		}
  		if (document.frm.queryType.value=="3") //客户ID
  		{
  		  var custId=document.frm.condText.value;
        var myPacket = new AJAXPacket("fe801_ajax_getUnitId.jsp","正在获取信息，请稍候......");
	    	myPacket.data.add("custId",custId);
	    	core.ajax.sendPacket(myPacket,doGetUnitId);
	    	myPacket=null; 
  		}
	}
	return true;
}

function doGetUnitId(packet){
  var retCode = packet.data.findValueByName("retcode");
  var retMsg = packet.data.findValueByName("retmsg");
  var unitIdBack = packet.data.findValueByName("unitIdBack");
  if(retCode!="000000"){
    rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
    window.location.href="fe801_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }else{
    window.location.href="fe801_ajax_queryInfo.jsp?unitId="+unitIdBack;
  }
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
              <option value="0">证件号码</option>
              <option value="1">集团编号</option>
              <option value="2">智能网编号</option>
              <option value="3">客户ID</option>
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
	      <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
	    </td>
	  </tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<!--***********************************************************************-->
