<%
  /* 
   * 功能: 批量恢复客户语音功能读取上传文件的数据
   * 版本: 1.0
   * 日期: 2011/06/23
   * 作者: huangrong
   * 版权: si-tech
  */
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.jspsmart.upload.*"%>
<%
	String regionCode=(String)session.getAttribute("regCode");
  String remark=request.getParameter("remark");
  	String seled = request.getParameter("seled");
	//System.out.println("seed====="+seled);
	int	flag=0;
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>	
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				sysAccept = seq;				
		    String filename=regionCode+sysAccept+".txt";
		    String sSaveName=request.getRealPath("/npage/tmp/")+"/"+filename;
				System.out.println("sSaveName:"+sSaveName);
				/* 准备上传至webloigc侧服务器 */
				SmartUpload mySmartUpload =new SmartUpload();
				mySmartUpload.initialize(pageContext);
				try {
					mySmartUpload.setAllowedFilesList("txt");//此处的文件格式可以根据需要自己修改
					//上载文件 
					mySmartUpload.upload();
				} catch (Exception e){
%>
					<SCRIPT language=javascript>
					rdShowMessageDialog("只允许上传.txt类型文本文件！");
					window.location="fd948main.jsp";
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					rdShowMessageDialog("请先选择要上传的文件！");					
					window.location="fd948main.jsp";
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					rdShowMessageDialog("<%=e.toString()%>",0);						
					window.location="fd948main.jsp";
					</script>
<%
				}
				System.out.println("==============文件上传完成==========");
				/* 读取文件，写入tuxedo侧服务器 */
				FileReader fr = new FileReader(sSaveName);
				BufferedReader br = new BufferedReader(fr);   
				String phoneText="";
				String line = null;
				String paraAray2[] = new String[2];
				paraAray2[0] = filename;
				paraAray2[1] = phoneText;
				do {
					line = br.readLine();
					if (line==null) continue;       
					if (line.trim().equals("")) continue;   
					phoneText+=line+"\n"; 
					System.out.println("==phoneText== " + phoneText);
					if (phoneText.length()>=1000){
						paraAray2[1] = phoneText;
%>
						<wtc:service name="sbatchWrite" routerKey="region" 
							 routerValue="<%=regionCode%>" 
									retcode="errCode2" retmsg="errMsg2"  outnum="2" >
						<wtc:param value="<%=paraAray2[0]%>"/>
						<wtc:param value="<%=paraAray2[1]%>"/>
						</wtc:service>
						<wtc:array id="resultArr" scope="end" />
<%
					System.out.println("==errCode2== " + errCode2);
						if(errCode2.equals("0")==false)
						{
					    flag=-1;
						}
						iErrorNo=resultArr[0][0];
						phoneText="";
					}
				}while (line!=null);        
				br.close();
				fr.close();
				paraAray2[1] = phoneText;
%>
				<wtc:service name="sbatchWrite" routerKey="region" 
					 routerValue="<%=regionCode%>" outnum="2" >
				<wtc:param value="<%=paraAray2[0]%>"/>
				<wtc:param value="<%=paraAray2[1]%>"/>
				</wtc:service>
				<wtc:array id="resultArr3" scope="end" />
<%
					System.out.println("==retCode== " + retCode);
				if(retCode.equals("0")==false)
				{
			    flag=-1;
				}
				iErrorNo=resultArr3[0][0];
%>					

<SCRIPT type=text/javascript>
	function ifprint(){
<% 
	
		if(flag==0){
%>
		frm_print_invoice.submit();
<% 
		}
		else{
%>
		rdShowMessageDialog("文件准备失败。<br>错误代码：'<%=iErrorNo%>'。<br>错误信息：'<%=sErrorMessage%>'。",0);
		history.go(-1);
<%
  	}
%>
	} 						
</SCRIPT>
<html>
	<body onload="ifprint()">
		<form action="fd948Cfm.jsp" name="frm_print_invoice" method="post">
			<INPUT TYPE="hidden" name="remark" value="<%=remark%>">
			<INPUT TYPE="hidden" name="sSaveName" value="<%=sSaveName%>">
			<INPUT TYPE="hidden" name="filename" value="<%=filename%>">
			<INPUT TYPE="hidden" name="seled" value="<%=seled%>">
		</form>
	</body>
</html>

