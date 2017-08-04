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
String sceid="";
String message="";
String retType = WtcUtil.repNull(request.getParameter("retType"));
addvalxin = (String)request.getParameter("addvalxin");
sceid = (String)request.getParameter("sceid");
  
String[] addvalxnew=addvalxin.split(",",-1);

String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
   
    if (retType.equals("addsceTrans"))
    {
			/**原strSql = "insert into difagfirst(SERIALNO,datetime,center10086,callag10086,callpe10086,callen10086,caller10086,callper10086,center12580,calloutag10086,callerout10086,outag10086,ag12580,ager12580,outager10086,ener10086,outmain,otherag1008612580,wavebd,outtotal,otherer1008612580,malfunction,agentavgnum,calltime) values(to_char(sysdate,'yyyymmddhh24miss')";
			strSql+= ",to_date('" + addvalxnew[20];
			strSql+= "', 'yyyy-mm-dd hh24:mi:ss')";
			strSql+= ",'" +addvalxnew[0]+"'";
			strSql+= ",'" +addvalxnew[1]+"'";
			strSql+= ",'" +addvalxnew[2]+"'";
			strSql+= ",'" +addvalxnew[3]+"'";
			strSql+= ",'" +addvalxnew[4]+"'";
			strSql+= ",'" +addvalxnew[5]+"'";
			strSql+= ",'" +addvalxnew[6]+"'";
			strSql+= ",'" +addvalxnew[7]+"'";
			strSql+= ",'" +addvalxnew[8]+"'";
			strSql+= ",'" +addvalxnew[9]+"'";
			strSql+= ",'" +addvalxnew[10]+"'";
			strSql+= ",'" +addvalxnew[11]+"'";
			strSql+= ",'" +addvalxnew[12]+"'";
			strSql+= ",'" +addvalxnew[13]+"'";
			strSql+= ",'" +addvalxnew[14]+"'";
			strSql+= ",'" +addvalxnew[15]+"'";
			strSql+= ",'" +addvalxnew[16]+"'";
			strSql+= ",'" +addvalxnew[17]+"'";
			strSql+= ",'" +addvalxnew[18]+"'";
			strSql+= ",'" +addvalxnew[19]+"'";
			strSql+= ",'" +addvalxnew[21]+"'";
			strSql+= ",'" +addvalxnew[22]+"'" + ")";
			格式化
	    	strSql = "insert into difagfirst(SERIALNO,datetime,center10086,callag10086,callpe10086,callen10086,caller10086,callper10086,center12580,calloutag10086,callerout10086,outag10086,ag12580,ager12580,outager10086,ener10086,outmain,otherag1008612580,wavebd,outtotal,otherer1008612580,malfunction,agentavgnum,calltime) values(to_char(sysdate,'yyyymmddhh24miss')";
			strSql+= ",to_date('"+addvalxnew[20]+"', 'yyyy-mm-dd hh24:mi:ss')";
			strSql+= ",'"+addvalxnew[0]+"'";
			strSql+= ",'"+addvalxnew[1]+"'";
			strSql+= ",'"+addvalxnew[2]+"'";
			strSql+= ",'"+addvalxnew[3]+"'";
			strSql+= ",'"+addvalxnew[4]+"'";
			strSql+= ",'"+addvalxnew[5]+"'";
			strSql+= ",'"+addvalxnew[6]+"'";
			strSql+= ",'"+addvalxnew[7]+"'";
			strSql+= ",'"+addvalxnew[8]+"'";
			strSql+= ",'"+addvalxnew[9]+"'";
			strSql+= ",'"+addvalxnew[10]+"'";
			strSql+= ",'"+addvalxnew[11]+"'";
			strSql+= ",'"+addvalxnew[12]+"'";
			strSql+= ",'"+addvalxnew[13]+"'";
			strSql+= ",'"+addvalxnew[14]+"'";
			strSql+= ",'"+addvalxnew[15]+"'";
			strSql+= ",'"+addvalxnew[16]+"'";
			strSql+= ",'"+addvalxnew[17]+"'";
			strSql+= ",'"+addvalxnew[18]+"'";
			strSql+= ",'"+addvalxnew[19]+"'";
			strSql+= ",'"+addvalxnew[21]+"'";
			strSql+= ",'"+addvalxnew[22]+"'" + ")";
			*/
	    	strSql = "insert into difagfirst(SERIALNO,datetime,center10086,callag10086,callpe10086,callen10086,caller10086,callper10086,center12580,calloutag10086,callerout10086,outag10086,ag12580,ager12580,outager10086,ener10086,outmain,otherag1008612580,wavebd,outtotal,otherer1008612580,malfunction,agentavgnum,calltime) values(to_char(sysdate,'yyyymmddhh24miss')";
			strSql+= ",to_date( :v1, 'yyyy-mm-dd hh24:mi:ss')";
			strSql+= ", :v2";
			strSql+= ", :v3";
			strSql+= ", :v4";
			strSql+= ", :v5";
			strSql+= ", :v6";
			strSql+= ", :v7";
			strSql+= ", :v8";
			strSql+= ", :v9";
			strSql+= ", :v10";
			strSql+= ", :v11";
			strSql+= ", :v12";
			strSql+= ", :v13";
			strSql+= ", :v14";
			strSql+= ", :v15";
			strSql+= ", :v16";
			strSql+= ", :v17";
			strSql+= ", :v18";
			strSql+= ", :v19";
			strSql+= ", :v20";
			strSql+= ", :v21";
			strSql+= ", :v22";
			strSql+= ", :v23" + ")";
			%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strSql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=addvalxnew[20]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalxnew[1]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[4]%>"/>
	<wtc:param value="<%=addvalxnew[5]%>"/>
	<wtc:param value="<%=addvalxnew[6]%>"/>
	<wtc:param value="<%=addvalxnew[7]%>"/>
	<wtc:param value="<%=addvalxnew[8]%>"/>
	<wtc:param value="<%=addvalxnew[9]%>"/>
	<wtc:param value="<%=addvalxnew[10]%>"/>
	<wtc:param value="<%=addvalxnew[11]%>"/>
	<wtc:param value="<%=addvalxnew[12]%>"/>
	<wtc:param value="<%=addvalxnew[13]%>"/>
	<wtc:param value="<%=addvalxnew[14]%>"/>
	<wtc:param value="<%=addvalxnew[15]%>"/>
	<wtc:param value="<%=addvalxnew[16]%>"/>
	<wtc:param value="<%=addvalxnew[17]%>"/>
	<wtc:param value="<%=addvalxnew[18]%>"/>
	<wtc:param value="<%=addvalxnew[19]%>"/>
	<wtc:param value="<%=addvalxnew[21]%>"/>
	<wtc:param value="<%=addvalxnew[22]%>"/>
</wtc:service>

<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);

