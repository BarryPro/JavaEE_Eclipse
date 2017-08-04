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

 		
 		/*流水*/
		String printAccept = (String)request.getParameter("printAccept");
		/*业务代码*/
		String opCode = (String)request.getParameter("opCode");
		/*业务名称*/
		String opName = (String)request.getParameter("opName");
		
		/*客户类别*/
		String ownerType = (String)request.getParameter("ownerType");
		
		/*个人开户分类*/
		String isJSX = (String)request.getParameter("isJSX");
		/*客户归属市县*/
		String districtCode = (String)request.getParameter("districtCode");
		
		/*客户名称*/
		String custName = (String)request.getParameter("custName");
		
		/*证件类型*/
		String idType = (String)request.getParameter("idType").split("\\|")[0];
		
		/*证件号码*/
		String idIccid = (String)request.getParameter("idIccid");
		
		/*证件地址*/
		String idAddr = (String)request.getParameter("idAddr");
		/*证件有效期*/
		String idValidDate = (String)request.getParameter("idValidDate");
		/*客户地址*/
		String custAddr = (String)request.getParameter("custAddr");
		/*联系人姓名*/
		String contactPerson = (String)request.getParameter("contactPerson");
		/*联系人电话*/
		String contactPhone = (String)request.getParameter("contactPhone");
		/*联系人地址*/
		String contactAddr = (String)request.getParameter("contactAddr");
		/*联系人邮编*/
		String contactPost = (String)request.getParameter("contactPost");
		/*联系人传真*/
		String contactFax = (String)request.getParameter("contactFax");
		/*联系人E_MAIL*/
		String contactMail = (String)request.getParameter("contactMail");
		/*联系人通讯地址*/
		String contactMAddr = (String)request.getParameter("contactMAddr");
		
		/*经办人姓名*/
		String gestoresName = (String)request.getParameter("gestoresName");
		/*经办人联系地址*/
		String gestoresAddr = (String)request.getParameter("gestoresAddr");
		/*经办人证件类型*/
		String gestoresIdType = (String)request.getParameter("gestoresIdType").split("\\|")[0];
		/*经办人证件号码*/
		String gestoresIccId = (String)request.getParameter("gestoresIccId");
		/*可选主资费*/
		String selOrder = (String)request.getParameter("selOrder");
		/*用户备注*/
		String sysNote = (String)request.getParameter("sysNote");
		
		
		/*责任人姓名*/
		String responsibleName = (String)request.getParameter("responsibleName");

		/*责任人联系地址*/
		String responsibleAddr = (String)request.getParameter("responsibleAddr");

		/*责任人证件类型*/
		String responsibleType = (String)request.getParameter("responsibleType").split("\\|")[0];

		/*责任人证件号码*/
		String responsibleIccId = (String)request.getParameter("responsibleIccId");		
		
		/*小区代码*/
		String xqdm = (String)request.getParameter("s_60001");
		if(xqdm == null || "".equals(xqdm)){
			xqdm = "";
		}
		/*附加产品串信息*/
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
						throw new Exception("文件格式不正确");
					}
				}
				dis.close(); 
				fis.close(); 
    		}
    		catch(IOException e)
    		{
			    e.printStackTrace();
			    flag = "error";
				System.out.println("文件不存在");
				%>
				<script>
					rdShowMessageDialog( "文件不存在" , 0 );
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
					rdShowMessageDialog( "文件格式不正确,必须是txt文本文件！" , 0 );
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
  
				input_parms[0] = printAccept;				/*流水*/
				input_parms[1] = "01";				/*渠道标识*/
				input_parms[2] = opCode;			/*操作代码*/
				input_parms[3] = loginNo;				/*工号*/
				input_parms[4] = noPass;				/*工号密码*/
				input_parms[5] = fileName;
				input_parms[6] = iServerIpAddr;
				input_parms[7] = path;
				input_parms[8] = districtCode	;			/*客户归属市县*/
				input_parms[9] = custName;			/*客户名称*/
				input_parms[10] = idType;				/*证件类型*/
				input_parms[11] = idIccid;				/*证件号码*/
				input_parms[12]	= idAddr;			/*证件地址*/
				input_parms[13]	= idValidDate;			/*证件有效期*/
				input_parms[14]	= contactPerson;			/*联系人姓名*/
				input_parms[15]	= contactAddr;			/*联系人地址*/
				input_parms[16]	= contactPhone;			/*联系人电话*/
				input_parms[17]	= contactFax;			/*联系人传真*/
				input_parms[18]	= contactPost;			/*联系人邮编*/
				input_parms[19]	= contactMail;			/*联系人邮箱*/
				input_parms[20]	= gestoresName;			/*经办人姓名*/
				input_parms[21]	= gestoresAddr;			/*经办人联系地址*/
				input_parms[22]	= gestoresIdType;			/*经办人证件类型*/
				input_parms[23]	= gestoresIccId;			/*经办人证件号码*/
				input_parms[24]	= selOrder;			/*主资费代码*/
				input_parms[25]	= "0";			/*sim卡费*/
				input_parms[26]	= "";	
				input_parms[27]	= responsibleType;			/*责任人证件类型*/
				input_parms[28]	= responsibleIccId;			/*责任人证件号码*/
				input_parms[29]	= responsibleName;			/*责任人姓名*/
				input_parms[30]	= responsibleAddr;			/*责任人联系地址*/
				input_parms[31]	= xqdm;			/*小区代码*/
				  
              
 
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
		System.out.println("调用服务 sBatchCustCfm in fm349BatCfm.jsp 成功@@@@@@@@@@@@@@@@@@@@@@@@@@");
		
		
%>
	<script language="JavaScript">
		
	</script>
<%
	}else{
		System.out.println(" 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");
%>
	<script language="JavaScript">
		rdShowMessageDialog("错误代码：<%=errCode%>，错误信息：<%=errMsg%>");
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
		<div id="title_zi">错误信息列表</div>
	</div>
	<div>
		<table>
			<tr>
				<th>行号</th>
				<th>手机号码</th>
				<th>失败原因</th>
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
						<input class="b_foot" name="sure"  type="button" value="返回"  onclick="window.location.href='/npage/sm349/fm349Main.jsp?opCode=m349&opName=批量普通开户';">
						<input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=关闭>
					</td>
			 </tr>
		</table>
	</div>
	<%@ include file="/npage/include/footer.jsp" %>
</body>
</html>

