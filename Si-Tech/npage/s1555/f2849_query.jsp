<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<%
  response.setDateHeader("Expires", 0);
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		
  String opCode = "2849";
  String opName = "�������ż��ŷ��������Ϣ��ѯ";	
  String loginNo = (String)session.getAttribute("workNo");
  String loginName =(String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String strRegionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String IccId = ""; 
  String mark = ""; 
  String cust_address = "";
  String shorttype = "";
  
%>
<%
  String retFlag="";
  String retMsg="";//�����ж�ҳ��ս���ʱ����ȷ��
  
  String strPhoneNo = request.getParameter("phone_no");
  String strProsDate = request.getParameter("pros_date");
  String strProsContent = request.getParameter("pros_content"); 
  
   //ȡ�û�������Ϣ
									
	String notestr="����phone_no==["+strPhoneNo+"]���в�ѯ";
	String strCustName = "";
	String strIdIccid = "";
	String strIdAddress = "";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=strRegionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=loginNo%>"/>	
  <wtc:param value="<%=loginNoPass%>"/>		
  <wtc:param value="<%=strPhoneNo%>"/>	
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result1" start="1" length="40" scope="end"/>
<%					
  if("000000".equals(retCode1)){
    if(result1.length>0){
      if("00".equals(returnFlag[0][0])){
  	   	strCustName = (result1[0][4]).trim();
        strIdIccid = (result1[0][12]).trim();
        strIdAddress = (result1[0][13]).trim();
      }
    }
  }
  

  String bp_name = "";
  String passwordFromSer = "";

  
	//����title
	String titlename = "�������ż��ŷ��������Ϣ��ѯ";  //��������
	String op_code = "";  //op_code
	
 	int j=0;
  
 	String[] paraAray1 = new String[5];
  paraAray1[0] = loginNo; 			/* ��������   */
  paraAray1[1] = loginNoPass; 	/* ��������   */
  paraAray1[2] = strPhoneNo;		/* �ֻ�����   */ 
  paraAray1[3] = strProsDate;		
  paraAray1[4] = strProsContent;

  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }
  System.out.println("123");
  //retList = impl.callFXService("sSMProsQry", paraAray1, "30","phone",strPhoneNo);
%>
           <wtc:service name="sSMProsQry" routerKey="regionCode" routerValue="<%=strRegionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="30" >
			       <wtc:param value="<%=paraAray1[0]%>"/>
			       <wtc:param value="<%=paraAray1[1]%>"/>
			       <wtc:param value="<%=paraAray1[2]%>"/>
			       <wtc:param value="<%=paraAray1[3]%>"/>
			       <wtc:param value="<%=paraAray1[4]%>"/>
		</wtc:service>
		<wtc:array id="tmpresult1" start="3" length="1" scope="end" />
		<wtc:array id="tmpresult2" start="0" length="1" scope="end" />
		<wtc:array id="tmpresult3" start="26" length="1" scope="end" />
		<wtc:array id="tmpresult4" start="1" length="1" scope="end" />
		<wtc:array id="tmpresult5" start="4" length="1" scope="end" />
		<wtc:array id="tmpresult6" start="10" length="1" scope="end" />
		<wtc:array id="tmpresult7" start="17" length="1" scope="end" />
		<wtc:array id="tmpresult8" start="12" length="1" scope="end" />
		<wtc:array id="tmpresult9" start="14" length="1" scope="end" />
		<wtc:array id="tmpresult10" start="28" length="1" scope="end" />
