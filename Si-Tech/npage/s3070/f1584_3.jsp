<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "�����ӳ���Ч��";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%request.setCharacterEncoding("GB2312");%>
<%@page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.util.*"%>


<HTML>
<HEAD>
<TITLE>������BOSS-������Ч���ӳ�</TITLE>
</HEAD>

<BODY>
<FORM action="" method=post name="form1">
</FORM>
</BODY>
</HTML>

<%
  String opCode1 = "1584";
  String opName1 = "�����ӳ���Ч��";
/*--------------------------------��֯s1259Cfm�Ĵ������-------------------------------*/
String stream = ReqUtil.get(request,"stream");                    //ϵͳ��ˮ      
String theop_code ="1584";                                        //��������
String thework_no = (String)session.getAttribute("workNo");                                 //��������    
String psw = (String)session.getAttribute("password");                           //��������	
String org_code = (String)session.getAttribute("orgCode");									                  //org_code 
String themob = ReqUtil.get(request,"i1");                        //�ֻ�����
String expireTime = ReqUtil.get(request,"expire_time");           //����ʱ��
String fircash = ReqUtil.get(request,"i20");                      //�̶�������	
String realcash = ReqUtil.get(request,"i19");                     //ʵ��������	
String sysnote = ReqUtil.get(request,"sysnote");                  //ϵͳ��ע	
String donote = ReqUtil.get(request,"tonote");                    //������ע	
String ip = (String)session.getAttribute("ipAddr");                                        //��½IP		
float  handcash = Float.parseFloat(realcash);                     //�����ѵ�����
String regionCode = (String)session.getAttribute("regCode");
String ret_code = "";
String ret_msg = "";

/*--------------------------------��ʼ����s1259Cfm--------------------------------*/

try{
    //retArray = callView.s1258CfmProcess(stream, theop_code,thework_no, psw,org_code, themob,expireTime, fircash, realcash,sysnote, donote, ip).getList();
%>

    <wtc:service name="s1258Cfm" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
    	    <wtc:param value="<%=stream%>" />
			<wtc:param value="<%=theop_code%>" />
			<wtc:param value="<%=thework_no%>" />
			<wtc:param value="<%=psw%>" />
			<wtc:param value="<%=org_code%>" />				
			<wtc:param value="<%=themob%>" />	
			<wtc:param value="<%=expireTime%>" />
			<wtc:param value="<%=fircash%>" />
			<wtc:param value="<%=realcash%>" />
			<wtc:param value="<%=sysnote%>" />				
			<wtc:param value="<%=donote%>" />
			<wtc:param value="<%=ip%>" />		
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />

<%    

		for(int iii=0;iii<result_t2.length;iii++){
				for(int jjj=0;jjj<result_t2[iii].length;jjj++){
					System.out.println("---------------------result_t2["+iii+"]["+jjj+"]=-----------------"+result_t2[iii][jjj]);
				}
		}
System.out.println("------------code-------------"+code);
System.out.println("------------msg-------------"+msg);
ret_code = code;
ret_msg  = msg;
}
catch(Exception e){
    e.printStackTrace() ;
	  System.out.println("***********call service is failed****************");
}
%>


<%
/*************************************��ô�ӡ��Ʊ�Ĳ���****************************************/
String cardno = ReqUtil.get(request,"icard_no");      //���֤����
	   //themob = ReqUtil.get(request,"i1");					  //�ƶ�����
String name =   ReqUtil.get(request,"iname");         //�û�����
String address =  ReqUtil.get(request,"iaddr");				//�û���ַ
	   //realcash = ReqUtil.get(request,"i19");   			//������
	   //stream = ReqUtil.get(request,"stream");        //ϵͳ��ˮ
/***********************************************************************************************/

%>

<script language="jscript">
function printBill(){
	 var infoStr="";
	 infoStr+='<%=cardno%>'+"|";   //���֤����                                                  
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";  //����
	 infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	 infoStr+='<%=themob%>'+"|";   //�ƶ�����                                                   
	 infoStr+=""+"|";              //��ͬ����                                                          
	 infoStr+='<%=name%>'+"|";     //�û�����                                                
	 infoStr+='<%=address%>'+"|";  //�û���ַ   
	 infoStr+="�ֽ�"+"|";
	 infoStr+='<%=handcash%>'+"|";
	 infoStr+="������Ч���ӳ���*�����ѣ�"+'<%=handcash%>'+"*��ˮ�ţ�"+'<%=stream%>'+"|";
	 location="<%=request.getContextPath()%>/npage/change/chkPrint.jsp?retInfo="+infoStr+"&dirtPage=<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=themob%>";                    
}
</script>

<%if(!ret_code.equals("000000")){%>
    <script language='jscript'>
    var ret_code = "<%=ret_code%>";
    var ret_msg = "<%=ret_msg%>";
    rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
    history.go(-1);
    </script>
<%}%>

<%if(ret_code.equals("000000")&&handcash>0.0){%>
    <script language="jscript">
    rdShowMessageDialog('�����ɹ�����ӡ��Ʊ.......',2);

    printBill();
    </script>
<%}%>

<%if(ret_code.equals("000000")){%>
    <script language='jscript'>
    rdShowMessageDialog('�����ɹ����뷵��.......',2);
    document.location.replace("f1584_1.jsp?ph_no=<%=themob%>");
    </script>
<%}%>


<%String url ="/npage/contact/upCnttInfo.jsp?opCode="+opCode1+
							"&retCodeForCntt="+ret_code+
							"&opName="+opName1+
							"&workNo="+thework_no+
							"&loginAccept="+stream+
							"&pageActivePhone="+themob+
							"&retMsgForCntt="+ret_msg+
							"&opBeginTime="+opBeginTime; %>
<jsp:include page="<%=url%>" flush="true" />