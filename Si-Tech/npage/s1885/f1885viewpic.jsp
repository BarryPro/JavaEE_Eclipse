   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-3-17
********************/
%>
              
<%
  String opCode = "1885";
  String opName = "身份证扫描件稽核报表";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="import java.sql.*"%> 
<%@ page import="java.text.SimpleDateFormat"%> 
<%@ page import="com.uploadftp.*"%>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);

  String regionCode = (String)session.getAttribute("regCode");
	String database=request.getParameter("database");
	String nameu=request.getParameter("nameu");
	String opc = request.getParameter("opc");
	String idIccid = request.getParameter("idIccidjs");
	
	System.out.println("-------------------------idIccid-----------------------"+idIccid);
	String databaseName = "dIdCardInfo"+database;
	
	System.out.println("-------------------------databaseName-----------------------"+databaseName);
	
 
	
		String login_accept=request.getParameter("login_accept");
  
		SimpleDateFormat sdf =   new SimpleDateFormat( "yyyyMMddHHmmss" );
    String picName = sdf.format(new java.util.Date());
    String sSaveName=request.getRealPath("npage/cust_ID1250")+"/"+picName+".jpg";
    
    File file_cre = new File(request.getRealPath("npage/cust_ID1250"));
			if(!file_cre.exists()){
			file_cre.mkdirs();
			}
    
    			String sql_idPath ="";
  		  if(opc.equals("1100")||opc.equals("1104"))
		    	 sql_idPath = "select id_image from DCUSTICCIDIMG where id_iccid='"+idIccid+"'";
		    else
		    	 sql_idPath = "select id_image from "+databaseName+" where login_accept='"+login_accept+"'"; //其他模块需要加身份照片时用到
%>

	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql_idPath%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%
		
		String idPicPath = "";
		if(result_t.length>0&&result_t[0][0]!=null){
			idPicPath = result_t[0][0];
		}
		ResourceBundle LogfileInfo = ResourceBundle.getBundle("LoginInfo");
		DesEncrypterIsmp t = new DesEncrypterIsmp();  //加密类，解密类
		String ftpsPassword = LogfileInfo.getString("ftpPassword");
		System.out.println("ftpsPassword|"+ftpsPassword);
		
		String yearMon=new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date());
		
		System.out.println("idPicPath|"+idPicPath);
		String filename = idPicPath.substring(idPicPath.indexOf("_")+1,idPicPath.length());
		String serverIP = idPicPath.substring(0,idPicPath.indexOf("_"));
		
		System.out.println("filename|"+filename);
		System.out.println("serverIP|"+serverIP);
		System.out.println("sSaveName|"+sSaveName);
		
		
		FtpTools ftpT=new FtpTools();
		if(ftpT.connect(serverIP)){
			if(ftpT.login_S("iccid",ftpsPassword)){
				boolean dlfile = ftpT.downloadFile("/"+filename,sSaveName);
				System.out.println("下载图片结果为："+dlfile);
				}
			}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>查看客户身份证照片</title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
function wdclose(){
	var picName = <%=picName%>;
	fPubSimpSel.action="deletePic.jsp?picName="+picName;
	fPubSimpSel.submit();
	window.close();
	}
	
  function   document.onkeydown()     
  {   
      if((window.event.altKey)&&(window.event.keyCode==115)){ 
      	wdclose();
      }   
  } 
  
   function  window.onbeforeunload()   
      {   
      if(event.clientX>document.body.clientWidth&&event.clientY<0||event.altKey)
            {   
           wdclose();  
            }   
      }
</script>
</head>

<body>
<FORM method=post name="fPubSimpSel">   
	<%@ include file="/npage/include/header_pop.jsp" %>

	<div class="title">
		<div id="title_zi">查看客户<%=nameu%>的身份证照片</div>
	</div>
	 
  <table cellspacing="0">
    <tr>
 		<td align=center>
 		<img src="/npage/cust_ID1250/<%=picName%>.jpg" width=200 height=130 ></img>
 		</td>
   </tr>
  </table>
 
    <TABLE cellSpacing="0">
    <TBODY>
        <TR> 
            <TD align=center id="footer"> 
                <input class="b_foot" name=back onClick="wdclose()" style="cursor:hand" type=button value=关闭>&nbsp;        
            </TD>
        </TR>
    </TBODY>
    </TABLE>
 
  <%@ include file="/npage/include/footer_pop.jsp" %>
</FORM>
</body>
<%
			File fpic =new File(sSaveName);
			if(fpic.length()==0)
			{%>
				<script language="JavaScript">
				  rdShowMessageDialog("文件为空",0);
				 wdclose();
				</script>
			<%}%>
</html>
