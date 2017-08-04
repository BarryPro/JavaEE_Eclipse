<%
    /********************
     version v2.0
     开发商: si-tech
     *
     * update:zhanghonga@2008-08-15 页面改造,修改样式
     * 废弃了用户号码密码验证功能,保留了二次密码验证
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
	<%@ page import="com.sitech.common.*" %>

<HTML>
<HEAD>
    <TITLE>地市详单查询</TITLE>
    <%
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <%
  String opCode = request.getParameter("opCode")==null?"1866":request.getParameter("opCode");
  String opName = request.getParameter("opName")==null?"地市详单查询":request.getParameter("opName");
        
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
	System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@flag4A============= "+flag4A);
	String appSessionId = (String)session.getAttribute("appSessionId");
	if(flag4A == null){
		flag4A = "0";
	}
	if(appSessionId == null){
		appSessionId = "0";
	}
	
    %>
    <%
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};
				String workNo = (String)session.getAttribute("workNo");
        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                //cal.add(Calendar.MONTH, -1);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        
    
    String[][] temfavStr = (String[][])session.getAttribute("favInfo");
    String[] favStr = new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++) {
       favStr[i]=temfavStr[i][0].trim();
       System.out.println("*********************************"+favStr[i]);
       System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@flag4A============= "+flag4A);
		}

		boolean needDymPasswd=false;
      if(WtcUtil.haveStr(favStr,"a306")){
    	needDymPasswd=true;
    }
    

  %>
</HEAD>

<body>
<jsp:include page="/npage/client4A/treasuryStatus.jsp">
	<jsp:param name="opCode" value="<%=opCode%>"  />
	<jsp:param name="opName" value="<%=opName%>"  />
</jsp:include>	
<SCRIPT language="JavaScript">
function isNumberString(InString, RefString)
{
    if (InString.length == 0) return (false);
    for (Count = 0; Count < InString.length; Count++) {
        TempChar = InString.substring(Count, Count + 1);
        if (RefString.indexOf(TempChar, 0) == -1)
            return (false);
    }
    return true;
}

function monthsOfDates(date1,date2,months)
{ 
	/*
	函数作用：判断两个月份之间是否超过6个月 如果超过6个月，返回为true 否则为false by wangdx 2009.3.17
	*/
  var temp = date1.substr(0,4);  
  date1 = temp + "-" + date1.substr(4,2);  
  temp = date2.substr(0,4);
  date2 = temp + "-" + date2.substr(4,2);
    
  var   temp1=date1.split("-");   
  var   temp2=date2.split("-") ;

  var   _months=(parseInt(temp2[0],10)-parseInt(temp1[0],10)+1)*12-(parseInt(temp1[1],10)+(12-parseInt(temp2[1],10)))   
 
 
  if((_months>months)||(_months==months&&(parseInt(temp2[2],10)-parseInt(temp1[2],10)>-1)))return   true   
  return   false   
}   

function getFormatDate(date_obj,date_templet)
{
  var year,month,day,hour,minutes,seconds,short_year,full_month,full_day,full_day,full_hour,full_minutes,full_seconds;
  if(!date_templet)date_templet = "yyyy-mm-dd hh:ii:ss";
  year = date_obj.getFullYear().toString();
  short_year = year.substring(2,4);
  month = (date_obj.getMonth()+1).toString();
  month.length == 1 ? full_month = "0"+month : full_month = month;
  day = date_obj.getDate().toString();
  day.length == 1 ? full_day = "0"+day : full_day = day;
  hour = date_obj.getHours().toString();
  hour.length == 1 ? full_hour = "0"+hour : full_hour = hour;
  minutes = date_obj.getMinutes().toString();
  minutes.length == 1 ? full_minutes = "0"+minutes : full_minutes = minutes;
  seconds = date_obj.getSeconds().toString();
  seconds.length == 1 ? full_seconds = "0"+seconds : full_seconds = seconds;
  return date_templet.replace("yyyy",year).replace("mm",full_month).replace("dd",full_day).replace("yy",short_year).replace("m",month).replace("d",day).replace("hh",full_hour).replace("ii",full_minutes).replace("ss",full_seconds).replace("h",hour).replace("i",minutes).replace("s",seconds);
}

