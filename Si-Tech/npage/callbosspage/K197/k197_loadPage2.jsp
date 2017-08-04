<%request.setCharacterEncoding("GB2312");%>
<%@ page contentType="text/html; charset=GB2312"%>
<%@ page errorPage="../common/errorpage.jsp" %>
<%@ page import="java.util.*,java.text.*"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.io.*"%>
<html>
<head>
		<title>特殊名单批量导入</title>
		<link rel="stylesheet" href="../../css/style.css" type="text/css">
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/tablabel.css"> 
		<script type="text/javascript" src="../../js/common/common_check.js"></script>
		<script type="text/javascript" src="../../js/common/common_util.js"></script>
		<script type="text/javascript" src="../../js/common/redialog/redialog.js"></script>

<%
		 
	 
		 
		int maxSize = 100;
		String uploadSum = "";
		String successSum = "";
	  
	  String filename = "";
	  String sSaveName="";
	  String srvIP=request.getServerName();
	  String iErrorNo ="";
	  String sErrorMessage = "";
	  String[][] returnInfo = new String[][]{};
	  
	    System.out.println("00000000000000000-------0000000000000000000000000000000000000000000000 ");  
	 System.out.println("00000000000000000-------0000000000000000000000000000000000000000000000 ");  
	   System.out.println("00000000000000000-------0000000000000000000000000000000000000000000000 ");  
	    
	  SmartUpload mySmartUpload = new SmartUpload();
	  
	  mySmartUpload.initialize(pageContext);
	  mySmartUpload.setMaxFileSize(500 * 1024*1024);
	  mySmartUpload.upload();
	  com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
	  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	  String dateTime = sdf.format(new java.util.Date());
	  filename = myFile.getFileName().substring(0,myFile.getFileName().length()-4)+dateTime+myFile.getFileName().substring(myFile.getFileName().length()-4,myFile.getFileName().length());
 
	 
	  
	  sSaveName=request.getRealPath("./file")+"/"+filename;
	  
	  if(!myFile.isMissing()){
	     myFile.saveAs(sSaveName);
	  }else{
%>
	   <script language="javascript" >
	   	    rdShowMessageDialog("文件上传失败!");
	   	    window.replace("k197_loadPage2.jsp");
	   </script>     
<%	
    }
    String InputStr = "";
    String temStr = "";
    int validFlag = 0;
    try{
		    BufferedReader br = new BufferedReader(new FileReader(sSaveName));
		    while ((temStr = br.readLine()) != null) {
						if (!temStr.trim().equals("")) { // 不是空行
							  if(temStr.trim().length()==11){
							  		InputStr +=temStr.trim()+"|";
							  }else{
%>
						   <script language="javascript" >
						   	    rdShowMessageDialog("上传文件格式有误!");
						   	    history.go(-1);   
						   </script>     
<%	
							  }
						}
						validFlag++;
						if(validFlag>maxSize){
						    break;
						}
				}
				if(validFlag>maxSize){
%>
						   <script language="javascript" >
						   	    rdShowMessageDialog("操作失败:最多支持上传<%=maxSize%>行!");
						   	    history.go(-1);   
						   </script>     
<%
			  }else{
%>
<wtc:service name="s4207Cfm" routerKey="region" routerValue="<%=regionCode%>" retcode="Code" retmsg="Msg" outnum="6" >
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=nopass%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=faze_type%>"/>
        <wtc:param value="<%=note%>"/>
        <wtc:param value="<%=filename%>"/>
        <wtc:param value="<%=InputStr%>"/>
</wtc:service>	
<wtc:array id="rows" start="4" length="2" >
<%
    returnInfo = rows;
%>
</wtc:array >
<wtc:array id="rows" start="1" length="3" >
		<%
		    uploadSum = rows[0][1];
		    successSum = rows[0][2];
		%>
</wtc:array >	
<%
    if(uploadSum.equals(successSum)){
        %>
        <script language="javascript" >
        rdShowMessageDialog("操作成功!\n上传总条数:<%=uploadSum%>\n成功条数:<%=successSum%>");
				window.location="f4207_1.jsp";
				</script>
        <%
    } 
%>

<script language="javascript" >

var pageShow = new Array();
var pageShowNew = new Array();
var pageIndex = 0;
<%
		for (int i=0;i<returnInfo.length;i++){
		if(returnInfo[i][0].trim().length()>0){
%>
    pageShow[pageIndex] = "<%=returnInfo[i][0].trim()%>";
    pageShowNew[pageIndex] = "<%=returnInfo[i][1].trim()%>";
    pageIndex++;
<%
}}
%>

var page = 1;   //页数
var pageLine = 10;    //每责显示行数
var sumLine = pageShow.length;    //总行数
var endPage = 1;    //最大页数
window.onload =function(){
		if(sumLine%pageLine==0){  //如果取余得0
			  endPage = sumLine/pageLine;
		}else{
			  endPage = parseInt(sumLine/pageLine)+1;
		}
		Init();
		document.all.sumNum.innerText=sumLine;
		document.all.pageNum.innerText=endPage;
		document.all.pageE.innerText=page;
}
document.onkeydown=function(){
      if (window.event.keyCode==8||window.event.keyCode==116||window.event.keyCode==78)
      {
           event.keyCode=0; 
           event.returnValue=false;
      }
}
function Init(){
	  isDisable();
    var tabOne = document.getElementById("tabOne");
    var phoneNo = "";
    var retInfo = "";
    var inHtml = "<table bgcolor=\"#EEEEEE\" width=\"98%\" >";
    inHtml +="<tr align=\"center\" ><td width=\"50%\" ><b>号码</td><td width=\"50%\" ><b>返回信息</td></tr>";
    for(var j=page*pageLine-pageLine;j<page*pageLine;j++){
    	  phoneNo = pageShow[j];
    	  retInfo = pageShowNew[j];
    	  if (typeof(phoneNo)!="undefined"){
    	  	  inHtml += "<tr align=\"center\" ><td width=\"50%\" >"+phoneNo+"</td><td width=\"50%\" >"+retInfo+"</td></tr>";
    	  }	
    }
    inHtml +="</table>";
    tabOne.innerHTML=inHtml;
    document.all.pageE.innerText=page; 
}
function getPageNext(){
	  page = getPageNextInfo(page,endPage);
	  isDisable();
    var tabOne = document.getElementById("tabOne");
    var phoneNo = ""; 
    var retInfo = "";
    var inHtml = "<table bgcolor=\"#EEEEEE\" width=\"98%\" >";
    inHtml +="<tr align=\"center\" ><td width=\"50%\" ><b>号码</td><td width=\"50%\" ><b>返回信息</td></tr>";
    for(var j=page*pageLine-pageLine;j<page*pageLine;j++){
    	  phoneNo = pageShow[j];
    	  retInfo = pageShowNew[j];
    	  if (typeof(phoneNo)!="undefined"){
    	  	  inHtml += "<tr align=\"center\" ><td width=\"50%\" >"+phoneNo+"</td><td width=\"50%\" >"+retInfo+"</td></tr>";
    	  }	
    }
    inHtml +="</table>";
    tabOne.innerHTML=inHtml;
    document.all.pageE.innerText=page;   
}
  
function getPageBack(){
	  page = getPageBackInfo(page,endPage);
	  isDisable();
    var tabOne = document.getElementById("tabOne");
    var phoneNo = "";
    var retInfo = "";
    var inHtml = "<table bgcolor=\"#EEEEEE\" width=\"98%\" >";
    inHtml +="<tr align=\"center\" ><td width=\"50%\" ><b>号码</td><td width=\"50%\" ><b>返回信息</td></tr>";
    for(var j=page*pageLine-pageLine;j<page*pageLine;j++){
				phoneNo = pageShow[j];
    	  retInfo = pageShowNew[j];
    	  if (typeof(phoneNo)!="undefined"){
    	  	  inHtml += "<tr align=\"center\" ><td width=\"50%\" >"+phoneNo+"</td><td width=\"50%\" >"+retInfo+"</td></tr>";
    	  }	
    }
    inHtml +="</table>";
    tabOne.innerHTML=inHtml;
    document.all.pageE.innerText=page;
}

function isDisable(){
	  if((page==1)&&(page==endPage)){
	  	  document.all.pageNext.disabled=true;
	  	  document.all.pageBack.disabled=true;
	  }else if((page>1)&&(page!=endPage)){
	  	  document.all.pageNext.disabled=false;
	  	  document.all.pageBack.disabled=false;
	  }else if((page>1)&&(page==endPage)){
	  	  document.all.pageNext.disabled=true;
	  	  document.all.pageBack.disabled=false;
	  }else if((page==1)&&(page!=endPage)){
	  	  document.all.pageNext.disabled=false;
	  	  document.all.pageBack.disabled=true;
	  }
}

function getPageNextInfo(page,endPage){
	  if((page==1)&&(page==endPage)){
	  	  alert("1");
	  	  page=1;
	  }else if((page>=1)&&(page!=endPage)){
	  	  page++;
	  }else if((page>1)&&(page==endPage)){
	  	  page=endPage;
	  }
	  return page;
}

function getPageBackInfo(page,endPage){
	  if(page==1){
	  	  page=1;
	  }else if((page>1)&&(page!=endPage)){
	  	  page--;
	  }else if((page>1)&&(page==endPage)){
	  	  page--;
	  }
	  return page;
}
	
</script>	
</head>
<%
   		 	 if(Code.equals("000000")){
%>	
		<%@ include file="/page/public/head.jsp" %>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" oncontextmenu="window.event.returnValue=false"  >
<form  action="" >
<div id="Operation_Table">
		<table bgcolor="#EEEEEE" width="98%" >
			<!--
				<tr align="center" >
						<td>
								<wtc:array id="rows" start="0" length="1" >
										<font color="red" size="5" >
											    <%=rows[0][0].equals("000000")?"操作成功!":"操作失败!"%>  
										</font>
								</wtc:array >	
						</td>
				</tr>
				-->
				<tr align="center" >
						<td>
							  <b>
								<font color="red" >
									    上传总数:<%=uploadSum%>  
									    成功总数:<%=successSum%>	
								</font>
						</td>
				</tr>
		</table>
		<div id="tabOne" >
			<!--
<table  width="98%" align="center" id="tabOne" bgcolor="#EEEEEE" cellspacing="1" border="0" >

</table>
      -->
    </div>
<table  width="98%" align="center" bgcolor="#EEEEEE" cellspacing="1" border="0" >
		<tr>  
				<td align="center" colspan="1">
					 共<div id="sumNum" style="display:inline;" ></div>条记录   
					 共<div id="pageNum" style="display:inline;" ></div>页 当前第<div id="pageE" style="display:inline;" ></div>页
					 <input name="pageBack" type="button" value="上一页" onclick="getPageBack()"   >
					 <input name="pageNext" type="button" value="下一页" onclick="getPageNext()"   >
				   <input name=sure type=button value=关闭 onClick="window.close()">
				   <input name=retu type=button value=返回 onClick="window.location='f4207_1.jsp'">
				</td>
		</tr>
</table>
</div>
<%@ include file="../public/foot.jsp" %>

</form>
</body>

</html>		
<%
    				}else{
%>
			   <script language="javascript" >
			   	    rdShowMessageDialog("<%=Msg+":["+Code+"]"%>");
			   	    history.go(-1);
			   </script>
<%
  		 			}
  		  }
    }catch(Exception ex){
%>
	   <script language="javascript" >
	   	    rdShowMessageDialog("读取文件失败!");
	   	    history.go(-1);   
	   </script>     
<%
    }
%>
