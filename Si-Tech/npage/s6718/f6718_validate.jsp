<% 
  /*
   * ����: У����忨�ţ��õ����忨��Ϣ
�� * �汾: v1.00
�� * ����: 2007/09/13
�� * ����: liubo
�� * ��Ȩ: sitech
   * �޸���ʷ
   * update by qidp @ 2008-12-17
   *  
   */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="org.apache.log4j.Logger"%>


<%
    //�õ��������
    Logger logger = Logger.getLogger("f6718_validate.jsp");
    
    //��ȡ�û�session��Ϣ
    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arrSession.get(0);
    //String workNo   = baseInfo[0][2];                 //����
    //String workName = baseInfo[0][3];               	//��������
    //String org_code = baseInfo[0][16];
    String ip_Addr  = request.getRemoteAddr();
    //String[][] pass = (String[][])arrSession.get(4);   
    //String nopass  = pass[0][0];                     	//��½����
    //String regionCode=org_code.substring(0,2);
    
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass = (String)session.getAttribute("password");
    String regionCode=org_code.substring(0,2);
    
    String retType = request.getParameter("retType");
    String colorRing_no = request.getParameter("colorRing_no");
    
    String sOutCardMonth    ="0";
    String sOutCardValue    ="0";
    String sOutColorType    ="0";
    String sOutColorTypeName="0";
    String sOutProductCode  ="0";
    String sOutProductName  ="0";
    
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
    String paramsIn[] = new String[5];
    
    paramsIn[0]=workNo;                                 //��������         
    paramsIn[1]=nopass;                                 //������������     
    paramsIn[2]="6718";                                 //��������         
    paramsIn[3]="���忨����֤";                         //��������         
    paramsIn[4]=colorRing_no;                           //�û��ֻ�����     
    
    //ArrayList acceptList = new ArrayList(); 
    //acceptList = impl.callFXService("sCRGetCarInfo",paramsIn,"6");
    //impl.printRetValue();
%>
    <wtc:service name="sCRGetCarInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="sCRGetCarInfoCode" retmsg="sCRGetCarInfoMsg" outnum="7">
        <wtc:param value="<%=paramsIn[0]%>"/>
        <wtc:param value="<%=paramsIn[1]%>"/>
        <wtc:param value="<%=paramsIn[2]%>"/>
        <wtc:param value="<%=paramsIn[3]%>"/>
        <wtc:param value="<%=paramsIn[4]%>"/>
    </wtc:service>
    <wtc:array id="sCRGetCarInfoArr" scope="end" />
<%
    //int errCode = impl.getErrCode();
    //String errMsg = impl.getErrMsg();
    
    String errCode = sCRGetCarInfoCode;
    String errMsg = sCRGetCarInfoMsg;
    
    
    if(errCode.equals("000000"))
    {
        //String result1  [][]	= (String[][])acceptList.get(0);
        //String result2  [][]  = (String[][])acceptList.get(1);
        //String result3  [][]	= (String[][])acceptList.get(2);
        //String result4  [][]	= (String[][])acceptList.get(3);
        //String result5  [][]	= (String[][])acceptList.get(4);
        //String result6  [][]	= (String[][])acceptList.get(5);
        
        //sOutCardMonth      =result1  [0][0];       // ���忨ʹ����   
        //sOutCardValue      =result2  [0][0];       // ���忨���        
        //sOutColorType      =result3  [0][0];       // ���忨����        
        //sOutColorTypeName  =result4  [0][0];       // ���忨��������    
        //sOutProductCode    =result5  [0][0];       // ���忨��Ʒ����    
        //sOutProductName    =result6  [0][0];       // ���忨��Ʒ����   
        
        sOutCardMonth      =sCRGetCarInfoArr[0][0];       // ���忨ʹ����   
        sOutCardValue      =sCRGetCarInfoArr[0][1];       // ���忨���        
        sOutColorType      =sCRGetCarInfoArr[0][2];       // ���忨����        
        sOutColorTypeName  =sCRGetCarInfoArr[0][3];       // ���忨��������    
        sOutProductCode    =sCRGetCarInfoArr[0][4];       // ���忨��Ʒ����    
        sOutProductName    =sCRGetCarInfoArr[0][5];       // ���忨��Ʒ����    	           				       
    }								
%>



var response = new AJAXPacket();
var retType = "<%=retType%>";
var retMessage="<%=errMsg%>";
var retCode= "<%=errCode%>";
var CardMonth  = "<%=sOutCardMonth%>"
var CardValue  ="<%=sOutCardValue%>"
var ColorType  = "<%=sOutColorType%>";
var ColorTypeName = "<%=sOutColorTypeName%>"
var ProductCode   ="<%=sOutProductCode%>"
var ProductName   = "<%=sOutProductName%>";


response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);    
response.data.add("CardMonth",CardMonth);      
response.data.add("CardValue",CardValue);
response.data.add("ColorType",ColorType);      
response.data.add("ColorTypeName",ColorTypeName);      
response.data.add("ProductCode",ProductCode);
response.data.add("ProductName",ProductName);
core.ajax.receivePacket(response);
