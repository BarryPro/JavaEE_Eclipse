<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-20 ҳ�����,�޸���ʽ
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
		//�����ʱû�п������.��ѯ��,�ɼ�������.
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] info = (String[][])arr.get(2);//��ȡ��½IP����ɫ���ƣ����ڲ��ţ���ϣ�

%>

<%

    String phone = WtcUtil.repNull(request.getParameter("phone"));//�ֻ�����
    String date = WtcUtil.repNull(request.getParameter("date"));//����
    String name = WtcUtil.repNull(request.getParameter("name"));//����
    String address = WtcUtil.repNull(request.getParameter("address"));//��ַ
    String cardno = WtcUtil.repNull(request.getParameter("cardno"));//֤������
    String stream = WtcUtil.repNull(request.getParameter("stream"));//��ˮ
    String toprintdata = WtcUtil.repNull(request.getParameter("kx_want")) + WtcUtil.repNull(request.getParameter("kx_cancle")) + WtcUtil.repNull(request.getParameter("kx_running")) ;//���������ҵ���������
    String sysnote = WtcUtil.repNull(request.getParameter("sysnote"));//ȡ��ϵͳ��־
    String donote = WtcUtil.repNull(request.getParameter("tonote"));//ȡ�ò�����־
    String work_no = WtcUtil.repNull(request.getParameter("work_no"));//��������

/**
ArrayList streamList = new ArrayList();//���巵�صĽ����
String[][] result = new String[][]{};

%>
<%

      String sqlStr = "select sMaxSysAccept.nextval from dual";
      if(stream.equals("0"))//�ж��Ƿ���ˮ����0 �������0 ��ʾ��һ�ε��ô�ӡ
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
        rdShowMessageDialog('��ӡ�ɹ�!');
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
    out.println("printctrl.Print(18,11,10,0,'"+phone+"')");//�ֻ�����
    out.println("printctrl.Print(47,11,10,0,'"+date+"')"); //����
    out.println("printctrl.Print(12,14,10,0,'"+name+"')");//�ͻ�����
    out.println("printctrl.Print(12,17,10,0,'"+address+"')");//��ϵ��ַ
    out.println("printctrl.Print(12,20,10,0,'"+cardno+"')");//֤������
    out.println("printctrl.Print(12,23,10,0,'"+address+"')");//֤����ַ
    
    /*****************************ѭ����ӡҵ���������************************************/
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
    out.println("printctrl.Print(6,'"+row+"',9,0,'"+sysnote+"')");//ϵͳ��ע
    out.println("printctrl.Print(6,58,9,0,'"+donote+"')");//������ע
    //out.println("printctrl.Print(12,60,10,0,'"+cardno+"')");//���֤��
    out.println("printctrl.Print(12,76,10,0,'"+info[0][5]+info[0][6]+info[0][7]+"')");//����Ӫҵ��
    out.println("printctrl.Print(12,79,10,0,'"+work_no+"')");//ӪҵԱ����
    /*******************************************************************************/
    out.println("printctrl.PageEnd()");
    out.println("printctrl.StopPrint()");
    out.println("}catch(e){}finally{return true;}");
    //out.println("sdfasdfsa");
    %>
        return true;
    }
</script>
