<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
		String workNo = (String)session.getAttribute("workNo");
		String selfIp = request.getRemoteAddr();
		String phone_no = request.getParameter("phone_no")==null?"":request.getParameter("phone_no");
		String loginType = request.getParameter("loginType")==null?"":request.getParameter("loginType");
		String gCustId = request.getParameter("gCustId")==null?"":request.getParameter("gCustId");
		System.out.println("in  phone_no=="+phone_no);
		System.out.println("in  loginType=="+loginType);
		System.out.println("in  gCustId=="+gCustId);
   	Map map = (Map)session.getAttribute("contactInfo"); 
    ContactInfo contactInfo = (ContactInfo) map.get(gCustId);
    String paraAray[] = new String[5];

		paraAray[0] ="0";
		paraAray[1] = gCustId;
		paraAray[2] = workNo;
		paraAray[3] = selfIp;
		paraAray[4] = "";  				
  	      
    //�Ӵ�ƽ̨״̬
    String appCnttFlag = (String)application.getAttribute("appCnttFlag"); 
    System.out.println("%%%%%%ͳһ�Ӵ�ƽ̨��ǰ״̬��%%%%%%% "+appCnttFlag);
    
    if(appCnttFlag!=null&&"Y".equals(appCnttFlag))
    {
      System.out.println("%%%%%%����ͳһ�Ӵ���������%%%%%%%");
    try{
        String Contact_id="";
			%>
			    <wtc:service name="sInitCntt"  routerKey="phone" routerValue="<%=phone_no%>" outnum="1">
				    <wtc:param value=""/>
				    <wtc:param value=""/>
						<wtc:param value=""/>
						<wtc:param value=""/>
						<wtc:param value="<%=paraAray[0]%>"/>
						<wtc:param value="<%=paraAray[1]%>"/>
						<wtc:param value="01"/>
						<wtc:param value="00"/>
						<wtc:param value="i"/>
						<wtc:param value="<%=paraAray[2]%>"/>
						<wtc:param value=""/>
						<wtc:param value=""/>
						<wtc:param value=""/>
						<wtc:param value=""/>		
						<wtc:param value="<%=paraAray[3]%>"/>	
						<wtc:param value="<%=paraAray[4]%>"/>
			    </wtc:service>
			    <wtc:array id="rows"  scope="end"/>
			 <%  

		 	if(retCode.equals("000000")){
		 	   contactInfo.setContact_id(rows[0][0]);
		 	   Contact_id=rows[0][0];
		 	   System.out.println("���ýӴ�ID�ųɹ���"); 
		    }
		  	 session.setAttribute("_lastCurrentContactType","1");
	       session.setAttribute("_lastCurrentContactId",phone_no);  	 
	       session.setAttribute("_lastContactSeq",Contact_id);   
	    }catch(Throwable e)
	      {
	    		e.printStackTrace();
	      }
	    }	    
     //map.put(phone_no, contactInfo);
     //System.out.println(map);
     System.out.println("%%%%%%ͳһ�Ӵ������ɹ�%%%%%%%%%%");
%>
