<%
String versonType = (String)session.getAttribute("versonType");
System.out.println("# versonType is : "+versonType);
session.setAttribute("cssPath",null);
session.setAttribute("layout",null);
if("simple".equals(versonType)){
    cssPath = "default";    /* 高速版时直接读取default下的css */
 	layout = "2";
    session.setAttribute("cssPath",cssPath);
    session.setAttribute("layout",layout);
}else{
    String sqlStr = "select all_path,login_path,vilid_flag,layout_status from SSKINCFG where login_no = '"+workNo+"'";
    System.out.println("# css sql = "+sqlStr);
    /*******
     * vilid_flag 0:表示节日肤色; 1:表示工号肤色.
     * all_path:节日肤色.
     * login_path:工号肤色.
     * layout_status:面板状态.
     *******/
     String cssPathDefault = "default"; /* 默认皮肤：查询SSKINCFG表出错或该工号无记录时使用此皮肤. */
     String layoutDefault = "2";        /* 默认面板：查询SSKINCFG表出错或该工号无记录时使用此面板. */
try{
%>
    <wtc:pubselect name="sPubSelect" retcode="retCode" retmsg="retMsg" outnum="4" routerKey="region" routerValue="<%=regionCode%>">
    	<wtc:sql><%=sqlStr%></wtc:sql>
    </wtc:pubselect>
    <wtc:array id="retArr" scope="end"/>
<%
    if("000000".equals(retCode) && retArr.length>0){
        if("0".equals(retArr[0][2])){
            cssPath = retArr[0][0];
        }else{
            cssPath = retArr[0][1];
        }
        layout = retArr[0][3];
    }else{
        cssPath = cssPathDefault;
        layout = layoutDefault;
    }
}catch(Exception e){
 	e.printStackTrace();
 	cssPath = cssPathDefault;
 	layout = layoutDefault;
}
    cssPathDefault = "";
    layoutDefault = "";
    session.setAttribute("cssPath",cssPath);
    session.setAttribute("layout",layout);
}
System.out.println("# css path is : "+cssPath);
System.out.println("# layout is : "+layout);
%>