<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-09-04 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
		String opCode = WtcUtil.repNull(request.getParameter("pageOpCode"));	
		String opName = WtcUtil.repNull(request.getParameter("pageOpName"));	
			
		int error_code = 0;
		String error_msg = "";
		SmartUpload mySmartUpload = new SmartUpload();
		String opType = WtcUtil.repNull(request.getParameter("opType"));
		String sSaveName="";
		String server_ip_Addr=realip;//0.100��������ip�����淽���õ�����0.100����ʵip
		
		String iErrorNo ="";
		String sErrorMessage = " ";
		String flag="0";                //�����ļ���ʽ��־
		String flag1="0";               //���ƺ����ʽ��־
		String alertPhone="";           


	if (opType.equals("file")){
		String filename = "ADC"+new java.text.SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
		System.out.println("##############s2897_2.jsp->sSaveName->"+sSaveName);
	}
	
	try{
	    mySmartUpload.initialize(pageContext);
	    mySmartUpload.upload();
			System.out.println("��ʼ�����!!");
	   }catch(Exception ex){
			System.out.println("�쳣�׳�!!");
			ex.printStackTrace();
			iErrorNo = "11111";
			sErrorMessage = "�����ļ������г���1��";
%>
		<script language='jscript'>
			rdShowMessageDialog('�����ļ������г���',0);
			location = "s2897.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
		</script>
<%
	}
	
	try 
	{
		System.out.println("��ʼ�����222222!!");
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0); 
			if (!myFile.isMissing())
			{
				myFile.saveAs(sSaveName);        
			}
		}catch(Exception ex){
			iErrorNo = "22222";
			sErrorMessage = "�����ļ��洢ʱ����1��";
%>
			<script language='jscript'>
				rdShowMessageDialog('�����ļ��洢ʱ����',0);
				location = "s2897.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
			</script>
		<%
	}
	
	
	try 
	{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0); 
		if (!myFile.isMissing())
		{
			myFile.saveAs(sSaveName);    
			
			//wuxy add for �ϴ�excel��ʽ�ļ�����
			
			try{
				FileInputStream fis = new FileInputStream(sSaveName);    
				DataInputStream dis = new DataInputStream(fis); 
				byte b;
				int data;
				int count=0;
				for(count=0; (count < 2 && count < dis.available()); count++)
				{
					b=dis.readByte();
					data = b - '0';
					if( data > 0 && data < 9)
					{
						System.out.println(" b = ["+b+ "]");
					}
					else
					{
						flag="1";
						throw new Exception("�ļ���ʽ����ȷ");
						
					}
				}
				dis.close(); 
				fis.close(); 
			}catch(IOException e)
			{
				flag="1";
				System.out.println("�ļ�������");
				
			}catch(Exception e)
			{
				System.out.println("�ļ���ʽ����ȷ!");
				
			}
			
			System.out.println("flag -----------------"+flag);
		}
	}	
	catch(Exception ex)	
	{
		iErrorNo = "22222";
		sErrorMessage = "�����ļ��洢ʱ����1��";
		%>
		<script language='jscript'>
			rdShowMessageDialog('�����ļ��洢ʱ����',0);
			location = "s2897.jsp";
		</script>
		<%
	}
	
	if(flag.equals("1"))
    {
%>    
		<script language='jscript'>
			rdShowMessageDialog('�����ļ���ʽ����ȷ,����Ϊ�ı��ļ���',0);
			location = "s2897.jsp";
		</script>
<%
    }
    else
    {
	
	
	

		String[] retStr = null;
	  String loginAccept     = mySmartUpload.getRequest().getParameter("loginAccept");														 
	  opCode = mySmartUpload.getRequest().getParameter("opCode");
	  String loginNo= mySmartUpload.getRequest().getParameter("loginNo");
	  String loginPwd = mySmartUpload.getRequest().getParameter("loginPwd");
	  String orgCode= mySmartUpload.getRequest().getParameter("orgCode");
	  String sysNote= mySmartUpload.getRequest().getParameter("sysNote");
	  String opNote = mySmartUpload.getRequest().getParameter("opNote");
	  String ipAddress = mySmartUpload.getRequest().getParameter("ipAddress");
	  String phoneNo= mySmartUpload.getRequest().getParameter("phoneNo");
	  String grpIdNo= mySmartUpload.getRequest().getParameter("grpIdNo");								   
	  String grpOutNo = mySmartUpload.getRequest().getParameter("grpOutNo");
	  String expect_time     = mySmartUpload.getRequest().getParameter("expect_time");
	    
	

	  System.out.println("before -------------phoneNo="+phoneNo);
		String phoneNo1 = phoneNo.replaceAll("\r\n","");
		String phoneNo2 = phoneNo1.replaceAll("\r","");
		phoneNo = phoneNo2.replaceAll("\n","");
		
		System.out.println("----------phoneNo="+phoneNo);
		
    //wuxy alter 20081030 Ϊ����绰�������������Χ����Խ�磬������л�ѹ����
	String [] array=phoneNo.split("\\|");
	
	for(int i=0;i<array.length;i++)
	{
		System.out.println("array["+i+"]="+array[i]);
		if(array[i].length()!=11)
		{
		  System.out.println("i="+i);
		  alertPhone=array[i];
		  flag1="1";
      break;
		}
		
	}
	
	if(flag1.equals("1"))
	{
%>
		<script language='jscript'>
			rdShowMessageDialog('<%=alertPhone%>�����ʽ����ȷ������!',0);
			location = "s2897.jsp";
		  </script>
<%	
	}
  else
  {
	
	if(array.length>50)
	{
%>
      <script language='jscript'>
			rdShowMessageDialog('һ��������50������',0);
			location = "s2897.jsp";
		</script>
<%	
	}
    else
    {
		
		String falseNo	="";
		String falseReason="";
		StringTokenizer strToken1=null;
		StringTokenizer strToken2=null;
		
		String regionCode = orgCode.substring(0,2);
			
		String[] paramsIn = null;
		paramsIn = new String[15];

	    paramsIn[0]=loginAccept   ;//0
	    paramsIn[1]=opCode        ;
	    paramsIn[2]=loginNo       ;
	    paramsIn[3]=loginPwd     	;
	    paramsIn[4]=orgCode       ;
	    paramsIn[5]=sysNote       ;
	    paramsIn[6]=opNote        ;
	    paramsIn[7]=ipAddress     ;
	    paramsIn[8]=phoneNo       ;
	    paramsIn[9]=grpIdNo       ;
	    paramsIn[10]=grpOutNo      ;//10
	    paramsIn[11]=expect_time   ;
	    paramsIn[12]=opType        ;
	    paramsIn[13]=sSaveName     ;
	    paramsIn[14]=server_ip_Addr;//14

			//callData = callView.callFXService("s2897Cfm", paramsIn, "3", "region", regionCode);
%>
			<wtc:service name="s2897Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="3" >
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
			</wtc:service>
			<wtc:array id="callDataArr" scope="end"/>
<%			

			String failedPhones = "";
			String failedReasons = "";
			if(callDataArr!=null&&callDataArr.length>0){
				failedPhones = callDataArr[0][1];
				failedReasons = callDataArr[0][2];
			}
			
			System.out.println("###################################failedPhones="+failedPhones);
			System.out.println("###################################failedReasons="+failedReasons);
			
			/**��������,��������ʱ��
			error_code=0;
			retStr = new String[3];
			retStr[0]="123456";
			retStr[1]="123|234|";
			retStr[2]="321|432|";
			**/
			
      error_code = retCode1==""?999999:Integer.parseInt(retCode1);
      error_msg= retMsg1;
      System.out.println("error_code="+error_code);
      
      if(error_code!=0)
      {
	%>
				<SCRIPT type=text/javascript>
					rdShowMessageDialog("�������:"+"<%=error_code%></br>"+"������Ϣ:"+"<%=error_msg%>");
					history.go(-1);
				</SCRIPT>
	<%
				return;
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
      	    	<input class="b_foot" name=back onClick="removeCurrentTab();" type=button value=�ر�>
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
	}
	}
%>

