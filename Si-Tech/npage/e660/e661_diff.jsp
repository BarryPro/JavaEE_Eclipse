<%
  /*
   * ����: ʵ���ļ��ϴ������ diff ������
   * �汾: 1.0
   * ����: 
   * ����: 
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.jspsmart.upload.*"%>


<jsp:useBean  id="wlUpload"  scope="page"  class="com.jspsmart.upload.SmartUpload"  />  


<%
	String opCode = "e661";
	String opName = "�ֹ�ϵͳ��ֵ���";
	String sRetMsg = "�����ϴ��ļ���һ�£�";
	String document_name	= request.getParameter("document_name") ;
	String document_no		= request.getParameter("document_no");
	String DOCUMENT_ACCEPT= request.getParameter("document_accept");

	String strFileName = document_name+"-"+document_no ;
	String strFileNameDiff = document_name+"-"+document_no+".diff" ;
	String strSaveFilePath =request.getRealPath("/npage/tmp")+"/";
	String strShellPath =request.getRealPath("/npage/e660/shell")+"/";
  String sCmdStr = "sh "+strShellPath+"mydiff.sh "+strSaveFilePath+strFileName;
	SmartUpload mySmartUpload = new SmartUpload(); 
	String	iErrorNo="";
	String	sErrorMessage="";
	String	NoteStr="";
	
	
	try
	{
		mySmartUpload.initialize(pageContext);
		mySmartUpload.upload();
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ������г���");
		iErrorNo = "139045";
		sErrorMessage = "�����ļ������г���";
	}
	try 
	{
		com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
		if (!myFile.isMissing())
		{
			myFile.saveAs(strSaveFilePath+strFileNameDiff);
    }
	}
	catch(Exception ex) 
	{
		//System.out.println("�����ļ��洢ʱ����");
		iErrorNo = "139046";
		sErrorMessage = "�����ļ��洢ʱ����";
	}
	
	if( false == iErrorNo.equals("000000"))
	{
%>
	<SCRIPT type=text/javascript>
		rdShowMessageDialog("�ļ�׼��ʧ�ܡ�<br>������룺'<%=iErrorNo%>'��<br>������Ϣ��'<%=sErrorMessage%>'��",0);
		history.go(-1);
	</SCRIPT>
<%
	}
	//����shell
	try {

System.out.println("++++++ zhaorh ==========>"+sCmdStr);		
		Process p = Runtime.getRuntime().exec(sCmdStr);
		InputStreamReader ir = new InputStreamReader(p.getInputStream());
		LineNumberReader input = new LineNumberReader(ir);

		NoteStr = input.readLine();

	} catch (IOException e) {
%>

			<SCRIPT type=text/javascript>
				rdShowMessageDialog("ִ�к˶Խű�����!!",0);
				history.go(-1);
			</SCRIPT>
<%
	} 
%> 


<%@ include file="/npage/include/public_title_name.jsp" %>
<title>�ֹ�ϵͳ��ֵ��ѯ</title>
</head>
<BODY onload=""> 

<script language="JavaScript">
function do_submit( busi_flag , document_accept )
{

	document.frm.action="e662_3.jsp?document_accept="+document_accept+"&busi_flag="+busi_flag ;

	document.frm.submit();	
}
</script>

<form action="e660_3.jsp" method="post" name="frm">
		 
  
  	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">�ļ��˶���Ϣ</div>
		</div>

  <table cellspacing="0">
    <tbody> 

     <tr> 
        <td class="blue" width="15%">���ϴ��ļ��˶���Ϣ��</td>
        <td width="35%"> 
 					<input readonly class="InputGrey"type="text" name="note" size="50" value="<%=NoteStr%>"  >  
				</td>

     </tr>
   </table>
   
   
  <table cellSpacing="0">
    <tr> 
      <td id="footer"> 
           <input type="button" name="query" class="b_foot" value="���ͨ��" onclick=do_submit("B","<%=DOCUMENT_ACCEPT%>") >
          &nbsp;
          <input type="button" name="return1" class="b_foot" value="���" onclick=do_submit("D","<%=DOCUMENT_ACCEPT%>") >
          &nbsp;
  
          &nbsp;
		  <input type="button" name="return2" class="b_foot" value="����" onClick="history.go(-1)" >
       </td>
    </tr>
     </table>
	<%@ include file="/npage/include/footer_simple.jsp"%>
  <%@ include file="../../npage/common/pwd_comm.jsp" %>
</form>
</BODY>
</HTML>	
		

