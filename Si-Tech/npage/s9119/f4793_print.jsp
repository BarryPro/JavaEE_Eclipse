<html xmlns="http://www.w3.org/1999/xhtml">
<%@page import="java.util.*"%>
<%@page import="java.text.*" %>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sitech.crmpd.core.bean.MapBean"%>
<%@page import="com.sitech.crmpd.core.util.SiUtil"%>
<%@page import="java.math.*" %>

<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%
	String loginNo = (String)session.getAttribute("workNo");
	String loginName=(String)session.getAttribute("workName");
	String groupName = (String)session.getAttribute("orgName");
	String loginAccept = request.getParameter("loginAccept");
	System.out.println("==f4793_print=loginAccept==="+loginAccept);
	System.out.println("==f4793_print=loginNo==="+loginNo);
	System.out.println("==f4793_print=loginName==="+loginName);
	System.out.println("==f4793_print=groupName==="+groupName);

	String custName = request.getParameter("custName")==null?"":request.getParameter("custName");//�ͻ�����
	String smName =  request.getParameter("smName")==null?"":request.getParameter("smName");//�ͻ�Ʒ��
    String depositFee = request.getParameter("depositFee")==null?"":request.getParameter("depositFee");//Ѻ��
    String phoneNo = request.getParameter("phoneNo")==null?"":request.getParameter("phoneNo");
    String depositFeeBig = request.getParameter("depositFeeBig")==null?"":request.getParameter("depositFeeBig");//Ѻ���д���
    String boxId = request.getParameter("boxId")==null?"":request.getParameter("boxId");
    String netCode = request.getParameter("netCode")==null?"":request.getParameter("netCode");
    String idtype = request.getParameter("idtype")==null?"":request.getParameter("idtype");
    String iccid = request.getParameter("iccid")==null?"":request.getParameter("iccid");

    System.out.println("==f4793_print=custName==="+custName);
    System.out.println("==f4793_print=smName==="+smName);
    System.out.println("==f4793_print=depositFee==="+depositFee);
    System.out.println("==f4793_print=phoneNo==="+phoneNo);
    System.out.println("==f4793_print=depositFeeBig==="+depositFeeBig);
    System.out.println("==f4793_print=boxId==="+boxId);
    System.out.println("==f4793_print=netCode==="+netCode);
    		
	 int ran = new Random().nextInt(9000)+1000;
	 Calendar c = Calendar.getInstance();
	 String year = c.get(Calendar.YEAR) + "";
	 String month = c.get(Calendar.MONTH) + 1 +"";
	 String day = c.get(Calendar.DAY_OF_MONTH) + "";
