<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2008��10��25��
�� * ����: leimd
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 20081220      wuxy        
 ��*/
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
	String orderSource = request.getParameter("orderSource");//������Դ
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
	String iServerIpAddr        = realip;   // 0.100��������ip�����淽���õ�����0.100����ʵip
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
	 rdShowMessageDialog("һ��������50������");
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
	rdShowMessageDialog("�����ɹ�!",2);
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
	rdShowMessageDialog("�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>");
	window.location.replace("f2035_1.jsp");
</script>
<%
   return;
}
	else{
		if(!"0".equals(chanpinNum)&&"0".equals(operType)){
		%>
			<script language="JavaScript">
				rdShowMessageDialog("ҵ������������ύ����24Сʱ���ѯ�鵵�������δ��ʱ�鵵�뷢��ҵ����档",1);
			</script>
		<%
		}
	}
	strToken1=new StringTokenizer(failedPhones,"|");
	strToken2=new StringTokenizer(failedReasons,"|");
%>
<HTML><HEAD><TITLE> δ�ɹ������б� </TITLE>
</HEAD>
<body>
<FORM method=post name="backandwhite">
	<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">δ�ɹ������б�</div>
		</div>		
      <table cellspacing=0>
        <TBODY>
          <TR>
            <TD class="blue">��ˮ</TD>
          </TR>
        </TBODY>
      </table>

	    <TABLE cellSpacing="0">
	      <TBODY>
	        <TR> 			
	          <TD width=12%>δ��ӳɹ�����</TD>
	          <TD width=13%>ʧ��ԭ��</TD>
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
      	        <input class="b_foot" name=back onClick="window.location.href='f2035_1.jsp';" type=button value=����>
      	    	<input class="b_foot" name=close onClick="removeCurrentTab();" type=button value=�ر�>
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

