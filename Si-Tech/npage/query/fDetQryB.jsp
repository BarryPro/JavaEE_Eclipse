<%
    /********************
     version v2.0
     ������: si-tech
     *
     * update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
     * 
     ********************/
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page import = "import java.awt.*" %>
<%@ page import = "import java.awt.image.*" %>
<%@ page import = "import java.io.*" %>
<%@ page import = "import javax.imageio.*" %>
<%@ page import = "import java.awt.font.*" %>
<%@ page import = "import java.awt.geom.*" %>
<%@ page import = "com.sitech.common.*" %>

<!-- yuanqs add 2010/8/31 2010/8/31 18:45:38 �굥��ˮӡ_�����������ӡ���� begin -->
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
<!-- yuanqs add 2010/8/31 2010/8/31 18:45:49 �굥��ˮӡ_�����������ӡ���� end -->
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);

    String opCode = request.getParameter("opCodeFlag")==null?"1863":request.getParameter("opCodeFlag");
    String opName = request.getParameter("opNameFlag")==null?"�����굥��ѯ":request.getParameter("opNameFlag");
    	
    String[][] result = new String[][]{};
    int slowcust = 0;
		int iErrorNo = 0;
    String sErrorMessage = "";
%>
<%!
    private static HashMap cfgMap = new HashMap(200);//���滰����ʽ
    private static String CGI_PATH = "";
    private static String DETAIL_PATH = "";
    static {
        //�ӹ��������ļ��ж�ȡ������Ϣ������Ϣ����sever����
        CGI_PATH = SystemUtils.getConfig("CGI_PATH");
        DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CGI_PATH" + CGI_PATH);
        System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DETAIL_PATH" + DETAIL_PATH);
        //�������"/"��ʽ����,����"/"
        if (!CGI_PATH.endsWith("/")) {
            CGI_PATH = CGI_PATH + "/";
            DETAIL_PATH = DETAIL_PATH + "/";
        }
    }
%>
<%

    String workNo = (String)session.getAttribute("workNo");  //����
    String phoneNo = request.getParameter("phoneNo");        //�ֻ�����
		String qryType = request.getParameter("qryType");        //�굥����
    String searchType = request.getParameter("searchType");  //ʱ������
    String billBegin = request.getParameter("beginTime");    //��ʼʱ��
    String billEnd = request.getParameter("endTime");        //����ʱ��
    String searchTime = request.getParameter("searchTime");	 //ʱ��
    String predictionNO="0";  															 //��ˮ
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
    String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    String rowlen = "26";																			 //��ʾ����
    String voiceBillType = request.getParameter("voiceBillType"); 																 //�Ƿ�Ϊ�߼��û�
    String outFile = phoneNo + qryType + dateStr1 + ".txt";	 //����ļ�
    String conn_phone = request.getParameter("connPhone");	 //��ϵ�绰
    String optType = request.getParameter("optType");        //��ѯ����
    String list_no = request.getParameter("listNo");		 //��������
    String reason_text = request.getParameter("reasonText"); //��ѯԭ��
    String dynPW = request.getParameter("dynPW"); //��̬����
    String ip = request.getRemoteAddr();//��ȡ����ԱIP��ַ
    
    String qryName = request.getParameter("qryName");        //�굥����
    
    if (searchType.equals("0")) 
    {
        searchTime = billBegin + "|" + billEnd + "|";
    }
	if(dynPW.equals(""))
	{
		dynPW = "0";
	}
	if(conn_phone.equals(""))
	{
		conn_phone = "0";
	}
		int icount = 0;
    String tline = null;
    File temp = null;	
		try 
		{
         //����·��,�������ļ���
			String paramterString = workNo + " " + 
														 	phoneNo + " " + 
														 	qryType + " " + 
														 	searchType + " " + 
														 	searchTime + " " + 
														 	predictionNO + " " + 
														 	dateStr + " " + 
														 	rowlen + " "+
														 	voiceBillType + " ";
			String paramterString2 = conn_phone + " " + 
															 optType + " " + 
															 list_no + " " + 
															 reason_text + " "+
															 dynPW + " "+opCode +" ";
															 
	
			String exePath = "/usr/bin/ksh " + CGI_PATH + "cp1863.sh " + paramterString + DETAIL_PATH + outFile + " " + paramterString2;
			System.out.println("######################exePath" + exePath);
			Runtime.getRuntime().exec(exePath);
		} 
		catch (Exception ioe) 
		{
			ioe.printStackTrace();
%>
			<script language="javascript">
				rdShowMessageDialog("ִ��shell����δ�ܳɹ�,ԭ��:<%=ioe.getMessage()%>");
				history.go(-1);
			</script>
<%					
    }
		String txtPath = DETAIL_PATH;
		String totalLine = "";
		int readCount = 0;
		temp = new File(txtPath, outFile);
		boolean fileExist;
				
		while (!temp.exists() && readCount < 500) 
		{
			Thread.sleep(1000);
	  	readCount++;
		};
		fileExist = temp.exists();
		if(temp.exists())
		{
			FileReader outFrT = new FileReader(temp);
			BufferedReader outBrT = new BufferedReader(outFrT);
			do 
      {
      	tline = outBrT.readLine();
      	icount++;
      } while (tline != null);
			outBrT.close();
			outFrT.close();
		}
		
		else
		{
%>
		<script language="javascript">
			rdShowMessageDialog("�굥�ļ�����ʧ��");
			history.go(-1);
		</script>
<%		
		}
		//yuanqs add 2010/8/31 9:14:01
    
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
    <title> �굥��ѯ-<%=qryName%>
    </title>
    <SCRIPT LANGUAGE="JavaScript">
        <!--
        function gohome() 
        {
            document.location.replace("f1863_1.jsp?activePhone=<%=phoneNo%>&opCode=<%=opCode%>&opName=<%=opName%>");
        }
        //-->
    </SCRIPT>
