<%
/********************
 version v2.0
������: si-tech
update:liutong@20080924
********************/
%>
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<HTML>
<HEAD>
    <TITLE>����������ӡ</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"></HEAD>

<% 
	request.setCharacterEncoding("gb2312");

    //ArrayList arrSession = (ArrayList)session.getAttribute("allArr");

	/**String[][] baseInfoSession = (String[][])arrSession.get(0);
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
	**/
	  //  String opCode = "1100";
	  //	 String opName = "�ͻ�����";
	    String op_code = "1210";
        String work_no =(String)session.getAttribute("workNo");
        String workName =(String)session.getAttribute("workName");
        String org_code =(String)session.getAttribute("orgCode");
        String nopass=(String)session.getAttribute("password");
        String regionCode = org_code.substring(0,2);
        String paraStr[]=new String[37];
        	paraStr[0]=op_code;
			paraStr[1]=work_no;
			paraStr[2]=nopass;
			paraStr[3]=org_code;

	String DlgMsg = request.getParameter("DlgMsg");
	String printInfo = request.getParameter("printInfo");
	String submitCfm = request.getParameter("submitCfm");
%>
<SCRIPT type=text/javascript>
	/**���ַ�������tok�ֽ�ȡֵ**/
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
		
			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }

	/**���ַ�������tok�ֽ��,ȡ�����ַ�������**/
	function getTokNums(str,tok){
	   var temStr=str;
	   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
	   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);
	
	   var temLen;
	   var temNum=1;
	   while(temStr.indexOf(tok)!=-1)
	   {	
	      temLen=temStr.length;
	      temLoc=temStr.indexOf(tok);
	      temStr=temStr.substring(temLoc+1,temLen);
		  temNum++;
	   }
	   return temNum;
	}
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

	var startCol=35;//18
	var startRow=15;//11
      	  
 	    printctrl.Print(startCol-9,startRow,10,0,oneTok(infoStr,"|",1));        //����
        printctrl.Print(startCol+33,startRow,10,0,oneTok(infoStr,"|",2));       //����Ա

		printctrl.Print(startCol-9,startRow+3,10,0,oneTok(infoStr,"|",3));      //�ͻ�����
		printctrl.Print(startCol-9,startRow+4,10,0,oneTok(infoStr,"|",4));      //֤������
        printctrl.Print(startCol-9,startRow+5,10,0,oneTok(infoStr,"|",5));      //֤����ַ
        printctrl.Print(startCol-9,startRow+6,10,0,oneTok(infoStr,"|",6));     //��ϵ������
		printctrl.Print(startCol-9,startRow+7,10,0,oneTok(infoStr,"|",7));     //��ϵ�˵绰
        printctrl.Print(startCol-9,startRow+8,10,0,oneTok(infoStr,"|",8));     //��ϵ�˵�ַ
		printctrl.Print(startCol-9,startRow+9,10,0,oneTok(infoStr,"|",9));     //��ӡ��ˮ
        printctrl.Print(startCol-9,startRow+10,10,0,oneTok(infoStr,"|",10));    

        //printctrl.Print(startCol-9,startRow+11,10,0,oneTok(infoStr,"|",11));     
    
	    var busiStr=oneTok(infoStr,"|",11);
		var temStr="";
		var j=0;
		var lineLen=45;
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
	    {
          temStr=oneTok(busiStr,"*",i+1);
		  if(temStr.length<lineLen)
		  {
            j++; 
            printctrl.Print(startCol-8,startRow+36+j*1,9,0,oneTok(busiStr,"*",i+1)); //ҵ����Ŀ
		  }
		  else
		  {
            var nums=Math.ceil((temStr.length/lineLen));
			for(var k=0;k<nums;k++)
			{
				j++;
				if(k<(nums*1-1))
				{
		          printctrl.Print(startCol-8,startRow+36+j*1,9,0,temStr.substring(lineLen*k,(lineLen*k+lineLen)));			     				  
				}
				else
				{
                  printctrl.Print(startCol-8,startRow+36+j*1,9,0,temStr.substring(lineLen*k,temStr.length));				  
				}
			}
		  }
		}

       // printctrl.Print(startCol-7,startRow+49,10,0,oneTok(infoStr,"|",11));//ICCID����
		printctrl.Print(startCol-8,startRow+51,9,0,oneTok(infoStr,"|",12));    //ϵͳ��ע
	    printctrl.Print(startCol-8,startRow+52,9,0,oneTok(infoStr,"|",13));    //������ע


	 
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
<body style="overflow-x:hidden;overflow-y:hidden">
	<head>
		<title>�������ƶ�BOSS</title>
		<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
	</head>
<FORM method=post name="spubPrint">
  <!------------------------------------------------------>
  <div class="popup">
	  	<div class="popup_qu" id="rdImage" align=center>
		  	<div class="popup_zi orange" id="message"><%=DlgMsg%></div>
		  </div>

	    <div align="center">
           <input class="b_foot" name=commit onClick="doPrint()"   type=button value="��ӡ">
		  		 <input class="b_foot" name=back onClick="doSub()"   type=button value="��һ��">
	    </div>
	    <br>   
	 </div>
</FORM>
<!-------�����ӡ�ؼ�---------->
<OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
</BODY>
</HTML>    