<%
  if(tmpresult1 == null)
  {
		retFlag = "1";
	  retMsg = "s2266Init��ѯ���������ϢΪ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }else if(!(tmpresult1 == null))
  {
  	if (!errCode.equals("000000")){
	  	retFlag = "1";
	    retMsg = "s2266Init��ѯ�û��������ż��ŷ��������Ϣʧ��!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
   	}		
  }
//********************�õ�ӪҵԱȨ�ޣ��˶����룬�������Ż�Ȩ��*****************************// 
   //�Ż���Ϣ
  
   String handFee_Favourable = "readonly";        //a230  ������
//begin add by diling for ������Ȩ������ @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==������======f2849_query.jsp==== pwrf = " + pwrf);
//end add by diling  
  
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
    System.out.println("enter");

	    
	   String passFromPage=Encrypt.encrypt(passTrans);
	    
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	
	   {
	    System.out.println("passFromPage="+passFromPage);
	    System.out.println("passwordFromSer="+passwordFromSer);

       retFlag = "1";
       retMsg = "�������!";
	  }
  }
  
if (pwrf){
System.out.println("2password is ture");
}else{
	System.out.println("2password is false");
} 
  
  /****�õ���ӡ��ˮ****/
  String printAccept="";
  printAccept = getMaxAccept();
	

%>
<head>
<title><%=titlename%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
<!--
  //����Ӧ��ȫ�ֵı���
  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
  var YE_SUCC_CODE = "0000";	 	//����Ӫҵϵͳ������޸�

 
//-->
</script>

</head>


<body>
<form name="frm" method="post"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�������ż��ŷ��������Ϣ��ѯ</div>
	</div>
      <table cellspacing="0">
		  <tr> 
            <td class="blue">�ٱ�����</td>
            <td>
			    <input name="phoneNo" type="text" class="button" id="phoneNo" value="<%=strPhoneNo%>" readonly> 
            <td class="blue">�ͻ�����</td>
            <td>
			  <input name="bp_name" type="text" class="button" id="bp_name" size="60" value="<%=strCustName%>" readonly> 
			</td>  
          </tr>
      </table>
     <table cellspacing="0">
		  <tr> 
     		<td class="blue">���֤��</td>
     		<td>
  			<input name="IccId" type="text" class="button" id="IccId" value="<%=strIdIccid%>" readonly> 
			</td>
			<td class="blue">�ͻ���ַ</td>
      <td>
			  <input name="cust_address" type="text" class="button" id="cust_address" size="60" value="<%=strIdAddress%>" readonly> 
			</td>  
      </tr>
      </table>
 
	<TABLE cellspacing="0">
   	<TBODY> 
			<tr >
		  	<td colspan="10"></td>
		  </tr>
		  <tr>
			  <th  align=center>�ٱ�����</th>
			  <th  align=center>�ٱ�ʱ��</th>
			  <th align=center >�ٱ�;��</th>
			  <th  align=center>���ٱ�����</th>
			  <th align=center >�������</th>
			  <th align=center >�ٱ����ݷ���</th>
			  <th  align=center>���ٱ�CP���</th>
			  <th align=center >���ٱ����������Ӫ��</th>
			  <th align=center >������</th>
			  <th align=center >���ŷ���</th>
		  </tr>
      <% 
			for(j=0;j<tmpresult1.length;j++){
		  %>
			<tr bgcolor="#F5F5F5" height="20">
				<TD ><%=tmpresult1[j][0]%></TD>
				<TD ><%=tmpresult2[j][0]%></TD>
				<TD ><%=tmpresult3[j][0]%></TD>
				<TD ><%=tmpresult4[j][0]%></TD>
				<TD ><%=tmpresult5[j][0]%></TD>
				<TD ><%=tmpresult6[j][0]%></TD>
				<TD ><%=tmpresult7[j][0]%></TD>
				<TD ><%=tmpresult8[j][0]%></TD>
				<TD ><%=tmpresult9[j][0]%></TD>
				<TD ><%=tmpresult10[j][0]%></TD>
			</tr>				
			<%}%>  		
 		</TBODY>
	</TABLE>			 
  <table cellspacing="0">

    <tr id="footer"> 
    	<td colspan="4"> 
				<div align="center"> 
				<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="����">
					&nbsp; 				
				</div>
			</td>
   	</tr>
	</TABLE>  
	  <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

