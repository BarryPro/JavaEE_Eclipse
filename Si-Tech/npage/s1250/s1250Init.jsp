<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
        //ArrayList retArray = new ArrayList();
        //String[][] result = new String[][]{};
        //String[][] result1 = new String[][]{};
        String strArray="var FavourCode; ";  //must 
        
		//SPubCallSvrImpl callWrapper = new SPubCallSvrImpl();
 		int    iCount = 0;	    
		String retType = request.getParameter("retType");      
        String region_code = request.getParameter("region_code"); 
        String OrgCode = request.getParameter("OrgCode"); 
        String phone_no = request.getParameter("phone_no"); 
        String user_pass = request.getParameter("user_pass"); 
        //String newPass = Encrypt.encrypt(user_pass);
        String PassFlag =   request.getParameter("PassFlag"); 
		String op_code = request.getParameter("op_code");
		String workNo = (String)session.getAttribute("workNo");
	  //add by diling for 安全加固修改服务列表
	  String password = (String)session.getAttribute("password");
	  
		//ArrayList  inputParam = new ArrayList();
		//String     outList[][] = new String [][]{{"0","11"}, {"11","11"}};

		//inputParam.add(phone_no   );
		//inputParam.add(newPass  );
		//inputParam.add(OrgCode    );
		//inputParam.add(PassFlag   );
		//inputParam.add(op_code   );
	
		//String [] inRetType = new String[]{};
                     
        //String retCode = "";                 
        //String retMessage = "";     
        String Cust_name = "";  
        String Run_name = "";  
        String Sm_name = "";
        String Id_name = "";     
        String Id_iccid = "";    
        String Grade_code = "";    
        String Grade_name = "";    
        String Current_point = "";  
		    String favTypeCode = ""; 
		    String totalUsedPoint = "";
		    
		    String id_address = "";
		    int l2 = 0;

	    	//retArray = callWrapper.callFXService("s1250Init",inputParam,"5",outList);                     
            //retCode = callWrapper.getErrCode();
            //retMessage = callWrapper.getErrMsg();
    %>
    <wtc:service name="s1250Init"  routerKey="phone" routerValue="<%=phone_no%>" retcode="retCode" retmsg="retMessage" outnum="24">
	 		<wtc:param value=" " />
			<wtc:param value="01" />
			<wtc:param value="<%=op_code%>"/>
			<wtc:param value="<%=workNo%>" />
			<wtc:param value="<%=password%>" />	
			<wtc:param value="<%=phone_no%>"/>
		   	<wtc:param value="<%=user_pass%>"/>   	     
		    <wtc:param value="<%=OrgCode%>"/>
			<wtc:param value="<%=PassFlag%>"/>
	</wtc:service>
	<wtc:array id="result" start="0" length="11"  scope="end"/>
	<wtc:array id="result1" start="11" length="11"  scope="end"/>
	<wtc:array id="result0" start="22" length="2"  scope="end"/>
    <%
            //retCode = retCode1;
            //retMessage = retMessage1;
			System.out.println("###################################################");
			System.out.println("retCode ===== " + retCode);
			System.out.println("retMessage ========" + retMessage);
			System.out.println("result====================="+result.length);
			System.out.println("result1====================="+result1.length);
			System.out.println("result0====================="+result0.length);
					
            //result = (String[][])retArray.get(0);           
            Cust_name = result[0][2];
            Run_name = result[0][3];
            Sm_name = result[0][4];
            Id_name = result[0][5];
            Id_iccid = result[0][6];
            Grade_code = result[0][7];
            Grade_name = result[0][8];
            Current_point = result[0][9];
	    	    totalUsedPoint = result[0][10];

	    	    if(result0[0][0].trim().length() !=0)
	    	    {	
	    	    	l2=Integer.parseInt(result0[0][0]);
	    	    }
	    		else
	    		{
	    		  	l2=0;
	    		}
	    	    id_address = result0[0][1];
            
            //result1 = (String[][])retArray.get(1);	
            iCount = result1.length; 
			System.out.println("iCount=["+iCount+"]");     
			System.out.println("Cust_name=["+Cust_name+"]");
			System.out.println("Run_name=["+Run_name+"]"); 
			System.out.println("Sm_name=["+Sm_name+"]"); 
			System.out.println("Id_name=["+Id_name+"]");
			System.out.println("Id_iccid=["+Id_iccid+"]");
			System.out.println("Grade_code=["+Grade_code+"]"); 
			System.out.println("Grade_name=["+Grade_name+"]");
			System.out.println("Current_point=["+Current_point+"]");
			System.out.println("totalUsedPoint=["+totalUsedPoint+"]");
			System.out.println("highFlag=["+l2+"]"); 
			System.out.println("id_address=["+id_address+"]"); 
%>

<%	  		 		 	 
		strArray = CreatePlanerArray.createArray("FavourCode",iCount);
%>
<%=strArray%>
<%                
    for(int i=0;i<iCount;i++)
    {
     //System.out.println(result1[i][0].trim());
%>
        	FavourCode[<%=i%>][0] = "<%= result1[i][0].trim()%>"; 
        	FavourCode[<%=i%>][1] = "<%= result1[i][1].trim()%>";
        	FavourCode[<%=i%>][2] = "<%= result1[i][2].trim()%>";
			FavourCode[<%=i%>][3] = "<%= result1[i][3].trim()%>";
			FavourCode[<%=i%>][4] = "<%= result1[i][4].trim()%>";
			FavourCode[<%=i%>][5] = "<%= result1[i][5].trim()%>";
			FavourCode[<%=i%>][6] = "<%= result1[i][6].trim()%>";
			FavourCode[<%=i%>][7] = "<%= result1[i][7].trim()%>";
			FavourCode[<%=i%>][8] = "<%= result1[i][8].trim()%>";
			FavourCode[<%=i%>][9] = "<%= result1[i][9].trim()%>";
			FavourCode[<%=i%>][10]= "<%= result1[i][10].trim()%>";
<%
       }      
%>   
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=retCode%>");
response.data.add("retMessage","<%=retMessage%>");
response.data.add("Cust_name","<%=Cust_name%>");
response.data.add("Run_name","<%=Run_name%>");
response.data.add("Sm_name","<%=Sm_name%>");
response.data.add("Id_name","<%=Id_name%>");
response.data.add("Id_iccid","<%=Id_iccid%>");
response.data.add("Grade_code","<%=Grade_code%>");
response.data.add("Grade_name","<%=Grade_name%>");
response.data.add("Current_point","<%=Current_point%>");
response.data.add("FavourCode",FavourCode);
response.data.add("totalUsedPoint","<%=totalUsedPoint%>");
response.data.add("iCount","<%=iCount%>");
response.data.add("higmsg","<%=l2%>");
response.data.add("id_address","<%=id_address%>");
core.ajax.receivePacket(response);


