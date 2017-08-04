
<%
   /*
   * 功能: 获取单个ID
　 * 版本: v2.0
　 * 日期: 2006/08/24
　 * 作者: ranlf
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2007-07-02    liuht
 　*/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	  String retType = request.getParameter("retType");
	  String sqlStr = request.getParameter("sqlStr");
	  System.out.println("sqlStr========="+sqlStr);
	  String retnewIdww="";
	  String [][] result=null;
%>

	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<%System.out.println("0  retCode---------- " +retCode);%>
	<wtc:array id="row" >
			<%result=row;%>
    </wtc:array>
<%
System.out.println("1  retCode-------"+retCode);
System.out.println("row-------");
	if(retCode.equals("000000")&&result.length>0)
	{ 
     retnewIdww = result[0][0];	
	 //retnewIdww="1";
    
    System.out.println("retnewIdww------------- "+retnewIdww);
 	System.out.println("retCode---------- " +retCode); 
 	}
  else	
  	{
  	 System.out.println("2222222222");
  	 retnewIdww = "0";
  	 }
	 
	System.out.println("retnewIdww------------- "+retnewIdww);
 	System.out.println("2  retCode---------- " +retCode);
 	System.out.println("2  retType---------- " +retType);	
%>
   	
	
  var response = new AJAXPacket();
  var retType = "<%=retType%>"; 
  var retnew=  "<%=retnewIdww%>";
  response.data.add("retType",retType);
  response.data.add("retnewId",retnew);
  response.data.add("retCode","000000");
  core.ajax.receivePacket(response);
  