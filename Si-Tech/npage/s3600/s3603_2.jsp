<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-4
********************/
%>
  
<%
  String opName = "BOSS侧VPMN成员管理(套餐变更)";
%>    
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>       
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<%
    ArrayList retArray = null;
    String error_code ="0";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3603_2.jsp");

	String[] retStr = null;
    String loginAccept    = request.getParameter("loginAccept");
    String opCode         = request.getParameter("opCode");
    String loginNo         = request.getParameter("loginNo");
    String loginPwd     = request.getParameter("loginPwd");
    String orgCode        = request.getParameter("orgCode");
    String sysNote       = request.getParameter("sysNote");
    String opNote        = request.getParameter("opNote");
    String ipAddress         = request.getParameter("ipAddress");
    String phoneNo         = request.getParameter("phoneNo");
    String grpIdNo         = request.getParameter("grpIdNo");
    String grpOutNo         = request.getParameter("grpOutNo");
	String mainRate       = request.getParameter("mainRate");
	String newRate       = request.getParameter("newRate");
    //
     String unitId	 =request.getParameter("unitId");
    //
    String regionCode = (String)session.getAttribute("regCode");
 	
			String[] paramsIn = new String[13];

            paramsIn[0]=loginAccept;
            paramsIn[1]=opCode ;
            paramsIn[2]=loginNo;
            paramsIn[3]=loginPwd;
            paramsIn[4]=orgCode ;
            paramsIn[5]=sysNote ;
            paramsIn[6]=opNote;
            paramsIn[7]=ipAddress  ;
            paramsIn[8]=phoneNo+"|" ;
            paramsIn[9]=grpIdNo ;
            paramsIn[10]=grpOutNo;
            paramsIn[11]=mainRate ;
            paramsIn[12]=newRate;

			//传入参数数组
			//retStr = callView.callService("s3603Cfm", paramsIn, "1", "region", regionCode);
%>

    <wtc:service name="s3603Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />
			<wtc:param value="<%=paramsIn[6]%>" />
			<wtc:param value="<%=paramsIn[7]%>" />
			<wtc:param value="<%=paramsIn[8]%>" />
			<wtc:param value="<%=paramsIn[9]%>" />
			<wtc:param value="<%=paramsIn[10]%>" />
			<wtc:param value="<%=paramsIn[11]%>" />
			<wtc:param value="<%=paramsIn[12]%>" />												
		</wtc:service>
<%			
            error_code = code1;
            error_msg= msg1;
            
%>

	<%
	System.out.println("--------------opCode--------"+opCode);   
	 
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+
								 "&retCodeForCntt="+error_code+
								 "&retMsgForCntt="+error_msg+
	               "&opName="+sysNote+
     	    			 "&workNo="+loginNo+
     	    			 "&loginAccept="+loginAccept+
     	    			 "&pageActivePhone="+phoneNo+
     	    			 "&opBeginTime="+opBeginTime+
     	    			 "&contactId="+unitId+
     	    			 "&contactType=grp";
     	    			 System.out.println("URL："+url);    
  %>
<jsp:include page="<%=url%>" flush="true" />            

<%       
            System.out.println("-------------error_code---1---------------"+error_code);
            System.out.println("-------------error_msg------------------"+error_msg);

    if(error_code.equals("000000"))
    {
%>
        <script language='jscript'>
<%
		if (opCode.equals("3603"))
		{
%>
            rdShowMessageDialog("成员用户开户操作成功！",2);
<%
		}
		else if (opCode.equals("3604"))
		{
%>
            rdShowMessageDialog("成员用户销户操作成功！",2);
<%
		}
		else if (opCode.equals("3605"))
		{
%>
            rdShowMessageDialog("成员用户套餐变更操作成功！",2);
<%
		}
%>
            location = "s3603_1.jsp?opCode=<%=opCode%>&opName=<%=sysNote%>";
        </script>
<%
	}
	else
	{
%>
        <script language='jscript'>
            
            var path="/npage/s3600/s3603_1_printxls.jsp?phoneNo=" + "<%=phoneNo%>";
               
	   		if (rdShowConfirmDialog("<%=error_code%>" + "[" + "<%=error_msg%>" + "]"+"<br>是否保存错误信息？")==1)	
			{
				path = path + "&returnMsg=" + "<%=error_code%>" + "[" + "<%=error_msg%>" + "]"+ "&unitID=" + "<%=unitId%>";
	  			path = path + "&loginAccept=" + "<%=loginAccept%>"  ;
	  			path = path + "&op_Code=" + "<%=opCode%>";
	  			path = path + "&orgCode=" + "<%=orgCode%>";
          			window.open(path);
			}	
            history.go(-1);
        </script>
<%
    }
%>
