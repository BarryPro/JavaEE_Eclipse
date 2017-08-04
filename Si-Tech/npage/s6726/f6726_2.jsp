<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-1-15
********************/
%>
<%
  String opName = "集团彩铃增加成员";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.util.StringTokenizer"%>


<%
    Logger logger = Logger.getLogger("s6726_2.jsp");

    String[] retStr = null;
    String loginAccept    = request.getParameter("loginAccept");										 
    String opCode         = request.getParameter("opCode");        
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
    String payType        = request.getParameter("payType1");
    String mebProdCode    = request.getParameter("mebProdCode");
    String mebMonthFlag   = request.getParameter("mebMonthFlag1");
    String matureFlag     = request.getParameter("matureFlag");
    String matureProdCode = request.getParameter("matureProdCode");
    if(phoneNo.equals("")){
     phoneNo= request.getParameter("phoneNo1")+"|";
    }                                                                                                                                     
		String mainRate       = " ";                                    
		String newRate       = " ";                                     
		String falseNo	="";                                            
		String falseReason="";
		StringTokenizer strToken1=null;
		StringTokenizer strToken2=null;
    String regionCode = (String)session.getAttribute("regCode");
  	String work_no = (String)session.getAttribute("workNo");  
						String[] paramsIn = new String[18];

            paramsIn[0]=loginAccept ;
            paramsIn[1]=opCode;
            paramsIn[2]=loginNo;
            paramsIn[3]=loginPwd;
            paramsIn[4]=orgCode  ;
            paramsIn[5]=sysNote   ;
            paramsIn[6]=opNote     ;
            paramsIn[7]=ipAddress   ;
            paramsIn[8]=phoneNo      ;
            paramsIn[9]=grpIdNo       ;
            paramsIn[10]=grpOutNo       ;
            paramsIn[11]=mainRate;
            paramsIn[12]=newRate  ;
            paramsIn[13]=payType    ;
            paramsIn[14]=mebProdCode ;
            paramsIn[15]=mebMonthFlag ;
            paramsIn[16]=matureFlag    ;
            paramsIn[17]=matureProdCode ;
            
						System.out.println("------------------phoneNo-------------------hjw----------------"+phoneNo);
			//传入参数数组s3702Cfm
			//retStr = callView.callService("s6726Cfm", paramsIn, "3", "region", regionCode);

%>

    <wtc:service name="s6726Cfm"  routerKey="region" routerValue="<%=regionCode%>" retmsg="msg1" retcode="code1" outnum="3" >				
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
		<wtc:array id="result1" scope="end"  />

<%      
      //System.out.println("--------------code1--------------hjw-----------"+code1);
			if(!code1.equals("000000")){
			%>
			<script language="JavaScript">
				rdShowMessageDialog("<%=msg1%>",2);
				history.go(-1);
			</script>
			<%}
			else{

				System.out.println("--------------result1[0][1]--------------hjw-----------"+result1[0][1]);
				System.out.println("--------------result1[0][2]--------------hjw-----------"+result1[0][2]);
				//--------------result1[0][1]--------------hjw-----------13900000000~
        //--------------result1[0][2]--------------hjw-----------没有用户资料或用户状态不正常[13900000000]!~
				    //--------------retStr[1]--------------hjw-----------13900000000~
            //--------------retStr[2]--------------hjw-----------没有用户资料或用户状态不正常[13900000000]!~
            
        String str1= result1[0][1];
        String str2= result1[0][2];   
				strToken1=new StringTokenizer(str1,"~");
				strToken2=new StringTokenizer(str2,"~");

%>

<script language="JavaScript">

 function print_xls()
	 {
	 	
	 	
	 	window.open('s6726_2_printxls.jsp?phoneNo=<%=str1%>&returnMsg=<%=str2%>&unitID=<%=unitId%>&loginAccept=<%=loginAccept%>&grpName=<%=grpName%>&op_Code=<%=opCode%>&orgCode=<%=orgCode%>');
	
	}
				
</script>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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
                  <td class="blue">未添加成功号码</TD>
                  <td class="blue">失败原因</TD>
                </TR>
				
				<%	while (strToken1.hasMoreTokens()) {
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
          <tr align="center"> 
      	    <td>
    	      &nbsp; <input class="b_foot" name=back  onClick="removeCurrentTab()" type=button value=关闭>
    	      &nbsp; 
    	         <input class="b_foot_long" name="prtxls"  type=button value="保存XLS文件" onclick="print_xls()" style="cursor:hand">&nbsp; &nbsp;
               <input class="b_foot" name=back onClick="window.location='f6726_1.jsp'" style="cursor:hand" type=button value=返回>&nbsp;                    
            </td>
          </tr>
        </tbody> 
      </table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%}%>

<%
String url = "/npage/contact/onceCnttInfo.jsp?opCode="+opCode+"&retCodeForCntt="+code1+"&retMsgForCntt="+msg1+"&opName="+opName+"&workNo="+work_no+"&loginAccept="+loginAccept+"&pageActivePhone="+phoneNo+"&opBeginTime="+opBeginTime+"&contactId="+unitId+"&contactType=grp";

%>
<jsp:include page="<%=url%>" flush="true" />