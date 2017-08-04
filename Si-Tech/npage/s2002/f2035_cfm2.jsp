<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: leimd
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 20081220      wuxy        
 　*/
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
	String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
	String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
	int error_code = 0;
	String error_msg = "";
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = WtcUtil.repNull((String)session.getAttribute("password"));
	String ipAddr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	
	String productId = request.getParameter("productID");
	String orderSource = request.getParameter("orderSource");//定单来源
	String operType=WtcUtil.repNull(request.getParameter("operType"));
	String memberType=WtcUtil.repNull(request.getParameter("memberType"));
	
	
	System.out.println("productId="+productId);
	System.out.println("operType="+operType);
	System.out.println("orderSource="+orderSource);
	System.out.println("memberType="+memberType);
	
	String phoneNo = request.getParameter("phoneNo");
	
	phoneNo.replaceAll("\n","");
	StringTokenizer strToken1=null;
	StringTokenizer strToken2=null;
	System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvphoneNo="+phoneNo);

	
	/*file*/
	String iInputFile           = WtcUtil.repNull((String)request.getParameter("inputFile"));
	String iServerIpAddr        = realip;   // 0.100主机隐藏ip用上面方法得到的是0.100非真实ip
	String file_flag = request.getParameter("fileflag");
	
	
	String[] tMemberNo = phoneNo.split("\\|");
	System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvphoneNo="+phoneNo);
	System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvtMemberNo.length="+tMemberNo.length);
	
	String  chanpinCheck [] = new String[2];
	chanpinCheck[0] = "select count(1) from dproductorderdet a,dgrpusermsg b where a.product_id = :product_id and b.id_no = a.id_no and b.sm_code = 'cw'";
	chanpinCheck[1] = "product_id="+productId;
	String chanpinNum="0";
	
	if ( !file_flag.equals("1") )
	{
		for(int i=0;i<tMemberNo.length;i++){
	    //operTypes[i] = operType;
	    System.out.println("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvtMemberNo="+tMemberNo[i]);
		}	
	}

	
	if(tMemberNo.length>50)
	{
%>	
	<script language="JavaScript">
	 rdShowMessageDialog("一次最多操作50个号码");
	  window.location.replace("f2035_1.jsp");
    </script>
<%	
	}
    else
	{

	String[] tMemberType = null; 
	String[] tMemberGroup = null; 
	String[] tBeginTime = null; 
	String[] tEndTime = null; 
	String[] tMemberProperty = null;

	String[] characterIds = new String[tMemberNo.length];
	String[] characterNames = new String[tMemberNo.length]; 
	String[] characterValues = new String[tMemberNo.length];
	String[] operTypes = new String[tMemberNo.length];
	
	String hBeginTime = request.getParameter("beginTime");
	String hMemberGroup = request.getParameter("memberGroup");
	String hEndTime = request.getParameter("endTime");
	String hmemberType = request.getParameter("memberType");
	
	System.out.println("hBeginTime =  " + hBeginTime);
	System.out.println("hMemberGroup =  " + hMemberGroup);	
	System.out.println("hEndTime =  " + hEndTime);	
	System.out.println("hmemberType =  " + hmemberType);	
try{
%>
<wtc:service name="TlsPubSelCrm" routerKey="chanpinregion" routerValue="<%=regionCode%>" retcode="chanpinretCode" retmsg="chanpinretMsg" outnum="1"> 
	    <wtc:param value="<%=chanpinCheck[0]%>"/>
	    <wtc:param value="<%=chanpinCheck[1]%>"/> 
  	</wtc:service>  
  <wtc:array id="chanpinResult"  scope="end"/>
  <%
	if("000000".equals(chanpinretCode)){
		if(chanpinResult.length>0){
			chanpinNum = chanpinResult[0][0]+"";
  		}
		else{
			chanpinNum = "0";
		}
	}else{
		chanpinNum = "0";
	}
	}catch(Exception e){
	}
  %>

<wtc:service name="s2035Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="3"  retcode="Code" retmsg="Msg">
	<wtc:param value="<%=workNo%>" />
	<wtc:param value="<%=org_code%>" />
	<wtc:param value="<%=productId%>" />
	<wtc:param value="<%=orderSource%>" />
	<wtc:param value="<%=operType%>" />
	<wtc:param value="<%=phoneNo%>" />
	<wtc:param value="<%=memberType%>" />
	<wtc:param value=""/>
	<wtc:params value="<%=tMemberGroup%>" />
	<wtc:params value="<%=tBeginTime%>" />
	<wtc:params value="<%=tEndTime%>" />
	<wtc:params value="<%=characterIds%>" />
	<wtc:params value="<%=characterNames%>" />
	<wtc:params value="<%=characterValues%>" />
	<wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value=""/>
    <wtc:param value="<%=workPwd%>"/>
	<wtc:param value="<%=ipAddr%>"/>
	<wtc:param value="<%=iServerIpAddr%>" />
	<wtc:param value="<%=file_flag%>"/>
	<wtc:param value="<%=iInputFile%>"/>	
	<wtc:param value="<%=hBeginTime%>"/>
	<wtc:param value="<%=hMemberGroup%>" />
	<wtc:param value="<%=hEndTime%>"/>
	<wtc:param value="<%=hmemberType%>"/>
	<wtc:param value=""/>			
		
</wtc:service>
<wtc:array id="result" scope="end"/>
<!--	
	<script language="JavaScript">
	rdShowMessageDialog("操作成功!",2);
	window.location.replace("f2035_5.jsp");
</script>-->
<%
	String failedPhones = "";
	String failedReasons = "";
	if(result!=null&&result.length>0){
				failedPhones = result[0][0];
				failedReasons = result[0][1];
			}
	System.out.println("###################################failedPhones="+failedPhones);
	System.out.println("###################################failedReasons="+failedReasons);
	error_code = Code==""?999999:Integer.parseInt(Code);
    error_msg= Msg;
	if(error_code!=0){
%>
<script language="JavaScript">
	rdShowMessageDialog("错误代码:"+"<%=error_code%></br>"+"错误信息:"+"<%=error_msg%>");
	window.location.replace("f2035_1.jsp");
</script>
<%
   return;
}
	else{
		if(!"0".equals(chanpinNum)&&"0".equals(operType)){
		%>
			<script language="JavaScript">
				rdShowMessageDialog("业务办理申请已提交，请24小时后查询归档情况，若未及时归档请发起业务申告。",1);
			</script>
		<%
		}
	}
	strToken1=new StringTokenizer(failedPhones,"|");
	strToken2=new StringTokenizer(failedReasons,"|");
%>
<HTML><HEAD><TITLE> 未成功号码列表 </TITLE>
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
      	        <input class="b_foot" name=back onClick="window.location.href='f2035_1.jsp';" type=button value=返回>
      	    	<input class="b_foot" name=close onClick="removeCurrentTab();" type=button value=关闭>
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

