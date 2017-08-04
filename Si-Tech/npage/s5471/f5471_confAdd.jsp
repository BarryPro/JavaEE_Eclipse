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
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl"%>
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
  String regionCode=orgCode.substring(0,2);
  
  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMdd hh:mm:ss").format(new java.util.Date());

	String inputArry[] = new String[1];
	String nowtime ="";
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
<title>资费套餐包月费新增</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
 
<script language="JavaScript">
 
  onload=function()
  {    
  	//document.all.phoneNo.focus();
   	self.status="";
   }
 
  function queryRegionCode()
{
	var pageTitle = "资费查询";
    var fieldName = "地区代码|地区名称";//弹出窗口显示的列、列名 
    var sqlStr ="select  region_code, region_name from(select a.region_code region_code , a.region_name region_name from sRegionCode a, sProdLoginCtrl b where decode(b.region_code,'99',b.region_code,a.region_code) = b.region_code and b.login_no ='" + document.all.loginNo.value + "' union select a.region_code region_code , a.region_name region_name from sRegionCode a where region_code ='"+ document.all.regionCode.value+ "') where rownum < 14 order by region_code " ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1";//返回字段
    var retToField = "region_code|region_name";//返回赋值的域    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
	//window.open("f5471_qryRegionCode.jsp?clear_sm_code=1&clear_mode_use=1","","height=400,width=400,scrollbars=yes");
}	
	
function queryModeCode()
{
	var regionCode = document.form1.region_code.value;	
	var modeCode=document.form1.mode_code.value;	
	var pageTitle = "资费查询";
    var fieldName = "资费代码|资费名称|";//弹出窗口显示的列、列名 
    //var sqlStr ="select unique mode_code,trim(mode_name) from sBillModeCode where region_code='" + document.form1.region_code.value + "' and mode_code like '";
    //sqlStr = sqlStr+codeChg("%" + modeCode + "%").trim() ;
    //sqlStr = sqlStr+"' and region_code||mode_code not in(select trim(group_id)||mode_code from sbillmoderelease)" ;
    var sqlStr = "select a.offer_id,a.offer_name ";
    sqlStr = sqlStr+ "from product_offer a, region b,sregioncode c ";
    sqlStr = sqlStr+ "where a.offer_id = b.offer_id and  b.group_id = c.group_id ";
    sqlStr = sqlStr+ "and c.region_code = '" + document.form1.region_code.value + "' and a.offer_id like '"+codeChg("%" + modeCode + "%").trim()+"'";
    sqlStr = sqlStr+ "and a.offer_id not in (select offer_id from product_offer_attr where offer_attr_seq= '5070')";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";//返回字段
    var retToField = "mode_code|mode_name|";//返回赋值的域    
    //alert(sqlStr);
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}
	
  //--------2---------查询主资费专用函数-------------
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

  function form1Cfm()
  {
 		getAfterPrompt();
 		if(document.all.mode_name.value.length==0){
			rdShowMessageDialog("请输入正确的主资费代码然后按查询<br/>或者不输入直接按查询！");
 			document.all.mode_code.focus();
 			return;
		}
		else if(document.all.month_rent_fee.value.length== 0){
			rdShowMessageDialog("请输入月租费！");
 			document.all.month_rent_fee.focus();
 			return;	
		}
 		else
 		{	
 			setOpNote();//为备注赋值 
 			//alert(document.all.region_code.value+"|"+document.all.mode_code.value+"|"+document.all.month_rent_fee.value+"|"+document.all.op_flag.value);
 			document.all.action="f5471_Cfm.jsp";
    	form1.submit();
  	}
  }
  /******为备注赋值********/
	function setOpNote(){
		if(document.form1.opNote.value=="")
		{
		  document.form1.opNote.value = "<%=loginNo%>：完成了资费套餐包月费新增操作"; 
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
			<td width="15%" class="blue">地市代码</td>
			<td width="35%">	
				<input class="button" type=text  v_type="string" size="8" v_must=0 v_minlength=0 v_maxlength=10 v_name="地区代码"  name=region_code value="请点选择"  maxlength=20 readonly></input><font color="#FF0000">*</font>
				<input class="button" type="button" name="query_regioncode" onclick="queryRegionCode()" value="选择">
			</td>  
			<td width="15%" class="blue">地市名称</td>  	
			<td width="35%">	
				<input name="region_name" type="text" class="InputGrey" id="region_name" maxlength=20 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly>    
        	</td>
        </tr>
		<tr>
			<td width="15%" class="blue">资费代码</td>
      <td width="35%">
				<input name="mode_code" type="text" class="button" id="mode_code" size="9" maxlength=8 >
				<input class="button" type="button" name="query_modecode" onclick="queryModeCode()" value="查询">
			</td>
			<td width="15%" class="blue">资费名称</td>  	
			<td width="35%">	
				<input name="mode_name" type="text" class="InputGrey" id="mode_name" maxlength=30 size="30" v_must=1 v_minlength=1 v_maxlength=30 readonly >
			</td> 
      </tr>
			<tr>
				<td width="15%" class="blue">月租费</td>
      		<td width="35%" colspan="3">
					<input name="month_rent_fee" type="text" class="button" id="month_rent_fee" maxlength=8 size="8" >	
      	  </td>
      	</tr>
      	<tr>
      		<td width="15%" class="blue">备注</td>
            <td colspan="3">
             <input name="opNote" type="text" id="opNote" value="" onFocus="setOpNote();" size="60" class="InputGrey"> 
            </td>           
			</tr>	
			<td colspan="4" id="footer"> 
				<div align="center"> 
                &nbsp; 
				<input name="commit" id="commit" type="button" class="b_foot"  value="确定" onClick="form1Cfm();" >
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
			<input type="hidden" name="iOpCode" value="5471">
			<input type="hidden" name="loginNo" value="<%=loginNo%>">
			<input type="hidden" name="regionCode" value="<%=regionCode%>">
			<input type="hidden" name="orgCode" value="<%=orgCode%>">	
			<input name="op_flag" type="hidden"  id="op_flag" value="<%=opFlag%>">  
			<input type="hidden" name="begin_time" id="begin_time" value="<%=beginTime%>" >																																			
			<input type="hidden" name="stream" value="<%=printAccept%>">
			<input type="hidden" name="return_page" value="/npage/s5471/f5471login.jsp?opName=<%=opName%>&opCode=<%=opCode%>">	
			<input type="hidden" name="ipAddr" value="<%=(String)session.getAttribute("ipAddr")%>" >	
</div>				
			<%@ include file="/npage/include/footer.jsp" %>        	
</form>
</body>
</html>
