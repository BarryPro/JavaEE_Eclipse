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

<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.common.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!-- ningtn 2011-7-18 18:26:15 -->
<script type="text/javascript" src="/npage/public/printExcel.js"></script>	
<script type="text/javascript" src="/npage/public/pubLightBox.js"></script>	
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
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
	
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    opCode="1526";
    opName="δ�ϲ��굥��ѯ";
    String[][] result = new String[][]{};
    boolean billCanView = false;
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
        System.out.println("---liujian----AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CGI_PATH" + CGI_PATH);
        System.out.println("---liujian----BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%DETAIL_PATH" + DETAIL_PATH);
        //�������"/"��ʽ����,����"/"
        if (!CGI_PATH.endsWith("/")) {
            CGI_PATH = CGI_PATH + "/";
            DETAIL_PATH = DETAIL_PATH + "/";
        }
    }
%>
<%
    String workNo = (String)session.getAttribute("workNo");  //����
    String workPassword = (String)session.getAttribute("password"); // ��������
    String phoneNo = request.getParameter("phoneNo");        //�ֻ�����
    String broadPhone = request.getParameter("broadPhone");  //����˺�
    String passWord = request.getParameter("passWord");        //��ѯ����
    String enPass = Encrypt.encrypt(passWord);				//���ܺ����� yuanqs add 100820 �����������
   
    String qryType = request.getParameter("qryType");        //�굥����
    String qryName = request.getParameter("qryName");        //�굥����
    String billBegin = request.getParameter("beginTime");    //��ʼʱ��
    String billEnd = request.getParameter("endTime");        //����ʱ��
    String charging_id = request.getParameter("charging_id");
    String resv = request.getParameter("resv");

    String searchType = request.getParameter("searchType");
		searchType="0";
    String ip = request.getRemoteAddr();//��ȡ����ԱIP��ַ yuanqs add 2010/9/6 15:27:46 �굥��ˮӡ����
    String billTime = billBegin + "^" + billEnd + "^";     //ʱ�䴮

    String predictionNO="0";                     //��ʧ��
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd_HH:mm:ss").format(new java.util.Date()); //��ǰʱ��
    String dateStr1 = new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date());
    String custName = "";       //�ͻ�����	
    String outFile = "";