function CheckIsDate(value)   
{   
  var   strValue     =   new   String();       
  var   year   =   new   String();   
  var   month   =   new   String();   
  var   day   =   new   String();   
    
  strValue   =   value;   
  if   (strValue.length=null)   
  alert("日期不能为空!");   
    
  if   (strValue.length!=8)   
  {     
  	return   false;   
  }       

    
    
  year   =   strValue.substr(0,4);   
  month   =   strValue.substr(4,2);   
  month   =   month-1;     
  day   =   strValue.substr(6,2);   
  var   testDate   =   new   Date(year,month,day);   
  return     (year   ==   testDate.getFullYear())   &&   (month   ==testDate.getMonth())&&(day   ==   testDate.getDate());   
}



/*by wangdx start*/
<%
	String sqlStr = "select belong_code  from dcustMsg where phone_no = \'";
	String phoneNo = request.getParameter("activePhone");
	sqlStr+=phoneNo;
	sqlStr+="\'";
	System.out.println("sqlStr = "+sqlStr);
	
	String orgCode = (String)session.getAttribute("orgCode");
	
	System.out.println("~~~~~~~~~~~~~~orgCode = "+orgCode);
	
	String changeOwnerDateStr = "select to_char(max(op_time),'YYYYMMDDHH24MISS') from dCustHisInfoQry where last_flag <=1 and qry_flag = 'N' and phone_no = \'";
	changeOwnerDateStr +=phoneNo;     
    changeOwnerDateStr+="\' ";    
    System.out.println("++++++++++++++"+changeOwnerDateStr);

	 
%>

	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="belongStr" scope="end"/>

		
		
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=changeOwnerDateStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="chOwnerStr" scope="end"/>
	
	
/*by wangdx end*/


/*wangwg 为解决跨月问题新增加*/
function monthCheck(date1,date2,months)
{
  var year1 = parseInt(date1.substr(0,4)); 
  var year2 = parseInt(date2.substr(0,4));
  var month1 = parseInt(date1.substr(4,1))*10+parseInt(date1.substr(5,1));
  var month2 =  parseInt(date2.substr(4,1))*10+parseInt(date2.substr(5,1));
  var flag = 0;
  if(year2 == year1) flag =0;
  else if(year2 - year1 == 1) flag = 1;
  else 
  {
  	return false;
  }
  if((flag*12+month2-month1)<months)
  {
  	return true;
  }
  else
  {
  	return false;  	
  }
}

