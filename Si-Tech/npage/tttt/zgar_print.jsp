<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-19 页面改造,修改样式
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%!
    private static HashMap cfgMap = new HashMap(200);//缓存话单格式
    private static String CGI_PATH = "";
    private static String DETAIL_PATH = "";

    static {
        //从公共配置文件中读取配置信息，此信息被多sever共享
        CGI_PATH = SystemUtils.getConfig("CGI_PATH");
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        System.out.println("---liujian----AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CGI_PATH" + CGI_PATH);
        System.out.println("---liujian----BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DETAIL_PATH" + DETAIL_PATH);
        //如果不以"/"格式结束,加上"/"
        if (!CGI_PATH.endsWith("/")) {
            CGI_PATH = CGI_PATH + "/";
            DETAIL_PATH = DETAIL_PATH + "/";
        }
    }
%>
<%
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String printNote = "0";
	String groupId = (String)session.getAttribute("groupId");
	String[][] favInfo = (String[][])session.getAttribute("favInfo");   //数据格式为String[0][0]---String[n][0]
	int infoLen = favInfo.length;
    String tempStr = null;
    for (int i = 0; i < infoLen; i++) {
        tempStr = (favInfo[i][0]).trim();
        if (tempStr.equals("a092")) printNote = "1";
    }
    //路由
	String regionCode = org_code.substring(0,2);
	//s_kpxm="++"%="++"&="+s_jsheje+"&="+s_hjse+"&="+s_xmmc+"&="+s_ggxh+"&="+s_hsbz+"&="+s_xmdj+"&="+s_xmje+"&="+s_sl+"&="+s_se;
	String s_kpxm = request.getParameter("s_kpxm");
	String s_ghmfc  = request.getParameter("s_ghmfc");
	String s_jsheje  = request.getParameter("s_jsheje");
	String s_hjse = request.getParameter("s_hjse");
 
	String s_hsbz = request.getParameter("s_hsbz");
 
	String s_xmje  = request.getParameter("s_xmje");
 
    System.out.println("ffffffffffffffffffffffffffff test dzfp s_kpxm is "+s_kpxm);
	String payaccept = WtcUtil.repNull(request.getParameter("payaccept"));
	String op_code= WtcUtil.repNull(request.getParameter("op_code"));
	String phone_no= WtcUtil.repNull(request.getParameter("phone_no"));
	String pay_note= WtcUtil.repNull(request.getParameter("pay_note"));
	String id_no= WtcUtil.repNull(request.getParameter("id_no"));
	String sm_code= WtcUtil.repNull(request.getParameter("sm_code"));
	String s_xmmc= WtcUtil.repNull(request.getParameter("s_xmmc"));
	String xmdw= WtcUtil.repNull(request.getParameter("xmdw"));
	String s_ggxh= WtcUtil.repNull(request.getParameter("s_ggxh"));
	String xmsl= WtcUtil.repNull(request.getParameter("xmsl"));
	String hsbz= WtcUtil.repNull(request.getParameter("s_hsbz"));
	String s_xmdj= WtcUtil.repNull(request.getParameter("s_xmdj"));
	String s_sl= WtcUtil.repNull(request.getParameter("s_sl"));
	String s_se= WtcUtil.repNull(request.getParameter("s_se"));
	String chbz= WtcUtil.repNull(request.getParameter("chbz"));
	String old_accept= WtcUtil.repNull(request.getParameter("old_accept"));
	String old_ym= WtcUtil.repNull(request.getParameter("old_ym"));
	String contract_no= WtcUtil.repNull(request.getParameter("contract_no"));
	String kphjje= WtcUtil.repNull(request.getParameter("kphjje"));
	String hjbhsje= WtcUtil.repNull(request.getParameter("hjbhsje"));
	String hjse= WtcUtil.repNull(request.getParameter("hjse"));
	String contractno =  WtcUtil.repNull(request.getParameter("contractno"));
	String returnPage = WtcUtil.repNull(request.getParameter("returnPage"));
	String[] inPara_sj = new String[29];
	String file_name="test_haha.txt";//写死的
 	String outPath="";
    String out_file="";
    String exePath = "";
	File temp1 = null;
	int secNum=0;
	inPara_sj[0]=payaccept;
	inPara_sj[1]="01";
	inPara_sj[2]=op_code;
	inPara_sj[3]=workNo;
	inPara_sj[4]=nopass;
	inPara_sj[5]=phone_no;
	inPara_sj[6]="";
	inPara_sj[7]=pay_note;
	inPara_sj[8]="";//操作时间
	inPara_sj[9]=id_no;
	inPara_sj[10]=sm_code;
	inPara_sj[11]="e";
	inPara_sj[12]="";
	inPara_sj[13]="";
	inPara_sj[14]=s_xmmc;
	inPara_sj[15]=xmdw;
	inPara_sj[16]=s_ggxh;
	inPara_sj[17]=xmsl;
	inPara_sj[18]=hsbz;
	inPara_sj[19]=s_xmdj;
	inPara_sj[20]=s_sl;
	inPara_sj[21]=s_se;//税率 税额 啥的得等hanfeng确认
	inPara_sj[22]=chbz;
	inPara_sj[23]=old_accept;
	inPara_sj[24]=old_ym;
	inPara_sj[25]=contractno;
	inPara_sj[26]=kphjje;
	inPara_sj[27]=hjbhsje;//税率 税额得确认
	inPara_sj[28]=hjse;
	
