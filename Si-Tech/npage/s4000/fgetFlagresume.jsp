<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>  


<%
     ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfoSession = (String[][])arrSession.get(0);
		String[][] otherInfoSession = (String[][])arrSession.get(2);
		String[][] pass = (String[][])arrSession.get(4);
		
		String loginNo = baseInfoSession[0][2];
		String loginName = baseInfoSession[0][3];
		String powerCode= otherInfoSession[0][4];
		String orgCode = baseInfoSession[0][16];
		String ip_Addr = request.getRemoteAddr();
		
		String regionCode = orgCode.substring(0,2);
		String regionName = otherInfoSession[0][5];
		String loginNoPass = pass[0][0];
     
     //得到输入参数   
     String path=request.getRealPath("");   
     ArrayList retArray = new ArrayList();         
     String[][] result = new String[][]{};
     
	    String retType = request.getParameter("retType"); 

 	    String prov_code=request.getParameter("prov_code");
 	   
 	    String card_no=request.getParameter("card_no");
 	  

	    //返回值定义
      String retCode = "";
      String retMessage = "";
		  String write_name = "";
		  String ver="";
		  String passwd="";
        	//查询空卡信息是否正确
        	String status_tmp="";
			
        	//MyLog.debugLog("fgetFlagresume111111111=");
      String sqcard="select status from dBlkCardRes where card_no= '"+card_no+"' and prov_code = '"+prov_code+"' and rownum < 2";
%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="4" retcode="retCode" retmsg="retMsg">
			<wtc:param value="<%=sqcard%>"/>
		</wtc:service>
		<wtc:array id="result111" scope="end"/>
<%	  
	       if(result111.length>0)
			 {
				if(status_tmp.equals("3")) {
			   System.out.println("重个人化卡不能进行写卡");
			   }								
		   }


%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var status_tmp="";

  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
write_name="<%=status_tmp%>";


  
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("status_tmp",status_tmp);
core.ajax.receivePacket(response);

