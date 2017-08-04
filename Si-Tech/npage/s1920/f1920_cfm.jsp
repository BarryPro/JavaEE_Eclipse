<%
  /*
   * 功能: 定购关系受理：处理定购关系
　 * 版本: 1.8.2
　 * 日期: 2005/12/08
　 * 作者: bihua
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
　*/
%>

<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-09-04 页面改造,修改样式
     *
     ********************/
%>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
	
	<%@ page contentType="text/html; charset=GB2312" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode = "1920";
		String opName = "梦网业务订购受理";
			
		String login_no = (String)session.getAttribute("workNo");//工号
		String login_name = (String)session.getAttribute("workName");//工号姓名
		String org_code =(String)session.getAttribute("orgCode");//归属代码
		String login_passwd = (String)session.getAttribute("password");//工号密码
		String region_code = org_code.substring(0,2);

		String idType="01";
		String idValue  = request.getParameter("phoneno");
		String optype  = request.getParameter("optype");
		String opcode    = request.getParameter("opCode");//操作码
		String NewPasswd = request.getParameter("NewPasswd");
		String oldPasswd = request.getParameter("confirmPasswd");
		if(optype.equals("03")){
			NewPasswd = request.getParameter("modiPasswd");
			oldPasswd = request.getParameter("NewPasswd");
		}
		
		String HomeProv = request.getParameter("HomeProv");
		String bizType=request.getParameter("busytype");
		String spCode=request.getParameter("spCode");
		if(spCode!=null){
			spCode=spCode.trim();
		}
		String spBizCode=request.getParameter("spBizCode");
		if(spBizCode!=null){
			spBizCode=spBizCode.trim();
		}
		String infocode="";
		String infovalue="";
		
		String value001=request.getParameter("value001");
		String code001=request.getParameter("code001");
		System.out.println("value001"+value001);
		if(value001!=null && !value001.equals("")){
		        infocode+=code001+"|";
		        infovalue+=value001.trim()+"|";
		}
		String value002=request.getParameter("value002");
		String code002=request.getParameter("code002");
		System.out.println("value002"+value002);
		if(value002!=null && !value002.equals("")){
		        infocode+=code002+"|";
		        infovalue+=value002.trim()+"|";
		}
		String value003=request.getParameter("value003");
		String code003=request.getParameter("code003");
		System.out.println("value003"+value003);
		if(value003!=null && !value003.equals("")){
		        infocode+=code003+"|";
		        infovalue+=value003.trim()+"|";
		}
		String value004=request.getParameter("value004");
		String code004=request.getParameter("code004");
		System.out.println("value004"+value004);
		if(value004!=null && !value004.equals("")){
		        infocode+=code004+"|";
		        infovalue+=value004.trim()+"|";
		}
		String value300=request.getParameter("value300");
		String code300=request.getParameter("code300");
		System.out.println("value300"+value300);
		if(value300!=null && !value300.equals("")){
		        infocode+=code300+"|";
		        infovalue+=value300.trim()+"|";
		}
		String value301=request.getParameter("value301");
		String code301=request.getParameter("code301");
		System.out.println("value301"+value301);
		if(value301!=null && !value301.equals("")){
		        infocode+=code301+"|";
		        infovalue+=value301.trim()+"|";
		}
 		String value005=request.getParameter("value005");
		String code005=request.getParameter("code005");
		System.out.println("value005"+value005);
		if(value005!=null && !value005.equals("")){
		        infocode+=code005;
		        infovalue+=value005.trim();
		}
	
	//添加国际漫游优选业务开始
		String infocode006="";
		String infocode007="";
		String infocode008="";
		String infocode009="";
		String infocode010="";
		String code006=request.getParameter("code006");
		System.out.println("code006"+code006);
		if(code006!=null && !code006.equals("")){
		        infocode006+=code006;
		       
		}
		String code007=request.getParameter("code007");
		System.out.println("code007"+code007);
		if(code007!=null && !code007.equals("")){
		        infocode007+=code007;
		       
		}
		String code008=request.getParameter("code008");
		System.out.println("code008"+code008);
		if(code008!=null && !code008.equals("")){
		        infocode008+=code008;
		       
		}
		String code009=request.getParameter("code009");
		System.out.println("code009"+code009);
		if(code009!=null && !code009.equals("")){
		        infocode009+=code009;
		       
		}
		String code010=request.getParameter("code010");
		System.out.println("code010"+code010);
		if(code010!=null && !code010.equals("")){
		        infocode010+=code010;
		       
		}
			int i = 0;
			int errCode=0;
			String retCode="";
			String errMsg="";
	if(bizType.equals("30")){
			String[] paraArray = new String[9];
			paraArray[i++] = login_no;
			paraArray[i++] = org_code;
			paraArray[i++] = optype;
			paraArray[i++] = infocode006;
			paraArray[i++] = idValue;
			paraArray[i++] = infocode007;
			paraArray[i++] = infocode008;
			paraArray[i++] = infocode009;
			paraArray[i++] = infocode010;

			for(int k=0;k<paraArray.length;k++){
				System.out.println("paraArray["+k+"]=["+paraArray[k]+"]");
			}
			//ret = impl.callService("s4223Snd",paraArray,"2","phone",idValue);
%>
			<wtc:service name="s4223Snd" routerKey="phone" routerValue="<%=idValue%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
			<wtc:param value="<%=paraArray[0]%>"/>
			<wtc:param value="<%=paraArray[1]%>"/>
			<wtc:param value="<%=paraArray[2]%>"/>
			<wtc:param value="<%=paraArray[3]%>"/>
			<wtc:param value="<%=paraArray[4]%>"/>
			
			<wtc:param value="<%=paraArray[5]%>"/>
			<wtc:param value="<%=paraArray[6]%>"/>
			<wtc:param value="<%=paraArray[7]%>"/>
			<wtc:param value="<%=paraArray[8]%>"/>
			</wtc:service>
			<wtc:array id="result1" scope="end"/>
<%
		  errCode = retCode1==""?999999:Integer.parseInt(retCode1);
		  retCode = retCode1;
		  errMsg = retMsg1;
		
	}else{
	//添加国际漫游优选业务结束
	//初始话服务所需要的参数
			String[] paraArray = new String[24];
		  paraArray[i++] = "0";
			paraArray[i++] = login_no;
			paraArray[i++] = org_code;
		  paraArray[i++] = login_passwd;
			paraArray[i++] = "1920";
			
			paraArray[i++]= idType;
			paraArray[i++] = idValue;		
			paraArray[i++] = "451";
			paraArray[i++] = optype;
			paraArray[i++] = bizType;
			
			paraArray[i++] = spCode;
			paraArray[i++] = spBizCode;
			paraArray[i++] = NewPasswd;
			paraArray[i++] = oldPasswd;
			paraArray[i++] = "";
			paraArray[i++] = "";
			paraArray[i++] = "";
			paraArray[i++] = infocode;
			paraArray[i++] = infovalue;
			
			paraArray[i++] = "08";
			paraArray[i++] = "";
			paraArray[i++] = "";
			paraArray[i++] = "0";
			paraArray[i++] = "1";

			for(int k=0;k<paraArray.length;k++){
				System.out.println("paraArray["+k+"]=["+paraArray[k]+"]");
			}

			//ret = impl.callService("sBizReq",paraArray,"2","phone",idValue);
%>
			<wtc:service name="sBizReq" routerKey="phone" routerValue="<%=idValue%>" retcode="retCode1" retmsg="retMsg1" outnum="4" >
			<wtc:param value="<%=paraArray[0]%>"/>
			<wtc:param value="<%=paraArray[1]%>"/>
			<wtc:param value="<%=paraArray[2]%>"/>
			<wtc:param value="<%=paraArray[3]%>"/>
			<wtc:param value="<%=paraArray[4]%>"/>
			
			<wtc:param value="<%=paraArray[5]%>"/>
			<wtc:param value="<%=paraArray[6]%>"/>
			<wtc:param value="<%=paraArray[7]%>"/>
			<wtc:param value="<%=paraArray[8]%>"/>
			<wtc:param value="<%=paraArray[9]%>"/>
				
			<wtc:param value="<%=paraArray[10]%>"/>
			<wtc:param value="<%=paraArray[11]%>"/>
			<wtc:param value="<%=paraArray[12]%>"/>
			<wtc:param value="<%=paraArray[13]%>"/>
			<wtc:param value="<%=paraArray[14]%>"/>
				
			<wtc:param value="<%=paraArray[15]%>"/>
			<wtc:param value="<%=paraArray[16]%>"/>
			<wtc:param value="<%=paraArray[17]%>"/>
			<wtc:param value="<%=paraArray[18]%>"/>
			<wtc:param value="<%=paraArray[19]%>"/>
				
			<wtc:param value="<%=paraArray[20]%>"/>
			<wtc:param value="<%=paraArray[21]%>"/>
			<wtc:param value="<%=paraArray[22]%>"/>
			<wtc:param value="<%=paraArray[23]%>"/>
			</wtc:service>
			<wtc:array id="result1" scope="end"/>
<%
		  errCode = retCode1==""?999999:Integer.parseInt(retCode1);
		  retCode=retCode1;
		  errMsg = retMsg1;
	}
	System.out.println("%%%%%%%%调用统一接触开始%%%%%%%%");
	String loginAccept = "";
	String cnttActivePhone = idValue;
	if(errCode==0){
	   retCode="000000";
	}else
		{
		  retCode=retCode+"00";  //保证返回六位代码
		}
	
	String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retCode+"&opName="+opName+"&workNo="+login_no+"&loginAccept="+loginAccept+"&pageActivePhone="+cnttActivePhone+"&opBeginTime="+opBeginTime+"&contactId="+cnttActivePhone+"&contactType=user";
%>
	<jsp:include page="<%=url%>" flush="true" />
<%
	System.out.println("%%%%%%%%调用统一接触结束%%%%%%%%");
%>
<%if(errCode!=0){%>
		<script language="JavaScript">
      rdShowMessageDialog("业务受理失败，原因：<%=errMsg%>!");
      history.go(-1);
		</script>
<%}
else{
%>
		<script language="JavaScript">
		  rdShowMessageDialog("业务受理成功!",2);
		  location.href="f1920.jsp?activePhone=<%=idValue%>";
		</script>
<%}%>
