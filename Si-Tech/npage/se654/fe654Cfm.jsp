
<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
		String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
		String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
			
		int error_code = 0;
		String error_msg = "";
		String opType = WtcUtil.repNull(request.getParameter("opType"));
		String regionCode = (String)session.getAttribute("regionCode");
		String retType = request.getParameter("retType");
		String id_no = request.getParameter("id_no");
		String black_type = request.getParameter("black_type");
		String EfftT = request.getParameter("EfftT");
		String ECSIID =	 request.getParameter("ECSIID");
		String ECSIType=request.getParameter("EcSiType1");
		String loginAccept = request.getParameter("loginAccept");
		String loginNo= request.getParameter("loginNo");
		String loginPwd =request.getParameter("loginPwd");
		String orgCode= request.getParameter("orgCode");
		String sysNote= request.getParameter("sysNote");
		String opNote = request.getParameter("opNote");
		String ipAddress =request.getParameter("ipAddress");
		String phoneNo= request.getParameter("phoneNo");
		phoneNo.replaceAll("\n"," ");
		String grpIdNo= request.getParameter("grpIdNo");
		String grpOutNo =request.getParameter("grpOutNo");
		String sSaveName="";
		String server_ip_Addr="";
		 if(black_type.equals("01"))
    {
    	opCode="e654";
    }
    else if(black_type.equals("02"))
    {
    	opCode="e655";
    }   
    else if(black_type.equals("03"))  
     	{
    	opCode="e656";
    }
  	else if(black_type.equals("04"))  
  	{
    	opCode="e657";
    }
		System.out.println("loginAccept:"+loginAccept);
		System.out.println("opCode:"+opCode);
		System.out.println("loginNo:"+loginNo);
		System.out.println("loginPwd:"+loginPwd);
		System.out.println("orgCode:"+orgCode);
		System.out.println("sysNote:"+sysNote);
		System.out.println("opNote:"+opNote);
		System.out.println("ipAddress:"+ipAddress);
		System.out.println("phoneNo:"+phoneNo);
		System.out.println("EfftT:"+EfftT);
		System.out.println("ECSIID:"+ECSIID);
		System.out.println("ECSIType:"+ECSIType);
		
		
	//wuxy alter 20081030 为解决电话号码个数超出范围引起越界，服务队列积压问题
	String [] array=phoneNo.split("\\|");
	
	if(array.length>50)
	{
%>
    <script language='jscript'>
			rdShowMessageDialog('一次最多操作50个号码',0);
			window.location.href="fe654.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%	
	}else{
			String falseNo	="";
			String falseReason="";
			StringTokenizer strToken1=null;
			StringTokenizer strToken2=null;
%>
				<wtc:service name="se654Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=loginNo%>"/>
				<wtc:param value="<%=loginPwd%>"/>
				<wtc:param value="<%=orgCode%>"/>
				<wtc:param value="<%=ipAddress%>"/>
				<wtc:param value="<%=phoneNo%>"/>
				<wtc:param value="<%=black_type%>"/>
				<wtc:param value="<%=EfftT%>"/>
				<wtc:param value="<%=ECSIID%>"/>
				<wtc:param value="<%=ECSIType%>"/>
				</wtc:service>
				<wtc:array id="callDataArr" scope="end"/>
<%			

			String failedPhones = "";
			String failedReasons = "";
			if(callDataArr!=null&&callDataArr.length>0){
				failedPhones = callDataArr[0][0];
				failedReasons = callDataArr[0][1];
			}
			
      error_code = retCode1==""?999999:Integer.parseInt(retCode1);
      error_msg= retMsg1;
      System.out.println("error_code="+error_code);
      
      if(error_code!=0)
      {
	%>
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>");
					window.location.href="fe654.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
				</SCRIPT>
	<%
				return;
			}
      strToken1=new StringTokenizer(failedPhones,"|");
			strToken2=new StringTokenizer(failedReasons,"|");
%>

<HTML><HEAD><TITLE> 未成功号码列表 </TITLE>
	<script type=text/javascript>
		function goBack(){
			window.location.href="fe654.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		}
	</script>
</HEAD>
<body>
<FORM method=post name="backandwhite">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">未成功号码列表</div>
		</div>		
      <table cellspacing=0>
        <TBODY>
          <TR>
            <TD class="blue">流水</TD>
          </TR>
        </TBODY>
      </table>

	    <TABLE cellSpacing="0">
	      <TBODY>
	        <TR> 			
	          <TD width=12%>未添加成功号码</TD>
	          <TD width=13%>失败原因</TD>
	        </TR>
				
			<%
			while (strToken1.hasMoreTokens()) 
			{
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
          <tr> 
      	    <td id="footer">
      	    	<input class="b_foot" name="cloBtn" onClick="removeCurrentTab();" type=button value=关闭>
      	    	 <input class="b_foot" name="backBtn" onClick="goBack()" style="cursor:hand" type=button value=返回>&nbsp;                    
    	    	</td>
          </tr>
        </tbody> 
      </table>
  		<%@ include file="/npage/include/footer.jsp" %>      
		</FORM>
	</BODY>
</HTML>
<%
	}
%>

