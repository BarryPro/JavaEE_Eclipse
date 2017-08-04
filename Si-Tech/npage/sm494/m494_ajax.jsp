<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) -------------------
 
 -------------------------后台人员：--------------------------------------------
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	
<%

	String opCode         = WtcUtil.repNull(request.getParameter("opCode"));

	                      
  String regionCode     = (String)session.getAttribute("regCode");
                        
	String retCode        = "";
	String retMsg         = "";
	
	
	//7个标准化入参
	String paraAray[] = new String[1];
	
	paraAray[0] = " select a.region_code,a.region_name from sregioncode a where a.toll_no!='000' order by a.region_code";
								                             	                                    
	String serverName = "TlsPubSelCrm";

%>
		<wtc:service name="<%=serverName%>" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
<%
			for(int i=0; i<paraAray.length; i++ ){
				System.out.println("-----chenlei-------------paraAray["+i+"]------["+serverName+"]------>"+paraAray[i]);
%>
				<wtc:param value="<%=paraAray[i]%>" />
<%					
			}
%>									
		</wtc:service>
		<wtc:array id="serverResult" scope="end"  />
<body>
<select align="left" name="shopInfo" id="shopInfo"
		onChange="getShopInfo();" width=50 index="18">	
		<option class="button" value="00" selected>全省</option>
<%
	retCode = code;
	retMsg = msg;
	if (retCode.equals("000000") && serverResult.length > 0) {
	//拼装返回数组
		for(int i=0;i<serverResult.length;i++){
%>
		 
		 
		 <option class="button"  value="<%=serverResult[i][0]%>" ><%=serverResult[i][1]%></option>
<%	
			for(int j=0;j<serverResult[i].length;j++){
				System.out.println("--chenlei--------出参------serverName=["+serverName+"]--------serverResult["+i+"]["+j+"]------->"+serverResult[i][j]);
		
%>
				
		    
<%		
			}
		}
	}else{
		System.out.println("chenlei--------------调用服务失败！");
	}


	System.out.println("--chenlei--------retCode-----serverName=["+serverName+"]---------"+retCode);
	System.out.println("--chenlei--------retMsg------serverName=["+serverName+"]---------"+retMsg);
%> 	
</select>
</body>
</html>