%>	 
 <wtc:service name="bs_sEInvIssue" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes" retmsg="sMsgs" outnum="2"  >
		<wtc:param value="<%=inPara_sj[0]%>"/>
		<wtc:param value="<%=inPara_sj[1]%>"/>
		<wtc:param value="<%=inPara_sj[2]%>"/>
		<wtc:param value="<%=inPara_sj[3]%>"/>
		<wtc:param value="<%=inPara_sj[4]%>"/>
		<wtc:param value="<%=inPara_sj[5]%>"/>
		<wtc:param value="<%=inPara_sj[6]%>"/>
		<wtc:param value="<%=inPara_sj[7]%>"/>
		<wtc:param value="<%=inPara_sj[8]%>"/>
		<wtc:param value="<%=inPara_sj[9]%>"/>
		<wtc:param value="<%=inPara_sj[10]%>"/>
		<wtc:param value="<%=inPara_sj[11]%>"/>
		<wtc:param value="<%=inPara_sj[12]%>"/>
		<wtc:param value="<%=inPara_sj[13]%>"/>
		<wtc:param value="<%=inPara_sj[14]%>"/>
		<wtc:param value="<%=inPara_sj[15]%>"/>
		<wtc:param value="<%=inPara_sj[16]%>"/>
		<wtc:param value="<%=inPara_sj[17]%>"/>
		<wtc:param value="<%=inPara_sj[18]%>"/>
		<wtc:param value="<%=inPara_sj[19]%>"/>
		<wtc:param value="<%=inPara_sj[20]%>"/>
		<wtc:param value="<%=inPara_sj[21]%>"/>
		<wtc:param value="<%=inPara_sj[22]%>"/>
		<wtc:param value="<%=inPara_sj[23]%>"/>
		<wtc:param value="<%=inPara_sj[24]%>"/>
		<wtc:param value="<%=inPara_sj[25]%>"/>
		<wtc:param value="<%=inPara_sj[26]%>"/>
		<wtc:param value="<%=inPara_sj[27]%>"/>
		<wtc:param value="<%=inPara_sj[28]%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
