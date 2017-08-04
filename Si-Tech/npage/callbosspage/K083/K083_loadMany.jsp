<%
  /*
   * 功能: 预定义短信界面树形数据生成页面
　 * 版本: 1.0.0
　 * 日期: 2009/01/15
　 * 作者: fengliang
　 * 版权: sitech
   * update:
　 */
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
<%  
	String opCode = "K083";
	String opName = "批量导入用户";
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import= "org.apache.commons.fileupload.*"%> 
<%@ page import= "java.io.*"%> 

<%
/*---------------获得页面传递参数开始-------------------*/
//iniFlag 1:代表有文件数据提交后的页面
String iniFlag =  request.getParameter("iniFlag") ;
System.out.println("requestrequestrequestrequestrequest0000000--->"+request );
System.out.println("requestrequestrequestrequestrequest1111111--->"+request.getParameter("uploadNums"));
/*---------------获得页面传递参数结束-------------------*/
		System.out.println("iniFlaginiFlaginiFlaginiFlag--->"+ iniFlag);
String phoneNums = "";
//result 0:发送成功 1：不成功
String result = "0";
if("1".equals(iniFlag)){
	DiskFileUpload   fu   =   new   DiskFileUpload(); 
	try{
			fu.setSizeMax(2048000);
			fu.setSizeThreshold(2048000);
			fu.setRepositoryPath("c:\\");
	}catch(Exception e){
			e.printStackTrace();
	}
	System.out.println("requestrequestrequestrequestrequest22222--->"+request );
	System.out.println("requestrequestrequestrequestrequest33333333--->"+request.getParameter("uploadNums"));
  List fileItems = fu.parseRequest(request);
  		System.out.println("fileItemsfileItemsfileItemsfileItems--->"+ fileItems.size());
  String fileName = "";
  Iterator   iter   =   fileItems.iterator(); 
  while(iter.hasNext()){
    FileItem item = (FileItem) iter.next(); //忽略其他不是文件域的所有表单信息 
    System.out.println("itemitemitemitemitemitemitemitemitemitemitemitem--->"+ item);
  	if (!item.isFormField()) 
					{		  
						fileName = item.getName();
						System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhh--->"+ fileName);
						if(fileName.toLowerCase().indexOf(".txt")==-1){
								result = "1";
								break;
						}
						try{   
              InputStream   in   =   item.getInputStream();  
              InputStreamReader   inReader   =   new   InputStreamReader(in); 
              BufferedReader   buffReader   =   new   BufferedReader(inReader); 
              String line = null;   
              boolean isfirst = true;
              while ((line = buffReader.readLine())!=null)   {   
                  if(line.length()==11&&isNumeric(line)){
                  	if(isfirst){
                  	System.out.println("ggggggggggggggggggggggggggggggggg--->"+ line);
                  		phoneNums = line;
                  		isfirst = false;
                  	}else{
                  		phoneNums = phoneNums+","+line;
                  	}
                  } 
              }   
            }catch(Exception e){   
              e.printStackTrace();   
          	}   
					}
  }
}
%>

	
	
<html>
<head>
<title>批量导入</title>
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
  *改变节点类型随动函数
  */
function submitItem(){
	if(formbar.uploadNums.value==''){ 
		rdShowMessageDialog('请选择文件!',2);
		return;
	}
	formbar.action="<%=request.getContextPath()%>/npage/callbosspage/K083/K083_loadMany.jsp?iniFlag=1";
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
	<div id="Operation_Title"><B>上传数据文件</B></div>
    <div id="Operation_Table">
    <div class="title"></div>  
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
    	<tr>
      	<td width=16% class="blue">请选择txt文件，电话号码用回车键分隔</td>
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
            <input class="b_foot" name="submit1" type="button" value="确认" onclick="submitItem()">
       		<input class="b_foot" name="reset1" type="button"  onclick="document.forms(0).reset();" value="清除">
       		<input class="b_foot" name="back" type="button" onclick="window.close();" value="关闭"  >
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
<%
if("1".equals(iniFlag)){
	if(phoneNums.length()>0){
%>
	 opener.document.getElementById('user_phone').value="<%=phoneNums%>";
	 window.close();
<%		
	}else{
%>
	 rdShowMessageDialog('导入数据失败，请确认数据格式和文件格式!',2);
<%			
	}
}
%>
</script>
</body>
</html>
 
 