%>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<base target="_self">
<SCRIPT language="JavaScript">
	//���תΪ����
	function toChnWord(n) {
	    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
	         return "���ݷǷ�";
	    var unit = "ǧ��ʰ��ǧ��ʰ��Ǫ��ʰԪ�Ƿ�", str = "";
	         n += "00";
	    var p = n.indexOf('.');
	    if (p >= 0)
	         n = n.substring(0, p) + n.substr(p+1, 2);
	         unit = unit.substr(unit.length - n.length);
	    for (var i=0; i < n.length; i++)
	         str += '��Ҽ��������½��ƾ�'.charAt(n.charAt(i)) + unit.charAt(i);
	    return str.replace(/��(Ǫ|��|ʰ|��)/g, "��").replace(/(��)+/g, "��").replace(/��(��|��|Ԫ)/g, "$1").replace(/(��)��|Ҽ(ʰ)/g, "$1$2").replace(/^Ԫ��?|���/g, "").replace(/Ԫ$/g, "Ԫ��");
	}
	function InitAjax() {
	    var ajax;
	    if (window.ActiveXObject) {
	        var versions = ['Microsoft.XMLHTTP', 'MSXML.XMLHTTP', 'Microsoft.XMLHTTP', 'Msxml2.XMLHTTP.7.0', 'Msxml2.XMLHTTP.6.0', 'Msxml2.XMLHTTP.5.0', 'Msxml2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP'];
	        for (var i = 0; i < versions.length; i++) {
	            try {
	                ajax = new ActiveXObject(versions[i]);
	                if (ajax) {
	                    return ajax;
	                }
	            } catch (e) {
	            }
	
	        }
	    } else if (window.XMLHttpRequest) {
	        ajax = new XMLHttpRequest();
	    }
	
	    return ajax;
	}
	//js�Զ������ļ������� 
	var xh;
	var localPath = "C:/billLogo.jpg";
	function getXML(geturl) {
	    xh = InitAjax();
	    xh.onreadystatechange = getReady;
	    xh.open("GET", geturl, true);
	    xh.send();
	}
	
	function getReady() { 
	    if (xh.readyState == 4) {
	        if (xh.status == 200) {
	            saveFile(localPath);
	            return true;
	        }
	        else {
	            return false;
	        }
	    }
	    else
	        return false;
	}
	
	function saveFile(tofile) {
		if(!judgeFileExsit(tofile)) {
			var objStream;
		    var imgs;
		    imgs = xh.responseBody;
		    objStream = new ActiveXObject("ADODB.Stream");
		    objStream.Type = 1;
		    objStream.open();
		    objStream.write(imgs);
		    objStream.SaveToFile(tofile);
		}
	}
	
	function judgeFileExsit(filespec)
	{
	  var fso = new ActiveXObject("Scripting.FileSystemObject");
	  if (fso.FileExists(filespec)) {
	      return true;
	  }
	  else {
	      return false;	
	  }
	}

    function printInvoice()
    {
	    printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
         <%-- getXML("<%=request.getContextPath()%>/nresources/UI/images/billLogo.jpg");
		printctrl.DrawImage(localPath,8,10,40,18);//�������� --%>
		printctrl.Print(30, 4, 12, 0, "�й��ƶ�ͨ�ż��ź��������޹�˾�ն����վ�");
       	//��Ʊ��α��
	    printctrl.Print(13, 10, 9, 0, "��Ʊ����:<%=year%>��<%=month%>��<%=day%>��");
	   <%--  printctrl.Print(80, 11, 9, 0, "���η�Ʊ����:<%=s_invoice_number_contract%>"); --%>
	    
	   
	    printctrl.Print(13, 13, 9, 0, "�ͻ����ƣ�<%=custName%>");//�ͻ�����
	    printctrl.Print(50, 13, 9, 0, "����˺ţ�<%=netCode%>");
	    printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ�ƣ�<%=smName%>");//�ͻ�Ʒ�� 
	    
	    <%-- printctrl.Print(115, 13, 9, 0, "�ͻ�Ʒ�ƣ�<%=smName%>");//�ͻ�Ʒ�� --%>
	    
	    printctrl.Print(13, 14, 9, 0, "�û����룺<%=phoneNo%>");//�û�����
	    printctrl.Print(50, 14, 9, 0, "Э����룺");
	    printctrl.Print(80, 14, 9, 0, "�������ڣ�");
	    printctrl.Print(115, 14,9, 0, "��ͬ�ţ�");
	    
	    printctrl.Print(13, 15, 9, 0, "ҵ�����ħ�ٺ�Ѻ��");
	    printctrl.Print(115, 15,9, 0, "֧Ʊ�ţ�");
	    
	    printctrl.Print(13, 16, 9, 0, "֤�����ͣ�<%=idtype%>");
	    printctrl.Print(50, 16,9, 0, "֤�����룺<%=iccid%>");
	    printctrl.Print(115, 16,9, 0, "����ͳ�����룺");
	    
	    printctrl.Print(13, 17, 9, 0, "�ն˴��룺<%=boxId%>");	
	    
	    printctrl.Print(13, 18, 9, 0, "Ʒ�����");
	    printctrl.Print(43, 18, 9, 0, "��λ");
	    printctrl.Print(73, 18, 9, 0, "����"); 
	    printctrl.Print(103, 18, 9, 0, "����");

	    printctrl.Print(13, 19, 9, 0, "ħ�ٺ��ն�Ѻ�����");
	    printctrl.Print(43, 19, 9, 0, "̨");
	    printctrl.Print(73, 19, 9, 0, "1"); 
	    printctrl.Print(103, 19, 9, 0, <%=depositFee%>);
	    
	    printctrl.Print(13, 20, 9, 0, "�ϼƣ�");
	    /* printctrl.Print(40, 18, 9, 0, "̨");
	    printctrl.Print(60, 18, 9, 0, "1"); */
	    printctrl.Print(80,20, 9, 0, "<%=depositFee%>");
	    
	    printctrl.Print(13, 23, 9, 0, "���η�Ʊ��(Сд)�� <%=depositFee%>");
	    printctrl.Print(80, 23, 9, 0, "��д���ϼƣ�<%=depositFeeBig%>");

	    printctrl.Print(13, 25, 9, 0, "��ע:�𾴵Ŀͻ�����������ҵ���˶�����ֹҵ��ʹ�õĲ���ʱ,��Я�����վݡ���Ч���֤��");
	    printctrl.Print(20, 26, 9, 0, "����ҵ��ʱ����ħ�ٺ��ն˵��ƶ�ָ������Ӫҵ������Ѻ���˻�������");
	    
	   // printctrl.Print(115,21, 9, 0, "���ɽ�");
	    
	    
		  /*   printctrl.Print(13, 23, 9, 0, "���ν��ѣ�  �ֽ�");
		    printctrl.Print(50, 23, 9, 0, "֧Ʊ");
		    printctrl.Print(70, 23, 9, 0, "ˢ��");
		    
		    printctrl.Print(13, 24, 9, 0, "�������:");
		    printctrl.Print(50, 24, 9, 0, "δ���˻���:");
		    printctrl.Print(70, 24, 9, 0, "��ǰ�������:"); */
	    
	    printctrl.Print(11, 28, 9, 0, "��ˮ�ţ�"+"<%=loginAccept %>");
	    printctrl.Print(50, 28, 9, 0, "��Ʊ�ˣ�"+"<%=loginName %>");
	    printctrl.Print(80, 28, 9, 0, "���ţ�"+"<%=loginNo %>");
	    printctrl.Print(115,28, 9, 0, "Ӫ������"+"<%=groupName%>");
        
        printctrl.PageEnd();
        printctrl.StopPrint();

        window.close();
    }
    
</SCRIPT>
</head>
<body onload="printInvoice()">
<input type="button" value="�ر�" onclick="window.close()">
<OBJECT
        classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
        codebase="/ocx/PrintEx.dll#version=1,1,0,5"
        id="printctrl"
        style="DISPLAY: none"
        VIEWASTEXT
        >
</OBJECT>
</body>
</html>