<%
    /********************
     version v2.0
     开发商: si-tech
     *
     * update:zhanghonga@2008-08-15 页面改造,修改样式
     * 
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<!-- ningtn 2011-7-18 18:26:15 -->
<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<!-- yuanqs add 2010/8/31 2010/8/31 18:45:38 详单加水印_设置浏览器打印背景 begin -->
<script language="VBScript">
dim hkey_root,hkey_path,hkey_key,doPrint,RegWsh
hkey_root="HKEY_CURRENT_USER"
hkey_path="\Software\Microsoft\Internet Explorer"
doPrint="yes"

Set RegWsh =CreateObject("WScript.Shell")

//设置打印背景图片
//on error resume next
hkey_key=hkey_root+hkey_path+"\Main\Print_Background"
//MsgBox hkey_key
RegWsh.RegWrite hkey_key,doPrint
//关闭RegWsh
set RegWsh=nothing
</script>
<!-- yuanqs add 2010/8/31 2010/8/31 18:45:49 详单加水印_设置浏览器打印背景 end -->
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    	
    String[][] result = new String[][]{};
    boolean billCanView = false;
    int slowcust = 0;

    int iErrorNo = 0;
    String sErrorMessage = "";
%>

<%!
    private static HashMap cfgMap = new HashMap(200);//缓存话单格式
    private static String CGI_PATH = "";
    private static String DETAIL_PATH = "";

    static {
        //从公共配置文件中读取配置信息，此信息被多sever共享
        CGI_PATH = SystemUtils.getConfig("CGI_PATH");
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CGI_PATH" + CGI_PATH);
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DETAIL_PATH" + DETAIL_PATH);
        //如果不以"/"格式结束,加上"/"
        if (!CGI_PATH.endsWith("/")) {
            CGI_PATH = CGI_PATH + "/";
            DETAIL_PATH = DETAIL_PATH + "/";
        }
    }
%>
<%
    String workNo = (String)session.getAttribute("workNo");  //工号 6 
    String workPassword = (String)session.getAttribute("password"); // 工号密码 6
    String phoneNo = request.getParameter("phoneNo");        //手机号码 20的 
    String broadPhone = request.getParameter("broadPhone");  //宽带账号
    String passWord = request.getParameter("passWord");        //查询密码
    String enPass = Encrypt.encrypt(passWord);				//加密后密码 yuanqs add 100820 密码改造需求
    String qryType = request.getParameter("qryType");        //详单类型
    String qryName = request.getParameter("qryName");        //详单类型
    String billBegin = request.getParameter("beginTime");    //开始时间
    String billEnd = request.getParameter("endTime");        //结束时间
    String in_towPassWord = request.getParameter("towPassWord");//二次密码
    String searchType = request.getParameter("searchType");//查询类型
    String searchTime = request.getParameter("searchTime");//出帐年月
    String ip = request.getRemoteAddr();//获取操作员IP地址 yuanqs add 2010/9/6 15:27:46 详单加水印需求
    String billTime = billBegin + "^" + billEnd + "^";     //时间串

    if (searchType.equals("1")) {
        billTime = searchTime;
    }

    String predictionNO="0";                     //流失号
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //当前时间
    String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    String custName = "";       //客户名词	
    String outFile = "";

    //是否有二次密码
    boolean haveTwoPassWord = false;
    //用户输入的二次密码是否与返回值相同
    boolean isTwoPassWordTrue = false;

    String twoPassWord = "";

    String[] inParas = new String[]{""};
    inParas[0] = "select b.cust_name, a.cust_id, a.user_passwd from dCustMsg a, dCustDoc b where a.phone_no not in (select phone_no from dServiceCtl) and a.cust_id = b.cust_id and substr(run_code,2,1) < 'a' and a.phone_no = '" + phoneNo + "'";
    System.out.println("inParas[0]=" + inParas[0]);
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>"  outnum="3">
		<wtc:sql><%=inParas[0]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="sVerifyTypeArr" scope="end" />
<%
   // yuanqs add 100820 密码改造需求 begin
    boolean haveCustName = true;

    if (false) 
    {
    System.out.println("--11111111111--------diling-----------sErrorMessage="+sErrorMessage);
    %>
    	<script language="JavaScript">
    		function doCheckPwd(packet) {
				var retResult = packet.data.findValueByName("retResult");
				var msg = packet.data.findValueByName("msg");
				if (retResult != "000000") {
					rdShowMessageDialog(msg);
					window.location="f1526_1.jsp?activePhone=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
				}
			}
    		var checkPwd_Packet = new AJAXPacket("/npage/public/pubCheckPwd.jsp","正在进行密码校验，请稍候......");
			checkPwd_Packet.data.add("custType","01");				//01:手机号码 02 客户密码校验 03帐户密码校验
			checkPwd_Packet.data.add("phoneNo","<%=phoneNo%>");		//移动号码,客户id,帐户id
			checkPwd_Packet.data.add("custPaswd","<%=enPass%>");	//用户/客户/帐户密码
			checkPwd_Packet.data.add("idType","en");				//en 密码为密文，其它情况 密码为明文
			checkPwd_Packet.data.add("idNum","");					//传空
			checkPwd_Packet.data.add("loginNo","<%=workNo%>");		//工号
			core.ajax.sendPacket(checkPwd_Packet, doCheckPwd, false);
			checkPwd_Packet=null;
    	</script>
    <%
// yuanqs add 100820 密码改造需求 end
      /* if (passWord != null) {
				String tcust_passwd = "";
				try{
					tcust_passwd =  Encrypt.encrypt(passWord);
				}catch(IllegalArgumentException e){
		    }
		
		    String cust_name = sVerifyTypeArr[0][0];	   
		    String cust_id = sVerifyTypeArr[0][1];
		    String cust_passwd = sVerifyTypeArr[0][2];
        
		    if (1 == Encrypt.checkpwd2(cust_passwd,tcust_passwd)) {
		      haveCustName = true;    
		    } else {
		      sErrorMessage = "查询密码不正确，请重新输入！";    
		    }
		} else {
		     haveCustName = true;
		}*/
    } else {
      System.out.println("---2222222222-------diling-----------sErrorMessage="+sErrorMessage);
        sErrorMessage = "该用户不存在，请重新输入！";
    }

    if (haveCustName) {
    System.out.println("---3333333333-------diling-----------sErrorMessage="+sErrorMessage);
        String[] inParass = new String[2];
        inParass[0] = phoneNo;
        inParass[1] = workNo;

        //是否有权限
        //callRemoteResultValue = viewBean.callService("0", null, "s1510_writeopr", "3", inParass);
%>
				<wtc:service name="s1510_writeopr" routerKey="phone" routerValue="<%=phoneNo%>" outnum="3" >
				<wtc:param value="<%=inParass[0]%>"/>
				<wtc:param value="<%=inParass[1]%>"/>
				</wtc:service>
				<wtc:array id="s1510_writeoprArr" scope="end"/>
<%
        iErrorNo = retCode==""?999999:Integer.parseInt(retCode);
        sErrorMessage = retMsg;

        if (iErrorNo == 0) {
            result = s1510_writeoprArr;
            if (result != null) {
                if (in_towPassWord != null) {
                    //取得二次密码
                    twoPassWord = result[0][2];
                    if (!twoPassWord.equals("")) {
                        //验证二次密码
                        haveTwoPassWord = true;

                        if (haveTwoPassWord) {
                            in_towPassWord = Encrypt.encrypt(in_towPassWord.trim());
                            isTwoPassWordTrue = (1 == Encrypt.checkpwd2(in_towPassWord.trim(), twoPassWord.trim()));
                            if (isTwoPassWordTrue) {
                                billCanView = true;
                            }
                        }
                    } else {
                        billCanView = true;
                    }
                } else {
                    billCanView = true;
                }
            }
        }
    }

  System.out.println("---44444444444-------diling-----------sErrorMessage="+sErrorMessage);
    int icount = 0;
    String tline = null;
    File temp = null;
    if (billCanView) {
        inParas = new String[17];
        inParas[0] = phoneNo;

        //是否为超低端用户
				//callRemoteResultValue = viewBean.callService("0", null, "slowcust", "1", inParas);
%>
				<wtc:service name="slowcust" routerKey="phone" routerValue="<%=phoneNo%>" outnum="1" >
				<wtc:param value="<%=inParas[0]%>"/>
				</wtc:service>
				<wtc:array id="slowcustArr" scope="end"/>
<%

        slowcust = retCode==""?999999:Integer.parseInt(retCode);
				System.out.println("###################fGetQryZ.jsp->slowcust->"+slowcust+"&CGI_PATH->"+CGI_PATH+"&DETAIL_PATH->"+DETAIL_PATH);
				
				
        try {
            /* ningtn 铁通宽带 */
        		String kshString = "";
        		String paramterString = "";
        		String exePath = "";
        		System.out.println("~~~~~~~~~~~~~~~~~~ " + opCode);
        		if("e155".equals(opCode)){
	            /* 宽带详单 */
	            kshString = CGI_PATH + "linkprint.sh" + " ";
	            paramterString = "0" + " " + "01" + " " + opCode + " " +
	            								workNo + " " + workPassword + " " + phoneNo + " " +
	            								passWord + " " + broadPhone + " " + passWord + " " +
	            								qryType  + " " + searchType + " " + billTime + " " +
	            								dateStr  + " " + "26 ";
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + kshString + paramterString + DETAIL_PATH + outFile + " " + "1" + " "+passWord;
            }else{
            	/* 普通电话详单 */
         
	            //程序路径,参数，文件名
	            kshString = CGI_PATH + "cp.sh" + " ";
	            paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " " + dateStr + " " + "26 ";
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + CGI_PATH + "cp.sh " + paramterString + DETAIL_PATH + outFile + " " + "1" + " "+passWord;
            }
            System.out.println("###################fGetQryZ.jsp->kshString->"+kshString+"&paramterString->"+paramterString+"&outFile->"+outFile);
            System.out.println("######################exePath" + exePath);
            
            Runtime.getRuntime().exec(exePath);

        } catch (Exception ioe) {
            ioe.printStackTrace();
            
            System.out.println("---55555555555-------diling-----------sErrorMessage="+sErrorMessage);
%>
			<script language="javascript">
				rdShowMessageDialog("执行shell命令未能成功,原因:<%=ioe.getMessage()%>");
				history.go(-1);
			</script>
<%					
        }

        //得到输出文件 
        String txtPath = DETAIL_PATH;
        String totalLine = "";


        temp = new File(txtPath, outFile);
        int readCount = 0;
        while (!temp.exists() && readCount < 500) {
            Thread.sleep(1000);
            readCount++;
        }
        ;

        FileReader outFrT = new FileReader(temp);
        BufferedReader outBrT = new BufferedReader(outFrT);

        do {
            tline = outBrT.readLine();
            icount++;
        } while (tline != null);

        outBrT.close();
        outFrT.close();
    }
     //yuanqs add 2010/9/6 15:28:25 详单加水印需求
	    String str = ip + "    " + workNo;
	    String imageName = ip+workNo+".jpg";
	    String imagePath = application.getRealPath("/") + "/npage/query/img/" + imageName;
	    System.out.println(imagePath + "===============imagePath");
	    int width = 600;
			int height = 250;
			float alpha = 0.5f;
	    CreateImg.drawImage(str, imagePath, width, height, alpha);
