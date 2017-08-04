<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="com.jspsmart.upload.*"%>
<%@ page import="com.uploadftp.*"%>
<%@ page import="java.io.File"%>



<%
		String regionCode = (String)session.getAttribute("regCode");
		String workNo = (String)session.getAttribute("workNo");

		String retType = request.getParameter("retType");
		System.out.println("---------- ftp download retType ----------------"+retType);
		String phoneNo = request.getParameter("phoneNo");
		System.out.println("---------- ftp download phoneNo ----------------"+phoneNo);
		String iccidFtpPwd = request.getParameter("ftpPwd");
		System.out.println("---------- ftp download iccidFtpPwd ----------------"+iccidFtpPwd);			
		
	    
    String errCode = "000000";
    String errMsg = "操作成功！";	    
    
    
    String sql_idPath ="";
		sql_idPath = "select b.id_image, b.id_type, b.id_name, b.id_sex, to_char(b.id_birthday,'yyyy    mm    dd'), b.id_address, b.id_iccid from DCUSTIDTOICCID a, DCUSTICCIDIMG b, dcustmsg c "
		 +" where a.id_iccid = b.id_iccid and a.cust_id = c.cust_id and a.op_code in('1100','1104') and c.phone_no = '"+phoneNo+"' ";
		 
		System.out.println("--------------sql_idPath-----------------"+sql_idPath);
%>

	 <wtc:pubselect name="sPubSelect" outnum="7" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql_idPath%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%
		int iccidCount = 0; 
		String idPicPath = "";		
		String idType = "";
		String custName = "";
		String custSex = "";
		String custBirthday = "";
		String custAddress = "";
		String custIccid = "";		
		if(result_t.length>0&&result_t[0][0]!=null){
			idPicPath = result_t[0][0];			
			idType = result_t[0][1];
			custName = result_t[0][2];
			custSex = result_t[0][3];
			custBirthday = result_t[0][4];
			custAddress = result_t[0][5];
			custIccid = result_t[0][6];			
			System.out.println("idPicPath|"+idPicPath);
			iccidCount = 1;
		}
		
		if(retType.equals("download")){
				if(iccidCount==1){
					String filename = idPicPath.substring(idPicPath.indexOf("_")+1,idPicPath.length());
					String serverIP = idPicPath.substring(0,idPicPath.indexOf("_"));
					String sSaveName = request.getRealPath("npage/cust_ID")+"/"+phoneNo+"_"+workNo+".jpg";					
					System.out.println("serverIP|"+serverIP);
					System.out.println("filename|"+filename);		
					System.out.println("sSaveName|"+sSaveName);						
					FtpTools ftpT=new FtpTools();
					if(ftpT.connect(serverIP)){
						if(ftpT.login_S("iccid",iccidFtpPwd)){
							boolean dlfile = ftpT.downloadFile("/"+filename,sSaveName);
							System.out.println("下载图片结果为："+dlfile);
						}else{
							errCode = "000003";
							errMsg = "ftp用户名密码错误！";
						}
					}else{
						errCode = "000002";
						errMsg = "ftp连接主机失败！";
					}
					
				}else{
					errCode = "000001";
					errMsg = "无身份证信息记录！";
				}				
		}else if(retType.equals("delete")){
				if(iccidCount==1){
					File filePic =new File(request.getRealPath("npage/cust_ID")+"/"+phoneNo+"_"+workNo+".jpg");
					boolean delflag  = filePic.delete();
					System.out.println("删除临时工单结果为："+delflag);
					if(!delflag){
						errCode = "000004";
						errMsg = "临时身份证信息删除失败";
					}
				}else{
					errCode = "000001";
					errMsg = "无身份证信息记录！";
				}				
		}		
%>

var response = new AJAXPacket();

var retType = "";
var errCode = "";
var errMsg = "";
retType = "<%=retType%>";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";
response.data.add("retType",retType);
response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);

response.data.add("idType","<%=idType%>");
response.data.add("custName","<%=custName%>");
response.data.add("custSex","<%=custSex%>");
response.data.add("custBirthday","<%=custBirthday%>");
response.data.add("custAddress","<%=custAddress%>");
response.data.add("custIccid","<%=custIccid%>");

core.ajax.receivePacket(response);

