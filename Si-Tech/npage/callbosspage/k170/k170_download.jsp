<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*"%>

<%	

String myParams="";
String org_code = (String)session.getAttribute("orgCode");
String regionCode = org_code.substring(0,2);

String opCode="k170";
String opName="综合查询-来电信息-保存语音";
String sqlStr = "";
int que_flag = 1;
String strContact_id=request.getParameter("flag_id");
//录音分表 by libin 2009-05-22
String  tablename_ym = "";
/**
   if(strContact_id != null && strContact_id.indexOf("KF") >= 0){
   tablename_ym = strContact_id.substring(0,6);
   }else if(strContact_id != null && strContact_id.indexOf("KF") < 0){
   tablename_ym = strContact_id.substring(4,10);
   }
*/
//	edit by hanjc 20090626 begin 
if(strContact_id != null){
     tablename_ym = strContact_id.substring(0,6);
}
//	edit by hanjc 20090626 end 
// strContact_id="111120081000000000000161";
//out.println(strContact_id);
String sSqlCondition="";
//分页1
int rowCount=0;
int pageSize=10;            //每页行数
int pageCount=0;              //总的页数
int curPage=0;                //当前页
String strPage;             //作为参数传过来的页	 

strPage = request.getParameter("page");
String[][] dataRows = new String[][]{};
boolean bUserExist=false;

String action=request.getParameter("myaction");
//查询角色
if ("doLoad".equals(action)) {
     sqlStr = "select to_char(file_id),contact_id,login_no,to_char(create_time,'yyyy-mm-dd hh24:mi:ss'),file_path,bak1 from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:contact_id";
     myParams="contact_id="+strContact_id;
     que_flag = 2;
}


if(que_flag==1){
     //初始、链接进入
     //分页2
     String  sql = "select to_char(count(*)) count from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:contact_id";  
     myParams="contact_id="+strContact_id;
     
     %>	
          <wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
                <wtc:param value="<%=sql%>"/>
                <wtc:param value="<%=myParams%>"/>
                </wtc:service>
                <wtc:array id="rowsC"  scope="end"/>	
                <% 
                rowCount = Integer.parseInt(rowsC[0][0]);
     if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
     }else{
          curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
     }
     pageCount=(rowCount+pageSize-1)/pageSize;
     if (curPage>pageCount) curPage=pageCount;
     pageCount = ( rowCount + pageSize - 1 ) / pageSize;
     if ( curPage > pageCount ) curPage = pageCount;     
     sqlStr = "select to_char(file_id),contact_id,login_no,to_char(create_time,'yyyy-mm-dd hh24:mi:ss'),file_path,bak1 from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:contact_id";
     myParams="contact_id="+strContact_id;
     String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
     %>		
          <!--modifed liujie 将start="1" 改为 start="0" -->
          <wtc:service name="TlsPubSelCrm" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
                <wtc:param value="<%=querySql%>"/>
                	<wtc:param value="<%=myParams%>"/>
                </wtc:service>
          <wtc:array id="queryList" start="0" length="6" scope="end"/>
                <%
                dataRows = queryList;
}
else
{
     //点击查询、翻页按钮进入
     //分页2'
     String  sql = PageFilterSQL.getCountSQL(sqlStr);
     %>	
          <wtc:service name="TlsPubSelCrm" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
               <wtc:param value="<%=sql%>"/>
               <wtc:param value="<%=myParams%>"/>
               </wtc:service>
          <wtc:array id="rowsC2" scope="end"/>
                <%					
        rowCount = Integer.parseInt(rowsC2[0][0]);
        if (strPage==null||strPage.equals("")||strPage.trim().length()==0){
          curPage=1;
        }else{
            curPage=Integer.parseInt(strPage);
          if(curPage<1) curPage=1;
        }
        pageCount=(rowCount+pageSize-1)/pageSize;
        if (curPage>pageCount) curPage=pageCount;
        String querySql = PageFilterSQL.getOraQuerySQL(sqlStr,String.valueOf(curPage),String.valueOf(pageSize),String.valueOf(rowCount));
        %>		
             <!--modifed liujie 将start="1" 改为 start="0" -->
                   <wtc:service name="TlsPubSelCrm" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
                   <wtc:sql><%=querySql%></wtc:sql>
                   <wtc:param value="<%=myParams%>"/>
                   </wtc:service>
                   <wtc:array id="queryList2" start="0" length="6" scope="end"/>
                   <%
                   dataRows = queryList2;
      }
%>
<base target="_self">
<html>
<head>
<title>综合查询-来电信息-听取语音</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script LANGUAGE=javascript>

