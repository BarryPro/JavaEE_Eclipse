<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GB2312" %>
<HTML>
<HEAD>
    <TITLE>��ӡ</TITLE>
</HEAD>

<%
    String DlgMsg = request.getParameter("DlgMsg");
    String printInfo = request.getParameter("printInfo");
    String submitCfm = request.getParameter("submitCfm");
%>
<SCRIPT type=text/javascript>
onload = function()
{
    var rdBackColor = "#E3EEF9";

  // If IE version >=5.5, This will be works
    // gradient start color
    var rdGradientStartColor = "#FFFFFFFF";

  // gradient end color
    var rdGradientEndColor = "#FFFDEDC1";

  // gradient type, 1 represents from left to right, 0 reresents from top to bottom
    var rdGradientType = "0";

    var fillter = "progid:DXImageTransform.Microsoft.Gradient(startColorStr=" + rdGradientStartColor + ",endColorStr=" + rdGradientEndColor + ", gradientType=" + rdGradientType + ")";

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

        var startCol = 18;
        var startRow = 10;
       //������Ϣ 	
        //printctrl.Print(startCol + 45, startRow - 6, 10, 0, oneTok(infoStr, "|", 1));       //��½����
        //printctrl.Print(startCol + 3, startRow - 6, 10, 0, oneTok(infoStr, "|", 2));        //����
        printctrl.Print(startCol - 2, startRow, 10, 0, oneTok(infoStr, "|", 1));  	        //�ͻ����� 
        printctrl.Print(startCol + 40, startRow  , 10, 0, oneTok(infoStr, "|", 2));        //�ֻ�����
        printctrl.Print(startCol - 2, startRow + 3, 10, 0, oneTok(infoStr, "|", 3));        //��ϵ��ַ
        printctrl.Print(startCol + 40, startRow + 3, 10, 0, oneTok(infoStr, "|", 4));        //֤������
        printctrl.Print(startCol - 2, startRow + 6, 10, 0, oneTok(infoStr, "|", 5));        //֤����ַ
        printctrl.Print(startCol + 40, startRow + 6, 10, 0, oneTok(infoStr, "|", 6));        //��ϵ�绰
        
        //printctrl.Print(startCol - 2, startRow + 9, 10, 0, oneTok(infoStr, "|", 7));        //�¿ͻ�����
        //printctrl.Print(startCol + 40, startRow + 9, 10, 0, oneTok(infoStr, "|", 8));       //���ֻ�����
        printctrl.Print(startCol - 2, startRow + 9, 10, 0, oneTok(infoStr, "|", 7));       //��֤������  
        printctrl.Print(startCol - 2, startRow + 12, 10, 0, oneTok(infoStr, "|", 8));      //��֤����ַ  
        printctrl.Print(startCol - 2, startRow + 15, 10, 0, oneTok(infoStr, "|", 9));      //����ϵ��ַ  
        printctrl.Print(startCol + 40, startRow + 15, 10, 0, oneTok(infoStr, "|", 10));      //����ϵ�绰  
        printctrl.Print(startCol - 2, startRow + 18, 10, 0, oneTok(infoStr, "|", 11));      //�¸��ѷ�ʽ
        printctrl.Print(startCol - 40, startRow + 18, 10, 0, oneTok(infoStr, "|", 12));
        //�հ�
        printctrl.Print(startCol - 2, startRow + 19, 10, 0, oneTok(infoStr, "|", 13));      //
        printctrl.Print(startCol - 2, startRow + 20, 10, 0, oneTok(infoStr, "|", 14));      //
        printctrl.Print(startCol - 2, startRow + 21, 10, 0, oneTok(infoStr, "|", 15));      //
        printctrl.Print(startCol - 2, startRow + 22, 10, 0, oneTok(infoStr, "|", 16));      //
        printctrl.Print(startCol - 2, startRow + 24, 10, 0, oneTok(infoStr, "|", 17));      //
        printctrl.Print(startCol - 2, startRow + 27, 10, 0, oneTok(infoStr, "|", 18));      //
        //��ˮ����Ϣ
        printctrl.Print(startCol - 2, startRow + 30, 10, 0, oneTok(infoStr, "|", 19));      //
        printctrl.Print(startCol - 2, startRow + 33, 10, 0, oneTok(infoStr, "|", 20));      //
        printctrl.Print(startCol - 2, startRow + 36, 10, 0, oneTok(infoStr, "|", 21));      //
        //�հ�
        printctrl.Print(startCol - 2, startRow + 37, 10, 0, oneTok(infoStr, "|", 22));      //
        printctrl.Print(startCol - 2, startRow + 38, 10, 0, oneTok(infoStr, "|", 23));      //
        printctrl.Print(startCol - 2, startRow + 39, 10, 0, oneTok(infoStr, "|", 24));      //
        //��ע��    
        printctrl.Print(startCol - 2, startRow + 40, 10, 0, oneTok(infoStr, "|", 25));      //ϵͳ��ע
        //printctrl.Print(startCol-2,startRow+42,10,0,oneTok(infoStr,"|",30));      //������ע
        //���д�ӡ����
        var lineLen = 45;
        var temStr = oneTok(oneTok(infoStr, "|", 36));//����
        if (temStr.length - lineLen < 0)
        {
            //printctrl.Print(startCol-2,startRow+42,10,0,tempStr);
            printctrl.Print(startCol - 2, startRow + 42, 10, 0, oneTok(infoStr, "|", 36));
        } else
        {
            var nums = Math.ceil((temStr.length / lineLen));
            for (var k = 0; k < nums; k++)
            {
                if (k < (nums * 1 - 1))
                {
                    printctrl.Print(startCol - 2, startRow + 42 + k * 1, 10, 0, temStr.substring(lineLen * k, (lineLen * k + lineLen)));
                } else
                {
                    printctrl.Print(startCol - 2, startRow + 42 + k * 1, 10, 0, temStr.substring(lineLen * k, temStr.length));
                }
            }
        }		
	

	 
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
        if (cfmInfo == "Yes")
        {
            retValue = "confirm";
        }
        window.returnValue = retValue;
        window.close();
    }
}

function doSub()
{
    window.returnValue = "continueSub";
    window.close();
}


function oneTok(str,tok,loc)
{

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
</SCRIPT>

		<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
		<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>	
<BODY>
<FORM method=post name="spubPrint">
		<div class="popup">
			<div class="popup_qu" id="rdImage" align=center>
			  <div class="popup_zi orange" id="message"><%=DlgMsg%></div>
			</div>
    	<div align="center">
				<input class="b_foot" name=commit onClick="doPrint()" type=button value="��ӡ">
        <input class="b_foot" name=back onClick="doSub()" type=button value="ȡ��">
			</div>
			<br>
		</div>
</FORM>
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
