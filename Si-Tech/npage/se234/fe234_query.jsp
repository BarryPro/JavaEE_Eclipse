<%
    /*************************************
    * ��  ��: ��������ͨ�굥��ѯ(��) e234
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2011-8-23
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GB2312");%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>

<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<!-- �굥��ˮӡ_�����������ӡ���� begin -->
<script language="VBScript">
    dim hkey_root,hkey_path,hkey_key,doPrint,RegWsh
    hkey_root="HKEY_CURRENT_USER"
    hkey_path="\Software\Microsoft\Internet Explorer"
    doPrint="yes"
    Set RegWsh =CreateObject("WScript.Shell")

    //���ô�ӡ����ͼƬ
    //on error resume next
    hkey_key=hkey_root+hkey_path+"\Main\Print_Background"
    //MsgBox hkey_key
    RegWsh.RegWrite hkey_key,doPrint
    //�ر�RegWsh
    set RegWsh=nothing
</script>
<!-- �굥��ˮӡ_�����������ӡ���� end -->
<%
    response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
	String opCode="e234";
    String opName="��������ͨ�굥��ѯ(��)";
	int slowcust = 0;
%>
<%!
    private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
    private static String CGI_PATH = "";
    private static String DETAIL_PATH = "";
    
    static{    
        //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
        CGI_PATH = SystemUtils.getConfig("CGI_PATH");
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        //�������"/"��ʽ����,����"/"
        if(!CGI_PATH.endsWith("/")){
    		CGI_PATH=CGI_PATH+"/";
            DETAIL_PATH=DETAIL_PATH+"/"; 
        }
      }
%>
<%
    //��ȡϵͳʱ��
    Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("MMdd");
    String currentTimeString = formatter.format(currentTime);
    System.out.println("------------e234-------------currentTimeString="+currentTimeString);
    
	ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String regCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
	String[][] baseInfo = (String[][])arr.get(0);
	String workNo = baseInfo[0][2];                         //����
	String phoneNo = request.getParameter("phoneNo");		//�ֻ�����
	String passWord = request.getParameter("passWord");		//��ѯ����
    String qryType = request.getParameter("qryType");		//�굥����
	String qryName = request.getParameter("qryName");		//�굥����
	String billBegin = request.getParameter("beginTime");	//��ʼʱ��
	String billEnd = request.getParameter("endTime");		//����ʱ��
	String ip = request.getRemoteAddr();//��ȡ����ԱIP��ַ yuanqs add 2010/9/6 15:27:46 �굥��ˮӡ����
	String in_towPassWord = request.getParameter("towPassWord");//��������
    String searchType = request.getParameter("searchType");

	String searchTime = request.getParameter("searchTime");
	//out.println(searchType);
	//out.println(qryType);
	//out.println(billBegin);
	//out.println(billEnd);
	//out.println(phoneNo);
	String billTime = billBegin + "^" + billEnd + "^";     //ʱ�䴮
	if (searchType.equals("1")) {
	   billTime = searchTime;
	}

	String predictionNO = "65258723";                       //��ʧ��
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
	String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
	String custName = "";       //�ͻ�����	
    String outFile = "";
	  
	int icount = 0;
  	String tline = null;
	File temp = null;
	
	try {
    	//����·��,�������ļ���
       	String kshString = CGI_PATH + "clicp.sh" + " ";
       	String paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " " + dateStr + " " + "26 ";
       	outFile = phoneNo + qryType + dateStr1 + ".txt";
       	String exePath = "/usr/bin/ksh "+ CGI_PATH +"clicp.sh " + paramterString + DETAIL_PATH + outFile+" "+"e234";
        Runtime.getRuntime().exec(exePath);
      }catch(IOException ioe) {
        ioe.printStackTrace();		
	  }    	

    //�õ�����ļ� 
    String txtPath = DETAIL_PATH;
    String totalLine = "";
    temp = new File( txtPath,outFile);
    int readCount=0;
    while(!temp.exists() && readCount<30) {
    	Thread.sleep(1000);
     	readCount++;
    };

    FileReader outFrT = new FileReader(temp);
    BufferedReader outBrT = new BufferedReader(outFrT);	
    do {
        tline = outBrT.readLine();
        icount++;
    }while(tline!=null);
	  outBrT.close();
	  outFrT.close();   
	//yuanqs add 2010/9/6 15:28:25 �굥��ˮӡ����
	    String str = ip + " " + workNo+ " " + currentTimeString;
	     System.out.println("------------e234-------------str="+str);
	    String imageName = ip+workNo+".jpg";
	    String imagePath = application.getRealPath("/") + "/npage/query/img/" + imageName;
	    System.out.println(imagePath + "=========e234======imagePath");
	    int width = 750;
			int height = 280;
			float alpha = 0.5f;
	    CreateImg.drawImage(str, imagePath, width, height, alpha);	
%>

<html>
    <head>
        <title> ��������ͨ�굥��׼��ѯ-<%=qryName%></title>
        <SCRIPT LANGUAGE="JavaScript">
            function gohome() {
               document.location.replace("fe234_main.jsp?activePhone=<%=phoneNo%>");
            }
        </SCRIPT>
    </head>	
    <body  onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
        <FORM method=post name="frm234q" OnSubmit=" ">
            <%@ include file="/npage/include/header.jsp" %>
            <input type="hidden" name="phoneNo"  value="<%=phoneNo%>">
            <input type="hidden" name="billBegin"  value="<%=billBegin%>">
            <input type="hidden" name="billEnd"  value="<%=billEnd%>">
            <input type="hidden" name="qryType"  value="<%=qryType%>">
            <input type="hidden" name="qryName"  value="<%=qryName%>">
            <input type="hidden" name="dateStr"  value="<%=dateStr1%>">
            <input type="hidden" name="outFile"  value="<%=outFile%>">
    		<div class="title">
    			<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
    		</div>
        	<table cellspacing="0" style="background-image:url(../query/img/<%=imageName%>)" name="t1" id="t1">
            <%
                int lineNum = 0;
                tline = null;
                int beginLine = 0;
                int pageSize = 30;
                
                FileReader outFrT1 = new FileReader(temp);
                BufferedReader outBrT1 = new BufferedReader(outFrT1);	
                do{
                    tline = outBrT1.readLine();
                    String tlinetep = "";
                    if (tline != null) {
                        tlinetep = tline.replaceAll(" ", "&nbsp;");
                    }
                    if (lineNum < beginLine + pageSize) {
                        out.println("<tr  align='center'><td nowrap height='24'><font style='font-size:14px;font-family:����'>" + tlinetep + "</font></td></tr>");
                    }
                
                    lineNum++;
                }while(tline!=null);
                    outBrT1.close();
                    outFrT1.close();
            %>    
            </table>
            <table width="98%" border=0 align=center cellpadding="1" cellspacing=0>
                <tbody> 
                    <tr>
    <font class="orange">
    	<% 	int allPage = 0; 
    		allPage = (icount - 1) / pageSize + ((icount - 1) % pageSize == 0 ? 0 : 1);
    	%>
        <td> �ܹ��� <%=allPage%> ҳ����ǰҳΪ�� 1
            ҳ
        </td>
        <%if (beginLine + pageSize < icount - 1) {
        System.out.println("**********************************"+slowcust);
        %>
        <td><a href="fDetQryPrinte234.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>">����һҳ�� </a>
        </td>
    
        <td><a href="fDetQryPrinte234.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>&phoneNo=<%=phoneNo%>">�����һҳ�� </a>
        </td>
        <%}%>
        <td>
        	��ת��
				<select name="toPage" id="toPage" style="width:80px" onchange="setPage(this.value);">
					<%
					for (int i = 1; i <= allPage; i ++) {
					%>
						<option value="<%=i%>">��<%=i%>ҳ</option>
					<%
					}
					%>
				</select>
				ҳ
        </td>
    </font>
</tr>
                </tbody> 
            </table>
            <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
            <tbody> 
              <tr align="center" > 
            	<td id="footer">
            		&nbsp; <input class="b_foot" name=back onClick="print_detail()" type=button value="  ��  ӡ  ">
            		&nbsp; <input class="b_foot" name=close onClick="parent.removeCurrentTab();" type=button value="  ��  ��  ">
            	    &nbsp; <input class="b_foot" name="back" onClick="gohome()" type=button value="  ��  ��  ">
            	    &nbsp; <input class="b_foot" name=save onClick="savefile1()" type=button value="  ��  ��  ">
            	    &nbsp; <input class="b_foot_long" name=save onClick="printTable(t1)" type=button value="������ǰҳ">
            	</td>
              </tr>
            </tbody> 
            </table>
            <%@ include file="/npage/include/footer.jsp" %> 
        </Form>
        <script language="JavaScript">
            function print_detail()
            {
                var h = 800;
                var w = 1000;
                var t = screen.availHeight / 2 - h / 2;
                var l = screen.availWidth / 2 - w / 2;
                var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
                var path = "sPrint.jsp?qryName=<%=qryName%>&outFile=<%=outFile%>";
                var ret = window.open(path, "", prop);
            }
            
            // ���ӱ��湦�� 
            function savefile1()
            {
            	var sFileName = document.frm234q.outFile.value;
            	var path = "fDownDatae234.jsp?fileName="+sFileName+"&sFilePath=<%=DETAIL_PATH%>";
                var ret = window.open(path);
            }
            //���ӱ��湦�� 
            
            function setPage(goPage){
    			if (goPage == "-1") {
    				return;
    			} else{
    				var pageSizeVal = "<%=pageSize%>";
    				var beginLineVal = pageSizeVal * (goPage - 1);
    				var dirtPate = "fDetQryPrinte234.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=" + beginLineVal + "&phoneNo=<%=phoneNo%>";
    				location = dirtPate;
    			}
		    }
        </script>
    </body>
</html>