$(document).ready(
		function()
		{
	    $("td").not("[input]").addClass("blue");
			$("#footer input:button").addClass("b_foot");
			$("td:not(#footer) input:button").addClass("b_text");
			$("input:text[@v_type]").blur(checkElement2);	
		
			$("a").hover(function() {
				$(this).css("color", "orange");
			}, function() {
				$(this).css("color", "blue");
			});
		}
	);

	function checkElement2() { 
				checkElement(this); 
		}	  
		function doLoad(operateCode){
    if(operateCode=="load")
    {
      document.sitechform.page.value="";
    }
    else if(operateCode=="first")
    {
      document.sitechform.page.value=1;
    }
    else if(operateCode=="pre")
    {
      document.sitechform.page.value=<%=(curPage-1)%>;
    }
    else if(operateCode=="next")
    {
      document.sitechform.page.value=<%=(curPage+1)%>;
    }
    else if(operateCode=="last")
    {
      document.sitechform.page.value="<%=pageCount%>";
    }
      document.sitechform.myaction.value="doLoad";
      document.sitechform.action="k170_getCallListen.jsp";
      document.sitechform.method='post';
      document.sitechform.submit();

 }
 
 
 
 
function doProcessNavcomring(packet)	 
	 {
	    var retType = packet.data.findValueByName("retType"); 
	    var retCode = packet.data.findValueByName("retCode"); 
	    var retMsg = packet.data.findValueByName("retMsg"); 
	    if(retType=="chkExample"){
	    	if(retCode=="000000"){
	    		similarMSNPop("放音操作成功！");
	    		//alert("放音操作成功!");
	    		setTimeout("window.close()",1500);
	    	}else{
	    		similarMSNPop("放音操作失败！");
	    		//alert("放音操作失败!");
	    		setTimeout("window.close()",1500);
	    		return false;
	    	}
	    }
	 } 
 
 function doLisenRecord(i,contactId)
 
{
		  var filepath=document.getElementById("recodeFilse"+i).value;
		  //alert("filepath"+filepath);
		  //alert("contactId"+contactId);
		  //alert(window.opener);
		  //20090417 lijin 修改 增加传contactId，不然放音提示信息处没有流水号
		  window.opener.top.document.getElementById("lisenContactId").value=contactId;
		  window.opener.top.document.getElementById("recordfile").value=filepath;
		  window.opener.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contactId);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;

}

function BrowseFolder()
{
   var Message = "清选择文件夹";
   
   var Shell  = new ActiveXObject( "Shell.Application" );
   var Folder = Shell.BrowseForFolder(0,Message,0x0040,0x11);
   if(Folder != null)
   {
    Folder = Folder.items(); // 返回 FolderItems 对象
    Folder = Folder.item();  // 返回 Folderitem 对象
    Folder = Folder.Path;  // 返回路径
    
    //if(Folder.charAt(varFolder.length-1) != "\\"){
    // Folder = varFolder + "\\";
    //}
    
    document.all.chfolder.value=Folder;
    if(Folder.charAt(document.all.chfolder.value.length-1)=="\\")
    {
      document.all.chfolder.value=document.all.chfolder.value.substring(0, document.all.chfolder.value.length-1) ;
      //alert(document.all.chfolder.value); 
    }
    return Folder;
   }
}

function doDownload(i,contactid){
	 //var localIp = document.getElementById("localIp").value
	var localIp = GetLocalIPAddr();
	//alert("localIp"+localIp);
	var filepath=document.getElementById("recodeFilse"+i).value;
	//alert("filepath"+filepath);
	var fileId=document.getElementById("fileId"+i).value;
	//alert("fileId"+fileId);
	var kf_login_no=window.opener.top.cCcommonTool.getWorkNo();
	
	var url="k170_download_1.jsp?remoteFileSerialNo="+filepath+"&remoteFile="+filepath+"&chfolder=&contact_id="+contactid+"&kf_login_no="+kf_login_no+"&localIp="+localIp+"&fileId="+fileId ;	
	window.location.href=url;
}
 

</SCRIPT>
</head>

