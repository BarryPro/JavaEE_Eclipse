<%
    /*************************************
    * 功  能: 安保部普通详单查询(新) e234
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2011-8-23
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<HTML>
<HEAD>
    <TITLE>安保部普通详单查询(新)</TITLE>
    <%
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);
    %>
    <%
        String opCode = "e234";
        String opName = "安保部普通详单查询(新)";
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
	
	String workNo = (String)session.getAttribute("workNo");
	
	
	/*@@@@@@@@*/
        String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};
        String account="";

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH, -2);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
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
	函数作用：判断两个月份之间是否超过6个月 如果超过6个月，返回为true 否则为false 
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

function   CheckIsDate(value)   
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
  
	String loginNo = (String)session.getAttribute("workNo");
	String tmpsql = "select account_type from dloginmsg where login_no = '"+loginNo+"'";
	
	String regionCode= (String)session.getAttribute("regCode");
  String sqlsl="select d.query_code, c.title_name from (select b.query_type query_type, b.title_name title_name from scrdquerycode a, scrdquerytype b where a.query_code = '25' and a.query_type = b.query_type) c, scrdquerycode d where c.query_type = d.query_type and d.query_code > 250";
  String sqlsl2="select to_char(start_date,'YYYYMMDD'), to_char(end_date,'YYYYMMDD'), query_type from dcustmsg a, dqueryenter b where a.id_no = b.id_no and a.phone_no = '"+phoneNo+"' and b.valid_flag = 'Y'";
	String start_dates=""; 
	String end_dates="";
	String query_types="";
%>
  	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="2">
			<wtc:sql><%=sqlsl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets1" scope="end" />
			
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode4" retmsg="RetMsg4" outnum="3">
			<wtc:sql><%=sqlsl2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets2" scope="end" />
<%
		if(RetCode4.equals("000000")) {
		if(rets2.length>0) {
			start_dates=rets2[0][0];
			end_dates=rets2[0][1];
			query_types=rets2[0][2];

		}
	 else	{
	 			%>
			
			rdShowMessageDialog("手机号码在“安保部详单查询录入功能”没录入过，不可以查询！");
			parent.removeTab('<%=opCode%>');
			<%
	 		
	 	}
		
	}else {
		%>
			
			rdShowMessageDialog("查询安保部详单录入表错误！");
			parent.removeTab('<%=opCode%>');		
			<%
  }

%>				
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="belongStr" scope="end"/>

		
		
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=changeOwnerDateStr%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="chOwnerStr" scope="end"/>
	
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=tmpsql%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="accountNo" scope="end"/>
	<% 
	if(accountNo!=null&& accountNo.length > 0)
	{
		account = accountNo[0][0];
	}
	%>
	
/* 为解决跨月问题新增加*/
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
  //rdShowMessageDialog(year2+" "+year1+" "+month1+" "+month2+" "+flag);
  if((flag*12+month2-month1)<months)
  {
  	return true;
  }
  else
  {
  	return false;  	
  }
}
	
