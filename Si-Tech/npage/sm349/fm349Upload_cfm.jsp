<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
 		String regionCode = (String)session.getAttribute("regCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");

 		
 		/*��ˮ*/
		String printAccept = (String)request.getParameter("printAccept");
		/*ҵ�����*/
		String opCode = (String)request.getParameter("opCode");
		/*ҵ������*/
		String opName = (String)request.getParameter("opName");
		
		/*�ͻ����*/
		String ownerType = (String)request.getParameter("ownerType");
		
		/*���˿�������*/
		String isJSX = (String)request.getParameter("isJSX");
		/*�ͻ���������*/
		String districtCode = (String)request.getParameter("districtCode");
		
		/*�ͻ�����*/
		String custName = (String)request.getParameter("custName");
		
		/*֤������*/
		String idType = (String)request.getParameter("idType").split("\\|")[0];
		
		/*֤������*/
		String idIccid = (String)request.getParameter("idIccid");
		
		/*֤����ַ*/
		String idAddr = (String)request.getParameter("idAddr");
		/*֤����Ч��*/
		String idValidDate = (String)request.getParameter("idValidDate");
		/*�ͻ���ַ*/
		String custAddr = (String)request.getParameter("custAddr");
		/*��ϵ������*/
		String contactPerson = (String)request.getParameter("contactPerson");
		/*��ϵ�˵绰*/
		String contactPhone = (String)request.getParameter("contactPhone");
		/*��ϵ�˵�ַ*/
		String contactAddr = (String)request.getParameter("contactAddr");
		/*��ϵ���ʱ�*/
		String contactPost = (String)request.getParameter("contactPost");
		/*��ϵ�˴���*/
		String contactFax = (String)request.getParameter("contactFax");
		/*��ϵ��E_MAIL*/
		String contactMail = (String)request.getParameter("contactMail");
		/*��ϵ��ͨѶ��ַ*/
		String contactMAddr = (String)request.getParameter("contactMAddr");
		
		/*����������*/
		String gestoresName = (String)request.getParameter("gestoresName");
		/*��������ϵ��ַ*/
		String gestoresAddr = (String)request.getParameter("gestoresAddr");
		/*������֤������*/
		String gestoresIdType = (String)request.getParameter("gestoresIdType").split("\\|")[0];
		/*������֤������*/
		String gestoresIccId = (String)request.getParameter("gestoresIccId");
		/*��ѡ���ʷ�*/
		String selOrder = (String)request.getParameter("selOrder");
		/*�û���ע*/
		String sysNote = (String)request.getParameter("sysNote");
		
		
		/*����������*/
		String responsibleName = (String)request.getParameter("responsibleName");

		/*��������ϵ��ַ*/
		String responsibleAddr = (String)request.getParameter("responsibleAddr");

		/*������֤������*/
		String responsibleType = (String)request.getParameter("responsibleType").split("\\|")[0];

		/*������֤������*/
		String responsibleIccId = (String)request.getParameter("responsibleIccId");		
		
		/*С������*/
		String xqdm = (String)request.getParameter("s_60001");
		if(xqdm == null || "".equals(xqdm)){
			xqdm = "";
		}
		/*���Ӳ�Ʒ����Ϣ*/
		String endStr = (String)request.getParameter("endStr");
		
				

		String iServerIpAddr = realip.trim();
 
    String fileName = opCode + "_" + printAccept + ".txt" ;
  	String path = ""; 