System.out.println("  zhaorh ==> qryType:" + qryType+"qryName="+qryName+"billBegin="+billBegin+"billEnd="+billEnd+"charging_id="+charging_id);
		
		
		SimpleDateFormat s = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss SSS"); 
		String beginTime = null;
		String getFileTime = null;
    //�Ƿ��ж�������
    boolean haveTwoPassWord = false;
    //�û�����Ķ��������Ƿ��뷵��ֵ��ͬ
    boolean isTwoPassWordTrue = false;

    String twoPassWord = "";

		/* liujian 2012-3-28 19:04:43 ���� begin */
		int pageCount = 0;
		String firstPageBody = "";
		int lines_one_page = 2000;
		long fileSize = 0L;
		int secNum = 0;
		int maxSec = 30;
		String fileStatus = "111111";
		String fileMsg = "�ļ�û������";
		/* liujian 2012-3-28 19:04:43 ���� end */


		
				
        try {
            /* ningtn ��ͨ��� */
        		String kshString = "";
        		String paramterString = "";
        		String exePath = "";
        		System.out.println("~~~~~~~~~~~~~~~~~~ " + opCode);
        		if("e155".equals(opCode)){
	            /* ����굥 */
	            kshString = CGI_PATH + "linkprint.sh" + " ";
	            paramterString = "0" + " " + "01" + " " + opCode + " " +
	            								workNo + " " + workPassword + " " + phoneNo + " " +
	            								passWord + " " + broadPhone + " " + passWord + " " +
	            								qryType  + " " + searchType + " " + billTime + " " +
	            								dateStr  + " " + "26 ";
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + kshString + paramterString + DETAIL_PATH + outFile + " " + "1" + " "+passWord;
           		System.out.println("--liujian--exePath=" + exePath);
            }else{
            	/* ��ͨ�绰�굥 */
         
	            //����·��,�������ļ���
	           // kshString = CGI_PATH + "cp.sh" + " ";
	            paramterString = workNo + " " + phoneNo + " " + qryType + " " + searchType + " " + billTime + " " + predictionNO + " "+ charging_id + " " + resv + " " ;
	            outFile = phoneNo + qryType + dateStr1 + ".txt";
	            exePath = "/usr/bin/ksh " + CGI_PATH + "cp_detail.sh " + paramterString + DETAIL_PATH + outFile ;
            }
            System.out.println("###################fGetQryZ.jsp->kshString->"+kshString+"&paramterString->"+paramterString+"&outFile->"+outFile);
            System.out.println("######################exePath" + exePath);
            
            Runtime.getRuntime().exec(exePath);

        } catch (Exception ioe) {
            ioe.printStackTrace();
%>
			<script language="javascript">
				rdShowMessageDialog("ִ��shell����δ�ܳɹ�,ԭ��:<%=ioe.getMessage()%>");
				history.go(-1);
			</script>
<%					
        }
        //�õ�����ļ� 
        String DETAIL_PATH = SystemUtils.getConfig("DETAIL_PATH");
   			String order_path = DETAIL_PATH + outFile;
   //		String order_path = "/iwebd2/detail/file/13703633753020120328155326.txt";
   // 	outFile = "13703633753020120328155326.txt";
   			int icount = 0;
    		String tline = null;
   			File temp = null;
        temp = new File(order_path);
        System.out.println("----liujian---temp=" + temp.getAbsolutePath());
        
        beginTime = s.format(new Date(System.currentTimeMillis()));
				
		    int c = 0;
				while(true) {
					//����ļ������ڣ��ȴ�10����
					if(!temp.exists()) {
						if(secNum >= 30) {
							System.out.println("--liujian--fileNoCreate--" + temp.exists());
							break;
						}else {
							secNum++;
							Thread.sleep(1000);
						}
					}else {
						if(fileSize == temp.length()) {
							 fileStatus = "000000";
						   fileMsg = "�ļ��������";
						   
						    int lineNum = 0;
				        tline = null;
				        int beginLine = 0;
				        int pageSize = 30;
				
				        FileReader outFrT1 = new FileReader(temp);
				        BufferedReader outBrT1 = new BufferedReader(outFrT1);
				        tline = outBrT1.readLine();
						    String tlinetep = "";
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
								else if((tline.indexOf("cust")==-1)&&(lineNum==0))
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
								}	else {
										pageCount = getPageCount(order_path,lines_one_page);
								    firstPageBody = parseDocument(order_path,1,lines_one_page);
								    System.out.println("--liujian--ok--");
								}			
				        outBrT1.close();
				        outFrT1.close();
							break;
						}else if(secNum < maxSec) {
							secNum++;
							fileSize = temp.length();
							Thread.sleep(1000);
						}else {
							fileStatus = "000001";
						  fileMsg = "�ļ�����ʱ�䳬��" + maxSec +"��";
						  System.out.println("--liujian--overTime--");
							break;
						}
					}
					System.out.println("----liujian----" + c++ );
				
    }
      getFileTime = s.format(new Date(System.currentTimeMillis()));
     //yuanqs add 2010/9/6 15:28:25 �굥��ˮӡ����
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
    <title> �굥��ѯ-<%=qryName%></title>
    <link href="../query/detail.css" rel="stylesheet" type="text/css"></link>
    <SCRIPT LANGUAGE="JavaScript">

        
			/*�����굥��ϸ*/
			function go_detail(phone_no,charging_id,resv,start_datetime,end_datetime)
			{
				var h=480;
				var w=650;
				var t=screen.availHeight/2-h/2;
				var l=screen.availWidth/2-w/2;
		 		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
		 		
		 
				alert(phone_no+"|"+charging_id+"|"+resv+"|"+start_datetime+"|"+end_datetime);	
				var returnValue=window.showModalDialog("fDetQryXDetail.jsp?phoneNo="+phone_no+"&qryType=95"+"&qryName=δ�ϲ��굥"+"&billBegin="+start_datetime+"&billEnd="+end_datetime);
				
				if(returnValue==null)
	     	{
             rdShowMessageDialog("�����ˣ�����");
             //window.location.href="s1300.jsp";
		  	}
			}



    </SCRIPT>
   
    <script language="javascript">
    	 /*  liujian  2012-3-14 9:06:36  ����굥js���� begin */
				var currPage = 1;
				$(function() {
					  
						/****************************ע��һϵ���¼�*****************************************/
					  // ��ҳ����first����һҳ����next����һҳ����prev��βҳ����last

						$('#prtBtn').click(function() {
			        var h = 800;
			        var w = 1000;
			        var t = screen.availHeight / 2 - h / 2;
			        var l = screen.availWidth / 2 - w / 2;
			        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			        var path = "../query/print.jsp?fileName=<%=outFile%>&opCode=<%=opCode%>&opName=<%=opName%>";
			        var ret = window.open(path, "", prop);
						});
						$('#submitBtn').click(function() {
				    	var path = "../query/downData.jsp?fileName=<%=outFile%>";
				      var ret = window.open(path);
						})
						/****************************��ʼ��ҳ��*****************************************/
					showLightBox();
				//	myInterval = setInterval("judgeFileComp()", 1000);
					if('<%=fileStatus%>' == '000000') {
							init();
					}else {
							hideLightBox();
							rdShowMessageDialog("������룺<%=fileStatus%>��������Ϣ��<%=fileMsg%>",0);
							history.go(-1);
					}
					
				});
				//��ʼ��
				function init() {

						$('#detailContainer').append('<%=firstPageBody%>');
						setToPageAttr();
						hideLightBox();	
				}
				
				//������ɫ��click�¼�
				function setToPageAttr() {

				}
				
				function setSelPage(pageCount) {

				}
				
				/*  liujian  2012-3-14 9:06:36  ����굥js���� end */
		</script>
		
