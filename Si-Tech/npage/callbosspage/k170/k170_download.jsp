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
String opName="�ۺϲ�ѯ-������Ϣ-��������";
String sqlStr = "";
int que_flag = 1;
String strContact_id=request.getParameter("flag_id");
//¼���ֱ� by libin 2009-05-22
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
//��ҳ1
int rowCount=0;
int pageSize=10;            //ÿҳ����
int pageCount=0;              //�ܵ�ҳ��
int curPage=0;                //��ǰҳ
String strPage;             //��Ϊ������������ҳ	 

strPage = request.getParameter("page");
String[][] dataRows = new String[][]{};
boolean bUserExist=false;

String action=request.getParameter("myaction");
//��ѯ��ɫ
if ("doLoad".equals(action)) {
     sqlStr = "select to_char(file_id),contact_id,login_no,to_char(create_time,'yyyy-mm-dd hh24:mi:ss'),file_path,bak1 from dcallrecordfile"+tablename_ym+" where 1=1 and contact_id=:contact_id";
     myParams="contact_id="+strContact_id;
     que_flag = 2;
}


if(que_flag==1){
     //��ʼ�����ӽ���
     //��ҳ2
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
          <!--modifed liujie ��start="1" ��Ϊ start="0" -->
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
     //�����ѯ����ҳ��ť����
     //��ҳ2'
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
             <!--modifed liujie ��start="1" ��Ϊ start="0" -->
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
<title>�ۺϲ�ѯ-������Ϣ-��ȡ����</title>
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
	    		similarMSNPop("���������ɹ���");
	    		//alert("���������ɹ�!");
	    		setTimeout("window.close()",1500);
	    	}else{
	    		similarMSNPop("��������ʧ�ܣ�");
	    		//alert("��������ʧ��!");
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
		  //20090417 lijin �޸� ���Ӵ�contactId����Ȼ������ʾ��Ϣ��û����ˮ��
		  window.opener.top.document.getElementById("lisenContactId").value=contactId;
		  window.opener.top.document.getElementById("recordfile").value=filepath;
		  window.opener.top.document.getElementById("K042").click();
			var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
	     packet.data.add("retType" ,  "chkExample");
	     packet.data.add("filepath" ,  filepath);
	     packet.data.add("liscontactId" ,contactId);
	    core.ajax.sendPacket(packet,doProcessNavcomring,true);
			packet =null;

}

function BrowseFolder()
{
   var Message = "��ѡ���ļ���";
   
   var Shell  = new ActiveXObject( "Shell.Application" );
   var Folder = Shell.BrowseForFolder(0,Message,0x0040,0x11);
   if(Folder != null)
   {
    Folder = Folder.items(); // ���� FolderItems ����
    Folder = Folder.item();  // ���� Folderitem ����
    Folder = Folder.Path;  // ����·��
    
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
  	<div class="title">�����б�</div>
  		<table cellspacing="0">

	      <tr>
	       <td>
	       	<!--<div id="folder" style="display:none">
	       	 <table  cellspacing="0">
	       	 	 <tr>
	       	 	 	 <input type="text" readonly name="chfolder">
	       	 	 	 
               <a href="#" onclick="BrowseFolder();">ѡ�񱣴����ļ�·��</a>
	       	 	 <tr>
	       	</table>
	       	</div-->
	       
		       <table  cellspacing="0" >
		         	<input type="hidden"  name="remoteFile">
	       	 	 	 <input type="hidden"  name="remoteFileSerialNo">
		          <tr >
		          	<th align="center"   width="15%" nowrap >���</th>
		            <th  align="center"  width="15%" nowrap >������ˮ��</th>
		            <th  align="center"  width="15%" nowrap >��ϯ����</th>
			          <th  align="center"  width="15%" nowrap >¼��ʱ��</th>
			          <th id="fullPath"  align="center"   width="25%" nowrap >�ļ�·��</th>
			          <th id="passNo"  align="center"   width="25%" nowrap >ͨ����</th>			          
			          <th id="caoZuo" align="center"   width="25%" nowrap >����</th>
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
	               <a href="#" onclick="doDownload('<%=i%>','<%=strContact_id%>')">����</a>
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
        <!--//��ҳ4-->
        <table cellspacing="0">
				<input type="hidden" id="page" name="page" value="">
				<input type="hidden" id="myaction"  name="myaction" value="">
    	  <tr >
            <td align="right" width="720">
              <%if(pageCount!=0){%>
              �� <%=curPage%>ҳ �� <%=pageCount%>ҳ �� <%=rowCount%>��
              <%} else{%>
              <font color="red">��ǰ��¼Ϊ�գ�</font>
              <%}%>
              <%if(pageCount!=1 && pageCount!=0){%>
              <a href="#"  onClick="doLoad('first');return false;">��ҳ</a>
              <%}%>
              <%if(curPage>1){%>
              <a href="#"   onClick="doLoad('pre');return false;">��һҳ</a>
              <%}%>
              <%if(curPage<pageCount){%>
              <a href="#"   onClick="doLoad('next');return false;">��һҳ</a>
              <%}%>
              <%if(pageCount>1){%>
              <a href="#"   onClick="doLoad('last');return false;">βҳ</a>
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

//��ȡip
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
          return "��ȡIP��ַʧ�ܣ�"; 
        } 
        oSetting = null; 
    }catch(e){ 
        return ip; 
    } 
    return ip; 
}

</script>