<%
	/* 
	 * version v2.0
	 * ������: si-tech
	 * zhouby 20121212
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<%	
	  response.setHeader("Pragma","No-Cache"); 
	  response.setHeader("Cache-Control","No-Cache");
	  response.setDateHeader("Expires", 0);
		request.setCharacterEncoding("GBK");
		
		String opCode = (String)request.getParameter("opCode");
		String opName = (String)request.getParameter("opName");
		
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode = (String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
    
    String ipowerRight = (String)request.getParameter("ipowerRight");
    String ipowerChg = (String)request.getParameter("ipowerChg");
    String irptRight = (String)request.getParameter("irptRight");
    String irptChg = (String)request.getParameter("irptChg");
    String iallowBegin = (String)request.getParameter("iallowBegin");
    String iallowbChg = (String)request.getParameter("iallowbChg");
    String iallowEnd = (String)request.getParameter("iallowEnd");
    String iallowEChg = (String)request.getParameter("iallowEChg");
    String oaNumber = request.getParameter("oaNumber");//OA���
	String oaTitle = request.getParameter("oaTitle");  //OA����
	System.out.println("liangyl===oaNumber========================"+oaNumber);
	System.out.println("liangyl===oaTitle========================"+oaTitle);

/*
		System.out.println("zhouby: ipowerRight " + ipowerRight);
		System.out.println("zhouby: ipowerChg " + ipowerChg);
		System.out.println("zhouby: irptRight " + irptRight);
		System.out.println("zhouby: irptChg " + irptChg);
		System.out.println("zhouby: iallowBegin " + iallowBegin);
		System.out.println("zhouby: iallowbChg " + iallowbChg);
		System.out.println("zhouby: iallowEnd " + iallowEnd);
		System.out.println("zhouby: iallowEChg " + iallowEChg);
		System.out.println("zhouby: opCode " + opCode);
		System.out.println("zhouby: opName " + opName);
*/
		String execResult = "�ϴ����δ֪��";
%>
		<script language="javascript">
				function goback(){
						window.location = 'fg443Main.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>';
				}
		</script>
		
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept"/>
<%
		/* ƴ���ļ��� */
    String filename = regionCode + sysAccept + ".txt";
    String sSaveName = request.getRealPath("/npage/tmp/") + "/" + filename;
		
		/* ׼���ϴ���webloigc������� */
		SmartUpload mySmartUpload =new SmartUpload();
		mySmartUpload.initialize(pageContext);
		
		boolean flag = false;
		try {
				mySmartUpload.setAllowedFilesList("txt,TXT");//�����ϴ�������
				mySmartUpload.upload();
				flag = true;
		} catch (Exception e){
%>
				<SCRIPT language=javascript>
						rdShowMessageDialog("ֻ�����ϴ�.txt�����ı��ļ���", 0);
						goback();
				</script>
<%
		}
		
		if (flag){
				try{ 
						com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
						if (myFile.isMissing()){
%>
								<SCRIPT language=javascript>
										rdShowMessageDialog("�ļ���ʧ���ϴ����ɹ���", 0);
										goback();
								</script>
<%
						}else{
								myFile.saveAs(sSaveName, SmartUpload.SAVE_PHYSICAL);
						}
				}catch (Exception e){
%>
						<SCRIPT language=javascript>
								rdShowMessageDialog("<%=e.toString()%>", 0);
								goback();
						</script>
<%
				}
				
				System.out.println("==============�ļ��ϴ����==========");
				/* ��ȡ�ļ���д��tuxedo������� */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String line = br.readLine();
				while(line != null && !line.trim().equals("")){
						String tmp = line + "\n";
%>
						<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode2" retmsg="errMsg2"  outnum="2" >
								<wtc:param value="<%=filename%>"/>
								<wtc:param value="<%=tmp%>"/>
						</wtc:service>
<%
						line = br.readLine();
				}
				br.close();
				fr.close();
		}
		/*
		iLoginAccept		��ˮ		����ʱĬ�ϴ�0
		iChnSource			������		01-boss	02-����	03-����Ӫҵ��	04-����Ӫҵ��	05-��ѯ��	06-10086
		iOpCode				��������	����ʱĬ�ϴ���
		iloginNo            ��������--	����
		iloginPwd           Ա������--	����	
		iPhoneNo			����		����ʱĬ�ϴ���
		iUserPwd			��������	����ʱĬ�ϴ���
		iIpAddr
		ipowerRight		Ȩ��ֵ
		ipowerChg			�Ƿ��޸�				0 - ���޸� 1-�޸�
		irptRight			����Ȩ��
		irptChg				�Ƿ��޸�				0 - ���޸� 1-�޸�
		iallowBegin		��½����ʱ��
		iallowbChg		�Ƿ��޸�				0 - ���޸� 1-�޸�
		iallowEnd			�������ʱ��
		iallowEChg		�Ƿ��޸�				0 - ���޸� 1-�޸�
		iFileName			�ļ���
		*/
%>
		<wtc:service name="sG443Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="6" >
	      <wtc:param value="<%=sysAccept%>"/>
	      <wtc:param value="01"/>
	      <wtc:param value="<%=opCode%>"/>
	      <wtc:param value="<%=loginNo%>"/>
	      <wtc:param value="<%=passWord%>"/>
	      <wtc:param value=""/>
	      <wtc:param value=""/>
	      <wtc:param value="<%=ip%>"/>
	      <wtc:param value="<%=ipowerRight%>"/>
	      <wtc:param value="<%=ipowerChg%>"/>
	      <wtc:param value="<%=irptRight%>"/>
	      <wtc:param value="<%=irptChg%>"/>
	      <wtc:param value="<%=iallowBegin%>"/>
	      <wtc:param value="<%=iallowbChg%>"/>
	      <wtc:param value="<%=iallowEnd%>"/>
	      <wtc:param value="<%=iallowEChg%>"/>
	      <wtc:param value="<%=filename%>"/>
	      <wtc:param value="<%=oaNumber%>" />
	      <wtc:param value="<%=oaTitle%>" />
		</wtc:service>
		<wtc:array id="result1" start="0" length="1" scope="end"/>
		<wtc:array id="result2" start="1" length="3" scope="end"/>
<%

if("000000".equals(Code)){
		execResult = result1[0][0];
%>
		</head>
		<body>
		<form name="form1" id="form1" method="POST">
		<%@ include file="/npage/include/header.jsp" %>
			<div>
			<div class="title">
				<div id="title_zi">������</div>
			</div>
			
			<table cellspacing="0">
				<tr>
					<td width="100%"><%=execResult%></td>
				</tr>
			</table>
			
			<div class="title">
				<div id="title_zi">������ʾ</div>
			</div>
			
			<table cellspacing="0">
				<tr>
					<th>�к�</th>
					<th>����</th>
					<th>����ԭ��</th>
				</tr>
<%
		  	int retLength = result2.length;
		  	for(int i = 0; i < retLength; i++ ){
%>
					  <tr>
							<td><%=result2[i][0]%></td>
							<td><%=result2[i][1]%></td>
							<td><%=result2[i][2]%></td>
						</tr>
<%
		  	}
%>
			  <tr>
			  	<td id="footer" colspan="3">
			  		<input type="button" name="back" class="b_foot" value="����" onClick="goback()"  >
			  	</td>
			  </tr>
		  </table>
			</div>
		  <%@ include file="/npage/include/footer.jsp"%>
		</form>
		</body>
<%
} else {
%>
		<script language="javascript">
				rdShowMessageDialog("sG443Cfm�������ʧ�ܣ�<%=Code%>, <%=Msg%>");
				goback();
		</script>
<%
}
%>
</html>