</head>

<!-- liujian 2012-3-14 9:08:55 �굥DOM�ṹ begin-->
<body onload="" >
<form action="" method="post" name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">�й��ƶ�ͨ�ſͻ�<%=qryName%>�굥</div>
	</div>
	<div style="background-image:url(/npage/query/img/<%=imageName%>)" id="detailContainer">

	</div>
	
	<table cellspacing="0">

  	<table cellspacing="0">
      <tr> 
          <td id="footer"> 
              <input name="prtBtn" id="prtBtn" class="b_foot"  type="button"  index="2" value="�� ӡ" />
              &nbsp;
              <input name="submitBtn" id="submitBtn" class="b_foot"  type="button"  index="2" value="�� ��" />
              &nbsp; 
         </td>
      </tr>
  </table>
  <%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
<!-- liujian 2012-3-14 9:08:55 �굥DOM�ṹ end-->

</html>




<%!
	   String detailCode = "111111";
 	   String detailMsg = "�ļ������ڣ�";
	 	 int pageCount = 0;
	 	 int secNum = 0;

	 	 
		 //�ж��ļ��Ƿ����
		 public boolean exsitFile(String path) {
				File file = new File(path);
				if (!file.exists() || file.isDirectory() || !file.canRead()) {
	//					System.out.println("---liujian---path=" + path);
						detailCode = "000001";
 	 					detailMsg = "�ļ������ڣ�";
				    return false;
				}else {
					return true;
				}
			}

			//�ж��Ƿ�ĩβ�ǿհ���
			public boolean lastLineIsBlank(File file) throws IOException {
			  RandomAccessFile raf = null;
			 	long len = 0;
	 		 	long pos = 0;
			  try {
			    raf = new RandomAccessFile(file, "r");
			    len = raf.length();
			    if (len == 0) {
			    	detailCode = "000002";
 	 					detailMsg = "�ļ����ڣ��ļ���СΪ0��";
			      return false;
			    } else {
			      pos = len - 1;
			      raf.seek(pos);
		    	  if( raf.readByte() == '\n' ) {
				    	return true;
				  	}
			    }
			  } catch (FileNotFoundException e) {
			  		detailCode = "000003";
 	 					detailMsg = "�ļ������쳣4��";
			  } finally {
			    if (raf != null) {
			      try {
			        raf.close();
			      } catch (Exception e2) {
			      }
			    }
			  }
			  return false;
		}
	
		// ����ļ�������,ȥ���հ���
		public int getLineNumber(String path) {
			int number = 0;
			File file = new File(path);
			long fileLength = file.length();
			LineNumberReader rf = null;
			try {
				rf = new LineNumberReader(new FileReader(file));
				if (rf != null) {
					rf.skip(fileLength);
					number = rf.getLineNumber();
//					System.out.println("------------liujian-----------number = " + number);
					//������Ϊ1����ֻ��һ�У����Ҵ��в�Ϊ��
					if(number != 0 || (number == 0 && fileLength != 0L)) {
						number++;
					}
					rf.close();
				}
				//������ڿհ��У�ȥ�����涨���ֻ��һ���հ���
				if(number >0 && lastLineIsBlank(new File(path))) {
					  number--;
				}
			} catch (IOException e) {
				if (rf != null) {
					try {
						detailCode = "000003";
 	 					detailMsg = "�ļ������쳣5��";
						rf.close();
					} catch (IOException ee) {
						detailCode = "000003";
 	 					detailMsg = "�ļ������쳣6��";
					}
				}
			}
			return number;
		}
	
	//����htmlһ�е�����
	public StringBuffer setTr(String[] beforeAndcurrLines) {
		char beforeLineFirstChar = '0'; //Ĭ��Ϊ0
		boolean isFirstLine = true; 
		if(beforeAndcurrLines[1] != null) {
			beforeLineFirstChar = beforeAndcurrLines[1].charAt(0);
			isFirstLine = false;
		}
		StringBuffer sb = new StringBuffer();
		//�и������ݣ����ÿһ���ֶ�,-1����Ϊ����|||���ֵ�����������߾��и�������-1
		String[] fields = beforeAndcurrLines[0].split("\\|",-1);
		
		//��һ���ֶο����ǣ�cust/g/body/head/title/span/foot
		//��������ȥ������,����ƥ���ַ�
		switch(fields[0].charAt(0)) {
			case 'c' : {
				if(beforeLineFirstChar == '0') {
					sb.append("<table cellspacing=\"0\" style=\"background:;\">");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'g' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table class=\"g\" cellspacing=\"0\" style=\"background:;\">").append("<tr><td>").append(fields[1]).append("</td></tr>");
				break;
			}
			case 'h' : {
				if(beforeLineFirstChar == 'h') {
					sb.append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == 'g') {
					sb.append("</table>");
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}else if(beforeLineFirstChar == '0' && isFirstLine) { //��һ��
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<fields.length-1;i++) {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				break;
			}
			case 't' : {
				if(!isFirstLine) {
					sb.append("</table>");
				}
				sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td>").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'b' : {
				if(isFirstLine) {
					//��ӱ���
					String[] titleFields = currTitleLine.split("\\|",-1);
					sb.append("<table cellspacing=\"0\" style=\"background:;\">").append("<tr class=\"detailtitle\">");
					for(int i=1;i<titleFields.length-1;i++) {
						sb.append("<td>").append(titleFields[i]).append("</td>");
					}
					sb.append("</tr>");
				}
				sb.append("<tr>");
				for(int i=1;i<fields.length-1;i++) {
					if( fields[i].length() >0 && fields[i].substring(0,1).equals("@") )
					{
						String[] sArrDetailParas = fields[i].split("\\,",-1);

						String   sTmpHTML="";
						sTmpHTML+="<td><span onClick=go_detail(";
						sTmpHTML+="\""+sArrDetailParas[0].substring(1,sArrDetailParas[0].length())+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[1]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[2]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[3]+"\""+"," ;
						sTmpHTML+="\""+sArrDetailParas[4]+"\"" ;
						sTmpHTML+=")> ��ϸ </span> </td>";
						sb.append(sTmpHTML);
					}
					else
					{
						sb.append("<td>").append(fields[i]).append("</td>");
					}
				}
				sb.append("</tr>");
				break;
			}
			case 's' : {
				if(isFirstLine) {
					sb.append("<table><tr>");
				}else {
					sb.append("<tr>");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					sb.append("<td  colspan=\"" + fieldSize + "\" class=\"detailtitle\">").append(fields[i]).append("</td>");
				}
				sb.append("</tr>");
				break;
			}
			case 'f' : {
				if(isFirstLine) {
					sb.append("<table><tr class=\"detailfoot\">");
				}else {
					sb.append("<tr class=\"detailfoot\">");
				}
				int fieldSize = currTitleLine.split("\\|",-1).length-2;
				if(fieldSize < 0) {
					fieldSize = 1;
				}
				for(int i=1;i<fields.length-1;i++) {
					if(i == 2) {
						sb.append("<td colspan=\"" + fieldSize + "\" align=\"right\">").append(fields[i]).append("</td>");
					}else {
						sb.append("<td>").append(fields[i]).append("</td>");
					}
				}
				sb.append("</tr>");
				break;
		    }
		}
		return sb;
	}
	public static final int LINES_ONE_PAGE = 2000;
	String currTitleLine = "";
	//�����ĵ�
	public String parseDocument(String path,int pageNum,int lines_one_page){
//		System.out.println("-------liujian-------------parseDocument begin");
		File file = new File(path);
		//һ��ģ��һ��ģ��ļ��뵽ҳ���У��Ȳ����Ƿ�ҳ����
		StringBuffer sb = new StringBuffer("");
		InputStreamReader isr = null;
		BufferedReader br = null;
		try{
			isr = new InputStreamReader(new FileInputStream(file), "GB2312");
			br = new BufferedReader(isr);
			//0:currLine��1��beforeLine
			String[] beforeAndcurrLines = new String[2];
			String s = null;
			int currNum = 0;
			while((s = br.readLine()) != null) {
				currNum++;
				if(s.startsWith("title")) {
					currTitleLine = s;
				}
				if(pageNum == -1 || (currNum > (pageNum-1) * lines_one_page && currNum <= pageNum * lines_one_page)) {
					//�������
					if(beforeAndcurrLines[0] == null ) {
						beforeAndcurrLines[0] = s;
					}else {
						beforeAndcurrLines[1] = beforeAndcurrLines[0];
						beforeAndcurrLines[0] = s;
					}
					//�����е�html��ʽ����������table
					sb.append(setTr(beforeAndcurrLines).toString());
				}
			}
			sb.append("</table>");
		}catch(Exception e) {
			detailCode = "000003";
 	 		detailMsg = "�ļ������쳣3��";
		}finally {
			try{
				br.close();
				isr.close();
				System.out.println("�ر�������");
			}catch(Exception e) {
				System.out.println("������Ϊ��");
			}
		}
//		System.out.println("-------liujian-------------parseDocument end");
		return sb.toString();
	}

	public int getPageCount(String path,int lines_one_page) throws IOException {
		return (getLineNumber(path)-1) / lines_one_page + 1;
	}
%>