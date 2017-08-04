<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-14
********************/
%>

<%
  String opCode = "6727";
  String opName = "集团彩铃删除成员";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>


<%
    ArrayList retArray = null;
    String error_code = "0";
    String error_msg = "";
    Logger logger = Logger.getLogger("s6726_2.jsp");
    
    String workNo = (String)session.getAttribute("workNo");
	  String workName = (String)session.getAttribute("workName");

    String retStr1 = null;
    String retStr2 = null;
    
    String loginAccept    = request.getParameter("loginAccept");		 												 
    String loginNo        = request.getParameter("loginNo");       
    String loginPwd       = request.getParameter("loginPwd");         
    String orgCode        = request.getParameter("orgCode");             
    String sysNote        = request.getParameter("sysNote");           
    String opNote         = request.getParameter("opNote");            
    String ipAddress      = request.getParameter("ipAddress");           
    String phoneNo        = request.getParameter("phoneNo");            
    String grpIdNo        = request.getParameter("grpIdNo");								   
    String grpOutNo       = request.getParameter("grpOutNo");       
    String unitId	        = request.getParameter("unitId");             
    String grpName        = request.getParameter("grpName");	          
    String payType        = request.getParameter("payType");
    String mebProdCode    = request.getParameter("mebProdCode");
    String mebMonthFlag   = request.getParameter("mebMonthFlag");
    String matureFlag     = request.getParameter("matureFlag");
    String matureProdCode = request.getParameter("matureProdCode");
                                                                                                                                    
		String mainRate       = " ";                                    
		String newRate       = " ";                                     
		String falseNo	="";                                            
		String falseReason="";
		StringTokenizer strToken1=null;
		StringTokenizer strToken2=null;
	//String new_s = phoneNo.replaceAll(System.getProperty("line.separator"), "|");
    String regionCode = orgCode.substring(0,2);	
		String[] paramsIn = new String[18];

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
            paramsIn[13]=payType     ;
            paramsIn[14]=mebProdCode     ;
            paramsIn[15]=mebMonthFlag     ;
            paramsIn[16]=matureFlag;
            paramsIn[17]=matureProdCode;


%>
    <wtc:service name="s6726Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
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
				 <wtc:param value="<%=paramsIn[13]%>"/>						
				 <wtc:param value="<%=paramsIn[14]%>"/>						
				 <wtc:param value="<%=paramsIn[15]%>"/>						
				 <wtc:param value="<%=paramsIn[16]%>"/>						
				 <wtc:param value="<%=paramsIn[17]%>"/>		
		</wtc:service>
		<wtc:array id="result1_t" scope="end" start="0"  length="3" />

<%
			//传入参数数组s3702Cfm
			//retStr = callView.callService("s6726Cfm", paramsIn, "3", "region", regionCode);
			//callView.printRetValue();
			
			retStr1=result1_t[0][1];
			retStr2=result1_t[0][2];
			
		//	System.out.println("---------------retStr1----------hjw----------"+retStr1);
		//	System.out.println("---------------retStr2----------hjw----------"+retStr2);			
			
      error_code = code1;
      error_msg  = msg1;
			if(!(error_code.equals("000000"))){
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=error_msg%>");
				location = "f6727_1.jsp";
			</script>
			<%}
			else{
				strToken1=new StringTokenizer(retStr1,"~");
				strToken2=new StringTokenizer(retStr2,"~");

%>

<script language="JavaScript">

 function print_xls()
	 {
	 	
	 	
	 	window.open('s6726_2_printxls.jsp?phoneNo=<%=retStr1%>&returnMsg=<%=retStr2%>&unitID=<%=unitId%>&loginAccept=<%=loginAccept%>&grpName=<%=grpName%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');
	
	}
				
</script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>未成功号码列表</TITLE>
</HEAD>
<body>


<FORM method=post name="f1500_custuser">
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">未成功号码列表</div>
	</div>

            <TABLE cellSpacing="0">
              <TBODY>
                <TR bgcolor="E8E8E8"> 			
                  <TD class="blue">未删除成功号码</TD>
                  <TD class="blue">失败原因</TD>
                </TR>
				
<%			while (strToken1.hasMoreTokens()) {
%>
				<TR>
				<td> <%= strToken1.nextToken()%> </td>
				<td> <%= strToken2.nextToken()%> </td>
				</TR>
<%
			}
%>
              </TBODY>
            </TABLE>

      <table cellspacing="0">
        <tbody> 
          <tr  align="center"> 
      	    <td>
    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
    	      &nbsp; 
    	           <input class="b_foot_long" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
            <input class="b_foot" name=back onClick="window.location='f6727_1.jsp'" style="cursor:hand" type=button value=返回>&nbsp;        
            
            </td>
            
          
          </tr>
        </tbody> 
      </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY></HTML>
<%}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&retMsgForCntt="+msg1+"&opName="+opName+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />