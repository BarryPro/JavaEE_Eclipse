<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-27 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!-------------------------------------------->
<!---����: 2003-10-23 ---->
<!---����: sunzhe ---->
<!---����: fPubSimpSel.jsp ---->
<!---���ܣ� ��ӡȷ�Ͻ��� ---->
<!---�޸ģ� ---->


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
<%@ page contentType="text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="java.util.*"%>
<HTML>
<HEAD>
    <TITLE>��Ʊ��ӡ</TITLE>
</HEAD>

<%
    ArrayList arrSession = (ArrayList) session.getAttribute("allArr");
    String[][] busInfoSession = (String[][]) arrSession.get(2);
    String busiSpot = busInfoSession[0][5] + busInfoSession[0][6] + busInfoSession[0][7];//�Ҳ��������,��ʱ�����.20080827
    String work_no = (String) session.getAttribute("workNo");
    request.setCharacterEncoding("gb2312");
    String retInfo = request.getParameter("retInfo");
    String dirtPage = request.getParameter("dirtPage");
    String backDate = request.getParameter("backDate");
    String phone = request.getParameter("activePhone");  //�����������Ϊ����f1213.jsp����phone
    System.out.println("##########################################phone->" + phone);

	//Billing�ṩȡ���������
	java.util.Random r = new java.util.Random();
	int key = 99999;
	int ran = r.nextInt(9999);
	int ran1 = r.nextInt(10)*1000;
	if ((ran+"").length()<4) {
		ran = ran+ran1;
	}
	int realKey = ran ^ key;
	
	int ran2 = r.nextInt(9999);
	int ran3 = r.nextInt(10)*1000;
	if ((ran2+"").length()<4) {
		ran3 = ran2+ran3;
	}
	int realKey2 = ran2 ^ key;
	
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== ���ȡrealKey = " + realKey);
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== ���ȡrealKey2 = " + realKey2);
	String accept = request.getParameter("accept");
	String opCode = request.getParameter("opCode");
	String opName = request.getParameter("opName");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	
	String sqlIdNo ="select * from dcustmsg where phone_no ='"+phone+"'";
	String idNo="";
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sqlIdNo = " + sqlIdNo);
%>
	<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeIdNo" retmsg="retMsgIdNo">
		<wtc:sql><%=sqlIdNo%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultIdNo" scope="end"/>
<%
	System.out.println("====wanghfa====pubBillPrintCfm.jsp==== sPubSelect retCodeIdNo = " + retCodeIdNo);
	if(retCodeIdNo.equals("000000") && resultIdNo.length > 0){
		idNo=resultIdNo[0][0];
  }else {
	}

%>
<SCRIPT type=text/javascript>

