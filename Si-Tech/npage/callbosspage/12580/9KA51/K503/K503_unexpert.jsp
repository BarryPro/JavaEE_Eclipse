<%
  /*
   * ����: Ԥ������Ž���������
�� * �汾: 1.0.0
�� * ����: 2009/8/1
�� * ����: libin
�� * ��Ȩ: sitech
   * update:
�� */
%>
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

<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import= "org.apache.commons.fileupload.*"%> 
<%@ page import= "java.io.*"%> 
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String loginNo = (String) (session.getAttribute("kfWorkNo")==null?"":session.getAttribute("kfWorkNo"));
	String msg_mod_id = request.getParameter("msg_mod_id")==null?"":request.getParameter("msg_mod_id");
%>
<%
/*---------------���ҳ�洫�ݲ�����ʼ-------------------*/

//iniFlag 1:�������ļ������ύ���ҳ��
String iniFlag = WtcUtil.repNull(request.getParameter("iniFlag"));
/*---------------���ҳ�洫�ݲ�������-------------------*/

String phoneNums = "";
if("1".equals(iniFlag)){
	DiskFileUpload fu = new DiskFileUpload(); 
	try{
			fu.setSizeMax(2048000);
			fu.setSizeThreshold(2048000);
			fu.setRepositoryPath("c:\\");
	}catch(Exception e){
			e.printStackTrace();
	}
  List fileItems  =  fu.parseRequest(request);
  String fileName = "";
  Iterator iter   =   fileItems.iterator(); 
  while(iter.hasNext()){
    FileItem item = (FileItem) iter.next(); //�������������ļ�������б���Ϣ 
  	if (!item.isFormField()) 
					{		  
						fileName = item.getName();
						if(fileName.toLowerCase().indexOf(".txt")==-1){
								break;
						}
						try{   
              InputStream               in   =   item.getInputStream();  
              InputStreamReader   inReader   =   new   InputStreamReader(in); 
              BufferedReader    buffReader   =   new   BufferedReader(inReader); 
              String line = "";   
              String sqlIn = ""; 
              while ((line = buffReader.readLine())!=null){
              	sqlIn = "insert into DMESSAGEMODELCONTENT select SEQ_12580.nextval,'"+msg_mod_id+"','"+line+"','"+loginNo+"',sysdate,'','','','' from dual";              	
%>
<wtc:service name="sKFModify" outnum="2">
	<wtc:param value="<%=sqlIn %>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%              
              }
%>
<script>
	alert("����ɹ���");
</script>
<%
            }catch(Exception e){
%>
<script>
	alert("����ʧ�ܣ�");
</script>
<% 
              e.printStackTrace();   
          	}   
					}
  }
}
%>

	
	
<html>
<head>
<title>Ԥ������ŵ���</title>
<meta http-equiv=Content-Type content="text/html; charset=GBK">

<link href="<%=request.getContextPath()%>/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="<%=request.getContextPath()%>/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>

<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/njs/si/validate_pack.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>

<script>


/**
  *
  *�ı�ڵ������涯����
  */
function submitItem(){
	if(formbar.uploadNums.value==''){ 
		rdShowMessageDialog('��ѡ���ļ�!',2);
		return;
	}
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/12580/9KA51/K503/K503_unexpert.jsp?iniFlag=1&msg_mod_id=<%=msg_mod_id %>";
	formbar.submit();
}




</script>

</head>
<body>

<form  name="formbar" method="post" enctype="multipart/form-data">
<div id="Main">
<table width="98%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="20" valign="top" background="<%=request.getContextPath()%>/nresources/default/images/DotGray.jpg" class="LeftFixBg"><img src="<%=request.getContextPath()%>/nresources/default/images/CornerLeft.jpg" width="20" height="75" /></td>
	<td valign="top" background="<%=request.getContextPath()%>/nresources/default/images/MainTopBg.jpg" class="TopFixBg">
    <div id="Operation_Table">
    <div class="title"></div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
      	<td width=16% class="blue">��ѡ��txt�ļ�����ͬ��¼�ûس����ָ�</td>
      </tr>
      <tr>
        <td width="34%"> 
        <input type="file" size="50" name="uploadNums" id="uploadNums" >
        </td>    
      </tr>
          
      
      </table>

      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td id="footer"  align=center> 
            <input class="b_foot" name="submit1" type="button" value="ȷ��" onclick="submitItem()">
       		<input class="b_foot" name="reset1" type="reset" value="���">
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
</body>
</html>
 




