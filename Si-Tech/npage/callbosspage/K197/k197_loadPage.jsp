<%
  /*
   * ����: ������������ҳ��
�� * �汾: 1.0.0
�� * ����: 2009/10/29
�� * ����: yinzx
�� * ��Ȩ: sitech
   * update:
�� */
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%!
public static boolean isNumeric(String str){ 
  for (int i = str.length();--i>=0;){   
   if (!Character.isDigit(str.charAt(i))){ 
    return false; 
   } 
  } 
  return true; 
} 
%> 
<% 
  String kf_longin_no = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
	String opCode = "K197";
	String opName = "����������������";
	String StrSql="";
	List sqlList=new ArrayList();
  String[] sqlArr = new String[]{};
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import= "java.util.*"%> 

<%@ page import= "java.io.*"%> 
<%@ page import= "java.text.*"%> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import= "org.apache.poi.hssf.usermodel.*"%>
<%@ page import= "org.apache.poi.poifs.filesystem.*"%> 
<%@ page import= "org.apache.commons.fileupload.*"%>
<%!
/*---------------���ҳ�洫�ݲ�����ʼ-------------------*/

 public String getCell(HSSFCell cell){
		
		String result = "";
		
		if(cell==null)
			return result;
		
		
		if(cell.getCellType()==1){
			
			result = cell.getStringCellValue();
		}else if(cell.getCellType()==0){
            result = new Double((double)cell.getNumericCellValue()).toString();
		}	
		if (result ==null)
			result="";
		return result.replaceAll("'", "''").replaceAll("\n", "");
		
	}
%>
<%	
	
//iniFlag 1:�������ļ������ύ���ҳ��
String iniFlag =  request.getParameter("iniFlag") ;
String selectedItemId = request.getParameter("selectedItemId") ;
StringBuffer tmpBufferSaveVal = new StringBuffer();
String tmpSaveVal = "";
/*---------------���ҳ�洫�ݲ�������-------------------*/
//result 0:���ͳɹ� 1�����ɹ�
String result = "0";
String addColumnValue=""; 
 
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2); 
String[] addvalxnew= new String[]{};

if("1".equals(iniFlag)){
	  int maxSize = 100;
		String uploadSum = "";
		String successSum = "";
	  
	  String filename = "";
	  String sSaveName="";
	  String srvIP=request.getServerName();
	  String iErrorNo ="";
	  String sErrorMessage = "";
	  String[][] returnInfo = new String[][]{};
 
	    
	  SmartUpload mySmartUpload = new SmartUpload();
	  
	  mySmartUpload.initialize(pageContext);
	  mySmartUpload.setMaxFileSize(500 * 1024*1024);
	  mySmartUpload.upload();
	  com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	  String dateTime = sdf.format(new java.util.Date());
	  filename = myFile.getFileName().substring(0,myFile.getFileName().length()-4)+dateTime+myFile.getFileName().substring(myFile.getFileName().length()-4,myFile.getFileName().length());
 
	 
	  
	  sSaveName=request.getRealPath("/npage/callbosspage/K197/file")+"/"+filename;
	  
	  if(!myFile.isMissing()){
	     myFile.saveAs(sSaveName);
	  }else{
%>
	   <script language="javascript" >
	   	    rdShowMessageDialog("�ļ��ϴ�ʧ��!");
	   	    window.replace("k197_loadPage2.jsp");
	   </script>     
<%	
    }
    String InputStr = "";
    String temStr = "";
    int validFlag = 0;
 
		    BufferedReader br = new BufferedReader(new FileReader(sSaveName));
		    while ((temStr = br.readLine()) != null) {
						if (!temStr.trim().equals("")) { // ���ǿ���
						  addvalxnew=temStr.split("[|]",-1); 
						  StrSql=" insert into dcallspeciallist (specialid,accept_phone,cust_name,specialtype_id,begin_date,end_date,sq_login_no,op_login_no,reason) values ( to_char(sysdate,'yyyymmddhh24miss')|| :v1 ,:v2,:v3,:v4,to_date(:v5,'yyyymmdd hh24:mi:ss'),to_date(:v6,'yyyymmdd hh24:mi:ss'),:v7,:v8,:v9 )";
							  addColumnValue = "&&"+kf_longin_no+validFlag;
							
							for (int x=0; x<addvalxnew.length ;x++)
							{
							  addColumnValue+="^"+addvalxnew[x];
							}
							 
						  sqlList.add(StrSql+addColumnValue);     	
     			    sqlArr = (String[])sqlList.toArray(new String[0]);
						}
						validFlag++;
						if(validFlag>maxSize){
						    break;
						}
				}
				if(validFlag>maxSize){
%>
						   <script language="javascript" >
						   	    rdShowMessageDialog("����ʧ��:���֧���ϴ�<%=maxSize%>��!");
						   	    history.go(-1);   
						   </script>     
<%
			  } 
			  
			   
     			
     			%>
						<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
						    <wtc:param value=""/>
						    <wtc:param value="dbchange"/>
						    <wtc:params value="<%=sqlArr%>"/>
						</wtc:service>
						<wtc:array id="rows" scope="end" />
					<%
					  if(retCode.equals("000000"))
					  {
					     %>	<script> rdShowMessageDialog("���������������ݳɹ���") ;</script> <%
					  }else
					  {
					     %>	<script> rdShowMessageDialog("����������������ʧ�ܣ�"); </script>	<%
					  }
 
}
%>

	
	
