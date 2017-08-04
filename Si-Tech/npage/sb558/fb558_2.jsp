<%
    /********************
     version v2.0
     开发商: si-tech
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.*" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.s1210.pub.Pub_lxd"%>
<%@ page import="com.sitech.boss.s1100.viewBean.*" %>
<%@ page import="javax.servlet.ServletInputStream" %>
<%@ page import="com.sitech.boss.common.viewBean.comImpl"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="jxl.*" %>

<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    
    String opCode = "b558";
    String opName = "局数据同步导入";	
    
    
    String workNo = (String)session.getAttribute("workNo");  //工号
    String org_code_note = (String)session.getAttribute("orgCode");
		String regionCode=org_code_note.substring(0,2);
    String searchType;
    String optType; 
    String dsmpType; 
    String sheetno;
    String feeunit;
    String balprop;
    String dsmpName = null;
    String dsmpNamecheck = "";
    String feefile = null;
    String insertbuff[] = new String[20];
    String ip = request.getRemoteAddr();
    Cell   cell[] = null;
    int max_columns,max_rows;
    int start_flag;
    int rowcount=0;
    int i=0;
    String irow= "";
    String errCode = "000000";
		String errMsg = "";
    
    Workbook info;
    Sheet sheet;
    
    String sysAccept = "";
    java.text.DateFormat format1 = new java.text.SimpleDateFormat("yyyyMMddhhmmss");
    String datenew = format1.format(new Date());
    String sSaveName=request.getRealPath("/npage/tmp/")+"/"+workNo+datenew+".xls";
    System.out.println("sSaveName = " +sSaveName );
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
    <%
    sysAccept = seq;
    
    SmartUpload mySmartUpload = new SmartUpload();
		try
		{
			mySmartUpload.initialize(pageContext);
			mySmartUpload.upload();
    }
    catch(Exception ex) 
    {
			System.out.println("上载文件传输中出错！");
    }
    
		System.out.println("Count = "+mySmartUpload.getFiles().getCount());
		try
		{
			com.jspsmart.upload.File myFile  = mySmartUpload.getFiles().getFile(0);
			feefile  = myFile.getFilePathName();
			if (!myFile.isMissing())
			{
				myFile.saveAs(sSaveName);
			}
		}
    catch(Exception ex) 
    {
			System.out.println("上载文件传输时出错！");
    }
    


	searchType = mySmartUpload.getRequest().getParameter("searchType");
	optType = mySmartUpload.getRequest().getParameter("optType");
	dsmpType = mySmartUpload.getRequest().getParameter("dsmpType");
	sheetno = mySmartUpload.getRequest().getParameter("sheetno");
	feeunit = mySmartUpload.getRequest().getParameter("feeunit");
	balprop = mySmartUpload.getRequest().getParameter("balprop");
	String tmpsql = "select servname from sdsmpservtype where servtype = '"+dsmpType+"'";
	info=Workbook.getWorkbook(new java.io.File(sSaveName));
	sheet = info.getSheet(Integer.parseInt(sheetno) - 1);
	%>
	<wtc:pubselect name="sPubSelect" outnum="1">
	<wtc:sql><%=tmpsql%></wtc:sql>	
	</wtc:pubselect>
	<wtc:array id="dsmptmp" scope="end"/>
	<%
	if(dsmptmp!=null&& dsmptmp.length > 0)
	{
		dsmpName = dsmptmp[0][0];
	}
	%>

<HTML>
<HEAD>
    <TITLE>局数据同步导入</TITLE>
</HEAD>
<BODY>
	<SCRIPT LANGUAGE="JavaScript">
		function gohome() 
		{
   		document.location.replace("fb558_1.jsp");
		}
		function doCheck()
		{
			var oButton = document.getElementById("Button1"); 
			oButton.disabled = true;
			var check1 = document.frmb558Cfm.dsmpName.value;
			var check2 = document.frmb558Cfm.dsmpNamecheck.value;
			if(check1!=check2)
			{
				if(rdShowConfirmDialog("选择的DSMP类型("+check1+")与EXCLE里的类型("+check2+")不符，继续么？")==0)
				{
					oButton.disabled = false;
					return;
				}
			}
			document.frmb558Cfm.action="fb558_cfm.jsp"
			frmb558Cfm.submit();
		}
	</SCRIPT>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    <div id="title_zi">导入信息</div>
	</div>
	<table border="0" align="center" cellspacing="0">
		<tr>
			
			<%
			out.println("<td width=16% class=orange>导入类型</td>");
			if(searchType.equals("0"))
	    {
	    	out.println("<td width=16% class=blue>SP企业局数据</td>");
	    }
	  	else
	  	{
	  		out.println("<td width=16% class=blue>SP业务局数据</td>");
	  	}
	  	out.println("<td width=16% class=orange>业务类型</td>");
	  	out.println("<td class=blue>"+dsmpName+"</td>");
	  	out.println("<td width=16% class=orange>操作类型</td>");
			if(optType.equals("0"))
	    {
	    	out.println("<td width=16% class=blue>新增</td>");
	    }
	  	else if(optType.equals("1"))
	  	{
	  		out.println("<td width=16% class=blue>修改</td>");
	  	}
	  	else
	  	{
	  		out.println("<td width=16% class=blue>删除</td>");
	  	}
	  	%>

		</tr>
		<tr>
			<%
				out.println("<TD width=16% class=orange>局数据文件:</TD>");
      	out.println("<td class=blue colspan=7>"+feefile+"</td>");
			%>
		</tr>
	</table>
	<table border="0" align="center" cellspacing="0">
    <%
    max_rows = sheet.getRows();
		start_flag =0;
		System.out.println("max_rows = "+max_rows);
		for(i = 0;i<max_rows;i++)
		{
			try{
				cell = sheet.getRow(i);
				System.out.println(" "+cell[0].getContents().trim()+" "+cell.length);
				if(cell.length<=0)
				{
					continue;
				}
				if(start_flag == 0||cell[0].getContents().trim().equals(""))
				{
					if(cell[0].getContents().trim().equals("业务类型"))
					{
						out.println("<tr>");
						out.println("<td class=orange align='left' nowrap>序号</td>");
						for(int j = 0;j<cell.length&&j<19;j++)
						{
							out.println("<td class=orange align='left' nowrap>" + cell[j].getContents() + "</td>");
						}
						out.println("</tr>");
						start_flag = 1;
						rowcount = 0;
					}
					continue;
				}
				System.out.println("cell.length = "+cell.length);
				if(dsmpNamecheck.equals(""))
				{
					dsmpNamecheck = cell[0].getContents().trim();
				}
			}
			catch(Exception e)
			{
				continue;
			}
			out.println("<tr>");
			out.println("<td class=blue align='left' nowrap>"+(rowcount+1)+"</td>");
			rowcount++;
			for(int j = 0;j<cell.length&&j<19;j++)
			{				
					if(insertbuff[j]==null)
					{
						insertbuff[j] = cell[j].getContents()+"~";
					}
					else
					{
						insertbuff[j] = insertbuff[j]+ cell[j].getContents()+"~";
					}
				System.out.println("insertbuff["+j+"] "+insertbuff[j]);
					out.println("<td class=blue align='left' nowrap>" + cell[j].getContents() + "</td>");
			}
			out.println("</tr>");
			if(rowcount%20==0)
			{
				irow="20";
			%>
			<wtc:service name="sb558init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
        	<wtc:param value="<%=sysAccept%>"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=searchType%>"/>
        	<wtc:param value="<%=optType%>"/>
        	<wtc:param value="<%=dsmpType%>"/>
        	<wtc:param value="<%=sheetno%>"/>
        	<wtc:param value="<%=feefile%>"/>
        	<wtc:param value="<%=irow%>"/>
        	<wtc:param value="<%=feeunit%>"/>
        	<wtc:param value="<%=balprop%>"/>
        	<wtc:param value="<%=insertbuff[0]%>"/>
        	<wtc:param value="<%=insertbuff[1]%>"/>
        	<wtc:param value="<%=insertbuff[2]%>"/>
        	<wtc:param value="<%=insertbuff[3]%>"/>
        	<wtc:param value="<%=insertbuff[4]%>"/>
        	<wtc:param value="<%=insertbuff[5]%>"/>
        	<wtc:param value="<%=insertbuff[6]%>"/>
        	<wtc:param value="<%=insertbuff[7]%>"/>
        	<wtc:param value="<%=insertbuff[8]%>"/>
        	<wtc:param value="<%=insertbuff[9]%>"/>
        	<wtc:param value="<%=insertbuff[10]%>"/>
        	<wtc:param value="<%=insertbuff[11]%>"/>
        	<wtc:param value="<%=insertbuff[12]%>"/>
        	<wtc:param value="<%=insertbuff[13]%>"/>
        	<wtc:param value="<%=insertbuff[14]%>"/>
        	<wtc:param value="<%=insertbuff[15]%>"/>
        	<wtc:param value="<%=insertbuff[16]%>"/>
				</wtc:service>
				<wtc:array id="retList" scope="end"/>
			<%
				errCode = retCode1;
				errMsg = retMsg1;
				for(int z=0;z<insertbuff.length;z++)
				{
					insertbuff[z] = "";
				}
				if(!errCode.equals("000000"))
				{
					%>
					<script language="JavaScript">
					rdShowMessageDialog("读取EXCEL表失败!(<%=errMsg%>)",0);
					history.go(-1);
					</script>
					<%
					break;
				}
			}
		}
		if(insertbuff[0]!=""&&errCode.equals("000000"))
		{
		 	irow = ""+(rowcount)%20;
			%>
			<wtc:service name="sb558init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2" >
        	<wtc:param value="<%=sysAccept%>"/>
        	<wtc:param value="<%=workNo%>"/>
        	<wtc:param value="<%=searchType%>"/>
        	<wtc:param value="<%=optType%>"/>
        	<wtc:param value="<%=dsmpType%>"/>
        	<wtc:param value="<%=sheetno%>"/>
        	<wtc:param value="<%=feefile%>"/>
					<wtc:param value="<%=irow%>"/>
					<wtc:param value="<%=feeunit%>"/>
        	<wtc:param value="<%=balprop%>"/>	
        	<wtc:param value="<%=insertbuff[0]%>"/>
        	<wtc:param value="<%=insertbuff[1]%>"/>
        	<wtc:param value="<%=insertbuff[2]%>"/>
        	<wtc:param value="<%=insertbuff[3]%>"/>
        	<wtc:param value="<%=insertbuff[4]%>"/>
        	<wtc:param value="<%=insertbuff[5]%>"/>
        	<wtc:param value="<%=insertbuff[6]%>"/>
        	<wtc:param value="<%=insertbuff[7]%>"/>
        	<wtc:param value="<%=insertbuff[8]%>"/>
        	<wtc:param value="<%=insertbuff[9]%>"/>
        	<wtc:param value="<%=insertbuff[10]%>"/>
        	<wtc:param value="<%=insertbuff[11]%>"/>
        	<wtc:param value="<%=insertbuff[12]%>"/>
        	<wtc:param value="<%=insertbuff[13]%>"/>
        	<wtc:param value="<%=insertbuff[14]%>"/>
        	<wtc:param value="<%=insertbuff[15]%>"/>
        	<wtc:param value="<%=insertbuff[16]%>"/>
				</wtc:service>
				<wtc:array id="retList" scope="end"/>
			<%
			errCode = retCode1;
			errMsg = retMsg1;
			for(int z=0;z<insertbuff.length;z++)
			{
				insertbuff[z] = "";
			}
			if(!errCode.equals("000000"))
			{
				%>
				<script language="JavaScript">
					rdShowMessageDialog("读取EXCEL表失败!(<%=errMsg%>)",0);
					history.go(-1);
				</script>
				<%
			}
		}
    %>    
</table>
	<FORM method=post name="frmb558Cfm">
		<input type="hidden" name="sysAccept" value="<%=sysAccept%>">
    <input type="hidden" name="workNo" value="<%=workNo%>">
    <input type="hidden" name="searchType" value="<%=searchType%>">
    <input type="hidden" name="optType" value="<%=optType%>">
    <input type="hidden" name="dsmpType" value="<%=dsmpType%>">
    <input type="hidden" name="sheetno" value="<%=sheetno%>">
    <input type="hidden" name="feefile" value="<%=sSaveName%>">
    <input type="hidden" name="dsmpName" value="<%=dsmpName%>">
    <input type="hidden" name="dsmpNamecheck" value="<%=dsmpNamecheck%>">
	 	<table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
			 <tr>
	        <td id="footer">
	            &nbsp; <input class="b_foot" name=Button1 type="button" onClick="doCheck()" value=确定导入>
	            &nbsp; <input class="b_foot" name=back onClick="gohome()" type=button value=返回>
	        </td>
	    </tr>
		</TABLE>
	  <%@ include file="/npage/include/footer.jsp" %>
		<jsp:include page="/npage/common/pwd_comm.jsp"/>
	</FORM>
</BODY>