</head>
<!-- yuanqs 2010/9/13 11:01:43 -->
<body topmargin="0" onselectstart="return false" oncontextmenu= "window.event.returnvalue=false" oncopy="return false;">
<%if (fileExist) {%>	
<FORM method=post name="frm1500" OnSubmit=" ">
	<%@ include file="/npage/include/header.jsp" %>
    <input type="hidden" name="phoneNo" value="<%=phoneNo%>">
    <input type="hidden" name="billBegin" value="<%=billBegin%>">
    <input type="hidden" name="billEnd" value="<%=billEnd%>">
    <input type="hidden" name="qryType" value="<%=qryType%>">
    <input type="hidden" name="qryName" value="<%=qryName%>">
    <input type="hidden" name="dateStr" value="<%=dateStr1%>">
    <input type="hidden" name="outFile" value="<%=outFile%>">
    <input type="hidden" name="opCodeFlag" value="<%=opCode%>" />
    <input type="hidden" name="opNameFlag" value="<%=opName%>" />

		<div class="title">
			<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
		</div>
		

<table cellspacing="0" id="t1" style="background-image:url(img/<%=imageName%>)">
    <%
        int lineNum = 0;
        tline = null;
        int beginLine = 0;
        int pageSize = 30;

        FileReader outFrT1 = new FileReader(temp);
        BufferedReader outBrT1 = new BufferedReader(outFrT1);
        do
        {
        	tline = outBrT1.readLine();
		     	String tlinetep = "";
		     	if(tline != null)
		     	{
						if((tline.trim().equals(""))&&(lineNum == 0))
						{
							System.out.println("�յĻ���");
							outBrT1.close();
	   					outFrT1.close();
	   					out.print("<script language=\"javascript\">") ;
	   					out.print("rdShowMessageDialog(\""); 
	   					out.print("�û�����Ϊ�գ�");
	   					out.println("\");");
	   					out.println("history.back(); ");	   				
	   					out.println("</script>");      
	   					return;      
	   				}
						else if((tline.indexOf("������")==-1)&&(lineNum==0))
						{
							System.out.println("��������ȷ������ʽ��˵���������汨���ˣ�");	
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
		     if (lineNum < beginLine + pageSize) 
		     {
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
                    <td> �ܹ��� <%=(icount - 1) / pageSize + ((icount - 1) % pageSize == 0 ? 0 : 1)%> ҳ����ǰҳΪ�� 1
                        ҳ
                    </td>
                    <%if (beginLine + pageSize < icount - 1) {
                    System.out.println("**********************************"+slowcust);
                    %>
                    <td><a href="fDetQry4.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=beginLine + pageSize%>&phoneNo=<%=phoneNo%>&opCodeFlag=<%=opCode%>&opNameFlag=<%=opName%>">����һҳ�� </a>
                    </td>

                    <td><a href="fDetQry4.jsp?islowcust=<%=slowcust%>&qryName=<%=qryName%>&icount=<%=icount-1%>&outFile=<%=outFile%>&beginLine=<%=((icount-1)/pageSize + ((icount-1) % pageSize == 0 ? 0 : 1)-1)*pageSize%>&phoneNo=<%=phoneNo%>&opCodeFlag=<%=opCode%>&opNameFlag=<%=opName%>">�����һҳ�� </a>
                    </td>
                    <%}%>
                </font>
            </tr>
        </tbody>
    </table>
    <table cellspacing=0>
        <tbody>
            <tr>
                <td id="footer">
                    &nbsp; <input class="b_foot" name=back onClick="print_detail()" type="button" value="  ��  ӡ  ">
                    &nbsp; <input class="b_foot" name=close onClick="removeCurrentTab()" type="button" value="  ��  ��  ">
                    &nbsp; <input class="b_foot" name=close onClick="gohome()" type="button" value="  ��  ��  ">
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
</script>
<%}%>
	 
</body>
</html>