<html>
<head>
<title>����������������</title>

<%
	 
	Random ran = new Random();
  String _K197validFlag = ran.nextInt(100000)+"";
	 
%>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script>


/**
  *
  *
  */
function submitLoad(){
	 

	var fileName = document.formbar.uploadFile.value;
	  if(fileName.length<1){
	  	  rdShowMessageDialog("��ѡ��Ҫ�ϴ����ļ�!");
	  	  return false;
	  }

	  if(fileName.indexOf(".txt")==-1){
	  	  rdShowMessageDialog("�ϴ��ļ���ʽҪ��Ϊ.txt!");
	  	  return false;
	  }
	  	  
 
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/K197/k197_loadPage.jsp?iniFlag=1";
	formbar.submit();
}

 

function ifSaveData(){

		var iFlag = '<%=iniFlag%>';
		if("1" == iFlag){
			document.getElementById('submit2').disabled=true;
			 
		}
}
</script>

</head>
<body onload=ifSaveData()>

<form  name="formbar" method="post" enctype="multipart/form-data">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
	<div id="Operation_Title"><B>�ϴ������ļ�</B></div>
    <div id="Operation_Table" style="width:100%;">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
      	<td width=16% class="blue">��ѡ���ļ�</td>
      </tr>
      <tr>
        <td width="34%"> 
        <input type="file" size="50"  name="uploadFile" id="uploadFile" />
        <div id="showAttachmentDiv" 
			style="white-space:normal; word-break:break-all; position: static; width: 80%;" >&nbsp;</div>
			
        <!--input class="b_text" name="submit1" type="button"  onclick="submitLoad();" value="����" /-->
        </td>    
      </tr>
          
      
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
      	<tr bgcolor="EEEEEE"> 
                  <td>
                     <br>
                      ˵����<br>
                      &nbsp;&nbsp; �ϴ��ļ��ı���ʽ���£� <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; �ֻ�����|�ͻ�����|��������|��ʼʱ�䣨YYYYMMDD��|����ʱ�䣨YYYYMMDD��|������|������|����ԭ��<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp;���磺
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 13500925125|XXX|1|20091102|20101202|kf1002|kf1002|�ÿͻ����Ų��⣬��ע�����Թ淶<br>
                    <br>
                    &nbsp;&nbsp;&nbsp;&nbsp; 13500926697|XXX|5|20091102|20101202|kf1002|kf1002|�ÿͻ����Ų��⣬��ע�����Թ淶<br>
                    <br>&nbsp;&nbsp;&nbsp;&nbsp; 5&nbsp;������&nbsp;6&nbsp;������&nbsp;1&nbsp;������<br>
                    <br>&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;������&nbsp;3&nbsp;������&nbsp;4	&nbsp;������<br>

                      <br>
                     &nbsp;&nbsp; <b>��ʽ�е�ÿһ������������|����������֮�������|Ϊ�������</b> 
                      &nbsp;&nbsp; <b>�ļ����ݲ�������100����</b> 
                    </td>
         </tr>
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" id="submit2" name="submit2" type="button" value="ȷ��" onclick="submitLoad();">
       		<input class="b_foot" name="reset1" type="button"  onclick="document.forms(0).reset();" value="���">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="�ر�"  >
        </td>
       </tr>  
     </table>
    </div>
    <br/>          
    </td>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="RightFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRight.jpg" width="20" height="45" /></td>
  </tr>
        
  <tr>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeftDown.gif" width="20" height="20" /></td>
    <td valign="bottom">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#D8D8D8">
      <tr>
        <td height="1"></td>
      </tr>
    </table>
    </td>
    <td><img src="<%=request.getContextPath()%>/nresources/default/images/CornerRightDown.gif" width="20" height="20" /></td>
  </tr>
</table>

</div>

</form>
<script>

</script>
</body>
</html>
 
 