<%
	  }else if(retType.equals("modifysceTrans"))
	  {
	       /**strSql = "update difagfirst set datetime = ";
           strSql += "to_date('"+addvalxnew[20]+"', 'yyyy-mm-dd hh24:mi:ss')";
           strSql += ",center10086 = '"+addvalxnew[0]+"'";
           strSql += ",callag10086 = '"+addvalxnew[1]+"'";
           strSql += ",callpe10086 = '"+addvalxnew[2]+"'";
           strSql += ",callen10086 = '"+addvalxnew[3]+"'";
           strSql += ",caller10086 = '"+addvalxnew[4]+"'";
           strSql += ",callper10086 = '"+addvalxnew[5]+"'";
           strSql += ",center12580 = '"+addvalxnew[6]+"'";
           strSql += ",calloutag10086 = '"+addvalxnew[7]+"'";
           strSql += ",callerout10086 = '"+addvalxnew[8]+"'";
           strSql += ",outag10086 = '"+addvalxnew[9]+"'";
           strSql += ",ag12580 = '"+addvalxnew[10]+"'";
           strSql += ",ager12580 = '"+addvalxnew[11]+"'";
           strSql += ",outager10086 = '"+addvalxnew[12]+"'";
           strSql += ",ener10086 = '"+addvalxnew[13]+"'";
           strSql += ",outmain = '"+addvalxnew[14]+"'";
           strSql += ",otherag1008612580 = '"+addvalxnew[15]+"'";  
           strSql += ",wavebd = '"+addvalxnew[16]+"'";
           strSql += ",outtotal = '"+addvalxnew[17]+"'";      
           strSql += ",otherer1008612580 = '"+addvalxnew[18]+"'";    
           strSql += ",malfunction ='"+addvalxnew[19]+"'";
           strSql += ",agentavgnum ='"+addvalxnew[21]+"'";
           strSql += ",calltime ='"+addvalxnew[22]+"'";     
           strSql += " where SerialNo = '"+sceid+"'";
           */
		  strSql = "update difagfirst set datetime = ";
          strSql += "to_date( :v1, 'yyyy-mm-dd hh24:mi:ss')";
          strSql += ",center10086 =  :v2";
          strSql += ",callag10086 =  :v3";
          strSql += ",callpe10086 =  :v4";
          strSql += ",callen10086 =  :v5";
          strSql += ",caller10086 =  :v6";
          strSql += ",callper10086 =  :v7";
          strSql += ",center12580 =  :v8";
          strSql += ",calloutag10086 =  :v9";
          strSql += ",callerout10086 =  :v10";
          strSql += ",outag10086 =  :v11";
          strSql += ",ag12580 =  :v12";
          strSql += ",ager12580 =  :v13";
          strSql += ",outager10086 =  :v14";
          strSql += ",ener10086 =  :v15";
          strSql += ",outmain =  :v16";
          strSql += ",otherag1008612580 =  :v17";  
          strSql += ",wavebd =  :v18";
          strSql += ",outtotal =  :v19";      
          strSql += ",otherer1008612580 =  :v20";    
          strSql += ",malfunction = :v21";
          strSql += ",agentavgnum = :v22";
          strSql += ",calltime = :v23";     
          strSql += " where SerialNo =  :v24";
          
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=strSql%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=addvalxnew[20]%>"/>
	<wtc:param value="<%=addvalxnew[0]%>"/>
	<wtc:param value="<%=addvalxnew[1]%>"/>
	<wtc:param value="<%=addvalxnew[2]%>"/>
	<wtc:param value="<%=addvalxnew[3]%>"/>
	<wtc:param value="<%=addvalxnew[4]%>"/>
	<wtc:param value="<%=addvalxnew[5]%>"/>
	<wtc:param value="<%=addvalxnew[6]%>"/>
	<wtc:param value="<%=addvalxnew[7]%>"/>
	<wtc:param value="<%=addvalxnew[8]%>"/>
	<wtc:param value="<%=addvalxnew[9]%>"/>
	<wtc:param value="<%=addvalxnew[10]%>"/>
	<wtc:param value="<%=addvalxnew[11]%>"/>
	<wtc:param value="<%=addvalxnew[12]%>"/>
	<wtc:param value="<%=addvalxnew[13]%>"/>
	<wtc:param value="<%=addvalxnew[14]%>"/>
	<wtc:param value="<%=addvalxnew[15]%>"/>
	<wtc:param value="<%=addvalxnew[16]%>"/>
	<wtc:param value="<%=addvalxnew[17]%>"/>
	<wtc:param value="<%=addvalxnew[18]%>"/>
	<wtc:param value="<%=addvalxnew[19]%>"/>
	<wtc:param value="<%=addvalxnew[21]%>"/>
	<wtc:param value="<%=addvalxnew[22]%>"/>
	<wtc:param value="<%=sceid%>"/>
</wtc:service>

<wtc:array id="rows" scope="end" />

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>");
response.data.add("retType","<%=retType%>");
core.ajax.receivePacket(response);
<%
	  }
%>