<body >
  <form name="sitechform" method="post" >
  	<%@ include file="/npage/include/header_pop.jsp"%>
  	<div id="Operation_Table" >
  	<div class="title">语音列表</div>
  		<table cellspacing="0">

	      <tr>
	       <td>
	       	<!--<div id="folder" style="display:none">
	       	 <table  cellspacing="0">
	       	 	 <tr>
	       	 	 	 <input type="text" readonly name="chfolder">
	       	 	 	 
               <a href="#" onclick="BrowseFolder();">选择保存结果文件路径</a>
	       	 	 <tr>
	       	</table>
	       	</div-->
	       
		       <table  cellspacing="0" >
		         	<input type="hidden"  name="remoteFile">
	       	 	 	 <input type="hidden"  name="remoteFileSerialNo">
		          <tr >
		          	<th align="center"   width="15%" nowrap >序号</th>
		            <th  align="center"  width="15%" nowrap >接续流水号</th>
		            <th  align="center"  width="15%" nowrap >坐席工号</th>
			          <th  align="center"  width="15%" nowrap >录音时间</th>
			          <th id="fullPath"  align="center"   width="25%" nowrap >文件路径</th>
			          <th id="passNo"  align="center"   width="25%" nowrap >通道号</th>			          
			          <th id="caoZuo" align="center"   width="25%" nowrap >操作</th>
			        </tr>
		         <% for (int i=0;i<dataRows.length;i++) { 
		         String cdClass = "";
							%>
							<%if (i%2==0){
							cdClass = "grey";
							}
							%>
		
						 <tr  >
	            <td align="center"  class="<%=cdClass%>" nowrap ><a href="#" onclick="doLisenRecord('<%=i%>','<%=dataRows[i][1]%>');"><%=dataRows[i][0]%></a></td>
	            <td align="center"  class="<%=cdClass%>" nowrap > <%=dataRows[i][1]%>&nbsp;</td>
	            <td align="center"  class="<%=cdClass%>" nowrap ><%=dataRows[i][2]%>&nbsp;</td>
	            <td align="center"  class="<%=cdClass%>" nowrap ><%=dataRows[i][3]%>&nbsp;</td>
	            <td id="fullName"  align="center"  class="<%=cdClass%>" nowrap ><%=dataRows[i][4]%>&nbsp;</td>
	            <td align="center"  class="<%=cdClass%>" nowrap ><%=dataRows[i][5]%>&nbsp;</td>	            
	            <td id="save"  align="center"  class="<%=cdClass%>" nowrap >
	               <a href="#" onclick="doDownload('<%=i%>','<%=strContact_id%>')">保存</a>
	            </td>
	             <input type="hidden"  id="recodeFilse<%=i%>" value="<%=dataRows[i][4]%>" nowrap>&nbsp;
               <input type="hidden"  id="fileId<%=i%>" value="<%=dataRows[i][0]%>" nowrap >&nbsp;  
	           </tr>
	           <% } %>
           <input type="hidden"  id="localIp" value="">&nbsp;  
	        </table>
	      </td>
	    </tr>
   <tr>
	    	<td>
        <!--//分页4-->
        <table cellspacing="0">
				<input type="hidden" id="page" name="page" value="">
				<input type="hidden" id="myaction"  name="myaction" value="">
    	  <tr >
            <td align="right" width="720">
              <%if(pageCount!=0){%>
              第 <%=curPage%>页 共 <%=pageCount%>页 共 <%=rowCount%>条
              <%} else{%>
              <font color="red">当前记录为空！</font>
              <%}%>
              <%if(pageCount!=1 && pageCount!=0){%>
              <a href="#"  onClick="doLoad('first');return false;">首页</a>
              <%}%>
              <%if(curPage>1){%>
              <a href="#"   onClick="doLoad('pre');return false;">上一页</a>
              <%}%>
              <%if(curPage<pageCount){%>
              <a href="#"   onClick="doLoad('next');return false;">下一页</a>
              <%}%>
              <%if(pageCount>1){%>
              <a href="#"   onClick="doLoad('last');return false;">尾页</a>
              <%}%>
            </td>
			    </tr>
			    <tr>
			    <td>

			    </td>
			    <tr>
			  </table>
      </td>
    </tr>
  </table>
</div>
  <%@ include file="/npage/include/footer_pop.jsp"%>
   </form>
  </body>
</html>
<script type=text/javascript>

 var isMonitor=window.opener.top.cCcommonTool.isMonitor();
 var isQcAgent=window.opener.top.cCcommonTool.isQcAgent();
  if(isMonitor==1||isQcAgent==1)
  {
  //alert("here!"+document.getElementById("folder"));     
  //document.getElementById("folder").style.display="";
  document.getElementById("fullPath").style.display="";
  document.getElementById("fullName").style.display="";
  document.getElementById("caoZuo").style.display="";
  document.getElementById("save").style.display="";
 }

//获取ip
function GetLocalIPAddr(){ 
    var oSetting = null; 
    var ip = null; 
    try{ 
        oSetting = new ActiveXObject( "rcbdyctl.Setting" ); 
        ip = oSetting.GetIPAddress; 
        var swap=ip.split(";");
        ip =swap[0];
        //alert(ip); 
        if (ip.length == 0){ 
          return "获取IP地址失败！"; 
        } 
        oSetting = null; 
    }catch(e){ 
        return ip; 
    } 
    return ip; 
}

</script>