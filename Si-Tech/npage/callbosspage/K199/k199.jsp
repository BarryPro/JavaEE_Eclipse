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
  String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2); 
	String retType = WtcUtil.repNull(request.getParameter("retType"));
  addvalxin = (String)request.getParameter("addvalxin");
  addvalyin = (String)request.getParameter("addvalyin");
  message = (String)request.getParameter("addvalzhi");
  String[] addvalxnew=addvalxin.split(",");
  String[] addvalynew=addvalyin.split(",");
  
    if (retType.equals("addsceTrans"))
    {
     	strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
      strSql+="select  :v1||:v2||user_class_id||:v3,substr(:v4||:v5||user_class_id||:v6,0,length(:v7||:v8||user_class_id||:v9)-1), ";
      strSql+="  :v10 ,:v11,  user_class_id  ,:v12,:v13,:v14,:v15,:v16,'','','',:v17 ";
     	strSql+=" FROM DUAL ,SCALLGRADECODE B";
     	
     	strSql+="&&"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+message+"^"+addvalxnew[1]+"^"+addvalxnew[5];    
	  }else if(retType.equals("modifysceTrans"))
	  {
	      String yuanid = (String)request.getParameter("sceid");
	      String accesscode = (String)request.getParameter("accesscode");
	      String citycode = (String)request.getParameter("citycode");
	      String digitcode = (String)request.getParameter("digitcode");
	  		strSql="  update DZXSCETRANSFERTAB set ID=:v1||:v2||USERCLASS||:v3 ";
	  		strSql+=" ,superid=substr( :v4||:v5||USERCLASS||:v6,0,length(:v7||:v8||USERCLASS||:v9)-1)"  ;
	  		strSql+=" ,TYPEID= :v10";
	  		strSql+=" ,SERVICENAME= :v11";
	  		strSql+=" ,ACCESSCODE= :v12";
	  		strSql+=" ,DIGITCODE= :v13";
	  		strSql+=" ,TRANSFERCODE= :v14";
	  		strSql+=" ,VISIABLE= :v15";
	  		strSql+=" ,messegecontent= :v16";
	  		strSql+=" ,CITYCODE= :v17";
	  		strSql+="  where accesscode= :v18";
	  		strSql+="  and citycode= :v19";
	  		strSql+="  and digitcode= :v20";
	  		strSql+="&&"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalxnew[1]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+addvalxnew[5]+"^"+addvalxnew[6]+"^"+addvalynew[0]+"^"+accesscode+"^"+citycode+"^"+digitcode;
	  		 
	  		
	  }
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value=""/>
   <wtc:param value="dbchange"/>
   <wtc:params value="<%=strSql%>"/>	
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);