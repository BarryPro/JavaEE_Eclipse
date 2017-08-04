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
  String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
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
     /**strSql=" INSERT INTO dcallspeciallist  ";
     strSql+="select to_char(sysdate,'yyyymmddhh24miss')||'"+kf_longin_no+"' ,'"+addvalxnew[2]+"','"+addvalxnew[3]+"','','','"+addvalynew[0]+"','','','' ";
     strSql+=",'"+addvalynew[1]+"','"+addvalxnew[0]+"','',sysdate ,to_date('"+addvalxnew[4]+"','yyyymmdd hh24:mi:ss'),to_date('"+addvalxnew[5]+"','yyyymmdd hh24:mi:ss'),'"+message+"','"+addvalxnew[1]+"','"+addvalynew[2]+"','',''";
     strSql+=" FROM DUAL   ";
     */
     strSql=" INSERT INTO dcallspeciallist  ";
     strSql+="select to_char(sysdate,'yyyymmddhh24miss')|| :v1 , :v2, :v3,'','', :v4,'','','' ";
     strSql+=", :v5, :v6,'',sysdate ,to_date( :v7,'yyyymmdd hh24:mi:ss'),to_date( :v8,'yyyymmdd hh24:mi:ss'), :v9, :v10, :v11,'',''";
     strSql+=" FROM DUAL   "; 
     strSql+="&&"+kf_longin_no+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalynew[0]+"^"+addvalynew[1]+"^"+addvalxnew[0]+"^"+addvalxnew[4]+"^"+addvalxnew[5]+"^"+message.trim()+"^"+addvalxnew[1]+"^"+addvalynew[2]; 
		
     	 
      
 
	  }else if(retType.equals("modifysceTrans"))
	  {
	      String yuanid = (String)request.getParameter("sceid");
	      
	  		/**strSql="  update dcallspeciallist set ";
	  		strSql+="  specialtype_id= '"+addvalynew[0]+"'";
	  		strSql+=" ,sq_login_no= '"+addvalxnew[0]+"'";
	  		strSql+=" ,op_login_no= '"+addvalxnew[1]+"'";
	  		strSql+=" ,accept_phone= '"+addvalxnew[2]+"'";
	  		strSql+=" ,cust_name= '"+addvalxnew[3]+"'";
	  		strSql+=" ,end_date= to_date('"+addvalxnew[4]+"','yyyymmdd hh24:mi:ss')";
	  		strSql+=" ,reason= '"+addvalxnew[5]+"'";
	  		strSql+="  where specialid= '"+yuanid+"'";
	  		*/
	  		
	  		strSql="  update dcallspeciallist set ";
	  		strSql+="  specialtype_id=  :v1";
	  		strSql+=" ,sq_login_no=  :v2";
	  		strSql+=" ,op_login_no=  :v3";
	  		strSql+=" ,accept_phone=  :v4";
	  		strSql+=" ,cust_name=  :v5";
	  		strSql+=" ,end_date= to_date( :v6,'yyyymmdd hh24:mi:ss')";
	  		strSql+=" ,reason=  :v7";
	  		strSql+="  where specialid=  :v8";
	  		strSql+="&&"+addvalynew[0]+"^"+addvalxnew[0]+"^"+addvalxnew[1]+"^"+addvalxnew[2]+"^"+addvalxnew[3]+"^"+addvalxnew[4]+"^"+addvalxnew[5].trim()+"^"+yuanid;
	  		
	  	
	  		 		 
	  }
	  
 
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:param value="<%=strSql%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);