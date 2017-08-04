<%
/********************
 *version v2.0
 *������: si-tech
 *update by qidp @ 2008-12-26
 ********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>

<%
    String workNo = request.getParameter("workNo");
    String phoneNo = request.getParameter("phoneNo");
    String opCode = request.getParameter("opCode");
    String orgCode = request.getParameter("orgCode");
        //System.out.println("workNo is : "+workNo);
        //System.out.println("phoneNo is : " + phoneNo);
        //System.out.println("opCode is : " + opCode);
        //System.out.println("orgCode is : " + orgCode);
        //F1222Wrapper wrap=new F1222Wrapper();
        //ArrayList arr = wrap.callF1222Init(workNo,phoneNo,opCode,orgCode);
%>
    <wtc:service name="s1222Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1222InitCode" retmsg="s1222InitMsg" outnum="53" >
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=phoneNo%>"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=orgCode%>"/>
    </wtc:service>
    <wtc:array id="userInfo" start="0" length="22" scope="end" />
    <wtc:array id="moreInfo" start="22" length="31" scope="end" />
<%
        //String[][] userInfo = (String[][])arr.get(0);
        //String[][] moreInfo = (String[][])arr.get(1);
        //String[][] errInfo = (String[][])arr.get(2);

    String[][] errInfo = new String[][]{{s1222InitCode,s1222InitMsg}};
    
    if(errInfo[0][1].equals("")){
        errInfo[0][1] = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(errInfo[0][0]));
        if( errInfo[0][1].equals("null")){
            errInfo[0][1] ="δ֪������Ϣ";
        }
    } 
        //System.out.println("moreInfo length is : "+moreInfo.length);
        //System.out.println("errCode is  : "+ errInfo[0][0]);
        //System.out.println("errMsg is  : "+ errInfo[0][1]);
        //System.out.println(userInfo.length);

    if(userInfo.length==0){
%>
        var response = new AJAXPacket();
        
        response.guid = '<%= request.getParameter("guid") %>';
        
        
        response.data.add("backString","");
        response.data.add("moreString","");
        
        response.data.add("flag","9");
        response.data.add("errCode","<%=errInfo[0][0]%>");
        response.data.add("errMsg","<%=errInfo[0][1]%>");


        core.ajax.receivePacket(response);

<%	
    }else{
            //System.out.println("idNo			�û�id                        is : "+userInfo[0][0]);
            //System.out.println("smCode			ҵ�����ʹ���                  is : "+userInfo[0][1]);
            //System.out.println("smName			ҵ����������                  is : "+userInfo[0][2]);
            //System.out.println("custName		�ͻ�����                      is : "+userInfo[0][3]);
            //System.out.println("userPassword	�û�����                      is : "+userInfo[0][4]);
            //System.out.println("runCode			״̬����                      is : "+userInfo[0][5]);
            //System.out.println("runName			״̬����                      is : "+userInfo[0][6]);
            //System.out.println("ownerGrade		�ȼ�����                      is : "+userInfo[0][7]);
            //System.out.println("gradeName		�ȼ�����                      is : "+userInfo[0][8]);
            //System.out.println("ownerType		�û�����                      is : "+userInfo[0][9]);
            //System.out.println("ownerTypeName	�û���������                  is : "+userInfo[0][10]);
            //System.out.println("custAddr		�ͻ�סַ                      is : "+userInfo[0][11]);
            //System.out.println("idType			֤������                      is : "+userInfo[0][12]);
            //System.out.println("idName			֤������                      is : "+userInfo[0][13]);
            //System.out.println("idIccid			֤������                      is : "+userInfo[0][14]);
            //System.out.println("totalOwe		��ǰǷ��                      is : "+userInfo[0][15]);
            //System.out.println("totalPrepay		��ǰԤ��                      is : "+userInfo[0][16]);
            //System.out.println("firstOweConNo	��һ��Ƿ���ʺ�                is : "+userInfo[0][17]);
            //System.out.println("firstOweFee		��һ��Ƿ���ʺŽ��            is : "+userInfo[0][18]);                                                                                               
%> 
                                                  
<%                                                        
        String strArray = CreatePlanerArray.createArray("userInfo",userInfo.length);
        String strArray1 = CreatePlanerArray.createArray("moreInfo",moreInfo.length);
%>
        <%=strArray%> 
        <%=strArray1%>
<%                                                        
        for(int i = 0 ; i < userInfo.length ; i ++){            
            for(int j = 0 ; j < userInfo[i].length ; j ++){                                                                                                               
%>                                                      
                                                        
                userInfo[<%=i%>][<%=j%>] = "<%=userInfo[i][j].trim()%>" ;
<%                                                      
            }                                                       
        }                                                       
%>
<%                                                      
                                                        
        for(int i = 0 ; i < moreInfo.length ; i ++){            
            for(int j = 0 ; j < moreInfo[i].length ; j ++){   
                                                        
                                                        
%>                                                      
                                                        
                moreInfo[<%=i%>][<%=j%>] = "<%=moreInfo[i][j].trim()%>" ;
<%                                                      
            }                                                       
        }                                                       
%>
    var response = new AJAXPacket();
    
    response.guid = '<%= request.getParameter("guid") %>';
    
    response.data.add("backString",userInfo);
    response.data.add("moreString",moreInfo);
    response.data.add("flag","0");
    response.data.add("errCode","<%=errInfo[0][0]%>");
    response.data.add("errMsg","<%=errInfo[0][1]%>");
    
    core.ajax.receivePacket(response);
<%}%>