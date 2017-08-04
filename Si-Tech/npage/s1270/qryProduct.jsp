<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.lang.Integer"%>
<%

  String flag="0";
  
  String param = WtcUtil.repNull(request.getParameter("param"));
  
  System.out.println("param  ------------ mylog");
  try{
  if(!param.equals("")){
  
  param=param.substring(0,param.length()-1);
  
  }
  
  String sqlStr="";
  sqlStr="select count(*) from product_offer where offer_type = 10 and offer_id in ("+param+")";
  System.out.println("mylog  ---  "+sqlStr);
  if(!param.equals("")){
  		%>
			<wtc:pubselect name="sPubSelect"  outnum="1">
			<wtc:sql><%=sqlStr%>
			</wtc:sql>
			</wtc:pubselect>
			<wtc:array id="retarr" scope="end"/>  	
  		<%
  		
  		if(retarr.length!=0){
  				if(!retarr[0][0].equals("0")){
  				flag="1";
  				}
  		}
  }
  }catch(Exception e){
  	flag="0";
  }
%>
var response = new AJAXPacket();
response.data.add("flag","<%=flag%>");
core.ajax.receivePacket(response);