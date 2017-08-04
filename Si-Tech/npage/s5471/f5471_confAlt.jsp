<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.1.8
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page language="java" import="java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>

<%            
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName"); 	
  String opFlag = request.getParameter("op_flag");

/****得系统流水****/
	String printAccept="";		
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%		
	printAccept = sLoginAccept;  
            
  String loginNo = (String)session.getAttribute("workNo");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
 	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	
	String inputArry[] = new String[1];
	String Tmsql="select to_char(sysdate,'yyyymmdd hh24:mi:ss') from dual";		
	inputArry[0] = Tmsql;
%> 
<wtc:service name="sPubSelect" retcode="retCode1" retmsg="retMsg1" outnum="1">
	<wtc:param value="<%=inputArry[0]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr1"  scope="end"/>
<%
	String beginTime = tempArr1[0][0];
%>

<head>
<title>资费套餐包月费修改</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

<script language="JavaScript">
<!--
 
  onload=function()
  {
   	self.status="";
   }

function queryRegionCode()
{
	var regionCode = "<%=regionCode%>";
	var pageTitle = "资费查询";
    var fieldName = "地区代码|地区名称";//弹出窗口显示的列、列名 
    var sqlStr ="select  region_code, region_name from(select a.region_code region_code , a.region_name region_name from sRegionCode a, sProdLoginCtrl b where decode(b.region_code,'99',b.region_code,a.region_code) = b.region_code and b.login_no ='" + document.all.loginNo.value + "' union select a.region_code region_code , a.region_name region_name from sRegionCode a where region_code ='"+ regionCode+ "') where rownum < 14 order by region_code " ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "region_code|region_name";//返回赋值的域    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	//window.open("f5471_qryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=400,width=400,scrollbars=yes");
}	
  function formCommit()
  {
	  getAfterPrompt();
	  if(document.all.mode_code.value ==""){ 
	  	rdShowMessageDialog("请输入资费代码，或直接按选择！");
			document.all.mode_code.focus();
			return false;
			}
		else if(parseFloat(document.form1.tmpPrepay.value) == parseFloat(document.form1.month_rent_fee.value))
		{
		  rdShowMessageDialog("信息未改动，请修改月租费信息!");
		  document.form1.month_rent_fee.focus();
  	  return false;
		}
		else
		{	
			setOpNote();//为备注赋值 
			//alert(document.all.region_code.value+"|"+document.all.mode_code.value+"|"+document.all.month_rent_fee.value+"|"+document.all.op_flag.value);
 			document.all.action="f5471_Cfm.jsp";	
			form1.submit();	
		}
  }


function salechage()
{   
  	document.all.commit.disabled=true;
  	var regionCode = document.form1.region_code.value;	
		var modeCode=document.form1.mode_code.value;	
		var pageTitle = "资费查询";
    var fieldName = "资费代码|资费名称|月租费|";//弹出窗口显示的列、列名 
    //var sqlStr ="select unique a.mode_code,trim(b.mode_name),a.month_rent from sModeChgChk a,sBillModeCode b where a.region_code='" + document.form1.region_code.value + "' and a.region_code=b.region_code and a.mode_code like '";
    //sqlStr = sqlStr+codeChg("%" + modeCode + "%").trim() ;
    // sqlStr = sqlStr+"' and a.mode_code=b.mode_code" ;
    //var sqlStr = "SELECT UNIQUE a.mode_code, TRIM (b.offer_name), a.month_rent ";
    //sqlStr = sqlStr+"FROM smodechgchk a, product_offer b ";
    //sqlStr = sqlStr+"WHERE a.region_code = '" + document.form1.region_code.value + "' ";
    //sqlStr = sqlStr+"AND to_number(a.mode_code) = b.offer_id ";
    //sqlStr = sqlStr+"AND a.mode_code LIKE '"+codeChg("%" + modeCode + "%").trim()+"' ";
    var sqlStr = "SELECT a.offer_id, b.offer_name, a.offer_attr_value ";
    sqlStr = sqlStr+"FROM product_offer_attr a, product_offer b ,region c,sregioncode d ";
    sqlStr = sqlStr+"WHERE a.offer_id = b.offer_id AND a.offer_attr_seq = '50002' ";
    sqlStr = sqlStr+"and a.offer_id like '"+codeChg("%" + modeCode + "%").trim()+"' ";
    sqlStr = sqlStr+"and a.offer_id = c.offer_id ";
    sqlStr = sqlStr+"and b.offer_id = c.offer_id ";
    sqlStr = sqlStr+"and c.group_id = d.group_id ";
    sqlStr = sqlStr+"and d.region_code = '" + document.form1.region_code.value + "' ";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "3|0|1|2|";//返回字段
    var retToField = "mode_code|mode_name|month_rent_fee|";//返回赋值的域    
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
		document.form1.tmpPrepay.value = document.form1.month_rent_fee.value
		//alert(document.form1.tmpPrepay.value);
		document.all.commit.disabled=false;
}

