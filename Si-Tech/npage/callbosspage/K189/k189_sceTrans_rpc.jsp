<%
  /*
   * 功能: 人工转自动-转业务咨询维护结点数据
　 * 版本: 1.0.0
　 * 日期: 2009/08/07
　 * 作者: yinzx
　 * 版权: sitech
   * modify by yinzx  20091012
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%
  String strSql="";
  String strFrame="";
  String addvalxin = "";
  String addvalyin="";
  String message="";
	String retType = WtcUtil.repNull(request.getParameter("retType"));
  addvalxin = (String)request.getParameter("addvalxin");
  addvalyin = (String)request.getParameter("addvalyin");
  message = (String)request.getParameter("addvalzhi");
  String[] addvalxnew=addvalxin.split(",",-1);
  String[] addvalynew=addvalyin.split(",",-1);
  List sqlList=new ArrayList();
  String[] sqlArr = new String[]{};
  
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2); 
 
    if (retType.equals("addsceTrans"))
    {
     	/**strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
      strSql+="select  "+addvalxnew[0]+"||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',substr("+addvalxnew[0]+"||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',0,length("+addvalxnew[0]+"||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"')-1), ";
      strSql+="  "+addvalxnew[0]+" ,'"+addvalynew[0]+"',  user_class_id  ,'" +addvalxnew[2]+"','"+addvalxnew[3]+"',"+addvalxnew[4]+",'"+message+"',"+addvalxnew[1]+",'','','', " +addvalxnew[5];
     	strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
     	
    	strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
        strSql+="select  '"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',substr('"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"',0,length('"+addvalxnew[0]+"'||'"+addvalynew[0]+"'||user_class_id||'"+addvalxnew[3]+"')-1), ";
        strSql+="  '"+addvalxnew[0]+"' ,'"+addvalynew[0]+"',  user_class_id  ,'"+addvalxnew[2]+"','"+addvalxnew[3]+"','"+addvalxnew[4]+"','"+message+"','"+addvalxnew[1]+"','','','', '"+addvalxnew[5]+"'";
       	strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
     	*/
     	
    	strSql=" INSERT INTO DZXSCETRANSFERTAB  ";
        strSql+="select   :v1|| :v2||user_class_id|| :v3,substr( :v4|| :v5||user_class_id|| :v6,0,length( :v7|| :v8||user_class_id|| :v9)-1), ";
        strSql+="   :v10 , :v11,  user_class_id  , :v12, :v13, :v14, :v15, :v16,'','','',  :v17";
       	strSql+=" FROM DUAL ,SCALLGRADECODE B  "; 
       	strSql+="&&"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalynew[0]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+message+"^"+addvalxnew[1]+"^"+addvalxnew[5]; 
       	
     	sqlList.add(strSql);
     	/**
      	strFrame="insert into DZXSCETRANSFERDETAIL ";
      	strFrame+= "select distinct  FRAMEID,'"+addvalxnew[3]+"','"+addvalxnew[4]+"','"+message+"',"+addvalxnew[1]+",'" +addvalxnew[2]+"','','0','','','','1','" +addvalxnew[2]+"',  " +addvalxnew[5]+",sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE= '"+addvalynew[0]+"' and accesscode='10086' ";
     	
      	strFrame="insert into DZXSCETRANSFERDETAIL ";
      	strFrame+= "select distinct  FRAMEID,'"+addvalxnew[3]+"','"+addvalxnew[4]+"','"+message+"','"+addvalxnew[1]+"','"+addvalxnew[2]+"','','0','','','','1', '"+addvalxnew[2]+"','"+addvalxnew[5]+"',sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE= '"+addvalynew[0]+"' and accesscode='10086' ";
      	*/
      	strFrame="insert into DZXSCETRANSFERDETAIL ";
      	strFrame+= "select distinct  FRAMEID, :v1, :v2, :v3, :v4, :v5,'','0','','','','1',  :v6, :v7,sysdate ,sysdate + 365*1000,'','' from dsceconsulttype where CITYCODE=  :v8 and accesscode='10086' ";
      	strFrame+="&&"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+message+"^"+addvalxnew[1]+"^"+addvalxnew[2]+"^"+addvalxnew[2]+"^"+addvalxnew[5]+"^"+addvalynew[0];
     	sqlList.add(strFrame);
     	
     	sqlArr = (String[])sqlList.toArray(new String[0]);
      
 
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
  		strSql+="  and digitcode= '"+digitcode.trim()+"'";
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
  		strSql+="&&"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[2]+"^"+addvalynew[0]+"^"+addvalxnew[3]+"^"+addvalxnew[0]+"^"+addvalxnew[1]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+addvalxnew[5]+"^"+addvalxnew[6]+"^"+addvalynew[0]+"^"+accesscode+"^"+citycode+"^"+digitcode.trim();
  		
	  		
	  		
	  	sqlList.add(strSql);
      	/**strFrame="update DZXSCETRANSFERDETAIL set ";
      	strFrame+="  TYPEID= '"+addvalxnew[0]+"'";
     	strFrame+=" ,messegecontent= '"+addvalxnew[6]+"'";
     	strFrame+=" ,SERVICENAME= '"+addvalxnew[1]+"'";
     	strFrame+=" ,fullNAME= '"+addvalxnew[1]+"'";
     	strFrame+=" ,VISIBLE= '"+addvalxnew[5]+"'";
     	strFrame+=" ,DIGITCODE= '"+addvalxnew[3]+"'";
     	strFrame+="  where FRAMEID=(select  distinct  FRAMEID from dsceconsulttype where CITYCODE= '"+addvalynew[0]+"' and accesscode='10086') ";
	  	strFrame+="  and digitcode= '"+digitcode.trim()+"'";
     	*/
     	strFrame="update DZXSCETRANSFERDETAIL set ";
      	strFrame+="  TYPEID=  :v1";
     	strFrame+=" ,messegecontent=  :v2";
     	strFrame+=" ,SERVICENAME=  :v3";
     	strFrame+=" ,fullNAME=  :v4";
     	strFrame+=" ,VISIBLE=  :v5";
     	strFrame+=" ,DIGITCODE=  :v6";
     	strFrame+="  where FRAMEID=(select  distinct  FRAMEID from dsceconsulttype where CITYCODE=  :v7 and accesscode='10086') ";
	  	strFrame+="  and digitcode=  :v8";
	  	strFrame+="&&"+addvalxnew[0]+"^"+addvalxnew[6]+"^"+addvalxnew[1]+"^"+addvalxnew[1]+"^"+addvalxnew[5]+"^"+addvalxnew[3]+"^"+addvalynew[0]+"^"+digitcode.trim();
     	
     	sqlList.add(strFrame);
     	
     	sqlArr = (String[])sqlList.toArray(new String[0]);
     	
 
	  		 
	  }
	  
 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlArr%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);