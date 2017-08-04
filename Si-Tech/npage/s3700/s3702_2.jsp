<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-16
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>  
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>
<%
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
%>
<%
    String error_code = "";
    String error_msg = "";
    
    Logger logger = Logger.getLogger("f3702_2.jsp");
    String workNo = (String)session.getAttribute("workNo");
   	String workName = (String)session.getAttribute("workName");
   	
    String loginAccept    = request.getParameter("loginAccept");														 
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
	String unitId=request.getParameter("unitId");	 /* 集团id baixf add 20070606   */
	//
	
	
	
	
	String mainRate       = " ";
	String newRate       = " ";
	String falseNo	="";
	String falseReason="";
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
  String regionCode = (String)session.getAttribute("regCode");
	String[] paramsIn = new String[18];
	String[][] retStr = new String[][]{};		
			
    phoneNo.replaceAll("\n"," ");
    //wuxy alter 20081201 为防止电话号码个数超出范围引起越界
	String [] array=phoneNo.split("\\|");	
    if(array.length>50)
	{
%>
      <script language='jscript'>
			rdShowMessageDialog('一次最多操作50个号码',0);
			location = "s3702.jsp";
		</script>	
<%  }
    else
    {	

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

            paramsIn[13]=request.getParameter("allPayFlag")	;
            paramsIn[14]=request.getParameter("allFlag")		;
            paramsIn[15]=request.getParameter("cycleMoney")	;
            paramsIn[16]=request.getParameter("beginDate")	;
        	  paramsIn[17]=request.getParameter("endDate")	;
        	  
		        
%> 

    <wtc:service name="s3702Cfm" outnum="3" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
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
			<wtc:param value="<%=paramsIn[13]%>" />
			<wtc:param value="<%=paramsIn[14]%>" />
			<wtc:param value="<%=paramsIn[15]%>" />
			<wtc:param value="<%=paramsIn[16]%>" />
			<wtc:param value="<%=paramsIn[17]%>" />
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%       	
			//传入参数数组
			//retStr = callView.callService("s3702Cfm", paramsIn, "3", "region", regionCode);
            error_code = code1;
            error_msg= msg1;
            retStr = result_t;
			if(!error_code.equals("000000")){
			%>

			<script language="JavaScript">
				rdShowConfirmDialog("错误代码:"+"<%=error_code%>"+"错误信息:"+"<%=error_msg%>")
				location = "s3702.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>			
			<%}
			else{
				
				strToken1=new StringTokenizer(retStr[0][1],"|");
				strToken2=new StringTokenizer(retStr[0][2],"|");

%>
<script language="JavaScript">
function print_xls()
 {
   var path="<%=request.getContextPath()%>/page/s3700/f3702_2_printxls.jsp?phoneNo=" + "<%=retStr[0][1]%>";
   path = path + "&returnMsg=" + "<%=retStr[0][2]%>"+ "&unitID=" + "<%=unitId%>";
   path = path + "&loginAccept=" + "<%=error_code%>"  ;
   path = path + "&op_Code=" + "<%=opCode%>";
   path = path + "&orgCode=" + "<%=orgCode%>";
   window.open(path);         	 	
  
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
	
            <TABLE  cellSpacing="0" >
              <TBODY>
                <TR> 			
                  <TD class="blue">未添加成功号码</TD>
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

      <table cellspacing=0>
        <tbody> 
          <tr align="center"> 
      	    <td>
      	    	<input class="b_foot" name=back2 onClick="history.go(-1);" type=button value=返回>
    	      &nbsp; 
    	      <input class="b_foot_long" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
    	      &nbsp; 
    	    <input class="b_foot" name=back 	onClick="removeCurrentTab()" type=button value=关闭>
    	    </td>
          </tr>
        </tbody> 
      </table>
<%@ include file="/npage/include/footer_simple.jsp" %>

</FORM>
</BODY></HTML>
<%}
}%>

<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+error_code+"&retMsgForCntt="+error_msg+"&opName="+opNote+"&workNo="+workNo+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";%>
<jsp:include page="<%=url%>" flush="true" />
