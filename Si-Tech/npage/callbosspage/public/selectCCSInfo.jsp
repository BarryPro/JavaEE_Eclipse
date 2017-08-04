<%
	/*
	 * 功能: 保存各种状态下时间
	 * 版本: 1.0
	 * 日期: 2008/12/21
	 * 作者: lijin 
	 * 版权: sitech
	 * modify by yinzx 20090825 更改ip为ip段
	 *  
	 */
%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%
       /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String myParams2="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
   String localIp= request.getParameter("localIp");
   String ccnoget=request.getParameter("ccno");
   String sql="select to_char(count(*)) count from dcrmcallcfg a where 1=1 and substr(agent_ip,0,INSTR(agent_ip ,'.', 1, 3)-1)= substr(:vlocalIp ,0,INSTR(:vvlocalIp ,'.', 1, 3)-1)";
   myParams="vlocalIp="+localIp+",vvlocalIp="+localIp ;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="1">
						<wtc:param value="<%=sql%>"/>
						<wtc:param value="<%=myParams%>"/>
					</wtc:service>
<wtc:array id="row" scope="end"/>
<%
   int rowCount = Integer.parseInt(row[0][0]);
 
   String sqlStr="";
   if(rowCount>0){
   if(ccnoget.equals("0")){
	    sqlStr="select a.mainccsip,a.ccsid,a.mainccsip2,a.agenttype,a.callerno,a.callinnerflag,a.bak2 from dcrmcallcfg a where 1=1 and substr(agent_ip,0,INSTR(agent_ip ,'.', 1, 3)-1)=substr(:vlocalIp ,0,INSTR(:vvlocalIp  ,'.', 1, 3)-1)";
	    myParams2="vlocalIp="+localIp+",vvlocalIp="+localIp ; 
	    }
	  else{
	    sqlStr="select a.mainccsip,a.ccsid,a.mainccsip2,a.agenttype,a.callerno,a.callinnerflag,a.bak2 from dcrmcallcfg a where 1=1 and a.bak2=:ccnoget and substr(agent_ip,0,INSTR(agent_ip ,'.', 1, 3)-1)=substr(:vlocalIp ,0,INSTR(:vvlocalIp  ,'.', 1, 3)-1)";
	    myParams2="ccnoget="+ccnoget+",vlocalIp="+localIp+",vvlocalIp="+localIp ; 
	  }
   } 		
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="7">
						<wtc:param value="<%=sqlStr%>"/>
						<wtc:param value="<%=myParams2%>"/>
					</wtc:service>
<wtc:array id="queryList" scope="end"/>

var response = new AJAXPacket();
<%
  String mainccsip="";
  String ccsid="";
  String mainccsip2="";
  String agenttype="";
  String callerno="";
  String callinnerflag="";
  String ccno="";
 if(rowCount>0){
   mainccsip=queryList[0][0];
   ccsid=queryList[0][1];
   mainccsip2=queryList[0][2];
   agenttype=queryList[0][3];
   callerno=queryList[0][4];
   callinnerflag=queryList[0][5];
   ccno=queryList[0][6];
 }
%>
response.data.add("mainccsip","<%=mainccsip%>");
response.data.add("ccsid","<%=ccsid%>");
response.data.add("mainccsip2","<%=mainccsip2%>");
response.data.add("agenttype","<%=agenttype%>");
response.data.add("callerno","<%=callerno%>");
response.data.add("callinnerflag","<%=callinnerflag%>");
response.data.add("ccno","<%=ccno%>");
core.ajax.receivePacket(response);

	