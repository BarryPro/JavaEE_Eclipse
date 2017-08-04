
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="com.sitech.boss.s2500.wrapper.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%@ page import="java.io.*" %>
<%

   int    iCount = 0;	    
   String retType         = request.getParameter("retType");      
   String region_code     = request.getParameter("region_code"); 
   String phone_no        = request.getParameter("phone_no"); 
   String Ed_Current_point= request.getParameter("Ed_Current_point"); 
   String giftclasscode   = request.getParameter("giftclasscode");
   
   
   //ArrayList retArray = new ArrayList();
   //SPubCallSvrImpl callView = new SPubCallSvrImpl();
   String insql = "select FAVOUR_CODE,FAVOUR_NAME,FAVOUR_POINT,GOOD_FLAG,to_char(FAV_RATE),FAVOUR_ADDRESS,"
        +"LIMIT_DAY,FAVOUR_MONEY, FAVOUR_TYPE, PREPAY_FEE, FAV_RATE*FAVOUR_POINT "
  		+"from sMarkfavCode "
	    +"where region_code ='"+region_code+"'"
        +" and favour_point <="+Ed_Current_point
        +" and sm_code = (select sm_code from dcustmsg where phone_no='"+phone_no+"')"
        +" and valid_flag = '0'"
        +" and favour_type in (select gift_class_code "
					   +" from sMarkGiftClass "
				 +" start with Trim(gift_class_code) = '"+giftclasscode+"'"
	       +" connect by prior gift_class_code = father_code) "
	    +" and sysdate between start_time and stop_time"
	    +" and show_flag = '0' ";//update by jianglei@20100928 增加对show_flag，页面显示表及判断
	       
   System.out.println("insql="+insql);	       

	//retArray = callView.sPubSelect("11",insql);
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=region_code%>" retcode="retCode1" retmsg="retMsg1" outnum="11">
    <wtc:sql><%=insql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result" scope="end"/>
<%		
	//String[][] result = new String[][]{};
	//result = (String[][])retArray.get(0);
	int recordNum = 0;
	recordNum = result.length;
    System.out.println("luxc:recordNum==================="+recordNum);	       
		

%>
  	var FavourCode=new Array(<%=recordNum%>);
  	var code_Array=new Array(<%=recordNum%>);
  	var name_Array=new Array(<%=recordNum%>);

<%          
        for(int i=0;i<recordNum;i++)
        {
		%>
			code_Array[<%=i%>] = "<%=result[i][0]%>";
			name_Array[<%=i%>] = "<%=result[i][1]%>";
			
			FavourCode[<%=i%>] = new Array(11);  
        	FavourCode[<%=i%>][0] = "<%= result[i][0].trim()%>"; 
        	FavourCode[<%=i%>][1] = "<%= result[i][1].trim()%>";
        	FavourCode[<%=i%>][2] = "<%= result[i][2].trim()%>";
			FavourCode[<%=i%>][3] = "<%= result[i][3].trim()%>";
			FavourCode[<%=i%>][4] = "<%= result[i][4].trim()%>";
			FavourCode[<%=i%>][5] = "<%= result[i][5].trim()%>";
			FavourCode[<%=i%>][6] = "<%= result[i][6].trim()%>";
			FavourCode[<%=i%>][7] = "<%= result[i][7].trim()%>";
			FavourCode[<%=i%>][8] = "<%= result[i][8].trim()%>";
			FavourCode[<%=i%>][9] = "<%= result[i][9].trim()%>";
			FavourCode[<%=i%>][10] ="<%= result[i][10].trim()%>";
			
		<%
        }
%>   

//var response = new AJAXPacket();
var retType = "";
var retCode = "";
var retMessage = "";
//var recordNum;

//recordNum=<%=recordNum%>;

retCode = "0";
retMessage = "成功";

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("code_Array",code_Array);
response.data.add("name_Array",name_Array);
response.data.add("FavourCode",FavourCode);
//response.data.add("recordNum",recordNum);

core.ajax.receivePacket(response);

