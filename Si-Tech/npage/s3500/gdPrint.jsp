<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>

<HTML>
<HEAD>
    <TITLE>����������ӡ</TITLE>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>    
</HEAD>

<% 
	request.setCharacterEncoding("gb2312");

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	String[][] baseInfoSession = (String[][])arrSession.get(0);
    String work_no = baseInfoSession[0][2];
    String loginName = baseInfoSession[0][3];
    String org_code = baseInfoSession[0][16];
	String op_code = "1210";
	String nopass = ((String[][])arrSession.get(4))[0][0];
	String paraStr[]=new String[37];

 	paraStr[0]=op_code;
	paraStr[1]=work_no;
	paraStr[2]=nopass;
	paraStr[3]=org_code;

	String[][] busInfoSession = (String[][])arrSession.get(2);
	String busiSpot=busInfoSession[0][5]+busInfoSession[0][6]+busInfoSession[0][7];

	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	String submitCfm = request.getParameter("submitCfm");
%>
<SCRIPT type=text/javascript>
onload=function()
{
  var rdBackColor = "#E3EEF9";

  // If IE version >=5.5, This will be works
  // gradient start color
  var rdGradientStartColor = "#FFFFFFFF";

  // gradient end color
  var rdGradientEndColor = "#FFFDEDC1";

  // gradient type, 1 represents from left to right, 0 reresents from top to bottom
  var rdGradientType = "0";

  var fillter = "progid:DXImageTransform.Microsoft.Gradient(startColorStr="+rdGradientStartColor+",endColorStr="+rdGradientEndColor+", gradientType="+rdGradientType+")";

  document.bgColor = rdBackColor;
  document.body.style.filter = fillter;	
}

function doPrint()
{
  try
  {
	//��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var chPos = -1;
	var tempObj = new Array(5);
	var temp;
	var strLen,fontSize,fontStyle;
	var printStr,InfoStr; 
	infoStr = "<%=printInfo%>";

	var startCol=18;
	var startRow=11;
      	  
 	    printctrl.Print(startCol-2,startRow,10,0,oneTok(infoStr,"|",1));      //�ֻ�����
        printctrl.Print(startCol+26,startRow,10,0,oneTok(infoStr,"|",2));      //����

        printctrl.Print(startCol-8,startRow+3,10,0,oneTok(infoStr,"|",3));      //�ͻ�����
        printctrl.Print(startCol-8+31,startRow+3,10,0,oneTok(infoStr,"|",4));      //��ϵ�绰

        printctrl.Print(startCol-8,startRow+6,10,0,oneTok(infoStr,"|",5));     //��ϵ��ַ

        printctrl.Print(startCol-8,startRow+9,10,0,oneTok(infoStr,"|",6));     //֤������

        printctrl.Print(startCol-8,startRow+12,10,0,oneTok(infoStr,"|",7));     //֤����ַ
    
	    var busiStr=oneTok(infoStr,"|",8);
		var temStr="";
		var j=0;
		var lineLen=45;
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
	    {
          temStr=oneTok(busiStr,"*",i+1);
		  if(temStr.length<lineLen)
		  {
            j++; 
            printctrl.Print(startCol-16,startRow+38+j*1,9,0,oneTok(busiStr,"*",i+1)); //ҵ����Ŀ
		  }
		  else
		  {
            var nums=Math.ceil((temStr.length/lineLen));
			for(var k=0;k<nums;k++)
			{
				j++;
				if(k<(nums*1-1))
				{
		          printctrl.Print(startCol-16,startRow+38+j*1,9,0,temStr.substring(lineLen*k,(lineLen*k+lineLen)));			     				  
				}
				else
				{
                  printctrl.Print(startCol-16,startRow+38+j*1,9,0,temStr.substring(lineLen*k,temStr.length));				  
				}
			}
		  }
		}

        printctrl.Print(startCol-7,startRow+49,10,0,oneTok(infoStr,"|",11));//ICCID����
		printctrl.Print(startCol-15,startRow+52,9,0,oneTok(infoStr,"|",9));    //ϵͳ��ע
	    printctrl.Print(startCol-15,startRow+54,9,0,oneTok(infoStr,"|",10));    //������ע

		printctrl.Print(startCol-7,startRow+65,10,0,"<%=busiSpot%>");    //Ӫҵ��
	    printctrl.Print(startCol-7,startRow+68,10,0,"<%=work_no%>");    //����

	 
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
     //rdShowMessageDialog("��ӡ�����ϣ��޷���ӡ������");
  }
  finally
  {
	//���ش�ӡȷ����Ϣ
	var cfmInfo = "<%=submitCfm%>";
	var retValue = "";
	if(cfmInfo == "Yes")
	{	retValue = "confirm";	}
	window.returnValue= retValue;     
	window.close(); 
  }
}

function doSub()
{
  window.returnValue="continueSub";
  window.close();
}
</SCRIPT>
<!--**************************************************************************************-->

<BODY>

<FORM method=post name="spubPrint">

        <div align="center">
           <input class="button" name=commit onClick="doPrint()"   type=button value="��ӡ">
		  <input class="button" name=back onClick="doSub()"   type=button value="��һ��">
         </div>
  <div class="popup">
	  	<div class="popup_qu" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>
		  </div>

        <div align="center">
           <input class="button" name=commit onClick="doPrint()"   type=button value="��ӡ">
		  <input class="button" name=back onClick="doSub()"   type=button value="��һ��">
         </div>
	    <br>   
  </div> 
</FORM>
<jsp:include page="/page/common/printatl.jsp"/>
</BODY>
</HTML>    
