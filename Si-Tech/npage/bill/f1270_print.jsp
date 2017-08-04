<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *update:zhanghonga@2008-08-20 页面改造,修改样式
     *
     ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);

%>
<%
		//这个暂时没有可替代的.已询问,可继续保留.
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] info = (String[][])arr.get(2);//读取登陆IP，角色名称，所在部门（组合）

%>

<%

    String phone = WtcUtil.repNull(request.getParameter("phone"));//手机号码
    String date = WtcUtil.repNull(request.getParameter("date"));//日期
    String name = WtcUtil.repNull(request.getParameter("name"));//姓名
    String address = WtcUtil.repNull(request.getParameter("address"));//地址
    String cardno = WtcUtil.repNull(request.getParameter("cardno"));//证件号码
    String stream = WtcUtil.repNull(request.getParameter("stream"));//流水
    String toprintdata = WtcUtil.repNull(request.getParameter("kx_want")) + WtcUtil.repNull(request.getParameter("kx_cancle")) + WtcUtil.repNull(request.getParameter("kx_running")) ;//传入的所有业务操作参数
    String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));//取得系统日志
    String donote = WtcUtil.repNull(request.getParameter("tonote"));//取得操作日志
    String work_no = WtcUtil.repNull(request.getParameter("work_no"));//操作工号

/**
ArrayList streamList = new ArrayList();//定义返回的结果集
String[][] result = new String[][]{};

%>
<%

      String sqlStr = "select sMaxSysAccept.nextval from dual";
      if(stream.equals("0"))//判断是否流水等于0 ，如果是0 表示第一次调用打印
        {
           try{
                streamList = callView.spubqry32Process("1","0",sqlStr).getList();
              }
            catch(Exception e)
              {
                //System.out.println("Call services is Failed!");
              }
          result = (String[][])streamList.get(0);
          stream = result[0][0];
        }
      

%>
**/
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=phone%>" id="sLoginAccept"/>
<%

    if(stream.equals("0")){
        stream = sLoginAccept;
    }

%>

<html>

<META http-equiv=Content-Type content="text/html; charset=GBK">
<OBJECT
        classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
        codebase="/ocx/printatl.dll#version=1,0,0,1"
        id="printctrl"
        style="DISPLAY: none"
        VIEWASTEXT
        >
</OBJECT>

<body onload="ifprint()">
<form action="" name="form" method="post">
</form>
</body>
</html>
<script language="javascript">
    function ifprint()
    {
        printInvoice();
        rdShowMessageDialog('打印成功!');
        var end = true;
        var stream = <%=stream%>;
        var theend = "true" + stream;
 //alert(theend);
        window.returnValue = theend;
        window.close();

    }

    function printInvoice()
    {
    <%
    out.println("try{");
    out.println("printctrl.Setup(0)");
    out.println("printctrl.StartPrint()");
    out.println("printctrl.PageStart()");
    out.println("printctrl.Print(18,11,10,0,'"+phone+"')");//手机号码
    out.println("printctrl.Print(47,11,10,0,'"+date+"')"); //日期
    out.println("printctrl.Print(12,14,10,0,'"+name+"')");//客户姓名
    out.println("printctrl.Print(12,17,10,0,'"+address+"')");//联系地址
    out.println("printctrl.Print(12,20,10,0,'"+cardno+"')");//证件号码
    out.println("printctrl.Print(12,23,10,0,'"+address+"')");//证件地址
    
    /*****************************循环打印业务操作内容************************************/
    String retInfo = toprintdata;
            int chPos = 0;
            int row = 51;
            int col = 6;
            chPos = retInfo.indexOf("|"); 
            String valueStr =""; 
            while(chPos > -1)
            {
             valueStr = retInfo.substring(0,chPos);
             out.println("printctrl.Print('"+col+"','"+row+"',9,0,'"+valueStr+"')" );
             row = row +1;
    
                retInfo = retInfo.substring(chPos + 1);
                chPos = retInfo.indexOf("|");
                if( !(chPos > -1)) break;
            }
    out.println("printctrl.Print(6,'"+row+"',9,0,'"+sysnote+"')");//系统备注
    out.println("printctrl.Print(6,58,9,0,'"+donote+"')");//操作备注
    //out.println("printctrl.Print(12,60,10,0,'"+cardno+"')");//身份证号
    out.println("printctrl.Print(12,76,10,0,'"+info[0][5]+info[0][6]+info[0][7]+"')");//受理营业厅
    out.println("printctrl.Print(12,79,10,0,'"+work_no+"')");//营业员工号
    /*******************************************************************************/
    out.println("printctrl.PageEnd()");
    out.println("printctrl.StopPrint()");
    out.println("}catch(e){}finally{return true;}");
    //out.println("sdfasdfsa");
    %>
        return true;
    }
</script>
