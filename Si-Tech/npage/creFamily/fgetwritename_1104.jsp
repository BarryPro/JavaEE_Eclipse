<%
/********************
 version v2.0
开发商: si-tech
update:liutong@2008.09.03
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.util.Tools"%>
<%@ page import="com.sitech.util.getfilestring"%>

<%
        //得到输入参数   
        String path=request.getRealPath("");    
       // Logger logger = Logger.getLogger("fgetwritename_1104.jsp");
       // ArrayList retArray = new ArrayList();         
        String[][] result = new String[][]{};
 		//comImpl co=new comImpl();
	    //--------------------------
	    String retType = request.getParameter("retType"); 
 	    String region_code = request.getParameter("region_code");
 	    String sim_type = request.getParameter("sim_type");
 	    String prov_code=request.getParameter("prov_code");
 	    String card_type=request.getParameter("card_type");
 	    String card_no=request.getParameter("card_no");
 	    //String sim_data=request.getParameter("sim_data");
 
	    //返回值定义
		String retCode = "";
		String retMessage = "";
		String card_status = "";
		
		
        //查询空卡信息是否正确
        	
        String sqcard="select status from dBlkCardRes where card_no='"+card_no+"' and status in ('0','3') and res_code='"+sim_type+"'";   
        System.out.println("sqcard_________________________________________________");	  
		System.out.println(sqcard);

%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
			<wtc:sql><%=sqcard%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
<%
	if(retCode1.equals("000000")||retCode1.equals("0"))
	{
          if(result1.length==0)
		  {
		        retCode="000001";
				retMessage="空卡资源信息不存在！"; 
				System.out.println(retMessage);			  
		  }
		  else
		  {
          	    retCode="000000";
			    retMessage="空卡资源信息查找成功！";
			    card_status=result1[0][0];
			           	
			           							        	
          }
        	
    }

System.out.println("-----outt");	
%>
var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
var cardstatus="";
var s2="";
  
retType = "<%=retType%>";
retCode = "<%=retCode%>";
retMessage = "<%=retMessage%>";
cardstatus= "<%=card_status%>";

response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("cardstatus",cardstatus);

core.ajax.receivePacket(response);