try
{
	SmartUpload mySmartUpload = new SmartUpload();
	mySmartUpload.initialize(pageContext);
	mySmartUpload.setMaxFileSize(2*1024*1024); 
	
	mySmartUpload.upload();
	com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
	path = (String)request.getRealPath("/npage/tmp/");
	System.out.println("gaopeng=============="+path);
	String sSaveName = path+"/"+fileName;
	System.out.println("gaopeng=============="+sSaveName);
	java.io.File fileNew = new java.io.File(path);  
	if(!fileNew.exists())  
	{
		fileNew.mkdirs();
	}
	String flag="";
	String book_name="";
	String iInputFile = "";
	if(myfiles.getCount()>0)
	{
		for(int i=0;i<myfiles.getCount();i++)
		{
			com.jspsmart.upload.File myFile = myfiles.getFile(i);  
			if(myFile.isMissing())
			{
				continue;
			}
			String fieldName = myFile.getFieldName();
			int fileSize = myFile.getSize();
			book_name=myFile.getFileName();
			
			iInputFile = sSaveName;
			myFile.saveAs(iInputFile);
				
			try
			{
				FileInputStream fis = new FileInputStream(iInputFile);    
				DataInputStream dis = new DataInputStream(fis); 
				byte b;
				int data;
				int count=0;
				for(count=0; (count < 2 && count < dis.available()); count++)
				{
					b=dis.readByte();
		
					data = b - '0';
		
					if( !( data >= 0 && data <= 9 ) )
					{
					 	flag = "error";
						throw new Exception("�ļ���ʽ����ȷ");
					}
				}
				dis.close(); 
				fis.close(); 
    		}
    		catch(IOException e)
    		{
			    e.printStackTrace();
			    flag = "error";
				System.out.println("�ļ�������");
				%>
				<script>
					rdShowMessageDialog( "�ļ�������" , 0 );
					removeCurrentTab();
				</script>
    			<%
    		}
    		catch(Exception e)
			{
				e.printStackTrace();
				flag = "error";
				%>	
				<script>
					rdShowMessageDialog( "�ļ���ʽ����ȷ,������txt�ı��ļ���" , 0 );
					removeCurrentTab();
				</script>								
				<%
    		}
		}
	}
	}catch(Exception e){
				e.printStackTrace();	
	}

		
  String input_parms[] = new String[32];
  
				input_parms[0] = printAccept;				/*��ˮ*/
				input_parms[1] = "01";				/*������ʶ*/
				input_parms[2] = opCode;			/*��������*/
				input_parms[3] = loginNo;				/*����*/
				input_parms[4] = noPass;				/*��������*/
				input_parms[5] = fileName;
				input_parms[6] = iServerIpAddr;
				input_parms[7] = path;
				input_parms[8] = districtCode	;			/*�ͻ���������*/
				input_parms[9] = custName;			/*�ͻ�����*/
				input_parms[10] = idType;				/*֤������*/
				input_parms[11] = idIccid;				/*֤������*/
				input_parms[12]	= idAddr;			/*֤����ַ*/
				input_parms[13]	= idValidDate;			/*֤����Ч��*/
				input_parms[14]	= contactPerson;			/*��ϵ������*/
				input_parms[15]	= contactAddr;			/*��ϵ�˵�ַ*/
				input_parms[16]	= contactPhone;			/*��ϵ�˵绰*/
				input_parms[17]	= contactFax;			/*��ϵ�˴���*/
				input_parms[18]	= contactPost;			/*��ϵ���ʱ�*/
				input_parms[19]	= contactMail;			/*��ϵ������*/
				input_parms[20]	= gestoresName;			/*����������*/
				input_parms[21]	= gestoresAddr;			/*��������ϵ��ַ*/
				input_parms[22]	= gestoresIdType;			/*������֤������*/
				input_parms[23]	= gestoresIccId;			/*������֤������*/
				input_parms[24]	= selOrder;			/*���ʷѴ���*/
				input_parms[25]	= "0";			/*sim����*/
				input_parms[26]	= "";	
				input_parms[27]	= responsibleType;			/*������֤������*/
				input_parms[28]	= responsibleIccId;			/*������֤������*/
				input_parms[29]	= responsibleName;			/*����������*/
				input_parms[30]	= responsibleAddr;			/*��������ϵ��ַ*/
				input_parms[31]	= xqdm;			/*С������*/
				  
              
 
%>
	<wtc:service name="sm349Cfm" routerKey="regionCode" routerValue="<%=regionCode%>"
		 retcode="errCode" retmsg="errMsg"  outnum="3">

<%
	for (int i=0;i<input_parms.length;i++){
		System.out.println("--------sm349Cfm------input_parms["+i+"]---------------->"+input_parms[i]);
%>
		<wtc:param value="<%=input_parms[i]%>" />
<%	
	}
%>
	</wtc:service>
	<wtc:array id="result_sm349Cfm" start="0"   scope="end" />
<%

	System.out.println("------hejwa-------------result_sm349Cfm.length-----------------"+result_sm349Cfm.length);


	if(errCode.equals("0")||errCode.equals("000000")){
		System.out.println("���÷��� sBatchCustCfm in fm349BatCfm.jsp �ɹ�@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" ʧ��@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>");
		history.go(-1);
	</script>
<%
	}		
%>	
<html>
<head>
	<title><%=opName%></title>
</head>
<body>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">������Ϣ�б�</div>
	</div>
	<div>
		<table>
			<tr>
				<th>�к�</th>
				<th>�ֻ�����</th>
				<th>ʧ��ԭ��</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result_sm349Cfm.length;i++){
				%>
				<tr>
					<td><%=(i+1)%></td>
					<td><%=result_sm349Cfm[i][0]%></td>
					<td><%=result_sm349Cfm[i][1]%></td>
				</tr>
				<%}}%>
			 <tr> 
					<td align="center" colspan="3" id="footer">
						<input class="b_foot" name="sure"  type="button" value="����"  onclick="window.location.href='/npage/sm349/fm349Main.jsp?opCode=m349&opName=������ͨ����';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

