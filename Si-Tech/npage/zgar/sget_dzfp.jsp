<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %> 
<%@ page import="com.sitech.boss.pub.util.*"%>
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
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String printNote = "0";
	String groupId = (String)session.getAttribute("groupId");
	 
 
    String i = WtcUtil.repNull(request.getParameter("i")); 
	String invoice_number = WtcUtil.repNull(request.getParameter("fphm"));
	String invoice_code = WtcUtil.repNull(request.getParameter("fpdm"));
	String phoneNo  = request.getParameter("phone_no");
	String s_login_accept = request.getParameter("ls");
	String s_dates = request.getParameter("s_dates");
	String files=invoice_number+invoice_code;
	
 	String outPath="";
    String out_file="";
    String exePath = "";
	File temp1 = null;
	int secNum=0;
	 
 


	String realPath = request.getSession().getServletContext().getRealPath("/");
	String path1 =  request.getContextPath();
	String path2 =  request.getRealPath("/");
	 
 
 
	String file_name="";//"test_haha.txt";//д����
	file_name="zgar_"+phoneNo+invoice_code+invoice_number;
%>	 
 
<%
	String s_flag="";//0���� 1������
	 
			//pdf����
			try
			{
				//shell begin
			   outPath=path2+"/cli_file/";
			   out_file=outPath+file_name;// outPath+"zgar_"+file_name
			   //out_file=outPath+"zgar_"+file_name;
			   temp1 = new File(out_file);
			   String paramterString = "zgar "+workNo+" "+phoneNo+" "+"���ӷ�Ʊ��ӡ"+" "+invoice_code+" "+invoice_number+" "+s_login_accept+" "+s_dates.substring(0,8);
			   exePath = "/usr/bin/ksh " + CGI_PATH + "cli_zgar.sh "+paramterString;
			   Runtime.getRuntime().exec(exePath);
			   System.out.println("ccccccccccccccccccccccccccccccccccccccccccccc out_file is "+out_file);	
			   while(true) 
			   {
					System.out.println("ttttttttttttttttttttttttttttttt temp1 is "+temp1);
					//����ļ������ڣ��ȴ�10����
					if(!temp1.exists()) {
						if(secNum >= 30) {
							System.out.println("--fffffffffffffffffffffffffffffffffffffffffff--" + temp1.exists());
							s_flag="1";
							break;
						}else {
							
							secNum++;
							Thread.sleep(1000);
							s_flag="3";
							System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh secNum is "+secNum);
						}
					} 
					else
				    {
						s_flag="0";
						break;
					}		
				}
				 
			}
			catch (Exception ioe) {
				s_flag="2";
				ioe.printStackTrace();
	%>
				<script language="javascript">
					rdShowMessageDialog("ִ��shell����δ�ܳɹ�,ԭ��:<%=ioe.getMessage()%>");
					history.go(-1);
				</script>
	<%					
			}
			//end shell
			
	  %>
			
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
var i = "<%=i%>";
response.data.add("s_flag",s_flag);
response.data.add("i",i); 
core.ajax.receivePacket(response);
 
 

	
 
