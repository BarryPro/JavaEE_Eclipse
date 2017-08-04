<%
   /*
   * 功能: SP查询退订
　 * 版本: v1.0
　 * 日期: 2008年11月04日
　 * 作者: kouwb
　 * 版权: sitech
   * 修改历史
   * 修改日期 2009年05月08日     修改人 libina      修改目的  解决sp业务价格小数点后不显示的问题   修改为位置174、176行
   * 修改日期 2009年06月14日     修改人 libina      修改目的  添加日期选择按钮
 　*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.text.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    	//清除缓存
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 

  String org_code = (String)session.getAttribute("orgCode");
  String regionCode=org_code.substring(0,2);
  String phone_no = (String)session.getAttribute("activePhone");
  
  
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
%>
<wtc:service name="sHW_SpQryByUsr" outnum="12" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="result" start="2" length="10" scope="end" />
	
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
<script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<%!
 public  String getCurrDateStr(String str) {
		java.text.SimpleDateFormat objSimpleDateFormat = new java.text.SimpleDateFormat(
				"yyyyMMdd");
		return objSimpleDateFormat.format(new java.util.Date()) + " " + str;
	}	
%>
<script language="javascript"> 	
	function doProcesss(packet)
	 {
		var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg  = packet.data.findValueByName("retMsg");	
	
		if(retType=='spInfo')
		{	

			if(retCode=='000000')
			{	
				
				rdShowMessageDialog(retMsg + "[" + retCode + "]",2);
				
				if(window.parent!=null){
	    		//window.opener.$("#spInfo").load("fspInfo.jsp");
	    		window.location.reload();
	    		
	    	}else{
	    		$("#spInfo").load("fspInfo.jsp");
	    	}		
				
			}
			else
			{	
				rdShowMessageDialog(retMsg + "[" + retCode + "]",0);
			}
		}
	}
	
	function doProcesss_new(packet)
	{
		var retType = packet.data.findValueByName("retType");		
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");	
		var sp_bizcode = packet.data.findValueByName("sp_bizcode");	
	
		if(retType=='spInfo')
		{	

			if(retCode=='000000')
			{	
				num++;
				if(num == checklen){
					rdShowMessageDialog(retMsg + "[" + retCode + "]",2);
					
					if(window.parent!=null){
		    		//window.opener.$("#spInfo").load("fspInfo.jsp");
		    		window.location.reload();
		    		
		    	}else{
		    		$("#spInfo").load("fspInfo.jsp");
		    	}	
	    	}	
				ConfirmJspbAll_new();
			}
			else
			{	
				rdShowMessageDialog("["+sp_bizcode+"]"+retMsg + "[" + retCode + "]",0);
				my_array = new Array();
				checklen = 0;
				num = 0;
			}
		}
	}
	
	function ConfirmJspb(x,y)
	{
		y =encodeURIComponent(y);
		if(rdShowConfirmDialog("是否确定提交？") == 1){
			var myPacket = new AJAXPacket("/npage/portal/kfuser/spInfo.jsp","正在提交，请稍候......");
			myPacket.data.add("retType","spInfo");
			myPacket.data.add("phone_no","<%=phone_no%>");
			myPacket.data.add("login_no","<%=workNo%>");
			myPacket.data.add("sp_code",x);
			myPacket.data.add("sp_bizcode",y);
			core.ajax.sendPacket(myPacket,doProcesss);
			myPacket=null;
			
		}
	} 
	
	function ConfirmJspb_new(x,y)
	{
		y =encodeURIComponent(y);
		//if(rdShowConfirmDialog("是否确定提交？") == 1){
			var myPacket = new AJAXPacket("/npage/portal/kfuser/spInfo.jsp","正在提交，请稍候......");
			myPacket.data.add("retType","spInfo");
			myPacket.data.add("phone_no","<%=phone_no%>");
			myPacket.data.add("login_no","<%=workNo%>");
			myPacket.data.add("sp_code",x);
			myPacket.data.add("sp_bizcode",y);
			core.ajax.sendPacket(myPacket,doProcesss_new);
			myPacket=null;
			
		//}
	}
	
	function   getLastDay(){   
  var   theDay   =   new   Date(year.value,month.value,0);   
  //theDay   =   new   Date(theDay.getFullYear(),theDay.getMonth(),theDay.getDate()-1);   
  alert(theDay.getFullYear()+"-"+(theDay.getMonth()+1)+"-"+theDay.getDate());   
  }
	
	// by xingzhan 20090511 全选
	function fcheckall(obj){
		//alert("111");
		if(obj.checked){
			var check = document.getElementsByName("mycheck_new");
			for(var i =0;i<check.length;i++){
				
				check[i].checked=true;
			}
			//alert("ok");
		}else {
			var check = document.getElementsByName("mycheck_new");
			for(var i =0;i<check.length;i++){
				
				check[i].checked=false;
			}
			//alert("no");
		}
	}

	// by xingzhan 20090511 批量退订
	var checklen = 0;
	var num = 0;
	var my_array = new Array();
	function ConfirmJspbAll(){
	
		var check = document.getElementsByName("mycheck_new");
	  
	  for(var i =0;i<check.length;i++){
			if(check[i].checked){
					my_array[checklen] = check[i].value;
					checklen++;
			}
		}
		if(checklen>0){
			if(rdShowConfirmDialog("是否确定提交？") == 1){
				ConfirmJspbAll_new();
			}
		}else{
			rdShowMessageDialog("请至少选择一条sp信息！",1);
		}
	}
	
	function ConfirmJspbAll_new(){	
		
		if(num != checklen){
			var values = my_array[num].split(",");
			var value0 = values[0];
			var value1 = values[1];
			ConfirmJspb_new(value0,value1);
		}else{
			my_array = new Array();
			checklen = 0;
			num = 0;
		}
	}
	
	function getSpHis(){
		if( document.all.time_begin.value == ""){
    	   showTip(document.all.time_begin,"开始时间不能为空");
    	   all.time_begin.focus();
    }else if(document.all.time_end.value == ""){
		     showTip(document.all.time_end,"结束时间不能为空");
    	   all.time_end.focus();
    }else if(document.all.time_end.value<=document.all.time_begin.value){
		     showTip(document.all.time_end,"结束时间必须大于开始时间");
    	   all.time_end.focus();
    }		

		var begin = document.all.time_begin.value;
		var end = document.all.time_end.value;  

		window.parent.showPageInfo('<%=request.getContextPath()%>/npage/portal/kfuser/fSpHis.jsp?time_begin='+begin+'&time_end='+end);		
	}
	
 </script>	
	<link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
		 <link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<div>
	<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	  <tr>							
		  <td align="center" width="20%">开始时间</td>
      <td align="left" width="65%">
	      <input id="time_begin" name ="time_begin" type="text"  value="<%=getCurrDateStr("00:00:00")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all.time_begin);return false;">
	      <img onclick="WdatePicker({el:$dp.$('time_begin'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	    </td>	  		       		  	
	    <td align="center" width="15%"><input type="button" name="sp_his" value="历史查询" onclick="getSpHis()"/></td>         
		</tr>
		<tr>
		  <td align="center" width="20%">结束时间</td>
      <td align="left" width="65%">
	      <input id="time_end" name ="time_end" type="text"   value="<%=getCurrDateStr("23:59:59")%>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.all.time_end);">
	      <img onclick="WdatePicker({el:$dp.$('time_end'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}})" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
	    </td> 
	    <td align="center" width="15%"><input type="button" name="" value="批量退订" onclick="ConfirmJspbAll();"/></td>            
		</tr>
	</table> 	
</div>
<div id="form">
 <div class="table_biaoge" style="overflow-x:auto">
	<table width="200%" class="ctl" cellpadding="0" cellspacing="0">
  	<tr> 
  		<th width="8%"  NOWRAP> 全选 <input type="checkbox" name="checkall" value="" onclick="fcheckall(this);"></th>
    	<th width="8%"  NOWRAP>企业代码</th>
			<th width="8%"  NOWRAP>企业名称</th>
			<th width="8%"  NOWRAP>业务代码</th>
			<th width="8%"  NOWRAP>业务名称</th>
			<th width="8%"  NOWRAP>服务费</th>
			<th width="15%" NOWRAP>订购时间</th>		 
			<th width="8%"  NOWRAP>订购/取消方式</th>
			<th width="8%"  NOWRAP>收费方式</th>
			<th width="8%"  NOWRAP>退订</th>	      
	  </tr> 	 
    <%
		if(retCode.equals("000000")){
			if(result.length>0){
				for(int i=0;i<result.length;i++){
	      	String classes="";
					if(i%2==1){classes="grey";}
					{
					//(result[i][6]==null||"".equals(result[i][6]))?"0":(Integer.parseInt(result[i][6])/1000)
					double	price =0.0;
					if(result[i][6]!=null&&!"".equals(result[i][6])){
						price = Double.parseDouble(result[i][6])/1000;
					}	
			%>	             
		<tr>
		  <td nowrap class="<%=classes%>" title="<%=result[i][0]%>"><input type="checkbox" name="mycheck_new" value="<%=result[i][0].equals("")?"&nbsp;":result[i][0]%>,<%=result[i][2].equals("")?"&nbsp;":result[i][2]%>"></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][0]%>"><%=result[i][0].equals("")?"&nbsp;":result[i][0]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][1]%>"><%=result[i][1].equals("")?"&nbsp;":result[i][1]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][2]%>"><%=result[i][2].equals("")?"&nbsp;":result[i][2]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][3]%>"><%=result[i][3].equals("")?"&nbsp;":result[i][3]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][6]%>"><%=price%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][9]%>"><%=result[i][9].equals("")?"&nbsp;":result[i][9]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][8]%>"><%=result[i][8].equals("")?"&nbsp;":result[i][8]%></td>
			<td nowrap class="<%=classes%>" title="<%=result[i][5]%>"><%=result[i][5].equals("")?"&nbsp;":result[i][5]%></td>
			<td nowrap class="<%=classes%>"><a href="javascript:ConfirmJspb('<%=result[i][0]%>','<%=result[i][2]%>');">[退订]</a></td>
		</tr>
		<%
		       }
			   }
			 }
		 }
		%>	
		<tr>
		</tr>
  </table>
</div>	
