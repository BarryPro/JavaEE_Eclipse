<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by wanglm @ 20110225
 ********************/
%>
<% request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="com.jspsmart.upload.*"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
		String opCode=request.getParameter("opCode");	
		String opName=request.getParameter("opName");
		
    String loginNo = (String)session.getAttribute("workNo");
    String regionCode=(String)session.getAttribute("regCode");
    String passWord = (String)session.getAttribute("password");
    String ip = request.getRemoteAddr();
    System.out.println("=========================ip==================   "+ip);
    String moneys="";
  	String numss="";

			/* 使用文件上传 */
%>
			<wtc:sequence name="sPubSelect" key="sMaxSysAccept" 
				 routerKey="region" routerValue="<%=regionCode%>"  id="seq"/>
<%
			/* 拼接文件名 */
				String iErrorNo ="";
				String sErrorMessage = " ";
				String sysAccept = "";
				String filename="";
				sysAccept = seq;
			    System.out.println("# fe121.jsp  @@@@@@@@@@     - 流水："+sysAccept);
			    filename = regionCode + sysAccept + ".txt";
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
					alert("只允许上传.txt类型文本文件");
					window.location="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
				}
				try{ 
					com.jspsmart.upload.File myFile = mySmartUpload.getFiles().getFile(0);
					if (myFile.isMissing()){
%>
					<SCRIPT language=javascript>
					alert("请先选择要上传的文件");
					window.location="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
					</script>
<%
					}else{
						myFile.saveAs(sSaveName,SmartUpload.SAVE_PHYSICAL);
					}
				}catch (Exception e){
					System.out.println(e.toString()); 
%>
					<SCRIPT language=javascript>
					alert("<%=e.toString()%>");
					window.location="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
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

<wtc:service name="s3075InitBat" routerKey="region" routerValue="<%=regionCode%>" 
	 retcode="Code" retmsg="Msg" outnum="4" >
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value="<%=filename%>"/>
        <wtc:param value="1"/>
</wtc:service>
<wtc:array id="ret" scope="end"/>

<%
System.out.println("=========================Code================================   "+Code);
String retcode = Code;
String retmsg = Msg;
if(retcode.equals("000000")){

	if(ret.length>0) {
		 moneys=ret[0][2];
		 numss=ret[0][3];
	}
	

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">
<script language="javascript">
	function goback(){
		window.location = "fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
	
	function doCommit()
		{
								
		    var  ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");

		     if(typeof(ret)!="undefined"){
        if((ret=="confirm")){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          			document.all.quchoose.disabled=true;
            		document.form.action="fm240Commit.jsp";
		            form.submit();
          }
        }
        if(ret=="continueSub"){
          if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          			document.all.quchoose.disabled=true;
            		document.form.action="fm240Commit.jsp";
		            form.submit();
          }
        }
      }else{
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
        				document.all.quchoose.disabled=true;	
            		document.form.action="fm240Commit.jsp";
		            form.submit();
        }
      }

		      
		}
		
		 function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框
			var pType="print";                     // 打印类型print 打印 subprint 合并打印
		    var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = "";                           //客户电话

		   	var h=150;
		   	var w=350;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {
			    var count=$("#infilling_number").val();
			    var count1=$("#infilling_price").val();
			         		
		        var cust_info=""; //客户信息
		      	var opr_info=""; //操作信息
		      	var retInfo = "";  //打印内容
		      	var note_info1=""; //备注1
		      	var note_info2=""; //备注2
		      	var note_info3=""; //备注3
		      	var note_info4=""; //备注4

				cust_info+=" "+"|";
				opr_info+="业务类型:<%=opName%>            业务流水：<%=sysAccept%>"+"|";
				opr_info+="业务受理时间：" + "<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>" +  "|";
				opr_info+="有价卡张数:"+count+"            总金额："+count1+"|";

	 			note_info1+=""+"|";

				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

	    	    return retInfo;
		  }
		  
		
</script>
</head>
<body>
<form name="form" id="form" method="POST">
<%@ include file="/npage/include/header.jsp" %>
	<div>
	<div class="title">
		<div id="title_zi">批量导入</div>
	</div>
	<table cellspacing="0">

       	        	  
       	        	<tr>

			        		<td width=16% class="blue">是否刮卡</td>

			        		<td width=34% >
                       <select id="isgua" name="isgua">
                       	<option value="0">已刮</option>
                       	<option value="1">未刮</option>
                       </select>
			        		</td>
			        		<td width=16% class="blue">是否充值</td>

			        		<td width=34% >
                       <select id="ischong" name="ischong">
                       	<option value="2">已充</option>
                       	<option value="3">未充</option>
                       </select>
			        		</td>
			        		
        				</tr>
        				
        				   <tr>
                  <td width="16%" class="blue"> 有价卡张数</td>
                  <td>
                     <input type="text" readonly id="infilling_number" name="infilling_number" value="<%=numss%>" size="14" class=InputGrey >
                  </td>
                  <td width="16%" class="blue"> 总金额 </td>
                  <td>
                      <input type="text" readonly id="infilling_price" name="infilling_price" value="<%=moneys%>" size="14" class=InputGrey>
                  </td>
         

                </tr>
                
        				

	</table>
	<table>
  <tr>
  	<td id="footer" colspan="4">
  		<input  name="quchoose" id="quchoose" class="b_foot" type=button value=确认&打印  onclick="doCommit()" >
  		<input type="button" name="back" class="b_foot" value="返回" onClick="goback()"  >
  	</td>
  </tr>
  </table>
	</div>
		<input type="hidden" name="opflag" value="1">
		<input type="hidden" name="filenamess" value="<%=filename%>">
		<input type="hidden" name="sysAccept" value="<%=sysAccept%>"> 
		<input type="hidden" name="opCode" value="<%=opCode%>">
	  <input type="hidden" name="opName" value="<%=opName%>">
    <%@ include file="/npage/include/footer.jsp"%>
   </form>
</body>
<%
} else {
	%>
	<script language="javascript">
		rdShowMessageDialog("校验卡号失败！错误代码：<%=retcode%>，错误信息：<%=retmsg%>" ,0);

		window.location.href="fm240.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	</script>
	<%
}
%>