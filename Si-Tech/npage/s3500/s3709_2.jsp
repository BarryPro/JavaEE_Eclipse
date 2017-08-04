 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-01-16 页面改造,修改样式
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.util.StringTokenizer"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	
	String opName = (String)request.getParameter("opName");	
	
    	//ArrayList retArray = null;
    	String  error_code = "";
    	String error_msg = "";
    	String [][] result1  = new String [][]{};
    	
    	String workNo = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
   	String retcode2="";
   	String retMsg2="";
    	    //SPubCallSvrImpl callView = new SPubCallSvrImpl();	

	    //String[] retStr = null;
	    String loginAccept    = request.getParameter("loginAccept");													 
	     String opCode         = request.getParameter("opCode");
	    String loginNo      = request.getParameter("loginNo");
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
	    String grpName       =request.getParameter("grpName");	
    
	    /*luxc 20080130 add*/
	    String addmodeflag = request.getParameter("addmodeflag");
	    String mode_code = "0";
	    String pay_flag = "3";
    
		System.out.println("addmodeflag="+addmodeflag);




	    if("9".equals(addmodeflag))
	    {
	    	mode_code = request.getParameter("addProduct");
	    }
		else if("10".equals(addmodeflag))
		{
			pay_flag = request.getParameter("pay_flag");
		}
		else if("11".equals(addmodeflag))
		{
			mode_code = request.getParameter("addProduct");
	    	pay_flag = request.getParameter("pay_flag");
		}
		else if("3".equals(addmodeflag))
		{
			pay_flag = request.getParameter("pay_flag_3");
		}

   
    
		String mainRate       = " ";
		String newRate       = " ";
		String falseNo	="";
		String falseReason="";
		StringTokenizer strToken1=null;
		StringTokenizer strToken2=null;
	//String new_s = phoneNo.replaceAll(System.getProperty("line.separator"), "|");
   		String regionCode = (String)session.getAttribute("regCode");
	   // ArrayList paramsIn = new ArrayList();
	    String[] paramsIn = new String[16];
            paramsIn[0]=loginAccept;
            paramsIn[1]=opCode  ;
            paramsIn[2]=loginNo ;
            paramsIn[3]=loginPwd ;  
            paramsIn[4]=orgCode   ;   
            paramsIn[5]=sysNote   ;  
            paramsIn[6]=opNote  ;    
            paramsIn[7]=ipAddress ;      
            paramsIn[8]=phoneNo ;     
            paramsIn[9]=grpIdNo   ;    
            paramsIn[10]=grpOutNo  ;     
            paramsIn[11]=mainRate  ;
            paramsIn[12]=newRate  ;
            
            paramsIn[13]=addmodeflag ; 
            paramsIn[14]=mode_code  ;
            paramsIn[15]=pay_flag ;     

	    //传入参数数组s3702Cfm
	   // retStr = callView.callService("sProdMebAD", paramsIn, "3", "region", regionCode);
	    //callView.printRetValue();
           // error_code = callView.getErrCode();
            //error_msg= callView.getErrMsg();
            
            %>
            <wtc:service name="sProdMebAD" outnum="3" retmsg="retmsg1" retcode="retcode1" routerKey="region" routerValue="<%=regionCode%>">
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
	    </wtc:service>
	    <wtc:array id="result2" scope="end"  />           
            	
            <%
            	retMsg2=retmsg1;
            	retcode2=retcode1;
            	result1=result2;            
            	error_code = retcode1;
            	System.out.println("result2==================="+error_code);
            	error_msg=retmsg1;
            	System.out.println("result2==================="+error_msg);
		if(!error_code.equals("000000"))
			{
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=error_msg%>");
				location = "s3709.jsp";
			</script>
			<%
				return;
			}
			else
			{
				strToken1=new StringTokenizer(result1[0][1],"|");
				strToken2=new StringTokenizer(result1[0][2],"|");

		%>

			<script language="JavaScript">

				 function print_xls(){				 	
					 	window.open('s3709_2_printxls.jsp?phoneNo=<%=result1[0][1]%>&returnMsg=<%=result1[0][2]%>&unitID=<%=unitId%>&loginAccept=<%=loginAccept%>&grpName=<%=grpName%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');
				}			
			</script>

			<HTML>
				<HEAD>
					<TITLE>未成功号码列表</TITLE>

				</HEAD>
				<body>
					<FORM method=post name="f1500_custuser">
					<%@ include file="/npage/include/header.jsp" %>  
					<div class="title">
						<div id="title_zi">未成功号码列表</div>
					</div>	
					<table  cellspacing=0>
						<TBODY>
						        <TR>
						            <TD class="blue">流水 <%=result1[0][0]%></TD>					          
						        </TR>
						</TBODY>
					</table>
					
					<table cellspacing="0">
					   	<TBODY>
					              <TR> 			
					                  <TD class="blue">未成功号码</TD>
					                  <TD class="blue">未成功原因</TD>
					              </TR>
									
					<%			while (strToken1.hasMoreTokens()) {
					%>
									<TR>
										<td class="blue"> <%= strToken1.nextToken()%> </td>
										<td class="blue"> <%= strToken2.nextToken()%> </td>
									</TR>
					<%
								}
					%>
					         </TBODY>
				       </TABLE>
				       <table cellspacing=0>
				       		<tbody> 
					          	<tr> 
					      	   		<td  id="footer">
							    	      &nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭>
							    	      &nbsp; 
							    	           <input class="b_foot_long" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
							            <input class="b_foot" name=back onClick="JavaScript:history.go(-1)" style="cursor:hand" type=button value=返回>&nbsp;        
					            
					            		</td>
					          	</tr>
					        </tbody> 
					   </table>
					<%@ include file="/npage/include/footer.jsp" %>						 
				</FORM>
			</BODY>
		</HTML>
	<%}%>
	
	<%String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+retcode2+"&retMsgForCntt="+retMsg2+"&opName="+opName+"&workNo="+loginNo+"&loginAccept="+loginAccept+"&pageActivePhone=&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";%>
	<jsp:include page="<%=url%>" flush="true" />