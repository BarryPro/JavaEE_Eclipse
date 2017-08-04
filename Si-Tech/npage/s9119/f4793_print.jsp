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

	String custName = request.getParameter("custName")==null?"":request.getParameter("custName");//客户名称
	String smName =  request.getParameter("smName")==null?"":request.getParameter("smName");//客户品牌
    String depositFee = request.getParameter("depositFee")==null?"":request.getParameter("depositFee");//押金
    String phoneNo = request.getParameter("phoneNo")==null?"":request.getParameter("phoneNo");
    String depositFeeBig = request.getParameter("depositFeeBig")==null?"":request.getParameter("depositFeeBig");//押金大写金额
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
	//金额转为汉字
	function toChnWord(n) {
	    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
	         return "数据非法";
	    var unit = "千佰拾亿千佰拾万仟佰拾元角分", str = "";
	         n += "00";
	    var p = n.indexOf('.');
	    if (p >= 0)
	         n = n.substring(0, p) + n.substr(p+1, 2);
	         unit = unit.substr(unit.length - n.length);
	    for (var i=0; i < n.length; i++)
	         str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
	    return str.replace(/零(仟|佰|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
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
	//js自动下载文件到本地 
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
		printctrl.DrawImage(localPath,8,10,40,18);//左上右下 --%>
		printctrl.Print(30, 4, 12, 0, "中国移动通信集团黑龙江有限公司终端类收据");
       	//发票防伪码
	    printctrl.Print(13, 10, 9, 0, "开票日期:<%=year%>年<%=month%>月<%=day%>日");
	   <%--  printctrl.Print(80, 11, 9, 0, "本次发票号码:<%=s_invoice_number_contract%>"); --%>
	    
	   
	    printctrl.Print(13, 13, 9, 0, "客户名称：<%=custName%>");//客户名称
	    printctrl.Print(50, 13, 9, 0, "宽带账号：<%=netCode%>");
	    printctrl.Print(115, 13, 9, 0, "客户品牌：<%=smName%>");//客户品牌 
	    
	    <%-- printctrl.Print(115, 13, 9, 0, "客户品牌：<%=smName%>");//客户品牌 --%>
	    
	    printctrl.Print(13, 14, 9, 0, "用户号码：<%=phoneNo%>");//用户号码
	    printctrl.Print(50, 14, 9, 0, "协议号码：");
	    printctrl.Print(80, 14, 9, 0, "话费账期：");
	    printctrl.Print(115, 14,9, 0, "合同号：");
	    
	    printctrl.Print(13, 15, 9, 0, "业务类别：魔百盒押金");
	    printctrl.Print(115, 15,9, 0, "支票号：");
	    
	    printctrl.Print(13, 16, 9, 0, "证件类型：<%=idtype%>");
	    printctrl.Print(50, 16,9, 0, "证件号码：<%=iccid%>");
	    printctrl.Print(115, 16,9, 0, "集团统付号码：");
	    
	    printctrl.Print(13, 17, 9, 0, "终端串码：<%=boxId%>");	
	    
	    printctrl.Print(13, 18, 9, 0, "品名规格");
	    printctrl.Print(43, 18, 9, 0, "单位");
	    printctrl.Print(73, 18, 9, 0, "数量"); 
	    printctrl.Print(103, 18, 9, 0, "单价");

	    printctrl.Print(13, 19, 9, 0, "魔百和终端押金费用");
	    printctrl.Print(43, 19, 9, 0, "台");
	    printctrl.Print(73, 19, 9, 0, "1"); 
	    printctrl.Print(103, 19, 9, 0, <%=depositFee%>);
	    
	    printctrl.Print(13, 20, 9, 0, "合计：");
	    /* printctrl.Print(40, 18, 9, 0, "台");
	    printctrl.Print(60, 18, 9, 0, "1"); */
	    printctrl.Print(80,20, 9, 0, "<%=depositFee%>");
	    
	    printctrl.Print(13, 23, 9, 0, "本次发票金额：(小写)￥ <%=depositFee%>");
	    printctrl.Print(80, 23, 9, 0, "大写金额合计：<%=depositFeeBig%>");

	    printctrl.Print(13, 25, 9, 0, "备注:尊敬的客户，如您办理业务退订等中止业务使用的操作时,请携带本收据、有效身份证件");
	    printctrl.Print(20, 26, 9, 0, "办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。");
	    
	   // printctrl.Print(115,21, 9, 0, "滞纳金：");
	    
	    
		  /*   printctrl.Print(13, 23, 9, 0, "本次交费：  现金");
		    printctrl.Print(50, 23, 9, 0, "支票");
		    printctrl.Print(70, 23, 9, 0, "刷卡");
		    
		    printctrl.Print(13, 24, 9, 0, "话费余额:");
		    printctrl.Print(50, 24, 9, 0, "未出账话费:");
		    printctrl.Print(70, 24, 9, 0, "当前可用余额:"); */
	    
	    printctrl.Print(11, 28, 9, 0, "流水号："+"<%=loginAccept %>");
	    printctrl.Print(50, 28, 9, 0, "开票人："+"<%=loginName %>");
	    printctrl.Print(80, 28, 9, 0, "工号："+"<%=loginNo %>");
	    printctrl.Print(115,28, 9, 0, "营销厅："+"<%=groupName%>");
        
        printctrl.PageEnd();
        printctrl.StopPrint();

        window.close();
    }
    
</SCRIPT>
</head>
<body onload="printInvoice()">
<input type="button" value="关闭" onclick="window.close()">
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