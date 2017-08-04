<%

/********************

 version v2.0

开发商: si-tech @yuanqs  2010/10/28 15:43:02 分层需求

********************/

%>

<%@ page contentType="text/html; charset=GBK" %>

<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%

		 //得到输入参数

		String sqlStr = WtcUtil.repStr(request.getParameter("sqlStr"), "");

		String retType = WtcUtil.repStr(request.getParameter("retType"), "");

		String sqlStrCount = "select count(*) from ( " + sqlStr + " )";

		String regionCode = (String)session.getAttribute("regCode");

		String errorCode="";

		String errorMsg=""; 

%>

<%!

    public static String createArray(String aimArrayName, int xDimension) {

        String stringArray = "var " + aimArrayName + " = new Array(";

        int flag = 1;

        for (int i = 0; i < xDimension; i++) {

            if (flag == 1) {

                stringArray = stringArray + "new Array()";

                flag = 0;

                continue;

            }

            if (flag == 0) {

                stringArray = stringArray + ",new Array()";

            }

        }



        stringArray = stringArray + ");";

        return stringArray;

    }

%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult" retmsg="retMsg" outnum="1">

		<wtc:sql><%=sqlStrCount%></wtc:sql>

		</wtc:pubselect>

		<wtc:array id="result1" scope="end" />



<%

		String detailCount = (result1[0][0]).trim();

	if(retResult.equals("0")||retResult.equals("000000"))

	{

      System.out.println("调用服务sPubSelect in getDetailNote.jsp@@@@@@@@@@@@@@@@@@@@@@@@@@="+sqlStrCount);

 		  System.out.println("============"+detailCount);

 		  errorCode="000000";

 		  errorMsg ="查询成功";

 	}

 	else

 	{

 		errorCode = "999999";

 		errorMsg = "查询失败";

		System.out.println("调用服务sPubSelect in getDetailNote.jsp 失败@@@@@@@@@@@@@@@@@@@@@@@@@@");

	}

	System.out.println("&&&&&&&&&&&&  retResult="+retResult);

	System.out.println("&&&&&&&&&&&&  errorCode="+errorCode);



%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retResult1" retmsg="retMsg1" outnum="2">

		<wtc:sql><%=sqlStr%></wtc:sql>

		</wtc:pubselect>

		<wtc:array id="result2" scope="end" />

<%

		String tri_detailMsg = createArray("js_detail_msg", result2.length); 

		System.out.println("sqlStr===" + sqlStr + "===yuanqs");

%>

<%=tri_detailMsg%>

<%

    for (int p = 0; p < result2.length; p++) {

        for (int q = 0; q < result2[p].length; q++) {

        System.out.println(result2[p][q] + "=======yuanqs");

%>

					js_detail_msg[<%=p%>][<%=q%>]="<%=result2[p][q]%>";

<%

        }

    }

%>



var response = new AJAXPacket();

response.data.add("retResult","<%=retResult1%>");

response.data.add("detailCount","<%=detailCount%>");

response.data.add("js_detail_msg",js_detail_msg);

response.data.add("errorCode","<%=errorCode%>");

response.data.add("errorMsg","<%=errorMsg%>");

response.data.add("retType","<%=retType%>");

core.ajax.receivePacket(response);

<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>







