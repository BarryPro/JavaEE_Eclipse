<%
/********************
 * version v3.0
 * 开发商: si-tech
 * author: qidp @ 2009-05-10
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@page contentType="text/html;charset=GBK"%>
<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*"%>
<%@ include file="../../npage/common/serverip.jsp" %>

<%
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNo		= (String)session.getAttribute("workNo");
	  String loginPwd		= (String)session.getAttribute("password");
    String groupNo	    = request.getParameter("groupNo_new"); 	/*集团号*/
		String groupName    = request.getParameter("groupName");/*集团名称*/	
		String phone_nos    = request.getParameter("phone_nos");/*集团名称*/
	  String offeridxuan 		= request.getParameter("offeridxuan");/*资费id*/
	  String  opCode		= WtcUtil.repNull((String)request.getParameter("opCodess"));/*资费id*/
	  String  opName		= WtcUtil.repNull((String)request.getParameter("opName"));/*资费id*/
	  String fuwuname="";
	  if(opCode.equals("g378")) {
	  fuwuname="sg378Cfm";
	  }
	  if(opCode.equals("g380")) {
	  fuwuname="sg380Cfm";
	  }
	  String iServerIpAddr        = realip;  
	  String errPhoneList = "";
    String errMsgList   = "";
%>

<%try{
		SmartUpload mySmartUpload = new SmartUpload();
        mySmartUpload.initialize(pageContext);
		mySmartUpload.setMaxFileSize(2*1024*1024); 

        mySmartUpload.upload();
		com.jspsmart.upload.Files myfiles = mySmartUpload.getFiles();
		String iSmCode = mySmartUpload.getRequest().getParameter("sm_code");
		String sysAccept = mySmartUpload.getRequest().getParameter("sysAccept");
		System.out.println("######## sysAccept = "+sysAccept);
		System.out.println("iiiiiiiiiiiiiiiiiiiiiiiSmCode = "+iSmCode);
		//String filename = iSmCode+new SimpleDateFormat("yyyyMMddHHmmss",Locale.getDefault()).format(new Date());
		String filename = iSmCode+sysAccept;
		String path = request.getRealPath("/npage/tmp/");
		String sSaveName = path+"/"+filename;
        java.io.File fileNew = new java.io.File(path);  
        if(!fileNew.exists())  
            fileNew.mkdirs();   
		System.out.println("kkkkkkkkkkkkkkkkkkkkk");

		String flag="";
		String book_name="";
		String iInputFile = "";

		System.out.println("========================================"+myfiles.getCount());
			if(myfiles.getCount()>0)
				{
				for(int i=0;i<myfiles.getCount();i++){
				com.jspsmart.upload.File myFile = myfiles.getFile(i);  
					if(myFile.isMissing()){
    					System.out.println("file ["+(i+1)+"] is null!");
    					continue;
					}
					String fieldName = myFile.getFieldName();
					int fileSize = myFile.getSize();
					book_name=myFile.getFileName();
					System.out.println("上传文件:" + sSaveName + "\n");
					iInputFile = sSaveName;
					myFile.saveAs(iInputFile);
					System.out.println("file ["+(i+1)+"] save!");
					
					try{
        				FileInputStream fis = new FileInputStream(iInputFile);    
        				DataInputStream dis = new DataInputStream(fis); 
        				byte b;
        				int data;
        				int count=0;
        				for(count=0; (count < 2 && count < dis.available()); count++)
        				{
        					b=dis.readByte();
        					System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb--"+b);
        					data = b - '0';
        					System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb--"+data);
        					if( data >= 0 && data <= 9)
        					{
        						System.out.println(" b = ["+b+ "]");
        					}
        					else
        					{
        					    flag = "error";
        						throw new Exception("文件格式不正确");
        					}
        				}
        				dis.close(); 
        				fis.close(); 
        			}catch(IOException e){
        			    e.printStackTrace();
        			    flag = "error";
        				System.out.println("文件不存在");
        				%>
            				<script>
                                rdShowMessageDialog('文件不存在!',0);
                                parent.doUnLoading();
                            </script>
            			<%
        			}catch(Exception e){
        			    e.printStackTrace();
        			    flag = "error";
        			%>
        				<script>
                            rdShowMessageDialog('文件格式不正确,必须是txt文本文件！',0);
                            parent.doUnLoading();
                        </script>
        			<%
        			}
				}
			}
	
System.out.println("--------------iInputFile======"+iInputFile);
if(!"error".equals(flag)){
%>
		<wtc:service name="<%=fuwuname%>"  outnum="2"
			routerKey="region" routerValue="<%=regionCode%>"  
			retcode="addRstCode" retmsg="addRstMsg"  >
			<wtc:param value="0"/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=loginPwd%>"/>
			<wtc:param value="<%=phone_nos%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=groupNo%>"/>
			<%if(opCode.equals("g378")) {%>
			<wtc:param value="<%=groupName%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=offeridxuan%>"/>
				<%}%>
			<wtc:param value="0"/>
			<wtc:param value="<%=iInputFile%>"/>
			<wtc:param value="<%=iServerIpAddr%>"/>
	
		</wtc:service>
		<wtc:array id="g378Rst" scope="end" />
			

<%
        if("000000".equals(addRstCode)){
             errPhoneList = g378Rst[0][0];
             errMsgList   = g378Rst[0][1];
             
					    StringTokenizer stPhone = new StringTokenizer(errPhoneList,"|");
					    String[] errPhoneArr = new String[stPhone.countTokens()];
					    int i = 0;   
					    while(stPhone.hasMoreTokens()){
					        errPhoneArr[i++] = stPhone.nextToken();
					    }
					    System.out.println("------------------errPhoneArr--------------------------"+errPhoneArr.length);
					    
					    StringTokenizer stMsg = new StringTokenizer(errMsgList,"|");
					    String[] errMsgArr = new String[stMsg.countTokens()];
					    int j = 0;
					    while(stMsg.hasMoreTokens()){
					        errMsgArr[j++] = stMsg.nextToken();
					    }
             %>
<html>
<BODY>
<form name="frm" action="" method="post" >
	<div id="t22">
<div id="Main">

   <DIV id="Operation_Table"> 
<div class="title">
	<div id="title_zi">未成功号码列表</div>
</div>

<TABLE cellSpacing="0" id="t1">
    <TR>
        <TH width='50%' align='center'><%if(opCode.equals("g378")) {%>未添加成功号码列表<%}else{%>未退出成功号码列表<%}%></TH>
        <TH width='50%'>失败原因</TH>
    </TR>
    <%
    for (int k=0;k<errPhoneArr.length;k++)
    {
        String tdClass = "";
        if (k%2==0){
            tdClass = "Grey";
        }
    %>
        <TR>
            <TD class='<%=tdClass%>' align='center'><%=errPhoneArr[k]%></TD>
            <TD class='<%=tdClass%>'><%=errMsgArr[k]%></TD>
        </TR>
    <%
    }
    %>
</TABLE>

<TABLE cellspacing="0">
    <tr id="footer">
        <td>
            <input class="b_foot_long" name="prtxls" id="prtxls" type=button value="保存XLS文件" onclick="printTable(t1)" style="cursor:hand">

                  </td>
    </tr>
</TABLE>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</html>

             <%
        }else {
        	
        	%>
<script>
    rdShowMessageDialog('服务提交失败！错误代码<%=addRstCode%>，错误原因<%=addRstMsg%>',0);
</script>
<%
        	}
}
}catch(Exception e){
%>
<script>
    rdShowMessageDialog('文件上传失败！',0);
</script>
<%
e.printStackTrace();
}
%>
<script ="javascript">
	  function clearTable() {
  		$('#t22').css('display','none');
  		
  }
  
var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =35;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   
  sheet.Columns("A").ColumnWidth =12;//设置列宽 
  sheet.Columns("A").numberformat="@";
  sheet.Columns("B").ColumnWidth =9;//设置列宽 
  sheet.Columns("C").ColumnWidth =21;//设置列宽 
  sheet.Columns("C").numberformat="@";
  sheet.Columns("D").ColumnWidth =14;//设置列宽 
  sheet.Columns("D").numberformat="@";
  sheet.Columns("E").ColumnWidth =25;//设置列宽
  sheet.Columns("F").ColumnWidth =25;//设置列宽 
  sheet.Columns("G").ColumnWidth =10;//设置列宽 
  sheet.Columns("G").numberformat="@"; 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
window.close();
}

</script>