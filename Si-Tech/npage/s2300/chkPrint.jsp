<%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-12 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<!--
Setup ��ʾ��ӡ���öԻ��� 1 ��ʾ 0 ����ʾ
StartPrint ��ʼ��ӡ
PageStart �µ�ҳ
Print 
����1 x���꣨0 - 100��һ�����꣩
����2 y���꣨0 - 100��һ�����꣩
����3 �ֺţ�0 - 100��0Ϊϵͳȱʡ�ֺţ�
����4 �ִ�ϸ��0 - 10��0Ϊϵͳȱʡ��
����5 Ҫ��ӡ���ַ���

PageEnd ҳ����
StopPrint ֹͣ��ӡ
<!-------------------------------------------->

<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<% 
    
    	String work_no = (String)session.getAttribute("workNo");
	String retInfo=request.getParameter("retInfo");
	String dirtPage=request.getParameter("dirtPage");
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
  
function doPrint()
{
  var infoStr="<%=retInfo%>";
  
  try
  {
     //��ӡ��ʼ��
	printctrl.Setup(0);
	printctrl.StartPrint();
	printctrl.PageStart();

	var startCol=20;
   	 var startRow=7;
      
  	    //printctrl.Print(startCol-2,startRow,0,0,oneTok(infoStr,"|",1));      //֤������ 
        printctrl.Print(startCol+10,startRow+1,10,0,oneTok(infoStr,"|",2));      //��
		printctrl.Print(startCol+18,startRow+1,10,0,oneTok(infoStr,"|",3));      //��
		printctrl.Print(startCol+23,startRow+1,10,0,oneTok(infoStr,"|",4));      //��

        printctrl.Print(startCol-5,startRow+3,10,0,oneTok(infoStr,"|",5));      //�ֻ����� 
        printctrl.Print(startCol+30,startRow+3,10,0,oneTok(infoStr,"|",6));   //��ͬ����  

        printctrl.Print(startCol-10,startRow+4,10,0,oneTok(infoStr,"|",7));     //�ͻ����� 

        printctrl.Print(startCol-10,startRow+6,10,0,oneTok(infoStr,"|",8));     //��ϵ��ַ

		printctrl.Print(startCol-10,startRow+8,10,0,oneTok(infoStr,"|",9));     //���ʽ

        //��Сд���
		printctrl.Print(startCol,startRow+10,10,0,chineseNumber(oneTok(infoStr,"|",10)));
		printctrl.Print(startCol+35,startRow+10,0,0,oneTok(infoStr,"|",10));     

        //ҵ����Ŀ
	    var busiStr=oneTok(infoStr,"|",11);
	    for(var i=0;i<getTokNums(busiStr,"*");i++)
          printctrl.Print(startCol-15,startRow+12+i*1,9,0,oneTok(busiStr,"*",i+1));  
       
	    //����Ա���տ�Ա
	    printctrl.Print(10,32,9,0,"<%=work_no%>");
		printctrl.Print(35,32,9,0,"<%=work_no%>");
         
 
	//��ӡ����
	printctrl.PageEnd();
	printctrl.StopPrint();
  }
  catch(e)
  {
 	rdShowMessageDialog("��ӡ�����ϣ��޷���ӡ��Ʊ��");
  }
  finally
  {
     location="<%=dirtPage%>";
  }
}
function chineseNumber(num)
{
if(parseFloat(num)<=0.01) return "��Բ��"
if (isNaN(num) || num > Math.pow(10, 12)) return ""
var cn = "��Ҽ��������½��ƾ�"
var unit = new Array("ʰ��Ǫ", "�ֽ�")
var unit1= new Array("����", "")
var numArray = num.toString().split(".")
var start = new Array(numArray[0].length-1, 2)

	function toChinese(num, index)
	{
	var num = num.replace(/\d/g, function ($1)
	{
	return cn.charAt($1)+unit[index].charAt(start--%4 ? start%4 : -1)
	})
	return num
	}

for (var i=0; i<numArray.length; i++)
{
var tmp = ""
for (var j=0; j*4<numArray[i].length; j++)
{
var strIndex = numArray[i].length-(j+1)*4
var str = numArray[i].substring(strIndex, strIndex+4)
var start = i ? 2 : str.length-1
var tmp1 = toChinese(str, i)
tmp1 = tmp1.replace(/(��.)+/g, "��").replace(/��+$/, "")
tmp1 = tmp1.replace(/^Ҽʰ/, "ʰ")
tmp = (tmp1+unit1[i].charAt(j-1)) + tmp
}
numArray[i] = tmp 
}

numArray[1] = numArray[1] ? numArray[1] : ""
numArray[0] = numArray[0] ? numArray[0]+"Բ" : numArray[0], numArray[1] = numArray[1].replace(/^��+/, "")
numArray[1] = numArray[1].match(/��/) ? numArray[1] : numArray[1]+"��"
return numArray[0]+numArray[1]
}
 </SCRIPT>
<!--**************************************************************************************-->
 <BODY  onload="doPrint()">
<FORM method=post name="spubPrint">
<!------------------------------------------------------>
   
          
  
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