function doPrint()
{
  var infoStr = "<%=retInfo%>";
	var inDbPacket = new AJAXPacket("/npage/innet/pubBillPrint_ajaxInDb.jsp","���ڽ��з�Ʊ��⣬���Ժ�......");
	inDbPacket.data.add("inParams0", "<%=realKey%>");							//�����
	inDbPacket.data.add("inParams1", "<%=accept%>");					//ҵ����ˮ
	inDbPacket.data.add("inParams2", "<%=opCode%>");								//opCode
	inDbPacket.data.add("inParams3", "<%=work_no%>");								//����
	inDbPacket.data.add("inParams4", oneTok(infoStr, "|", 2) + oneTok(infoStr, "|", 3) + oneTok(infoStr, "|", 4));	//������
	inDbPacket.data.add("inParams5", "<%=phone%>");		//�ƶ�����
	inDbPacket.data.add("inParams6", "<%=idNo%>");									//�û�idNo
	inDbPacket.data.add("inParams7", "1");		//�෢Ʊ���
	<%
		for (int j = 1;j <= (retInfo.split("\\|").length); j ++) {
			System.out.println("====wanghfa====pubBillPrintCfm.jsp==== j = " + j);
		%>
			inDbPacket.data.add("inParams<%=7+j%>", oneTok(infoStr, "|", <%=j%>));
		<%
		}
	%>
	inDbPacket.data.add("inParamsNo", "<%=retInfo.split("\\|").length + 8%>");
	core.ajax.sendPacket(inDbPacket, printIt);
	inDbPacket.data.add("inParams0", "<%=realKey2%>");							//�����
	core.ajax.sendPacket(inDbPacket, printIt);
	inDbPacket = null;
}
var successNo = 0;
function printIt(packet){
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	if (retCode != "000000" && retCode != "0") {
		alert("s1300PrintInDB��Ʊ���ʧ�ܣ�"+retCode+"��"+retMsg+"������ϵ����Ա�Ϳ�����Ա��");
		window.close();
		return false;
	} else {
		successNo ++;
	}
	
	if (successNo != 2) {
		return false;
	} else {
    var infoStr = "<%=retInfo%>";
    try
    {
        //��ӡ��ʼ��
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
				
        /*liujian 2012-3-26 10:17:24 �޸ķ�Ʊ begin */
        printctrl.Print(20,9,9, 0, oneTok(infoStr,"|",2)+oneTok(infoStr,"|",3)+oneTok(infoStr,"|",4));
		 		printctrl.Print(50,9,9, 0, "�ʵ�ͨ��ҵ");
	
				printctrl.Print(13,11,9,0, "��α�룺<%=ran%>");	//��Ʊ��α��
				
				printctrl.Print(13,12,9,0,"��    �ţ�");//����
				printctrl.Print(33,12,9,0,"������ˮ��");//��ˮ
				printctrl.Print(53,12,9,0,"ҵ�����ƣ�");//ҵ������
				
				printctrl.Print(13,13,9,0,"�ͻ����ƣ�" + oneTok(infoStr, "|", 7));//�û�����
				printctrl.Print(53,13,9,0,"��    �ţ�");//����
				
				printctrl.Print(13,14,9,0,"�ֻ����룺" + oneTok(infoStr, "|", 5));//�ƶ�����
				printctrl.Print(33,14,9,0,"Э����룺");//Э�����
				printctrl.Print(53,14,9,0,"֧Ʊ���룺");//֧Ʊ����
				
				printctrl.Print(13,15,9,0,"�ϼƽ�(��д)" + chineseNumber(oneTok(infoStr, "|", 10)));//�ϼƽ��(��д)
				printctrl.Print(55,15,9,0,"(Сд)��" + oneTok(infoStr, "|", 10));//���(Сд)
				
				printctrl.Print(13,17,9,0,"(��Ŀ)");//��Ŀ
				
				var busiStr = oneTok(infoStr, "|", 11);
				var row = 0;
				for(var i=0;i<getTokNums(busiStr,"~");i++) {
					if (i % 2 == 0) {
						printctrl.Print(20,17+row,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
					} else if (i % 2 == 1) {
						printctrl.Print(50,17+row,9,0,oneTok(busiStr,"~",i+1));  //ҵ����Ŀ
						row ++;
					}
				}
				printctrl.Print(20,24,9,0,oneTok(infoStr, "|", 8));  //��ϵ��ַ
				printctrl.Print(20,25,9,0,"�ֽ�:");  //���ʽ
				
				printctrl.Print(13,29,9,0,"��Ʊ��<%=work_no%>"); //����Ա
				printctrl.Print(43,29,9,0,"�տ<%=work_no%>");//�տ�Ա 
				printctrl.Print(69,29,9,0,"���ˣ�");
 				/*liujian 2012-3-26 10:17:24 �޸ķ�Ʊ end */
 				
	//��ӡ����
        printctrl.PageEnd();
        printctrl.PageStart();
        
        /*liujian 2012-3-26 10:17:24 �޸ķ�Ʊ begin */        
        printctrl.Print(20,9,9, 0, "<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>");
		printctrl.Print(50,9,9, 0, "�ʵ�ͨ��ҵ");

		printctrl.Print(13,11,9,0, "��α�룺<%=ran%>");	//��Ʊ��α��
		
		printctrl.Print(13,12,9,0,"��    �ţ�<%=work_no%>");//����
		printctrl.Print(33,12,9,0,"������ˮ��");//��ˮ
		printctrl.Print(53,12,9,0,"ҵ�����ƣ�");//ҵ������
		
		printctrl.Print(13,13,9,0,"�ͻ����ƣ�" + oneTok(infoStr, "|", 7));//�û����� 0
		printctrl.Print(53,13,9,0,"��    �ţ�");//����
		
		printctrl.Print(13,14,9,0,"�ֻ����룺" + oneTok(infoStr, "|", 5));//�ƶ����� 0
		printctrl.Print(33,14,9,0,"Э����룺");//Э�����
		printctrl.Print(53,14,9,0,"֧Ʊ���룺");//֧Ʊ����
		
		printctrl.Print(13,15,9,0,"�ϼƽ�(��д)" + chineseNumber(oneTok(infoStr, "|", 10)));//�ϼƽ��(��д)
		printctrl.Print(55,15,9,0,"(Сд)��" + oneTok(infoStr, "|", 10));//���(Сд)
		
		printctrl.Print(13,17,9,0,"(��Ŀ)");//��Ŀ
		
		printctrl.Print(20, 17, 9, 0, "�û���ַ��" + oneTok(infoStr, "|", 8));
		printctrl.Print(20, 18, 9, 0, "֤�����룺" + oneTok(infoStr, "|", 9));
		printctrl.Print(50, 18, 9, 0, "�˿����ڣ�<%=backDate%>");
		printctrl.Print(20, 19, 9, 0, "Ӫҵ����<%=busiSpot%>");
		printctrl.Print(20, 20, 9, 0, "��ע��" + oneTok(infoStr, "|", 1));
		printctrl.Print(20, 21, 9, 0, "�ͻ����ѣ����㻰��ʱ��������˳ֱ���ִ��");
		printctrl.Print(20, 22, 9, 0, "����Ч���֤��ǰ������");

		printctrl.Print(13,29,9,0,"��Ʊ��<%=work_no%>"); //����Ա
		printctrl.Print(43,29,9,0,"�տ<%=work_no%>");//�տ�Ա 
		printctrl.Print(69,29,9,0,"���ˣ�");
        /*liujian 2012-3-26 10:17:24 �޸ķ�Ʊ end */
        
        printctrl.PageEnd();
        printctrl.StopPrint();
    }
    catch(e)
    {
        //rdShowMessageDialog("��ӡ�����ϣ��޷���ӡ��Ʊ��");
    }
    finally
    {
        location = "<%=dirtPage%>?activePhone=<%=phone%>&opCode=<%=opCode%>&opName=<%=opName%>";
    }
  }
}

function oneTok(str, tok, loc)
{

    var temStr = str;
    if (str.charAt(0) == tok) temStr = str.substring(1, str.length);
    if (str.charAt(str.length - 1) == tok) temStr = temStr.substring(0, temStr.length - 1);

    var temLoc;
    var temLen;
    for (ii = 0; ii < loc - 1; ii++)
    {
        temLen = temStr.length;
        temLoc = temStr.indexOf(tok);
        temStr = temStr.substring(temLoc + 1, temLen);
    }
    if (temStr.indexOf(tok) == -1)
        return temStr;
    else
        return temStr.substring(0, temStr.indexOf(tok));
}


function chineseNumber(num)
{
    if (parseFloat(num) <= 0.01) return "��Բ��"
    if (isNaN(num) || num > Math.pow(10, 12)) return ""
    var cn = "��Ҽ��������½��ƾ�"
    var unit = new Array("ʰ��Ǫ", "�ֽ�")
    var unit1 = new Array("����", "")
    var numArray = num.toString().split(".")
    var start = new Array(numArray[0].length - 1, 2)

    function toChinese(num, index)
    {
        var num = num.replace(/\d/g, function ($1)
        {
            return cn.charAt($1) + unit[index].charAt(start-- % 4 ? start % 4 : -1)
        })
        return num
    }

    for (var i = 0; i < numArray.length; i++)
    {
        var tmp = ""
        for (var j = 0; j * 4 < numArray[i].length; j++)
        {
            var strIndex = numArray[i].length - (j + 1) * 4
            var str = numArray[i].substring(strIndex, strIndex + 4)
            var start = i ? 2 : str.length - 1
            var tmp1 = toChinese(str, i)
            tmp1 = tmp1.replace(/(��.)+/g, "��").replace(/��+$/, "")
            tmp1 = tmp1.replace(/^Ҽʰ/, "ʰ")
            tmp = (tmp1 + unit1[i].charAt(j - 1)) + tmp
        }
        numArray[i] = tmp
    }

    numArray[1] = numArray[1] ? numArray[1] : ""
    numArray[0] = numArray[0] ? numArray[0] + "Բ" : numArray[0],numArray[1] = numArray[1].replace(/^��+/, "")
    numArray[1] = numArray[1].match(/��/) ? numArray[1] : numArray[1] + "��"
    return numArray[0] + numArray[1]
}


  function getTokNums(str,tok)
{
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
</SCRIPT>
<FORM method=post name="spubPrint">
    <BODY onload="doPrint()">

    </BODY>
</FORM>
<OBJECT
        classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
        codebase="/ocx/printatl.dll#version=1,0,0,1"
        id="printctrl"
        style="DISPLAY: none"
        VIEWASTEXT
        >
</OBJECT>

</HTML>    
