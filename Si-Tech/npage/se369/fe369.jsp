<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ include file="/npage/client4A/connect4A.jsp" %>
<%@ include file="/npage/client4A/XMLHelper1.jsp" %>
<%@ include file="/npage/client4A/BASE64Crypt.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
 
	<%@ page import="com.sitech.common.*" %>
<head>
	<title>安保部详单查询录入功能</title>
	<%
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
   String opCode = "e369";
		String opName = "安保部详单查询录入功能";
        
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
		String regionCode= (String)session.getAttribute("regCode");
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
		String sqlsl="select d.query_code, c.title_name from (select b.query_type query_type, b.title_name title_name from scrdquerycode a, scrdquerytype b where a.query_code = '25' and a.query_type = b.query_type) c, scrdquerycode d where c.query_type = d.query_type and d.query_code > 250";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode3" retmsg="RetMsg3" outnum="2">
			<wtc:sql><%=sqlsl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="rets1" scope="end" />
		<script language="javascript">
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
			     function quechoosee() {
			
					
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
					if(!check(frme234)) {
					 return false;
					}
	        //document.frme234.action="fe369_1.jsp?qryType="+document.frme234.detType.value+"&qryName="
		      //+document.frme234.detType.options[document.frme234.detType.options.selectedIndex].text;
	      	var oButton = document.getElementById("quchoose"); 
          oButton.disabled = true; 
	       // frme234.submit();
	       	var qryType =document.frme234.detType.value;
					//var qryName =document.frme234.detType.options[document.frme234.detType.options.selectedIndex].text;
					var phoneNo = document.frme234.phoneNo.value;
					var beginTime = document.frme234.beginTime.value;
					var endTime = document.frme234.endTime.value;
					var opCode = document.frme234.opCode.value;

					var getdataPacket = new AJAXPacket("fe369_1.jsp","正在获得操作代码路径，请稍候......");
					getdataPacket.data.add("qryType",qryType);
					getdataPacket.data.add("phoneNo",phoneNo);
					getdataPacket.data.add("beginTime",beginTime);
					getdataPacket.data.add("endTime",endTime);
					getdataPacket.data.add("opCode",opCode);
					core.ajax.sendPacket(getdataPacket);
					getdataPacket = null;
					
					
	}
			 function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var oButton = document.getElementById("quchoose"); 
			if(retCode == "000000"){
			rdShowMessageDialog("录入成功！",2);
			oButton.disabled = false;
			}else{
				rdShowMessageDialog("录入失败！ 错误代码：" + retCode + "，错误信息：" + retMsg,0);
				oButton.disabled = false;
				 
			}
			var getdataPacket = new AJAXPacket("/npage/query/fAjax50851.jsp","正在获得数据，请稍候......");
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
		
				function doReset(){
			window.location.href = "fe369.jsp?opCode=<%=opCode%>&opName=<%=opName%>"
		}
		 function querys() {
		  var lac_idss =document.frme234.lac_id.value; 
		  var cell_idss =document.frme234.cell_id.value; 
		  if(lac_idss.trim()=="" && cell_idss.trim()=="") {
		  rdShowMessageDialog("查询条件不能都为空，请重新输入！" ,0);
		  return false;
		  }
		  if(lac_idss.trim()=="") {
		  rdShowMessageDialog("lac_id不能为空，请重新输入！" ,0);
		  return false;
		  }
		  if(cell_idss.trim()=="") {
		  rdShowMessageDialog("cell_id不能为空，请重新输入！" ,0);
		  return false;
		  }
		  
		  		var getdataPacket = new AJAXPacket("fe369_query.jsp","正在获得数据，请稍候......");
					getdataPacket.data.add("lac_id",lac_idss);
					getdataPacket.data.add("cell_id",cell_idss);
					core.ajax.sendPacketHtml(getdataPacket,chaxunqr,true);
					getdataPacket = null;
		  
		 }
		 function chaxunqr(data) {
		 			
				//找到添加表格的div
				var markDiv=$("#chaquer"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
 
		 }
		 
		</script>
		<jsp:include page="/npage/client4A/treasuryStatus1.jsp">
		<jsp:param name="opCode" value="<%=opCode%>"  />
		<jsp:param name="opName" value="<%=opName%>"  />
		</jsp:include>
		<body>
		<form name="frme234" method="POST" action="">
	<%@ include file="/npage/include/header.jsp" %>
		<div class="title">
		<div id="title_zi">安保部详单查询录入功能</div>
	</div>
	<table cellspacing="0">
				<tr>
			<td class="blue" >手机号码</td>
			<td >
				<input type="text" id="phoneNo" name="phoneNo"  v_must="1" 
						v_type="mobphone" onblur="checkElement(this)" style="width:147px;"  maxlength="11" />
						<font class="orange">*</font> 
			</td>

            <TD class="blue">详单类型</TD>
            <TD > 
              <select align="left" name="detType" width=50 index="4" >
              	<option class="button" value="25">全部</option>
              	           <%
        	for(int i=0;i<rets1.length; i++){
			    out.println("<option class='button' value='"+rets1[i][0]+"'>"+rets1[i][1]+"</option>");
			    }
		      %>
                </select>
             </TD>
        </TR>
				<tr>
          <TD class="blue" >开始日期</TD>
          <TD >
            <input type="text" class="button" name="beginTime" style="width:147px;" size="20" maxlength="8" value=<%=mon[1]+"01"%>></TD>
          <TD class="blue" >结束日期</TD>
          <TD >
             <input type="text" class="button" name="endTime" style="width:147px;" size="20" maxlength="8" value=<%=dateStr%>></TD>
		</tr>

  </table>
 
	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="quchoose" class="b_foot" value="确定" onclick="quechoosee()" />		
				&nbsp;
				<input type="button" name="close" class="b_foot" value="关闭" onClick="removeCurrentTab();"/>
			</div>
			</td>
		</tr>
	</table>
	<br>
	<br>
	<br>
	<br>

	
	<table cellspacing="0">
				
				<tr>
          <TD class="blue" >lac_id</TD>
          <TD >
            <input type="text" class="button" id="lac_id" name="lac_id" style="width:147px;" size="20" maxlength="6" value=""></TD>
          <TD class="blue" >cell_id</TD>
          <TD >
             <input type="text" class="button" id="cell_id" name="cell_id" style="width:147px;" size="20" maxlength="6" value=""></TD>
		</tr>

  </table>
  
  	 	<table cellspacing="0">
		<tr>
			<td noWrap id="footer">
			<div align="center">
					<input type="button"  name="queryssss" class="b_foot" value="查询" onclick="querys()" />		
					&nbsp;
					<input name="back" onClick="doReset()" type="button" class="b_foot"  value="清除">
				
			</div>
			</td>
		</tr>
	</table>
	<br>
	<div id="chaquer">
	</div>
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/footer.jsp" %>
	
</form>


</body>
</html>