%>

<html>
<head>
    <title> 详单查询-<%=qryName%>
    </title>
    <SCRIPT LANGUAGE="JavaScript">
        <!--
        <%if (slowcust == 242000) {%>
        rdShowMessageDialog("该用户为超低端用户，请交手续费！");
        <% } %>

        function ifprint() {
        <% if (!billCanView) { %>
        <% if (haveTwoPassWord) {%>
        <%if (!isTwoPassWordTrue) {%>
        <% if (in_towPassWord.equals("")) {%>
            rdShowMessageDialog("二次密码不能为空，请输入！");
            history.go(-1);
        <% } else {%>
            rdShowMessageDialog("二次密码输入不正确，请重新输入！");
            history.go(-1);
        <% } %>
        <% } %>
        <%} else {
          System.out.println("---666666666666-------diling-----------sErrorMessage="+sErrorMessage);
          %>
            rdShowMessageDialog("<%=sErrorMessage%>");
            history.go(-1);
        <% } %>
        <% } %>
        }

        function gohome() {
            document.location.replace("f1526_1.jsp?activePhone=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>");
        }
        //-->
    </SCRIPT>
</head>
<!-- yuanqs add 2010/9/13 11:02:01 -->
<body onload="ifprint()" onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">

<%if (billCanView) {%>
<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
    <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
    <input type="hidden" name="billBegin" value="<%=billBegin%>">
    <input type="hidden" name="billEnd" value="<%=billEnd%>">
    <input type="hidden" name="qryType" value="<%=qryType%>">
    <input type="hidden" name="qryName" value="<%=qryName%>">
    <input type="hidden" name="dateStr" value="<%=dateStr1%>">
    <input type="hidden" name="outFile" value="<%=outFile%>">
    

		<div class="title">
			<div id="title_zi">中国移动通信客户<%=qryName%>详单</div>
		</div>
		<table cellspacing="0" style="background-image:url(img/<%=imageName%>)" name="t1" id="t1">
    <%
        int lineNum = 0;
        tline = null;
        int beginLine = 0;
        int pageSize = 30;

        FileReader outFrT1 = new FileReader(temp);
        BufferedReader outBrT1 = new BufferedReader(outFrT1);

        do {
             tline = outBrT1.readLine();
		     String tlinetep = "";
		     if (tline != null) {
//System.out.println(tline);
				//added by wangdx
				if((tline.trim().equals(""))&&(lineNum == 0))
				{
System.out.println("空的话单");
					
					
					outBrT1.close();
	   				outFrT1.close();
	   				
	   				out.print("<script language=\"javascript\">") ;
	   				out.print("rdShowMessageDialog(\""); 
	   				out.print("用户话单为空！");
	   				out.println("\");");
	   				out.println("history.back(); ");	   				
	   				out.println("</script>");      
	   				return;      
	   				
				}
				else if((tline.indexOf("黑龙江")==-1)&&(lineNum==0))
				{
					System.out.println("不符合正确话单格式，说明服务里面报错了！");	
					outBrT1.close();
	   				outFrT1.close();
	   				
	   				out.print("<script language=\"javascript\">") ;
	   				out.print("rdShowMessageDialog(\""); 
	   				out.print(tline);
	   				out.println("\");");
	   				out.println("history.back(); ");	   				
	   				out.println("</script>");                 	
                  
                  return;
	   				
				}				
		        tlinetep = tline.replaceAll(" ", "&nbsp;");
		     }
		     
		     if (lineNum < beginLine + pageSize) {
		         out.println("<tr><td align='left' nowrap>" + tlinetep + "</td></tr>");
		     }
		     
		     lineNum++;
        } while (tline != null);
        outBrT1.close();
        outFrT1.close();
    %>
</table>
    <table cellspacing="0">
        <tbody>
            <tr>
                <font class="orange">
                	<% 	int allPage = 0; 
                			allPage = (icount - 1) / pageSize + ((icount - 1) % pageSize == 0 ? 0 : 1);
                	%>
                    <td> 总共有 <%=allPage%> 页，当前页为第 1
                        页
                    </td>
                    <%if (beginLine + pageSize < icount - 1) {
                    System.out.println("**********************************"+slowcust);
                    %>
                    <td><a href="fDetQry1.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>">【下一页】 </a>
                    </td>

                    <td><a href="fDetQry1.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>">【最后一页】 </a>
                    </td>
                    <%}%>
                    <td>
                    	跳转到
											<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
												<%
												for (int i = 1; i <= allPage; i ++) {
												%>
													<option value="<%=i%>">第<%=i%>页</option>
												<%
												}
												%>
											</select>
											页
                    </td>
                </font>
            </tr>
        </tbody>
    </table>
    <table cellspacing=0>
        <tbody>
            <tr>
                <td id="footer">
                    &nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  打  印  ">
                    &nbsp; <input class="b_foot" name=close onClick="removeCurrentTab();" type=button value="  关  闭  ">
                    &nbsp; <input class="b_foot" name=close onClick="gohome()" type=button value="  返  回  ">
                    <%if (slowcust == 242000) {%>
                    &nbsp; <input class="b_foot" name=fee onClick="payFee()" type=button value="  交 手 续 费  ">
                    <% } %>
                    &nbsp; <input class="b_foot" name=save onClick="savefile1()" type=button value="  保  存  ">
                    &nbsp; <input class="b_foot_long" name=save onClick="printTable(t1)" type=button value="导出当前页">
                </td>
            </tr>
        </tbody>
    </table>
    <%@ include file="/npage/include/footer.jsp" %>
</Form>

<script language="JavaScript">
    function print_detail()
    {
    		/***改成弹出窗口,配合打印页面
        document.frm1500.action = "sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
        frm1500.submit();
        return true;
        ***/
        var h = 800;
        var w = 1000;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;
        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
        var ret = window.open(path, "", prop);
    }

    function payFee() {
        document.frm1500.action = "/npage/s5061/f1295_1.jsp?phoneNo=<%=phoneNo%>&op_code=1526";
        frm1500.submit();
        return true;
    }
    //begin huangrong add for 增加保存功能 2011-5-17    
    function savefile1()
    {
    	var sFileName = document.frm1500.outFile.value;
    	var path = "fDownData1526.jsp?fileName="+sFileName+"&sFilePath=<%=DETAIL_PATH%>";
      var ret = window.open(path);
    }
    //end huangrong add for 增加保存功能 2011-5-17    
    function setPage(goPage){
			if (goPage == "-1") {
				return;
			} else{
				var pageSizeVal = "<%=pageSize%>";
				var beginLineVal = pageSizeVal * (goPage - 1);
				var dirtPate = "fDetQry1.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=" + beginLineVal + "&phoneNo=<%=phoneNo%>&broadPhone=<%=broadPhone%>&opCode=<%=opCode%>&opName=<%=opName%>";
				location = dirtPate;
			}
		}
</script>
<% } %>
</body>
</html>
