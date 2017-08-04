<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-15
********************/
%>
<%
/*huangrong update for 关于求职通业务支撑的函  2011-8-1*/
  String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<%
    Logger logger = Logger.getLogger("f3596Cfm.jsp");

    String[] retStr = null;
    String loginAccept    = request.getParameter("loginAccept");										        
    String loginNo        = request.getParameter("loginNo");       
    String loginPwd       = request.getParameter("loginPwd");         
    String orgCode        = request.getParameter("orgCode");             
    String systemNote        = request.getParameter("systemNote");                  
    String ipAddress      = request.getParameter("ipAddress");   
            
    String phoneNo          = request.getParameter("phoneNo1");            
    String opFlag           = request.getParameter("opFlag");								   
    String ecsiId           = request.getParameter("ecsiId");       
    String bizcode	        = request.getParameter("bizcode");             
    String baseservcodeprop = request.getParameter("baseservcodeprop");	          
    String servcode         = request.getParameter("servcode");
    String explog           = request.getParameter("explog");
    String extraOption        = request.getParameter("extraOption");
    String idNo             = request.getParameter("vidNo");
    String opCode1="";
                                                                   
    if(opFlag.equals("01"))
    {
    	opCode1="3709";
    }
    else
    {
    	opCode1="3704";
    }                              
                                                                                                                                    
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
    String regionCode = (String)session.getAttribute("regCode");
  	String work_no = (String)session.getAttribute("workNo"); 
  	String phoneNo1 =phoneNo+"|";
  	System.out.println("opCode="+opCode);
  	System.out.println("loginNo="+loginNo);
  	System.out.println("loginPwd="+loginPwd);
  	System.out.println("orgCode="+orgCode);
  	System.out.println("systemNote="+systemNote);
  	System.out.println("phoneNo="+phoneNo);
  	System.out.println("opFlag"+opFlag);
  	System.out.println("ecsiId="+ecsiId);
  	System.out.println("bizcode="+bizcode);
  	System.out.println("baseservcodeprop="+baseservcodeprop);
  	System.out.println("servcode="+servcode);
  	System.out.println("explog="+explog);
  	System.out.println("extraOption="+extraOption);
  	System.out.println("idNo="+idNo);
  	System.out.println("phoneNo1="+phoneNo1);
  	System.out.println("opCode1"+opCode1);
  	

%>

    <wtc:service name="sProdAD_NXE"  routerKey="region" routerValue="<%=regionCode%>" retmsg="msg1" retcode="code1" outnum="3" >	
    	<wtc:param value="<%=loginAccept%>"/>			
			<wtc:param value="<%=opCode1%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=orgCode%>"/>
			<wtc:param value="<%=systemNote%>"/>
			<wtc:param value="<%=systemNote%>"/>
			<wtc:param value="<%=ipAddress%>"/>
			<wtc:param value="<%=phoneNo1%>"/>
			<wtc:param value="<%=idNo%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="9"/>
			<wtc:param value="<%=extraOption%>"/>
			<wtc:param value="3"/>
			<wtc:param value="<%=opCode%>"/>  <!--huangrong add for 关于求职通业务支撑的函  2011-8-1-->
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
			
<%      


		System.out.println("%%%%%%%调用统一接触开始%%%%%%%%");
		String retCodeForCntt = code1 ;
		//String loginAccept ="";
		if(code1.equals("0")||code1.equals("000000")){
				if(result1.length>0){
				  loginAccept=result1[0][0];
				}
		}
		String url = "/npage/contact/upCnttInfo.jsp?opCode="+opCode +"&retCodeForCntt="+code1+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&retMsgForCntt="+msg1+"&opBeginTime="+opBeginTime;
		System.out.println("url="+url);
		
%>
		<jsp:include page="<%=url%>" flush="true" />
<%
		System.out.println("%%%%%%%调用统一接触结束%%%%%%%%"); 	
		
      System.out.println("--------------code1--------------hjw-----------"+code1);
      System.out.println("--------------msg1--------------msg1-----------"+msg1);
			if(!code1.equals("000000")){
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=msg1%>",0);
				history.go(-1);
			</script>
			<%}
			else{

				
				System.out.println("--------------result1[0][1]--------------hjw-----------"+result1[0][0]);
				System.out.println("--------------result1[0][2]--------------hjw-----------"+result1[0][1]);
				//--------------result1[0][1]--------------hjw-----------13900000000~
        //--------------result1[0][2]--------------hjw-----------没有用户资料或用户状态不正常[13900000000]!~
		    //--------------retStr[1]--------------hjw-----------13900000000~
        //--------------retStr[2]--------------hjw-----------没有用户资料或用户状态不正常[13900000000]!~
            
          
          String str2= result1[0][1];  
          if(!str2.trim().equals(""))
          {
                String str1= result1[0][2];
          		strToken2=new StringTokenizer(str1,"|");
          		String[] errMsgArr = new String[strToken2.countTokens()];
          		int j = 0;
    			while(strToken2.hasMoreTokens()){
        		errMsgArr[j++] = strToken2.nextToken();
        		}
        		System.out.println("---------"+errMsgArr[0]);
%>
          <script language="JavaScript">
				   rdShowMessageDialog("<%=errMsgArr[0]%>",1);
				   history.go(-1);
			    </script>
<%
          }
        else
        {
		//		strToken1=new StringTokenizer(str1,"|");
		//		strToken2=new StringTokenizer(str2,"|");

%>
     <script language="JavaScript">
				rdShowMessageDialog("操作成功",2);
				window.location.replace("f3596_1.jsp?activePhone=<%=phoneNo%>&activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>");//huangrong update for 关于求职通业务支撑的函  2011-8-1
		 </script>    

<%}

}
		





%>


		
			
			
