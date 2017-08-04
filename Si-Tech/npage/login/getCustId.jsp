<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="java.util.regex.Pattern"%>
<%@ page import="java.util.regex.Matcher"%>
<%
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
    String broadPhone = "";
   	String phone_no  = request.getParameter("phoneNo").trim();
    String loginType  = request.getParameter("loginType").trim();   
    System.out.println("liujian--loginType="+loginType); 
    System.out.println("liujian--phoneNo="+phone_no);  
    /*
    if(phone_no != null && phone_no.length() > 5 && phone_no.substring(0,5).equals("10648")) {
		phone_no = phone_no.replaceFirst("10648", "205");//liujian 2013-5-15 15:15:57 
    	loginType = "1";
	}*/
    
    UType u = new UType();
	u.setUe("STRING",phone_no);
	System.out.println("---------------------liujian------getCustId.jsp---------------------------loginType="+loginType);	
	System.out.println("---------------------liujian------getCustId.jsp---------------------------phone_no="+phone_no);	
%>
<wtc:utype name="sQryCustId" id="retVal" scope="end" routerKey="region" routerValue="<%=regionCode%>">
     <wtc:uparam value="<%=loginType%>" type="INT"/>
     <wtc:uparam value="<%=u%>" type="UTYPE"/>
</wtc:utype>
	var custIdArr = new Array();
	var custNameArr = new Array();
	var custIccid = new Array();
	var custCtime = new Array();
	var phoneNo = new Array();
	var broadPhone = new Array();
<%

 	String retCode=String.valueOf(retVal.getValue(0));
	String retMsg=retVal.getValue(1);
	
	
	System.out.println("### getCustId.jsp -> return by sQryCustId --------------> "+retCode+" || "+retMsg);
	if("0".equals(retCode)){
		int size=retVal.getSize("2.0");
		
		if(size>18)
		{
			size =18;
		}
		System.out.println("---------------------------size---------------------------"+size);
		if(size==1)
		{
			Pattern p=Pattern.compile("\\s*|\t|\r|\n");
			Matcher m=p.matcher(retVal.getValue("2.0.0.1"));
			String name =m.replaceAll("");
			
			System.out.println("---------------------------retVal.getValue(2.0.0.4)---------------------------"+retVal.getValue("2.0.0.4"));								
			
			%>
			custIdArr[0]="<%=retVal.getValue("2.0.0.0")%>";
			custNameArr[0]="<%=name%>";
			phoneNo[0]="<%=retVal.getValue("2.0.0.4")%>";
			broadPhone[0]="<%=retVal.getValue("2.0.0.5")%>";
			<%
		}else
		{
		
				Pattern p=Pattern.compile("\\s*|\t|\r|\n");
				Matcher m=null;
				String name=null;
				for(int i=0; i<size; i++){				
				System.out.println("---------------------------retVal.getValue(2.0."+i+".0)---------------------------"+retVal.getValue("2.0."+i+".0"));								
				System.out.println("---------------------------retVal.getValue(2.0."+i+".1)---------------------------"+retVal.getValue("2.0."+i+".1"));								
				System.out.println("---------------------------retVal.getValue(2.0."+i+".2)---------------------------"+retVal.getValue("2.0."+i+".2"));								
				System.out.println("---------------------------retVal.getValue(2.0."+i+".3)---------------------------"+retVal.getValue("2.0."+i+".3"));								
				System.out.println("---------------------------retVal.getValue(2.0."+i+".4)---------------------------"+retVal.getValue("2.0."+i+".4"));								
				System.out.println("---------------------------retVal.getValue(2.0."+i+".5)---------------------------"+retVal.getValue("2.0."+i+".5"));								
				m=p.matcher(retVal.getValue("2.0."+i+".1"));
	      name =m.replaceAll("");
					%>
					custIdArr["<%=i%>"]  	= "<%=retVal.getValue("2.0."+i+".0")%>";
					custNameArr["<%=i%>"]	= "<%=name%>";
					custIccid["<%=i%>"]  	= "<%=retVal.getValue("2.0."+i+".2")%>";
					custCtime["<%=i%>"]  	= "<%=retVal.getValue("2.0."+i+".3")%>";
					phoneNo["<%=i%>"]  		= "<%=retVal.getValue("2.0."+i+".4")%>";
					broadPhone["<%=i%>"]  = "<%=retVal.getValue("2.0."+i+".5")%>";
					<%
				}
		}
		
	}else{
		%>
		phoneNo[0] = "<%=phone_no%>";
		
		<%
	}
	System.out.println("################################getCustId.jsp end####################  "+phone_no);
	retMsg="chenggong";
%>


var response = new AJAXPacket();
response.data.add("retCode","<%=retCode%>" );
response.data.add("retMsg","<%=retMsg%>");
response.data.add("loginType","<%=loginType%>");
response.data.add("phone_no",phoneNo);
response.data.add("custIdArr",custIdArr);
response.data.add("custNameArr",custNameArr);
response.data.add("custIccid",custIccid);
response.data.add("custCtime",custCtime);
response.data.add("broadPhone",broadPhone);
core.ajax.receivePacket(response);

