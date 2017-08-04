<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>移动梦网详单查询</TITLE>
<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<%
  String opCode = "1527";
  String opName = "移动梦网详单查询";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String nopass = (String)session.getAttribute("password");	
	String orgCode = (String)session.getAttribute("orgCode");
	String ip_Addr = (String)session.getAttribute("ipAddr");
       		/* 操作时间 requestTime节点 */
	String currTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date());
	/* 获取敏感数据和敏感操作 */
	String readPath = request.getRealPath("npage/properties")+"/treasury.properties";
	/* 资源ID */
	String appId = readValue("treasury",opCode,"appId",readPath);
	/* 资源名称 */
	String appName = readValue("treasury",opCode,"appName",readPath);
	/* 场景ID sceneId */
	String sceneId = readValue("treasury",opCode,"sceneId",readPath);
	/* 测试用场景ID，上线删掉 by zhangyta at 20120824*/
	/*sceneId = "ff808081395641c901395641c9220000";*/
	/* 场景名称 sceneName */
	String sceneName = readValue("treasury",opCode,"sceneName",readPath);
	String ipAddr = (String)session.getAttribute("ipAddr");
	String flag4A = (String)session.getAttribute("flag4A");
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	} 
    
  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String[] mon = new String[]{"","","","","",""};

  Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=5;i++)
      {
              if(i!=5)
              {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
      }                                       
%>

</HEAD>
<!--
onLoad=""
onFocus=""
onBlur="CloseInput()"
onBeforeUnload="CloseInputPort()"
-->
<body>
	<jsp:include page="/npage/client4A/treasuryStatus.jsp">
	<jsp:param name="opCode" value="<%=opCode%>"  />
	<jsp:param name="opName" value="<%=opName%>"  />
	</jsp:include>
<SCRIPT language="JavaScript">
function isNumberString (InString,RefString)
{
if(InString.length==0) return (false);
	for (Count=0; Count < InString.length; Count++)  {
		TempChar= InString.substring (Count, Count+1);
		if (RefString.indexOf (TempChar, 0)==-1)  
		return (false);
	}
	return true;
}

function doCheck()
{	
    
	if (document.frm1527.phoneNo.value.length<11) {	
	    rdShowMessageDialog("服务号码不能小于11位，请重新输入 !");
		document.frm1527.phoneNo.focus();
		return false;
	} else {

	    document.frm1527.action="fDetQryY.jsp";
	    var getdataPacket = new AJAXPacket("fAjax5085.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.frm1527.phoneNo.value);
				getdataPacket.data.add("currTime","<%=currTime%>");
				getdataPacket.data.add("appId","<%=appId%>");
				getdataPacket.data.add("appName","<%=appName%>");
				getdataPacket.data.add("flag4A","<%=flag4A%>");
				getdataPacket.data.add("appSessionId","<%=appSessionId%>");
				getdataPacket.data.add("ipAddr","<%=ipAddr%>");
				
				core.ajax.sendPacket(getdataPacket,doFileInput);
				getdataPacket = null;
	    
	}
	
	return true;
}


function doFileInput(packet){
			var result = packet.data.findValueByName("result");
		   // alert("test result is "+result);
			var resultDesc = packet.data.findValueByName("resultDesc");
			if(result == "1"){
				/**调用成功 */
				frm1527.submit();
			}else{
				/**调用失败 */
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
				return false;
			}
}

function seltimechange() {
	if (document.frm1527.searchType.selectedIndex == 0) {
	   IList1.style.display = "";
	   IList2.style.display = "none";
	} else {
	   IList1.style.display = "none";
	   IList2.style.display = "";
	}
}

</SCRIPT>

<FORM method=post name="frm1527" >
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">移动梦网详单查询</div>
</div>
<input type="hidden" name="opCode"  value="<%=opCode%>">
<input type="hidden" name="monNum"  value="1">


<TABLE cellSpacing=0>
    <TR> 
        <TD class=blue>服务号码</TD>
        <TD>
            <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" maxlength="11">
        </TD>
        <TD class=blue>查询类型</TD>
        <TD>
            <select name="searchType" onchange="seltimechange()">
                <option  value="0" selected>时间范围</option>
                <option  value="1" >出帐年月</option>
            </select>
        </TD>   
    </TR>
    
    <TR style="display:" id="IList1"> 
        <TD class=blue>开始日期</TD>
        <TD>
            <input type="text" name="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
        </TD>
        <TD class=blue>结束日期</TD>
        <TD>
            <input type="text" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
        </TD>
    </TR>
    
    <TR style="display:none" id="IList2"> 
        <TD class=blue>出帐年月</TD>
        <TD colspan=3>
            <input type="text" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
        </TD>
    </TR>
    
    
    <tr id="footer"> 
        <td colspan=4>
            <input class="b_foot" name=Button1  type="button" onClick="doCheck()" value=查询>
            <input class="b_foot" name=reset  type=reset onClick="" value=清除>
            <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
        </td>
    </tr>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
