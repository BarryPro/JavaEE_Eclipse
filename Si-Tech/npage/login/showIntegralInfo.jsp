 <%
/********************
 version v2.0
 开发商 si-tech
 create hejwa@2010-10-15  
 功能   查询用户积分信息
 更新记录 
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
 
<%
		
    String opName = "积分查询";
    String opCode = WtcUtil.repNull(request.getParameter("opCode"));
    String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
 	String regionCode = (String)session.getAttribute("regCode");
    
 
 
 
String integralATime          = "";        //用户积分申请时间
String initIntegral           = "";        //初始化积分      
String currentIntegral        = "";        //当前积分        
String yearIntegral           = "";        //年度积分        
String accumulationIntegral   = "";        //累计积分        
String integralUTime          = "";        //积分变更时间    
String integralBTime          = "";        //积分开始计算时间
String grandUseIntegral       = "";        //总使用积分      
String grandPrizeIntegral     = "";        //总奖励积分      
String grandReducIntegral     = "";        //总扣减积分      
String byearIntegral          = "";        //上年度积分      
String cMonthIntegral         = "";        //本月基本积分    

String sPubUserMsgFlag = "";
	try{
		sPubUserMsgFlag = "109";
%>		
	 	<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_109" retcode="retCode_109" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_109" scope="end" />
<%    
	sPubUserMsgFlag = "110";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_110" retcode="retCode_110" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_110" scope="end" />
<%    
	sPubUserMsgFlag = "111";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_111" retcode="retCode_111" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_111" scope="end" />	
<%    
	sPubUserMsgFlag = "112";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_112" retcode="retCode_112" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_112" scope="end" />
<%    
	sPubUserMsgFlag = "113";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_113" retcode="retCode_113" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_113" scope="end" />								
<%    
	sPubUserMsgFlag = "114";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_114" retcode="retCode_114" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_114" scope="end" />	
<%    
	sPubUserMsgFlag = "115";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_115" retcode="retCode_115" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_115" scope="end" />							
<%    
	sPubUserMsgFlag = "116";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_116" retcode="retCode_116" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_116" scope="end" />		
<%    
	sPubUserMsgFlag = "117";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_117" retcode="retCode_117" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_117" scope="end" />	
<%    
	sPubUserMsgFlag = "118";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_118" retcode="retCode_118" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_118" scope="end" />	
			
<%    
	sPubUserMsgFlag = "119";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_119" retcode="retCode_119" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_119" scope="end" />	
<%    
	sPubUserMsgFlag = "120";
%>	
		<wtc:service name="sPubUserMsg" outnum="3" retmsg="retMsg_120" retcode="retCode_120" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="0" />
			<wtc:param value="<%=phoneNo%>" />	
			<wtc:param value="<%=sPubUserMsgFlag%>" />	
		</wtc:service>
		<wtc:array id="result_120" scope="end" />									
<%			
		if(retCode_119.equals("000000")&&result_119.length>0){
			byearIntegral = result_119[0][2] ;
		}
		if(retCode_120.equals("000000")&&result_120.length>0){
			cMonthIntegral = result_120[0][2] ;
		}
		
		if(retCode_118.equals("000000")&&result_118.length>0){
			grandReducIntegral = result_118[0][2] ;
		}
		if(retCode_117.equals("000000")&&result_117.length>0){
			grandPrizeIntegral = result_117[0][2] ;
		}
		if(retCode_116.equals("000000")&&result_116.length>0){
			grandUseIntegral = result_116[0][2] ;
		}
		if(retCode_115.equals("000000")&&result_115.length>0){
			integralBTime = result_115[0][2] ;
		}
		if(retCode_114.equals("000000")&&result_114.length>0){
			integralUTime = result_114[0][2] ;
		}
		if(retCode_113.equals("000000")&&result_113.length>0){
			accumulationIntegral = result_113[0][2] ;
		}
		
		if(retCode_112.equals("000000")&&result_112.length>0){
			yearIntegral = result_112[0][2] ;
		}
		
		if(retCode_111.equals("000000")&&result_111.length>0){
			currentIntegral = result_111[0][2] ;
		}
		if(retCode_110.equals("000000")&&result_110.length>0){
			initIntegral = result_110[0][2] ;
		}
		
		if(retCode_109.equals("000000")&&result_109.length>0){
			integralATime = result_109[0][2] ;
		}
	}catch(Exception ex){ }

 
%>		
<html>
<head>
<title> 话费余额查询</title>
</head>


<body>
<form name="form1">
<div id="Main">
   <DIV id="Operation_Table"> 
<div class="title"><div id="title_zi">积分信息查询</div></div>
   <table  cellspacing="0">
   	  <tr>
   	   	<td class="blue">用户积分申请时间</td>
   	   	<td><input type="text" name="integralATime"  id="integralATime" readOnly value="<%=integralATime%>"></td>
   	   	<td class="blue">初始化积分</td>
   	   	<td><input type="text" name="initIntegral"  id="initIntegral"  readOnly value="<%=initIntegral%>"></td>
   	  </tr> 
   	  
   	   
   	  
   	  <tr>
   	   	<td class="blue">当前积分</td>
   	   	<td><input type="text" name="currentIntegral"  id="currentIntegral"  readOnly value="<%=currentIntegral%>"></td>
   	   	<td class="blue">年度积分</td>
   	   	<td><input type="text" name="yearIntegral"  id="yearIntegral"  readOnly value="<%=yearIntegral%>"></td>
   	  </tr> 
   	   
   	  
   	  <tr>
   	   	<td class="blue">累计积分</td>
   	   	<td><input type="text"  name="accumulationIntegral"  id="accumulationIntegral" readOnly value="<%=accumulationIntegral%>"></td>
   	   	<td class="blue">积分变更时间</td>
   	   	<td><input type="text"  name="integralUTime"  id="integralUTime" readOnly value="<%=integralUTime%>"></td>
   	  </tr> 
   	  
   	  <tr>
   	   	<td class="blue">积分开始计算时间</td>
   	   	<td><input type="text"   name="integralBTime"  id="integralBTime" readOnly value="<%=integralBTime%>"></td>
   	   	<td class="blue">总使用积分</td>
   	   	<td><input type="text"   name="grandUseIntegral"  id="grandUseIntegral" readOnly value="<%=grandUseIntegral%>"></td>
   	  </tr> 
   	  
   	  <tr>
   	   	<td class="blue">总奖励积分</td>
   	   	<td><input type="text"   name="grandPrizeIntegral"  id="grandPrizeIntegral" readOnly value="<%=grandPrizeIntegral%>"></td>
    	   	<td class="blue">总扣减积分</td>
   	   	<td><input type="text"   name="grandReducIntegral"  id="grandReducIntegral" readOnly value="<%=grandReducIntegral%>"></td>
   	  </tr> 
   	  <tr>
   	   	<td class="blue">上年度积分</td>
   	   	<td><input type="text"   name="byearIntegral"  id="byearIntegral" readOnly value="<%=byearIntegral%>"></td>
    	   	<td class="blue">本月基本积分</td>
   	   	<td><input type="text"   name="cMonthIntegral"  id="cMonthIntegral" readOnly value="<%=cMonthIntegral%>"></td>
   	  </tr> 
   	    
   </table>
<%@ include file="/npage/include/footer.jsp" %>   
 </form>
</body>

</html>