function dateCheck()
{
	if(document.frm1527.searchType.value == 0)//选择的是按时间范围
	{
		
		var inbegintime = document.frm1527.beginTime.value;		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		var inEndtime = document.frm1527.endTime.value;
		
		if(!CheckIsDate(inbegintime))
		{
			rdShowMessageDialog("开始日期不合法!");
			return false;
		}
		
		if(!CheckIsDate(inEndtime))
		{
			rdShowMessageDialog("结束日期不合法!");
			return false;
		}


		/*wangwg 处理10月份不能查询9月份详单的问题
		if(nowDate.localeCompare(inEndtime.substr(0,6))<0)
		{
			//处理结束日期晚于当月月末
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}		
		else */
		if(nowDate.localeCompare(inEndtime)<0)
		{
			//如果结束日期晚于当前日期则设定为当前日期
			document.frm1527.endTime.value = nowDate;

		}
		else if(inEndtime.localeCompare(inbegintime)<0)
		{
			rdShowMessageDialog("开始时间不能大于结束时间!");
			return false;
		}	
		else if(true ==monthsOfDates(inbegintime,inEndtime,0))
		{
			rdShowMessageDialog("查询不能跨月!");
			return false;
		}		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		
		 /*wangwg 处理10月份不能查询9月份详单的问题
		 if(true ==monthsOfDates(inbegintime.substr(0,8),nowDate,8))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}
		*/
		if(monthCheck(inbegintime.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}

	}
	else//选择的是按出账月份
	{
		var queryDate = document.frm1527.searchTime.value;
		var nowDate = getFormatDate(new Date(),"yyyymm");
		
		if(nowDate.localeCompare(queryDate.substr(0,6))<0)
		{
			rdShowMessageDialog("出账日期不应该迟于当月，请重新输入!");
			return false;
		}	
		/*wangwg 处理10月份不能查询9月份详单的问题
		if(true ==(queryDate.substr(0,6),nowDate,6))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}
		*/
		if(monthCheck(queryDate.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}
		if(!CheckIsDate(queryDate+"01"))
		{
			rdShowMessageDialog("查询年月不合法!");
			return false;
		}
	}
	
	return true;
}
	
function doCheck()
{
	if(dateCheck()==false)
	{
		return;
	}

	if(document.frm1527.listNo.value.length==0)
	{
			rdShowMessageDialog("工单号不能为空，请重新输入 !");
			document.frm1527.listNo.focus();
			return false;
	}
	if(document.frm1527.reasonText.value.length==0)
	{
			rdShowMessageDialog("查询原因说明不能为空，请重新输入 !");
			document.frm1527.reasonText.focus();
			return false;
	}
	if( document.frm1527.phoneNo.value.length<11) 
	{	
	    rdShowMessageDialog("服务号码不能小于11位，请重新输入 !");
			document.frm1527.phoneNo.focus();
			return false;
	} 
	else 
	{
			if((document.frm1527.optType.value == 0 )||(document.frm1527.optType.value == 1 )
					||(document.frm1527.optType.value == 2)||(document.frm1527.optType.value == 3 ))
			{
				document.frm1527.action=
				"fDetQryB.jsp?qryType="+document.frm1527.detType.value+
				"&qryName="+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
				
				//查询的时候让“查询”按钮不可用，避免等待的时候重复查询
				var oButton = document.getElementById("Button1"); 
    		oButton.disabled = true; 
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
	    else if(document.frm1527.dynPW.value.length==6)
			{
				document.frm1527.action="fDetQryB.jsp?qryType="+document.frm1527.detType.value+"&qryName="
					+document.frm1527.detType.options[document.frm1527.detType.options.selectedIndex].text;
				//查询的时候让“查询”按钮不可用，避免等待的时候重复查询
				var oButton = document.getElementById("Button1"); 
    		oButton.disabled = true; 
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
	    else
	    {
	    	rdShowMessageDialog("动态密码格式不对，请重新输入");
				document.frm1527.dynPW.focus();
				return false;
	    }
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

function seltimechange() 
{
        if (document.frm1527.searchType.value == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
}

function seloptTypechange()
{

	if(document.frm1527.optType.value == 4 || document.frm1527.optType.value == 5 )
	{
		IList3.style.display = "";
	}
	else
	{
		IList3.style.display = "none";
	}
	
}

function dosndmsg()
{	
	var loginNo = "<%=workNo%>";
	if(dateCheck()==false)
	{
		return;
	}
	if(document.frm1527.connPhone.value.length==0)
	{
			rdShowMessageDialog("联系电话不能为空，请重新输入 !");
			document.frm1527.connPhone.focus();
			return false;
	}
	if(document.frm1527.listNo.value.length==0)
	{
			rdShowMessageDialog("工单号不能为空，请重新输入 !");
			document.frm1527.listNo.focus();
			return false;
	}
	if(document.frm1527.reasonText.value.length==0)
	{
			rdShowMessageDialog("查询原因说明不能为空，请重新输入 !");
			document.frm1527.reasonText.focus();
			return false;
	}
	if( document.frm1527.phoneNo.value.length<11) 
	{	
	    rdShowMessageDialog("服务号码不能小于11位，请重新输入 !");
			document.frm1527.phoneNo.focus();
			return false;
	}
	else 
	{
			if(rdShowConfirmDialog('确认要发送动态密码吗？')==1)
			{
				var myPacket=new AJAXPacket("f1863_ajax.jsp","正在获取发送动态密码，请稍候......");
				myPacket.data.add("loginNo",loginNo);
				myPacket.data.add("phoneNo",document.frm1527.phoneNo.value);
				myPacket.data.add("ConnPhone",document.frm1527.connPhone.value);
				myPacket.data.add("OptType",document.frm1527.optType.value);
				myPacket.data.add("SearchType",document.frm1527.searchType.value);
				if(document.frm1527.searchType.value==0)
				{
					myPacket.data.add("SearchTime",document.frm1527.beginTime.value +"|"+document.frm1527.endTime.value+"|");
				}
				else
				{
					myPacket.data.add("SearchTime",document.frm1527.searchTime.value);
				}
				myPacket.data.add("DetType",document.frm1527.detType.value);
				myPacket.data.add("WorkListNo",document.frm1527.listNo.value);
				myPacket.data.add("ReasonText",document.frm1527.reasonText.value);
				myPacket.data.add("voiceBillType",document.frm1527.voiceBillType.value);
				core.ajax.sendPacket(myPacket);
				myPacket=null;  
	    }
	}
	return true; 
}
function doProcess(packet)
{
	var retCode=packet.data.findValueByName("retCode");
	var retMsg=packet.data.findValueByName("retMsg");
	if(retCode=="000000")
	{
		rdShowMessageDialog("动态密码短信发送成功！");
	}
	else
	{
		rdShowMessageDialog("动态密码短信发送失败！"+
												"retCode = ["+retCode+
												"] retMsg = ["+retMsg+"]");
	}
}

</SCRIPT>

<FORM method=post name="frm1527">
		<input type="hidden" name="opCodeFlag" value="<%=opCode%>" />
    <input type="hidden" name="opNameFlag" value="<%=opName%>" />
    <input type="hidden" name="opCode" value="1527">
    <input type="hidden" name="monNum" value="1">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">请选择查询类型</div>
    </div>
    <TABLE cellSpacing="0">
        <tr>
            <TD width=16% class="blue">服务号码</TD>
            <TD >
                <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" readonly>
            </TD>
            <TD width=16% class="blue">操作分类</TD>
          	<TD >
                <select name="optType" onchange="seloptTypechange()">
                	<%
                		if(needDymPasswd == false)
                		{
                	%>
                		<option value="4">投诉处理</option>
                    <option value="5">其他类</option>
                   <% 
                    }
                  else
                  	{
                  	%>
                  	<option value="0">资费代码验证</option>
                    <option value="1">实时帐务验证</option>
                    <option value="2">程序上线验证</option>
                    <option value="3">安保部详单查询</option>
                    <option value="4">投诉处理</option>
                    <option value="5">其他类</option>
                    <%
                  	}
                   %>
                 </select>
            </TD>        
        </tr>
        <%
                		if(needDymPasswd == false)
                		{
                	%>
 				<TR style="display:''" id="IList3">
 					<%
 					} else {%>
 					
 					<TR style="display:none" id="IList3">
 						<%}%>
        		<TD class="blue" width=16%>动态密码</TD>
            <TD width=34% colspan="1">
                <input type="text" name="dynPW" size="20" maxlength="6" value="">
                &nbsp;<input class="b_text" name=sndbutton type="button" onClick="dosndmsg()" value=发送>

            </TD>	
            <TD class="blue" width=16%>与客户联系的电话</TD>
            <TD width=34%>
                <input type="text" name="connPhone" size="20" maxlength="15" value="">
            </TD>
            
            
        </TR>
        <tr>
            <TD class="blue" width=16%>查询类型</TD>
            <TD colspan="3">
                <select name="searchType" onchange="seltimechange()">
                    <option value="0" selected>时间范围</option>
                    <option value="1">出帐年月</option>
                </select>
            </TD>
        		
        </tr>

        <tr style="display:''" id="IList1">
            <TD class="blue" width=16%>开始日期</TD>
            <TD width=34%>
                <input type="text" name="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>结束日期</TD>
            <TD width=34%>
                <input type="text" name="endTime" size="20" maxlength="8" value=<%=dateStr%>>
            </TD>
        </tr>

        <tr style="display:none" id="IList2">
            <TD class="blue" width=16%>出帐年月</TD>
            <TD colspan="3">
                <input type="text" name="searchTime" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </tr>

        <tr>
            <TD class="blue">详单类型</TD>
            <TD>
                <select align="left" name="detType" width=50 index="4">
                    <option value="0">全部</option>
                    <option value="1">本地</option>
                    <option value="2">省内漫游</option>
                    <option value="3">出访</option>
                    <option value="4">呼转</option>
                    
                    <option value="46">可视电话</option>
                    <option value="51">可视电话呼转</option>    
                    
                    
                    <option value="5">短信</option>
                    <option value="6">移动梦网</option>
                    <option value="7">GPRS</option>
                    <option value="8">短信互通</option>
                    <option value="9">VPMN</option>
                    <option value="10">彩信</option>
                    <option value="11">移动购物</option>
                    <option value="12">WLAN</option>
                    <option value="13">彩铃</option>
                    <option value="14">彩话</option>
                    <option value="15">语音杂志</option>
                    <option value="16">号簿管家</option>
                    <option value="17">全球呼</option>
                    <option value="18">边界漫游</option>
                    <option value="19">VPMN包月</option>
                    <option value="20">智能名片夹</option>
                    <option value="21">手机动画</option>
                    <option value="22">集团总机</option>
                    <option value="23">小区短信</option>
                    <option value="24">企业信息机</option>
                    <option value="33">互联彩信</option>
                    <option value="35">手机视频</option>
                    <option value="36">专线通</option>
                    <option value="37">国际彩信</option>
                    <option value="38">会议电话</option>
                    <option value="39">无线音乐俱乐部</option>
                    <option value="40">彩票投注话单</option>
                    <option value="41">行业应用短信话单</option>
                    <option value="43">手机地图</option>
                    <option value="44">全网农信通</option>
                  
                    
                    <option value="47">随E行G3上网笔记本</option>
                    
                		<option value="45">多媒体彩铃</option>
                    <option value="48">视频留言</option>
                    <option value="49">视频共享</option>
                    <option value="50">视频会议</option>        
                    <option value="52">MMK话单</option>
                    <option value="53">widget话单</option>
                    <option value="54">手机电视收视费(广电合作)</option>
                    <option value="55">手机阅读</option>
                    <option value="56">短号短信</option>
                    <option value="57">手机游戏</option>
                    <option value="58">手机对讲业务(PoC)</option>
                    <option value="59">手机动漫业务</option>
                    <option value="60">12582农信通百事易</option>
                    <option value="61">短信回执</option>
                    <option value="62">亲情通</option>
                    <option value="63">GPRS国际漫游</option>
                    <option value="64">宜居通</option>
                </select>
            </TD>
            <TD class="blue"  width=16%>语音话单类型</TD><!--权限类型-->
          	<TD width=34%>
                <select name="voiceBillType"><!--powerType-->
                <option  value="0" selected>普通</option>
                <option  value="1" >高级</option>
              </select>	
          </TD>
        </TR>
        
        <TR>
        		<TD class="blue" width=16%>工单号</TD>
            <TD width=34%>
                <input type="text" name="listNo" size="20" maxlength="20" value="">
            </TD>
            <TD class="blue" width=16%>查询原因说明</TD>
            <TD width=34%>
                <input type="text" name="reasonText" size="20" maxlength="200" value="">
            </TD>	
        </TR>
        
        
    </TABLE>
    	
    <table cellspacing="0">
        <tr>
            <td id="footer">
            		&nbsp; <input class="b_foot" name=Button1 type="button" onClick="doCheck()" value=查询>
                &nbsp; <input class="b_foot" name=reset type=reset onClick="" value=清除>
                &nbsp; <input class="b_foot" name=back onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
    <jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>

</BODY>
</HTML>
