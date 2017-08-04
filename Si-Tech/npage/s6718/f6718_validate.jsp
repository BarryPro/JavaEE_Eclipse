<% 
  /*
   * 功能: 校验彩铃卡号，得到彩铃卡信息
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
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
    //得到输入参数
    Logger logger = Logger.getLogger("f6718_validate.jsp");
    
    //读取用户session信息
    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arrSession.get(0);
    //String workNo   = baseInfo[0][2];                 //工号
    //String workName = baseInfo[0][3];               	//工号姓名
    //String org_code = baseInfo[0][16];
    String ip_Addr  = request.getRemoteAddr();
    //String[][] pass = (String[][])arrSession.get(4);   
    //String nopass  = pass[0][0];                     	//登陆密码
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
    
    paramsIn[0]=workNo;                                 //操作工号         
    paramsIn[1]=nopass;                                 //操作工号密码     
    paramsIn[2]="6718";                                 //操作代码         
    paramsIn[3]="彩铃卡号验证";                         //操作描述         
    paramsIn[4]=colorRing_no;                           //用户手机号码     
    
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
        
        //sOutCardMonth      =result1  [0][0];       // 彩铃卡使用期   
        //sOutCardValue      =result2  [0][0];       // 彩铃卡面额        
        //sOutColorType      =result3  [0][0];       // 彩铃卡类型        
        //sOutColorTypeName  =result4  [0][0];       // 彩铃卡类型名称    
        //sOutProductCode    =result5  [0][0];       // 彩铃卡产品代码    
        //sOutProductName    =result6  [0][0];       // 彩铃卡产品名称   
        
        sOutCardMonth      =sCRGetCarInfoArr[0][0];       // 彩铃卡使用期   
        sOutCardValue      =sCRGetCarInfoArr[0][1];       // 彩铃卡面额        
        sOutColorType      =sCRGetCarInfoArr[0][2];       // 彩铃卡类型        
        sOutColorTypeName  =sCRGetCarInfoArr[0][3];       // 彩铃卡类型名称    
        sOutProductCode    =sCRGetCarInfoArr[0][4];       // 彩铃卡产品代码    
        sOutProductName    =sCRGetCarInfoArr[0][5];       // 彩铃卡产品名称    	           				       
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