function doCheck()
{
	
	var inEndtime = document.frme234.endTime.value;	
	
	//start
	if(document.frme234.searchType.selectedIndex == 0)//选择的是按时间范围
	{
		
		var inbegintime = document.frme234.beginTime.value;		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		var inEndtime = document.frme234.endTime.value;
		
		if(!CheckIsDate(inbegintime))
		{
			rdShowMessageDialog("开始日期不合法!");
			return;
		}
		
		if(!CheckIsDate(inEndtime))
		{
			rdShowMessageDialog("结束日期不合法!");
			return;
		}


		if(nowDate.localeCompare(inEndtime.substr(0,6))<0)
		{
			//处理结束日期晚于当月月末
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}		
		else if(nowDate.localeCompare(inEndtime)<0)
		{
			//如果结束日期晚于当前日期则设定为当前日期
			document.frme234.endTime.value = nowDate;
		}
		else if(inEndtime.localeCompare(inbegintime)<0)
		{
			rdShowMessageDialog("开始时间不能大于结束时间!");
			return;
		}	
		else if(true ==monthsOfDates(inbegintime,inEndtime,5))
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return;
		}		
		var nowDate = getFormatDate(new Date(),"yyyymmdd");
		
		if(monthCheck(inbegintime.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}
	}
	else//选择的是按出账月份
	{
		
		var queryDate = document.frme234.searchTime.value;
		var nowDate = getFormatDate(new Date(),"yyyymm");
	
		if(nowDate.localeCompare(queryDate.substr(0,6))<0)
		{
			rdShowMessageDialog("出账日期不应该迟于当月，请重新输入!");
			return;
		}
		
		if(monthCheck(queryDate.substr(0,6),nowDate.substr(0,6),6)==false)
		{
			rdShowMessageDialog("只允许查询最近6个月的详单!");
			return false;
		}
	}
	
	// end
	if( document.frme234.phoneNo.value.length<11) {	
	    rdShowMessageDialog("服务号码不能小于11位，请重新输入 !");
		document.frme234.phoneNo.focus();
		return false;
	}else {
	    if(!check(frme234)) return false;
	    document.frme234.action="fe234_query.jsp?qryType="+document.frme234.detType.value+"&qryName="
		+document.frme234.detType.options[document.frme234.detType.options.selectedIndex].text+"&searchType="+document.frme234.searchType.value;
		var oButton = document.getElementById("Button1"); 
        oButton.disabled = true; 
        var getdataPacket = new AJAXPacket("/npage/query/fAjax5085.jsp","正在获得数据，请稍候......");
				getdataPacket.data.add("loginNo","<%=workNo%>");
				getdataPacket.data.add("sceneId","<%=sceneId%>");
				getdataPacket.data.add("sceneName","<%=sceneName%>");
				getdataPacket.data.add("phoneNo",document.frme234.phoneNo.value);
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
				frme234.submit();
			}else{
				/**调用失败 */
				rdShowMessageDialog("执行失败，失败原因：" + resultDesc);
				return false;
			}
}

    function seltimechange() {
        if (document.frme234.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    }

</SCRIPT>

<FORM method=post name="frme234">
    <input type="hidden" name="opCode" value="e234">
    <input type="hidden" name="monNum" value="1">
    <%@ include file="/npage/include/header.jsp" %>
    <div class="title">
        <div id="title_zi">请选择查询类型</div>
    </div>
    <TABLE cellSpacing="0">
        <tr>
            <TD width=16% class="blue">服务号码</TD>
  		    <TD width=34%>
  		        <input type="text" class="InputGrey" name="phoneNo" value="<%=activePhone%>" size="20" style="width:145px;" readonly />
  		    </TD>
            <TD width=16% class="blue">查询密码</TD>
            <TD width=34%>
                <input type="password"  name="passWord" size="20" maxlength="8" class="InputGrey" style="width:145px;" readonly />	
            </TR>
        </TR>
      <tr>
            <TD class="blue" width=16%>查询类型</TD>
            <TD colspan="3">
                <select name="searchType" onchange="seltimechange()"   disabled >
                    <option value="0" selected>时间范围&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                    <option value="1">出帐年月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</option>
                </select>
            </TD>
        </TR>

        <TR style="display=''" id="IList1" > 
          <TD class="blue" width=16% >开始日期</TD>
          <TD width=34%>
            <input type="text"  name="beginTime" size="20" maxlength="8" value="<%=start_dates%>" style="width:145px;" class="InputGrey" readonly></TD>
          <TD class="blue" width=16% >结束日期</TD>
          <TD width=34%>
             <input type="text"  name="endTime" size="20" maxlength="8" value="<%=end_dates%>" style="width:145px;" class="InputGrey" readonly></TD>
        </TR>

        <TR style="display:none" id="IList2">
            <TD class="blue" width=16%>出帐年月</TD>
            <TD colspan="3">
                <input type="text" name="searchTime" size="20" maxlength="6" style="width:145px;" value=<%=mon[1]%>>
            </TD>
        </TR>

        <tr>
            <TD class="blue">详单类型</TD>
            <TD colspan="3"> 
              <select align="left" name="detType"  class="button" disabled >
              	<%
	          String selectTypesled="";
	        	if(query_types.equals("25")) {
	        	selectTypesled=" selected";
	          }else {
	          	selectTypesled="";
	        	}
        	
              	%>
              	<option class="button" value="25" <%=selectTypesled%>>全部</option>
					 <%
					 String selectTypes="";
        	for(int i=0;i<rets1.length; i++){
        	if(rets1[i][0].equals(query_types)) {
        	selectTypes=" selected";
          }else {
          	selectTypes="";
        	}
			    out.println("<option class='button' value='"+rets1[i][0]+"' "+selectTypes+">"+rets1[i][1]+"</option>");
			    }
		      %>
                </select>
             </TD>
        </TR>
    </TABLE>
    <table cellspacing="0">
        <tr>
            <td id="footer">
                <input class="b_foot" name="Button1" type="button" value="查询" onClick="doCheck()"  />
                <input class="b_foot" name="reset"   type="hidden"  value="重置" onClick="location.reload()"  />
                <input class="b_foot" name="back"    type="button" value="关闭" onClick="parent.removeTab('<%=opCode%>')"   />
            </td>
        </tr>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
    <jsp:include page="/npage/common/pwd_comm.jsp"/>
</FORM>

</BODY>
</HTML>
