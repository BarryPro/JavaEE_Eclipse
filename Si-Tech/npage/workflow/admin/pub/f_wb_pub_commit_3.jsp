<%
/********************
 version v2.0
开发商: si-tech
公共提交页面
需要参数：用户输入的变量，工单号 和订单号
********************/
%>



<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

<%request.setCharacterEncoding("ISO-8859-1");%>  


<script>
	var CnttIdFromCsp="";
function _refreshParent()
{
	opener.condquery4();
	opener.condquery3();
}
</script>

<%      ///wono
  //String orgCode = (String)session.getAttribute("orgCode");
  
  String orgCode="0101009ml";
	
	
  String regionCode_wn = orgCode.substring(0,2);
  String CnttIdFromCsp=request.getParameter("CnttIdFromCsp");
  String loginAccept=request.getParameter("loginAccept");
  String phoneNo=request.getParameter("phoneNo");
  String wo_no_wn=request.getParameter("wono");
  String work_no =(String)session.getAttribute("workNo");
  String sqlStrOut="select accept_no from case_rec where flow_id="+wo_no_wn;
  String op_name = "工单受理";
  String wn_wn ="";
  System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
  System.out.println("["+CnttIdFromCsp+"]");
  System.out.println(loginAccept);
  System.out.println(phoneNo);
  System.out.println(wo_no_wn);
  System.out.println(sqlStrOut);
  System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
 %>
       <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode_wn%>"  retcode="retCode1" retmsg="retMsg1" outnum="4">
			<wtc:sql><%=sqlStrOut%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="outRet" scope="end" />
				
 <%
 		
         if(retCode1.equals("0")||retCode1.equals("000000")){
            System.out.println("调用服务sPubSelect in pubSysAccept.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
            
            	if(outRet.length==0){
 	            }else{
 	        	   wn_wn = (outRet[0][0]).trim(); 
 	        	   
 	        	}
            
            
 	     	}else{
 	         	System.out.println(retCode1+"    retCode1");
 	     		System.out.println(retMsg1+"    retMsg1");
 			   System.out.println("调用服务sPubSelect in pubSysAccept.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
 			}
 %>
<%
	String xmlstr = "";
	//long seq = test.LogCommit.getId();
	String wano=request.getParameter("_wano");
	System.out.println("00----------开始提交页面:"+wano);
  wano=(String)request.getAttribute("_wano");
	System.out.println("00----------开始提交页面:"+wano);		
  //new test.LogCommit().write(seq,"00----------开始提交页面:"+wano);
	
	String _dataid=request.getParameter("_dataid");
	System.out.println("00----------开始提交页面:"+_dataid);			
	_dataid=(String)request.getAttribute("_dataid");
	System.out.println("00----------开始提交页面:"+_dataid);
   String group_id=(String)session.getAttribute("_wb_groupid");
	
	String regionCode = "1";
	String opCode="6";
	System.out.println("1");
	if(_dataid==null||_dataid.equals(""))
	{
	System.out.println("2");
	 com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9302","f_wb_pub_commit.jsp ,_dataidis :"+_dataid+";commit中，页面失效，请重新处理"+" loginno:"+loginNo);
	}
	//从cache中获取数据，保存成功后删除
	
	String tmp_str=(String)WorkFlowCacheManager.get("gdcs");
	System.out.println("*******************************3");
	System.out.println(tmp_str);
	if(!("20081112".equals(tmp_str)))
	{
	System.out.println("*******************************4");
	 com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9303","缓存失效,测试tmp_str未取得值"+" loginno:"+loginNo);
	}
	System.out.println("*******************************5");
	ParseParaxml parsexml = (ParseParaxml)WorkFlowCacheManager.get(_dataid);
	//new test.LogCommit().write(seq,"0----in commit,dataid:"+_dataid);
	if(parsexml==null)
	{
	System.out.println("6");
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9300","commit中，页面失效，请重新处理"+" loginno:"+loginNo);
	//new test.LogCommit().write(seq,"1---页面失效，请重新处理:"+loginNo);
	%>
	<%

//-------------------------------------begin of 记录当前业务接触----------------------------
System.out.println("7");
 if(work_no.charAt(0)=='k'){
 System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
   if(CnttIdFromCsp!=null && CnttIdFromCsp.length()!=0){
		try{
			%>	
				<wtc:service name="sUpCnttInfo"  routerKey="region" routerValue="<%=regionCode_wn%>"    retcode="err_code" retmsg="err_message" outnum="0"  >
					<wtc:param value="<%=CnttIdFromCsp%>" />
					<wtc:param value="<%=wn_wn%>" />
					<wtc:param value="" />
					<wtc:param value="0125" />
					<wtc:param value="<%=op_name%>" />
					<wtc:param value="<%=loginAccept%>" />
					<wtc:param value="012502" />
					<wtc:param value="<%=phoneNo%>" />
					<wtc:param value="<%=phoneNo%>" />
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
			<%
				if(!err_code.equals("000000")){
					System.out.println("sUpCnttInfo记录接触错误:"+err_code);
			   }
	    }catch(Throwable e)
	    {
	    }
	    
     }else{
     	System.out.println("8");
  	System.out.println("ltlltlltlltltlltltltltlltlltllltltltllttlllttttttttttttltttttttttttttttttttttttttttttttttttttttttttttttttttttt");
  	 String urls1 = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012502&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		
 	<%
  	
  	}
		
 }else{
 	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
 	 String urls = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012502&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		<jsp:include page="<%=urls%>" flush="true" />
 	<%
 	
 	}
 
//-------------------------------------end of 记录当前业务接触 ---------------------------- 
%>
		<script>
		alert('页面失效，请重新处理');
		window.close();
		_refreshParent();
	</script>
		<%
		return;
	}
%>
 
<%
try
{
%>
<wtc:service name="sGetWAParamPage" outnum="2" >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="2"/>
        <wtc:param value="<%=wano%>"/>
</wtc:service>
<wtc:array id="ret"  start="0" length="2" scope="end" /> 
	
<% 
//new test.LogCommit().write(seq,"2-------调用服务sGetWAParamPage等待返回参=================================");

if(retCode.equals("000000"))
{
System.out.println("9");
    //new test.LogCommit().write(seq,"3--------保存数据成功==sGetWAParamPage");
	xmlstr = ret[0][0];
}
else
{
//new test.LogCommit().write(seq,"4-------保存失败,原因为："+retMsg);
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9800","commit中，sGetWAParamPage失败:原因为："+retMsg+" loginno:"+loginNo);
%>
<%

//-------------------------------------begin of 记录当前业务接触----------------------------
System.out.println("10");
 if(work_no.charAt(0)=='k'){
 System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
   if(CnttIdFromCsp!=null && CnttIdFromCsp.length()!=0){
		try{
			%>	
				<wtc:service name="sUpCnttInfo"  routerKey="region" routerValue="<%=regionCode_wn%>"   retcode="err_code" retmsg="err_message" outnum="0"  >
					<wtc:param value="<%=CnttIdFromCsp%>" />
					<wtc:param value="<%=wn_wn%>" />
					<wtc:param value="" />
					<wtc:param value="0125" />
					<wtc:param value="<%=op_name%>" />
					<wtc:param value="<%=loginAccept%>" />
					<wtc:param value="012501" />
					<wtc:param value="<%=phoneNo%>" />
					<wtc:param value="<%=phoneNo%>" />
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
			<%
				if(!err_code.equals("000000")){
					System.out.println("sUpCnttInfo记录接触错误:"+err_code);
			   }
	    }catch(Throwable e)
	    {
	    }
    }else{
	    	System.out.println("ltlltlltlltltlltltltltlltlltllltltltllttlllttttttttttttltttttttttttttttttttttttttttttttttttttttttttttttttttttt");
	    	 String urls1 = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012501&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
		 	%>
		 		
		 	<%
	    	
	    	}

		
 }else{
 	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
 	 String urls = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012501&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		<jsp:include page="<%=urls%>" flush="true" />
 	<%
 	
 	}
 
//-------------------------------------end of 记录当前业务接触 ---------------------------- 
%>
<script>
alert("保存失败,原因为：<%=retMsg%>");
window.close();
_refreshParent();
</script>

<%
return;
}
}catch(Exception ex)
{
System.out.println("11");
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9900","commit中，sGetWAParamPage调用异常"+" loginno:"+loginNo);
	throw new Exception("服务调用失败");
}


    System.out.println("@@@@sGetWAParamPage="+xmlstr);
    Map wbMap = parsexml.ParameterMap2WbMap(request.getParameterMap());
 		String str = ParseData2XML.getOutputXMLStr(xmlstr,wbMap,"OUTPUT_PARAM","UTF-8") ;
    System.out.println("@@@@@@@@@@"+str);
 		response.setContentType("text/html;charset=gb2312");

try{
System.out.println("12");
%>
<wtc:service name="sSetWAObj" outnum="0">
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=wano%>"/>
	      <wtc:param value="<%=str%>"/>
</wtc:service>

<% 
//new test.LogCommit().write(seq,"5-------调用服务sSetWAObj等待返回参===opCode=="+opCode+"=========wano===="+wano+"================="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"6--------调用服务sSetWAObj返回成功");
//进行提交操作
%>

<%
try{
System.out.println("13");
%>
<wtc:service name="sLoadWA" outnum="0"  >
	      <wtc:param value="<%=loginNo%>"/>
        <wtc:param value="7"/>
        <wtc:param value="<%=wano%>"/>
        <wtc:param value="<%=group_id%>"/>
</wtc:service>


<%
//new test.LogCommit().write(seq,"7-----------调用服务sLoadWA等待返回参===group_id=="+group_id+"=========wano===="+wano+"========loginNo======="+loginNo);
if(retCode.equals("000000"))
{
//new test.LogCommit().write(seq,"8--------调用服务sLoadWA返回成功");
	//保存成功后，删除缓存
	WorkFlowCacheManager.remove(_dataid);
%>
<%

//-------------------------------------begin of 记录当前业务接触----------------------------
System.out.println("14");
 if(work_no.charAt(0)=='k')
 {
     System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK"+CnttIdFromCsp);
     //System.out.println(CnttIdFromCsp.length()!=0);
     if(CnttIdFromCsp!=null && CnttIdFromCsp.length()!=0){
			     try{
						%>	
							<wtc:service name="sUpCnttInfo"  routerKey="region" routerValue="<%=regionCode_wn%>"    retcode="err_code" retmsg="err_message" outnum="0"  >
								<wtc:param value="<%=CnttIdFromCsp%>" />
								<wtc:param value="<%=wn_wn%>" />
								<wtc:param value="" />
								<wtc:param value="0125" />
								<wtc:param value="<%=op_name%>" />
								<wtc:param value="<%=loginAccept%>" />
								<wtc:param value="000000" />
								<wtc:param value="<%=phoneNo%>" />
								<wtc:param value="<%=phoneNo%>" />
							</wtc:service>
							<wtc:array id="rows"  scope="end"/>
						<%
							if(!err_code.equals("000000")){
								System.out.println("sUpCnttInfo记录接触错误:"+err_code);
						   }
				    }catch(Throwable e)
				    {
				    }
     
	    }else{
	    	System.out.println("ltlltlltlltltlltltltltlltlltllltltltllttlllttttttttttttltttttttttttttttttttttttttttttttttttttttttttttttttttttt");
	    	 String urls1 = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=000000&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
			 System.out.println(urls1);
		 	%>
		 		
		 	<%
	    	
	    	}
     
		
		
 }else{
 	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
 	 String urls = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=000000&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		<jsp:include page="<%=urls%>" flush="true" />
 	<%
 	
 	}
 
//-------------------------------------end of 记录当前业务接触 ---------------------------- 
%>
<script>
	
	alert("提交成功");
   window.close();
	_refreshParent();
//刷新页面

</script>

<%
	return;
}
else
{
System.out.println("15");
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9500","commit中，sLoadWA失败:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"9-------调用服务sLoadWA失败:"+retMsg);
%>
<%

//-------------------------------------begin of 记录当前业务接触----------------------------
System.out.println("16");
 if(work_no.charAt(0)=='k'){
 System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
   if(CnttIdFromCsp!=null && CnttIdFromCsp.length()!=0){
		try{
			%>	
				<wtc:service name="sUpCnttInfo"  routerKey="region" routerValue="<%=regionCode_wn%>"    retcode="err_code" retmsg="err_message" outnum="0"  >
					<wtc:param value="<%=CnttIdFromCsp%>" />
					<wtc:param value="<%=wn_wn%>" />
					<wtc:param value="" />
					<wtc:param value="0125" />
					<wtc:param value="<%=op_name%>" />
					<wtc:param value="<%=loginAccept%>" />
					<wtc:param value="012503" />
					<wtc:param value="<%=phoneNo%>" />
					<wtc:param value="<%=phoneNo%>" />
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
			<%
				if(!err_code.equals("000000")){
					System.out.println("sUpCnttInfo记录接触错误:"+err_code);
			   }
	    }catch(Throwable e)
	    {
	    }
	    
     }else{
  	System.out.println("ltlltlltlltltlltltltltlltlltllltltltllttlllttttttttttttltttttttttttttttttttttttttttttttttttttttttttttttttttttt");
  	 String urls1 = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012503&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		
 	<%
  	
  	}
		
 }else{
 	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
 	 String urls = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012503&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		<jsp:include page="<%=urls%>" flush="true" />
 	<%
 	
 	}
 
//-------------------------------------end of 记录当前业务接触 ---------------------------- 
%>
<script>
	alert("提交失败,原因为：<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}

}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9600","commit中，sLoadWA调用异常"+" loginno:"+loginNo);
		throw new Exception("服务调用失败");
}

%>

<%
}
else
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9400","commit中，sSetWAObj失败:"+retMsg+" loginno:"+loginNo);
//new test.LogCommit().write(seq,"10-------保存失败:"+retMsg);
%>
<%

//-------------------------------------begin of 记录当前业务接触----------------------------
System.out.println("17");
 if(work_no.charAt(0)=='k'){
 System.out.println("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
   if(CnttIdFromCsp!=null && CnttIdFromCsp.length()!=0){
		try{
			%>	
				<wtc:service name="sUpCnttInfo"  routerKey="region" routerValue="<%=regionCode_wn%>"    retcode="err_code" retmsg="err_message" outnum="0"  >
					<wtc:param value="<%=CnttIdFromCsp%>" />
					<wtc:param value="<%=wn_wn%>" />
					<wtc:param value="" />
					<wtc:param value="0125" />
					<wtc:param value="<%=op_name%>" />
					<wtc:param value="<%=loginAccept%>" />
					<wtc:param value="012504" />
					<wtc:param value="<%=phoneNo%>" />
					<wtc:param value="<%=phoneNo%>" />
				</wtc:service>
				<wtc:array id="rows"  scope="end"/>
			<%
				if(!err_code.equals("000000")){
					System.out.println("sUpCnttInfo记录接触错误:"+err_code);
			   }
	    }catch(Throwable e)
	    {
	    }
	    
	 }else{
  	System.out.println("ltlltlltlltltlltltltltlltlltllltltltllttlllttttttttttttltttttttttttttttttttttttttttttttttttttttttttttttttttttt");
  	 String urls1 = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012504&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		
 	<%
  	
  	}
	    
		
 }else{
 	System.out.println("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS");
 	 String urls = "/npage/contact/upCnttInfo.jsp?opCode=0125&retCodeForCntt=012504&opName="+op_name+"&workNo="+work_no+"&loginAccept="+loginAccept+"&contactId="+phoneNo;
 	%>
 		<jsp:include page="<%=urls%>" flush="true" />
 	<%
 	
 	}
 
//-------------------------------------end of 记录当前业务接触 ---------------------------- 
%>
<script>
	alert("保存失败,原因为：<%=retMsg%>");
	window.close();
	_refreshParent();
</script>

<%
}
%>
<%
}catch(Exception ex)
{
	com.sitech.boss.workflow.WorkFlowErrorRec.rec(wano,"00001","9700","commit中，sSetWAObj调用异常"+" loginno:"+loginNo);
		throw new Exception("服务调用失败");
}
%>