<%
	//bill_cancel[0][0]="000000";
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		if(bill_cancel[0][0]=="000000" ||bill_cancel[0][0].equals("000000"))
		{
			//pdf生成
			try
			{
				//shell begin
			   outPath="/iwebd2/applications/DefaultWebApp/cgi_bin/";
			   out_file=outPath+file_name;
			   temp1 = new File(out_file);
			   exePath = "/usr/bin/ksh " + CGI_PATH + "cli_test.sh";
			   Runtime.getRuntime().exec(exePath);
			   System.out.println("ccccccccccccccccccccccccccccccccccccccccccccc out_file is "+out_file);	
			   while(true) 
			   {
					System.out.println("ttttttttttttttttttttttttttttttt");
					//如果文件不存在，等待10秒钟
					if(!temp1.exists()) {
						if(secNum >= 30) {
							System.out.println("--fffffffffffffffffffffffffffffffffffffffffff--" + temp1.exists());
							break;
						}else {
							secNum++;
							Thread.sleep(1000);
							System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh secNum is "+secNum);
						}
					} 
					else
				    {
						break;
					}		
				}
			}
			catch (Exception ioe) {
				ioe.printStackTrace();
	%>
				<script language="javascript">
					rdShowMessageDialog("执行shell命令未能成功,原因:<%=ioe.getMessage()%>");
					history.go(-1);
				</script>
	<%					
			}
			//end shell
			//String file_name="test.txt";//"testtes1";//发票号码+发票代码
			String file_path=request.getRealPath("");
			//String filenameIn=file_path+"/txt_tmp/"+file_name;//"/xuxz.txt";
			String filenameIn=out_file;
			String filenameOut=file_path+"/pdf_tmp/"+file_name+".pdf";
			System.out.println("cccccccccccccccccccccccccccccc filenameOut is "+filenameOut+" and filenameIn is "+filenameIn);
			File file=new File(filenameIn);
			BufferedReader br=new BufferedReader(new FileReader(file));
			String temp=null;
			StringBuffer sb=new StringBuffer();
			temp=br.readLine();
			while(temp!=null)
			{
			   sb.append(temp+" ");
			   temp=br.readLine();
			}
			//System.out.println("test is "+sb.toString());
			//System.out.println("111");
			FileOutputStream fileOutputStream;
			try {
				fileOutputStream = new FileOutputStream(new File(filenameOut));
				byte[] byte_pdf = org.apache.axis.encoding.Base64.decode(sb.toString());
				fileOutputStream.write(byte_pdf);
				fileOutputStream.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			%>
			<html>
				<META http-equiv=Content-Type content="text/html; charset=GBK">
				<BODY>
						<NOSCRIPT>
							Cannot determine if you have Acrobat Reader (or the full Acrobat)
							installed <FONT size="-1">(because JavaScript is unavailable or 
							turned off)</FONT>.
						</NOSCRIPT>
						<DIV id="IfNoAcrobat" style="display:none">
							你需要先安装Adobe Reader才能正常浏览文件，请点击这里下载Adobe Reader.
						</DIV>
					<div>
						<object classid="clsid:CA8A9780-280D-11CF-A24D-444553540000" id="Pdf1" width="100%" height="120%">   
						  <param name="_Version" value="327680"> 
						  <param name="_ExtentX" value="2646">   
						  <param name="_ExtentY" value="1323">   
						  <param name="_StockProps" value="0">   
						  <param name="SRC" value="../../pdf_tmp/<%=file_name%>.pdf">
						</object>   
					</div>
				</BODY>
			 
		</html>
			<%
		}
		else
		{
			%>
				<script language="javascript">
					rdShowMessageDialog("电子发票打印失败!错误代码:"+"<%=sCodes%>"+",错误原因:"+"<%=sMsgs%>");
					document.location.replace("<%=returnPage%>");
				</script>
			<%
		}	
	}
	else
	{
		%>
			<script language="javascript">
				rdShowMessageDialog("服务调用异常！");
				document.location.replace("<%=returnPage%>");
			</script>
		<%
	}
%>

 
 

	
 
