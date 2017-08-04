<%
  /*
   * 功能: 人工转自动-转业务咨询维护结点数据
　 * 版本: 1.0.0
　 * 日期: 2009/08/07
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
String strSql="";
String addvalxin = "";
String addvalyin="";
String message="";
String retType = WtcUtil.repNull(request.getParameter("retType"));
addvalxin = (String)request.getParameter("addvalxin");
addvalyin = (String)request.getParameter("addvalyin");
message = (String)request.getParameter("addvalzhi");
String[] addvalxnew=addvalxin.split(",");
String[] addvalynew=addvalyin.split(",");
 
System.out.println("=============================="); 
System.out.println(addvalxnew);

System.out.println(addvalynew);
System.out.println(message);
System.out.println("==============================");

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);

    if (retType.equals("addsceTrans"))
    {
/**原
strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
strSql+="select  "+addvalxnew[0]+"||"+addvalynew[0]+"||user_class_id||'"+addvalxnew[3]+"',substr("+addvalxnew[0]+"||"+addvalynew[0]+"||user_class_id||'"+addvalxnew[3]+"',0,length("+addvalxnew[0]+"||"+addvalynew[0]+"||user_class_id||'"+addvalxnew[3]+"')-1), ";
strSql+="  "+addvalxnew[0]+" ,'"+addvalynew[0]+"',  user_class_id  ,'" +addvalxnew[2]+"','"+addvalxnew[3]+"',"+addvalxnew[4]+",'"+message+"',"+addvalxnew[1]+",'','','', " +addvalxnew[5];
strSql+=" FROM DUAL ,SCALLGRADECODE B";

格式化strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
strSql+="select  '"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',substr('"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',0,length('"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"')-1), ";
strSql+="  '"+addvalxnew[0]+"' ,'"+addvalynew[0]+"',  user_class_id  ,'"+addvalxnew[2]+"','"+addvalxnew[3]+"','"+addvalxnew[4]+"','"+message+"','"+addvalxnew[1]+"','','','', '"+addvalxnew[5]+"'";
strSql+=" FROM DUAL ,SCALLGRADECODE B";
*/
    	strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
    	strSql+="select   :v1|| :v2||user_class_id|| :v3,substr( :v4|| :v5||user_class_id|| :v6,0,length( :v7|| :v8||user_class_id|| :v9)-1), ";
    	strSql+="   :v10 , :v11,  user_class_id  , :v12, :v13, :v14, :v15, :v16,'','','',  :v17";
    	strSql+=" FROM DUAL ,SCALLGRADECODE B";
    	
    	%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
   	<wtc:param value="<%=strSql%>"/>
   	<wtc:param value="dbchange"/>
   	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[4]%>"/>
	<wtc:param value="<%=message%>"/>
	<wtc:param value="<%=addvalxnew[1]%>"/>
	<wtc:param value="<%=addvalxnew[5]%>"/>
	</wtc:service>
    	<%
     	
	  }else if(retType.equals("modifysceTrans"))
	  {
		String yuanid = (String)request.getParameter("sceid");
		String accesscode = (String)request.getParameter("accesscode");
		String citycode = (String)request.getParameter("citycode");
		String digitcode = (String)request.getParameter("digitcode");
  		/**strSql="  update DZXSCETRANSFERTAB set ID='"+addvalxnew[2]+"'||'"+addvalynew[0]+"'||USERCLASS||'"+addvalxnew[3]+"'";
  		strSql+=" ,superid=substr( '"+addvalxnew[2]+"'||'"+addvalynew[0]+"'||USERCLASS||'"+addvalxnew[3]+"',0,length('"+addvalxnew[2]+"'||'"+addvalynew[0]+"'||USERCLASS||'"+addvalxnew[3]+"')-1)"  ;
  		strSql+=" ,TYPEID= '"+addvalxnew[0]+"'";
  		strSql+=" ,SERVICENAME= '"+addvalxnew[1]+"'";
  		strSql+=" ,ACCESSCODE= '"+addvalxnew[2]+"'";
  		strSql+=" ,DIGITCODE= '"+addvalxnew[3]+"'";
  		strSql+=" ,TRANSFERCODE= '"+addvalxnew[4]+"'";
  		strSql+=" ,VISIABLE= '"+addvalxnew[5]+"'";
  		strSql+=" ,messegecontent= '"+addvalxnew[6]+"'";
  		strSql+=" ,CITYCODE= '"+addvalynew[0]+"'";
  		strSql+="  where accesscode= '"+accesscode+"'";
  		strSql+="  and citycode= '"+citycode+"'";
  		strSql+="  and digitcode= '"+digitcode+"'";
  		*/
		strSql="  update DZXSCETRANSFERTAB set ID= :v1|| :v2||USERCLASS|| :v3";
  		strSql+=" ,superid=substr(  :v4|| :v5||USERCLASS|| :v6,0,length( :v7|| :v8||USERCLASS|| :v9)-1)"  ;
  		strSql+=" ,TYPEID=  :v10";
  		strSql+=" ,SERVICENAME=  :v11";
  		strSql+=" ,ACCESSCODE=  :v12";
  		strSql+=" ,DIGITCODE=  :v13";
  		strSql+=" ,TRANSFERCODE=  :v14";
  		strSql+=" ,VISIABLE=  :v15";
  		strSql+=" ,messegecontent=  :v16";
  		strSql+=" ,CITYCODE=  :v17";
  		strSql+="  where accesscode=  :v18";
  		strSql+="  and citycode=  :v19";
  		strSql+="  and digitcode=  :v20";
  		%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
   	<wtc:param value="<%=strSql%>"/>
   	<wtc:param value="dbchange"/>
   	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalxnew[1]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[4]%>"/>
	<wtc:param value="<%=addvalxnew[5]%>"/>
	<wtc:param value="<%=addvalxnew[6]%>"/>
	<wtc:param value="<%=addvalynew[0]%>"/>
	<wtc:param value="<%=accesscode%>"/>
	<wtc:param value="<%=citycode%>"/>
	<wtc:param value="<%=digitcode%>"/>
</wtc:service>
  		<%
	  		 
	  		
	  }
	  
	  System.out.println(strSql);
%>

<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);