function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=5471";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
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
	return true;
}

function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
 /******为备注赋值********/
	function setOpNote(){
		if(document.form1.opNote.value=="")
		{
		  document.form1.opNote.value = "<%=loginNo%>：完成了资费套餐包月费修改操作"; 
		}
		return true;
	}

</script>

</head>

<body>
	<form name="form1" method="post" action="f5471_Cfm.jsp" onKeyUp="chgFocus(form1)">
		<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
		<div id="title_zi"><%=opName%></div>
		</div>
	<table cellspacing="0">
		<tr>
			<tr>
			<td width="15%" class="blue">地市代码</td>
			<td width="35%">	
				<input class="hidden" type=text  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="地区代码"  name=region_code value="请点选择"  maxlength=20 readonly></input><font color="#FF0000">*</font>
				<input class="button" type="button" name="query_regioncode" onclick="queryRegionCode()" value="选择">
			</td>  
			<td width="15%" class="blue">地市名称</td>  	
			<td width="35%">	
				<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30>    
        	</td>
        </tr>
        <tr>    
            <td width="15%" class="blue">
            	资费代码
            </td>
            <td width="35%">
            	<input type="text" name="mode_code" id="mode_code" size="9" class="button" maxlength=9 >   
            	<input class="button" type="button" name="query_modecode" onclick="salechage()" value="查询">       
            </td>   
            <td width="15%" class="blue">
            	资费名称
            </td>
            <td width="35%">
				<input name="mode_name" type="text" class="InputGrey" id="mode_name" maxlength=60 readonly>
			</td>	
		</tr>
		<tr>
			<td width="15%" class="blue">
				月租费
			</td>
			<td width="35%" colspan="3">
				<input name="month_rent_fee" type="text" class="button" id="month_rent_fee" size="9">			
				</td>
		</tr>
		<tr>
    	<td class="blue">备注</td>
      <td colspan="3">
       <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" size="60" class="InputGrey"> 
      </td>           
		</tr>	
		<tr>
			<td id="footer" colspan="4">
				<div align="center">
                &nbsp;
				<input name="commit" id="commit" type="button" class="b_foot"   value="确认" onClick="formCommit();" disabled >
                &nbsp; 
                <input name="reset" type="reset" class="b_foot" value="清除" >
                &nbsp; 
                <input name="close" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭">
                &nbsp; 
				<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
				</div>
			</td>
		</tr>
	</table>
	
<div name="gonght" id="gonght">
			<input type="hidden" name="iOpCode" value="">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">
			<input name="op_flag" type="hidden"  id="op_flag" value="<%=opFlag%>">  					
			<input type="hidden" name= "tmpPrepay" value="" >
			<input type="hidden" name="begin_time" id="begin_time" value="<%=beginTime%>" >																																			
			<input type="hidden" name="stream" value="<%=printAccept%>">
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
			<input type="hidden" name="return_page" value="/npage/s5471/f5471login.jsp?opName=<%=opName%>&opCode=<%=opCode%>">
</div>		
 <%@ include file="/npage/include/footer.jsp" %>   	
</form>
</body>
</html>
