<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-27 页面改造,修改样式
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%!
		public static String createArray(String aimArrayName, int xDimension)
    {
        String stringArray = "var " + aimArrayName + " = new Array(";
        int flag = 1;
        for(int i = 0; i < xDimension; i++)
        {
            if(flag == 1)
            {
                stringArray = stringArray + "new Array()";
                flag = 0;
                continue;
            }
            if(flag == 0)
            {
                stringArray = stringArray + ",new Array()";
            }
        }

        stringArray = stringArray + ");";
        return stringArray;
    }
%>
<%
	String [] inPubParams= new String [6];
	inPubParams[0] = request.getParameter("vEvalValue");
	inPubParams[1] = request.getParameter("vLoginAccept");
	inPubParams[2] = request.getParameter("vOpCoce");
	inPubParams[3] = request.getParameter("vLoginNo");
	inPubParams[4] = request.getParameter("vPhoneNo");
	
	System.out.println("vEvalValue :" + inPubParams[0]);
	System.out.println("vLoginAccept :" + inPubParams[1]);	
	System.out.println("vLoginAccept :" + inPubParams[4]);
	
	//String [] backInfo = impl.callService("sCommEvalCfm", inPubParams, "3", "phoneno", inPubParams[5]);								   
%>
	<wtc:service name="sCommEvalCfm" routerKey="phone" routerValue="<%=inPubParams[4]%>" outnum="3" >
	<wtc:param value="<%=inPubParams[0]%>"/>
	<wtc:param value="<%=inPubParams[1]%>"/>
	<wtc:param value="<%=inPubParams[2]%>"/>
	<wtc:param value="<%=inPubParams[3]%>"/>
	<wtc:param value="<%=inPubParams[4]%>"/>
	</wtc:service>
<%	
	String  errCode = retCode;
	String  errMsg = retMsg;
	System.out.println("Msg1 :" + errCode + ":" + errMsg);
%>

<%
	String strArray = createArray("backInfo",backInfo.length);
%>

