<%
    /********************
     * @ OpCode    :  b030
     * @ OpName    :  ��ʡVPMN��Ա�����г�Ա��ѡ�����ʷѵĻ�ȡ
     * @ CopyRight :  si-tech
     * @ Author    :  qidp
     * @ Date      :  2010-7-19 21:14:11
     * @ Update    :  
     ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String opCode = "b030";
    String opName = "��ʡV�����ų�Ա�����ʷѹ���";
    
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		
    String iGroupNo = WtcUtil.repNull((String)request.getParameter("group_no"));    //��ʡ���ű��
    String iAcrGroupNo = WtcUtil.repNull((String)request.getParameter("acr_group_no")); //��ʡ���ű��
    
    String sqlStr = "";
    String errCode = "";
    String errMsg = "";
    try{
        sqlStr = "SELECT b.other_value1,c.offer_name FROM DACROSSVPMNRELATION A, DACROSSVPMNFEEDEPLOY B,product_offer c WHERE A.FEE_INDEX = B.FEE_INDEX AND b.other_value1 = c.offer_id AND A.GROUP_NO ='"+iGroupNo+"' AND A.ACR_GROUP_NO ='"+iAcrGroupNo+"' ORDER BY b.other_value1";
        System.out.println("sqlStr = "+sqlStr);
    %>
        <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
        	<wtc:sql><%=sqlStr%></wtc:sql>
        </wtc:pubselect>
        <wtc:array id="retArr" scope="end"/>
    <%
        errCode = retCode;
        errMsg = retMsg;
        System.out.println(retArr.length);
    	String[][] colNameArr = retArr;	
        String strArray = WtcUtil.createArray("colNameArr",colNameArr.length);
        System.out.println(strArray);
        %>
            <%=strArray%>
        <%
        for(int i = 0 ; i < colNameArr.length ; i ++){
            for(int j = 0 ; j < colNameArr[i].length; j ++){
                System.out.println(colNameArr[i][j].trim());
            %>
                colNameArr[<%=i%>][<%=j%>] = "<%=colNameArr[i][j].trim()%>";
            <%
            }
        }
    }catch(Exception e){
        e.printStackTrace();
        errCode = "999999";
        errMsg = "��ѯ��Ա��ѡ�����ʷ�ʧ�ܣ�";
    }
%>

var response = new AJAXPacket();
var errCode = "";
var errMsg = "";
errCode = "<%=errCode%>";
errMsg = "<%=errMsg%>";

response.data.add("errCode",errCode);
response.data.add("errMsg",errMsg);
response.data.add("backString",colNameArr);
core.ajax.receivePacket(response);