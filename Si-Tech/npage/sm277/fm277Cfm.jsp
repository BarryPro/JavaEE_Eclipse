<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/*
* ����: 
* �汾: 1.0
* ����: liangyl 2017/01/04 ���������������Ż�������
* ����: liangyl
* ��Ȩ: si-tech
*/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/common/serverip.jsp" %>
<%
	String opCode="m277";
	String opName="�������û��ָ����ݷ���(����)";
	String loginNo = (String)session.getAttribute("workNo");
	String regionCode=(String)session.getAttribute("regCode");
	String passWord = (String)session.getAttribute("password");
	String ipAddr = realip; 
	System.out.println("=========================ipAddr==================   "+ipAddr);
	String opNote = "";
	
	String workNos = "";
	String[] workNosArr = new String[]{""};
	String wayFlag = "";
	String filename = "";
	String execResult = "0";
	int count_row = 0;
	
	String divshowmsg="";
	String servicesname="";
	String sopcodes="";
	
	String phoneIn="";
	String operType="";
	String busiType="";

			/* ʹ���ļ��ϴ� */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
			/* ƴ���ļ��� */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;
			    System.out.println("# fm277Cfm.jsp  @@@@@@@@@@     - ��ˮ��"+sysAccept);
			    filename = regionCode + sysAccept + ".txt";
			    
			    String path_name = request.getRealPath("/npage/tmp/");
			    
			    String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
				System.out.println("sSaveName:"+sSaveName);
				/* ׼���ϴ���webloigc������� */
				SmartUpload mySmartUpload =new SmartUpload();
				mySmartUpload.initialize(pageContext);
				try {
					mySmartUpload.setAllowedFilesList("txt");//�˴����ļ���ʽ���Ը�����Ҫ�Լ��޸�
					//�����ļ� 
					mySmartUpload.upload();
				} catch (Exception e){
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
%>
					<SCRIPT language=javascript>
					alert("ֻ�����ϴ�.txt�����ı��ļ�");
					window.location="fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					
					phoneIn=mySmartUpload.getRequest().getParameter("phoneIn").trim();;
					operType=mySmartUpload.getRequest().getParameter("operType").trim();
					busiType=mySmartUpload.getRequest().getParameter("busiType").trim();
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					alert("����ѡ��Ҫ�ϴ����ļ�");
					window.location="fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					alert("<%=e.toString()%>");
					window.location="fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
					</script>
<%
				}
				System.out.println("==============�ļ��ϴ����==========");
				/* ��ȡ�ļ���д��tuxedo������� */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String phoneText="";
				String line = null;
				String paraAray2[] = new String[2];
				paraAray2[0] = filename;
				paraAray2[1] = phoneText;
				do {
					line = br.readLine();
					if (line==null) continue;       
					if (line.trim().equals("")) continue;   
					count_row ++ ;
					phoneText+=line+"\n"; 
					System.out.println("==phoneText== " + phoneText);
					if (phoneText.length()>=1000){
						paraAray2[1] = phoneText;
%>
						<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>"  retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
						</wtc:service>
						<wtc:array id="resultArr" scope="end" />
<%
						phoneText="";
					}
				}while (line!=null);        
				br.close();
				fr.close();
				paraAray2[1] = phoneText;
%>
				<wtc:service name="sbatchWrite" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr3" scope="end" />
<%
System.out.println("====wanghfa====fm277_1.jsp====fm277_1==== filename = " + filename);

System.out.println("====wanghfa====fm277_1.jsp====fm277_1==== count_row= " + count_row);

if(count_row>500){
%>
	<script language="JavaScript">
		rdShowMessageDialog("���ݼ�¼���ܳ���500�����������ϴ���");
		window.location.href = "fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
	</script>
<%
}else{
%>
	<wtc:service name="m277Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg"  outnum="3" >
		<wtc:param value="<%=sysAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=operType%>"/>
		<wtc:param value="<%=loginNo%>"/>
		<wtc:param value="<%=passWord%>"/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value=""/>
		<wtc:param value="<%=filename%>"/>
		<wtc:param value="<%=ipAddr%>"/>
		<wtc:param value="<%=path_name%>"/>
		<wtc:param value="<%=busiType%>"/>
	</wtc:service>
	<wtc:array id="result1" start="0" length="2" scope="end" />
	<wtc:array id="result2" start="2" length="1" scope="end" />
<%
System.out.println("=========================errCode================================   "+errCode);

if(errCode.equals("000000")){

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
	}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi"><%=divshowmsg%>-�������</div>
	</div>
			<table>

			<tr>
				<td WIDTH = '20%' ALIGN = 'center' class = 'blue'>������ˮ</td>
				<td><%=sysAccept%>&nbsp;&nbsp<font class="orange">����ˮ�����ڽ����ѯ  ��ѯʹ��</font></td>
			</tr>

		</table>
		<table>
			<%if(errCode.equals("000000")){
				if(result2.length > 0){
				%>
			<tr>
				<td colspan="2">����ɹ��ĺ��������<%=result2[0][0]%></td>
			</tr>
			<%}}%>
			<tr>
				<th>�ֻ�����</th>
				<th>ʧ��ԭ��</th>
			</tr>
			
				<%if(errCode.equals("0")||errCode.equals("000000")){
					for(int i=0;i<result1.length;i++){
				%>
				<tr>
					<td><%=result1[i][0]%></td>
					<td><%=result1[i][1]%></td>
				</tr>
				<%}}%>

		</table>
	<table cellspacing="0">
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
		rdShowMessageDialog("����ʧ�ܣ��������<%=errCode%>,����ԭ��<%=errMsg%>.");
		window.location.href = "fm277_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&crmActiveOpCode=<%=opCode%>&activePhone=<%=phoneIn%>&broadPhone=";
	</script>
	<%
}
}
%>