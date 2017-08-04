<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<%

			String regionCode = (String)session.getAttribute("regCode");
      String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
			String errorCode="4444";
       List al=null;
       int valid=0;
       String login_no =request.getParameter("login_no");
	   String org_code =request.getParameter("org_code");
	   if(org_code==null){org_code="010100101";}
	   String op_code =request.getParameter("op_code");
	   String total_date =request.getParameter("total_date");
	   String MobNum =request.getParameter("MobNum");
	   String Name =request.getParameter("Name");
	   String IDCardType_list =request.getParameter("IDCardType_list");
	   String IDCardNum_list =request.getParameter("IDCardNum_list");
	   String CCPassword =request.getParameter("CCPassword");
	   String testFlag=request.getParameter("test_flag");
	   if(testFlag==null) testFlag = "";
	   /**输出参数定义**/
	   String OldMSISDN="";
	   String Score="";
	   String Type="";
	   String Level="";
	   String Rslt  ="";
	   String retInfo = "";
	   String ruwangtime="";

	   String xiaofeijifens="";   
		 String pinpaijianglijf =""; 
		 String wanglingjianglijf =""; 
		 String zhuanxiangzyjf="";
		 String yiduihuanjf=""; 
		 String keduihuanjf=""; 
	   int recordNum = 0;
	   String opNote="跨区入网服务鉴权，手机号："+MobNum;
	   String  inputParsm [] = new String[10];
	   inputParsm[0] = login_no;
	   inputParsm[1] = org_code;
	   inputParsm[2] = "4255";
	   inputParsm[3] = MobNum;
	   inputParsm[4] = Name;
	   inputParsm[5] = IDCardType_list;
	   inputParsm[6] = IDCardNum_list;
	   inputParsm[7] = CCPassword;
	   inputParsm[8] = opNote;
	   inputParsm[9] = testFlag;
	   try{
%>
        <wtc:service name="s4255CfmNew" outnum="17" retmsg="msgs4255CfmNew" retcode="codes4255CfmNew" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=inputParsm[0]%>" />
			<wtc:param value="<%=inputParsm[1]%>" />
			<wtc:param value="<%=inputParsm[2]%>" />
			<wtc:param value="<%=inputParsm[3]%>" />
			<wtc:param value="<%=inputParsm[4]%>" />
			<wtc:param value="<%=inputParsm[5]%>" />					
			<wtc:param value="<%=inputParsm[6]%>" />	
			<wtc:param value="<%=inputParsm[7]%>" />
			<wtc:param value="<%=inputParsm[8]%>" />
			<wtc:param value="<%=inputParsm[9]%>" />			
		</wtc:service>
		<wtc:array id="result"  scope="end" />
		
<%       

System.out.println("---------------code----------------"+codes4255CfmNew);
System.out.println("---------------msg-----------------"+msgs4255CfmNew);
System.out.println("---------------result.length-----------------"+result.length);


	        if( result.length <= 0 || result==null ){
				valid = 1;
	        }else{
		        errorCode = codes4255CfmNew;
		        errorMsg = msgs4255CfmNew;
		        if(!errorCode.equals("0000")){
			        valid = 2;
		        }else{
			        valid = 0;
				    OldMSISDN = result[0][2];
				    Score = result[0][3];
				    Type = result[0][4];
				    Level = result[0][5];
				    Rslt = result[0][6];
				    ruwangtime =result[0][7];
	          xiaofeijifens=result[0][8];   
						pinpaijianglijf =result[0][9]; 
						wanglingjianglijf =result[0][10]; 
						zhuanxiangzyjf=result[0][11];
						yiduihuanjf=result[0][12]; 
						keduihuanjf=result[0][13]; 
		        }
	        }
	        System.out.println(OldMSISDN+Score+Level+Rslt);
	        System.out.println("retInfo="+retInfo);
        }
	    catch(Exception e){
	        System.out.println("e="+e);
	        errorCode="1001";
	        errorMsg = "获得归属地号码失败！";
	    }                    
    String rpcPage = "4255";                        
%>                              
<%="var retJsArr=new Array();"%>
<%if( valid == 0){%>
    retJsArr=new Array("<%=OldMSISDN%>","<%=keduihuanjf%>","<%=Type%>","<%=Level%>","<%=Rslt%>","<%=ruwangtime%>");
<%}%>
var retType = "<%=rpcPage%>";
var recordNum = "<%=recordNum%>";
var retInfo = "<%=retInfo%>";
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retCode","<%=errorCode%>");
response.data.add("retMsg","<%=errorMsg%>");
response.data.add("retType",retType);
response.data.add("recordNum",recordNum);
response.data.add("retInfo",retInfo);
response.data.add("retJsArr",retJsArr);
response.data.add("xiaofeijifens","<%=xiaofeijifens%>");
response.data.add("pinpaijianglijf","<%=pinpaijianglijf%>");
response.data.add("wanglingjianglijf","<%=wanglingjianglijf%>");
response.data.add("zhuanxiangzyjf","<%=zhuanxiangzyjf%>");
response.data.add("yiduihuanjf","<%=yiduihuanjf%>");
response.data.add("keduihuanjf","<%=keduihuanjf%>");
core.ajax.receivePacket(response);

