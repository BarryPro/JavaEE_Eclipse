<%
    /********************
     * @ OpCode    :  8564
     * @ OpName    :  IMEI拆包查询
     * @ Services  :  QueryMark,
     * @ Pages     :  s8564/f8564.jsp,
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2011-03-23
     * @ Update    :  
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
  String opCode = "8564";
  String opName = "营销案返费及拆包情况查询";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	activePhone = request.getParameter("activePhone");
  String PhoneHead = activePhone.substring(0, 3);
	String op_name = "IMEI拆包查询";
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("rogCode");
	String password  = (String)session.getAttribute("password");
	String cust_id="";	
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="loginAccept"/>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">

onload=function()
	{		
		init();
	}

function init()
{
		document.all.verifyType[0].checked=true;
    chg_queryMethod();	
}	
	
function conf()
{		
  if(!check(document.frm)){
      	return false;			
  } 
  if(isNaN(document.frm.time.value))
  {
		rdShowMessageDialog("输入日期格式不对，请重新输入！");
		return false;
  }
  if(document.frm.time.value.length<6)
  {
  	rdShowMessageDialog("输入日期格式不对，请重新输入！");
		return false;
  }
  if(document.all.verifyType[1].checked){
	frm.action="f8564_1.jsp";
  frm.submit();
  }
 if(document.all.verifyType[0].checked){
 	  var phoneHead = <%=PhoneHead%>;
	  
	  		if(phoneHead == '147'){
	  			check147SuperTD("<%=activePhone%>");
	  			if(flagTD == "false"){
	  			rdShowMessageDialog("147号段只有TD公话号码才能办理该业务！");
	  			return false;
	 				}
	  		}
	  		if(phoneHead == '157'){
	  			check157SuperTD("<%=activePhone%>");
	  			if(flagTD == "false"){
	  			rdShowMessageDialog("157号段只有TD公话号码才能办理该业务！");
	  			return false;
	 				}
	  		}
	  		if(phoneHead == '184'){
	  			check184SuperTD("<%=activePhone%>");
	  			if(flagTD == "false"){
	  			rdShowMessageDialog("184号段只有TD公话号码才能办理该业务！");
	  			return false;
	 				}
	  		}
	 		else if(phoneHead !='147'&& phoneHead !='157' && phoneHead !='184' )
	      	{
						rdShowMessageDialog("只有147、157、184号段TD公话号码才能办理该业务！");
		  			return false;
	      	}  
	  
		frm.action="f8564_2.jsp";
	  frm.submit();
  }
}

function check147SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check147SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
function check157SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check157SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
function check184SuperTD(phoneNo){
		var phoneHead = phoneNo.substring(0,3);
		var check_Packet = new AJAXPacket("/npage/bill/check184SuperTD.jsp","正在进行校验，请稍候......");
		check_Packet.data.add("phoneNo",phoneNo);
		core.ajax.sendPacket(check_Packet,getResult);
		check_Packet=null;
}
var flagTD = "true";
function getResult(packet){
	var result=packet.data.findValueByName("result");
	if("false"==result){
		flagTD = "false";
	}else{
		flagTD = "true";
	}
}

function chg_queryMethod()
{
	 if(document.all.verifyType[0].checked==true) 
	 {	  
		 document.all.tr0.style.display="block";	
		 document.all.tr1.style.display="none";		
	 }else {
	 	validateFeeQuery();	
	  }	
}

function validateFeeQuery()
{
		var packet = new AJAXPacket("validateFeeQuery.jsp","正在验证用户信息，请稍候......");
	  packet.data.add("phoneNo","<%=activePhone%>");
	  core.ajax.sendPacket(packet,doInfo);
	  packet = null;
}

function doInfo(packet)
{
	 var retCode = packet.data.findValueByName("retCode");
   var retMsg = packet.data.findValueByName("retMsg");
   if(retCode != "000000")
   {
   		rdShowMessageDialog("错误信息："+retMsg+"！",0);
   		init(); 
   }else
   {
    	var no_type = packet.data.findValueByName("no_type");
    	if(no_type=="0000t")
    	{
	   		rdShowMessageDialog("铁通号码不能办理此业务！",1);
	   		init();    		
    	}else
  		{	
   			getFunctionName();  			
  		}
   }
}

function getFunctionName()
{	
		var packet = new AJAXPacket("getFunctionName.jsp","正在验证用户信息，请稍候......");
	  packet.data.add("phoneNo","<%=activePhone%>");
	  core.ajax.sendPacket(packet,doGetName);
	  packet = null;	
}

function doGetName(packet)
{	
	 var retCode = packet.data.findValueByName("retCode");
   var retMsg = packet.data.findValueByName("retMsg");	
   if(retCode != "000000")
   {   
   		rdShowMessageDialog(retMsg,1);
   		init();
   		return;
   }else
   {
			var opCodes = packet.data.findValueByName("opCodes");
			var names = packet.data.findValueByName("names");
			fillDropDown(document.all.functionname,opCodes,names);				 	
			document.all.tr0.style.display="none";	
			document.all.tr1.style.display="block";	
			return;
   }	
}

function fillDropDown(obj,_value,_text){
    obj.options.length = 0;
    for(var i=0; i<_value.length;i++)
    {
      var option = new Option(_text[i],_text[i]+"~"+_value[i]);
      obj.add(option);
   }
}
</script>
</head>
<body>
<form name="frm" method="POST" action="">
		<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
<%@ include	file="/npage/include/header.jsp"%>
	<div class="title">
    	<div id="title_zi">IMEI拆包查询</div>
    </div>
<table cellSpacing="0">        
          <tr> 
            <td nowrap class=blue width="10%">查询方式</td>                    
						<td colspan="4">
              <div align="left"> 							
								<input type="radio" name="verifyType" value="0" onclick="chg_queryMethod()">拆包资费查询&nbsp;&nbsp;
								<input type="radio" name="verifyType" value="1" onclick="chg_queryMethod()">拆包费用查询&nbsp;&nbsp;     
              </div>							       
            </td>				            
            
          </tr>

          <tr id="tr1"> 
            <td nowrap class=blue width="10%">营销案名称</td>
            <td  colspan="4" width="20%"> 
              <div align="left"> 
								<select name="functionname" class="button" id="functionname"></select>               			
              </div>
            </td>
          </tr>
          
          <tr>
            <td class=blue nowrap width="10%">电话号码</td>
            <td colspan="4" width="20%">
						<input   type="text" size="12" name="phoneNo" id="phoneNo" v_minlength=1 v_maxlength=16 v_type="phone" v_must=1   maxlength="11" index="0"  Class="InputGrey" readOnly  value ="<%=activePhone%>">
            </td>
          </tr>
          
          <tr id="tr0" style="display:none">
            <td class=blue nowrap width="10%">日期</td>
            <td colspan="4" width="20%">
						<input   type="text" size="12" name="time" id="time" v_minlength=1 maxlength=6  v_must=1   maxlength="11" index="0" value="<%=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date())%>"><font class="orange">*(格式为：YYYYMM)</font>
            </td>
          </tr>
                    
          <tr>
          	<td colspan="5" id="footer">
          		 <div align="center">
	          	   <input name="sumbit" class="b_foot" type="button"  value="查询" onClick="conf()">
	          		 <input type="button" name="close" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
               </div>
             </td>
          </tr>
</table>          	
<%@ include file="/npage/include/footer.jsp"%>	
</form>	 	
</body>
</html>
