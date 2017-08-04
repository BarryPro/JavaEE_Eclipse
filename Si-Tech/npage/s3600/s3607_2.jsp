<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-20
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  String opName = "BOSS侧VPMN批量成员管理";
%>

<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>

<%
    String error_code = "";
    String error_msg = "";
    Logger logger = Logger.getLogger("f3607_2.jsp");
    
    String workNo = (String)session.getAttribute("workNo");
   	String workName = (String)session.getAttribute("workName");
		String regionCode = (String)session.getAttribute("regCode");
		
	  String[][] retStr = null;
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
	//
	 String unitId	 =request.getParameter("unitId");
	//

	//for(int i=0;i<phoneNo.length;i++){
	phoneNo.replaceAll("\n"," ");
	//}
	//System.out.println("@@@@@@@@@@@@@@"+phoneNo.trim());
	String mainRate       = " ";
	String newRate       = " ";
	String falseNo	="";
	String falseReason="";
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
    try
    {		
			String[] paramsIn = new String[13];

            paramsIn[0]=loginAccept;
            paramsIn[1]=opCode     ;
            paramsIn[2]=loginNo     ;
            paramsIn[3]=loginPwd ;
            paramsIn[4]=orgCode    ;
            paramsIn[5]=sysNote   ;
            paramsIn[6]=opNote    ;
            paramsIn[7]=ipAddress     ;
            paramsIn[8]=phoneNo     ;
            paramsIn[9]=grpIdNo     ;
            paramsIn[10]=grpOutNo     ;
            paramsIn[11]=mainRate;
            paramsIn[12]=newRate;

			//传入参数数组
			//retStr = callView.callService("s3603Cfm", paramsIn, "3", "region", regionCode);

%>

    <wtc:service name="s3603Cfm"  routerKey="region" routerValue="<%=regionCode%>" retmsg="msg1" retcode="code1" outnum="3">
			<wtc:param value="<%=paramsIn[0]%>"/>
			<wtc:param value="<%=paramsIn[1]%>"/>
			<wtc:param value="<%=paramsIn[2]%>"/>
			<wtc:param value="<%=paramsIn[3]%>"/>
			<wtc:param value="<%=paramsIn[4]%>"/>
			<wtc:param value="<%=paramsIn[5]%>"/>
			<wtc:param value="<%=paramsIn[6]%>"/>
			<wtc:param value="<%=paramsIn[7]%>"/>
			<wtc:param value="<%=paramsIn[8]%>"/>
			<wtc:param value="<%=paramsIn[9]%>"/>
			<wtc:param value="<%=paramsIn[10]%>"/>
			<wtc:param value="<%=paramsIn[11]%>"/>
			<wtc:param value="<%=paramsIn[12]%>"/>
		</wtc:service>
		<wtc:array id="result_t" scope="end"/>

<%           
  					retStr = result_t;	
						error_code = code1;
            error_msg= msg1;
            if(!error_code.equals("000000"))
            {
            %>
            <script language="JavaScript">
            	
	   		if (rdShowConfirmDialog("<br>错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>"+"<br>是否保存错误信息？")==1)	
			{
				window.open('s3607_2_printxls.jsp?phoneNo=<%=retStr[0][1]%>&returnMsg=<%=retStr[0][2]%>&unitID=<%=unitId%>&loginAccept=<%=loginAccept%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');	
          		}	
            	document.location.replace("s3607_1.jsp");
            	//history.go(-1);
            </script>
            <%
            return;
            }
     //System.out.println("---------------retStr[0][1]---------------hjw-----------------"+retStr[0][1]);
     //System.out.println("---------------retStr[0][2]---------------hjw-----------------"+retStr[0][2]);
            
			strToken1=new StringTokenizer(retStr[0][1],"|");
			strToken2=new StringTokenizer(retStr[0][2],"|");
			 
    }
    catch(Exception e)
    {
		System.out.println(e.toString());
        logger.error("Call s3603Cfm is Failed!");
    }


%>
<script language="JavaScript">

function print_xls()
{	 	
 	window.open('s3607_2_printxls.jsp?phoneNo=<%=retStr[0][1]%>&returnMsg=<%=retStr[0][2]%>&unitID=<%=unitId%>&loginAccept=<%=loginAccept%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');	
}				
</script>



<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>未成功号码列表</TITLE>
</HEAD>
<body>


<FORM method=post name="f1500_custuser">
	<%@ include file="/npage/include/header.jsp" %>


		<div class="title">
		<div id="title_zi">未成功号码列表</div>
	</div>

            <TABLE cellSpacing="0">
              <TBODY>
                <TR> 			
                  <TD class="blue">未添加成功号码</TD>
                  <TD class="blue">失败原因</TD>
                </TR>
				
<%			while (strToken1.hasMoreTokens()) {
%>
				<TR>
				<td height="25"> <%= strToken1.nextToken()%> </td>
				<td height="25"> <%= strToken2.nextToken()%> </td>
				</TR>
<%
			}
%>
              </TBODY>
            </TABLE>

      <table cellspacing=0>
        <tbody> 
          <tr align="center" id="footer"> 
      	    <td>
      	    	
    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	      &nbsp; 
    	     <input class="b_foot" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
            <input class="b_foot" name=back onClick=window.location="s3607_1.jsp" style="cursor:hand" type=button value=返回>&nbsp;        
            
    	    </td>
          </tr>
        </tbody> 
      </table>

<%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY></HTML>
<%
	String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code
		+"&retMsgForCntt="+error_msg+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept
		+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+unitId
		+"&contactType=grp";
	
%>
	<jsp:include page="<%=url%>" flush="true" />
