<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-15
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="jxl.*"%>
<%@ page import="jxl.format.UnderlineStyle"%>
<%@ page import="jxl.write.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%!

 void writeExcel(OutputStream os,StringTokenizer phoneNo,StringTokenizer returnMsg,String inputPara[])
 {
 	String fixStrings[]=new String[11+1];
 	fixStrings[0]="�������ƶ�ͨѶ��˾���ų�Ա�����ɹ���¼��������";
 	fixStrings[1]="�������ƣ�	";
 	fixStrings[2]="���ű�ţ�	";
 	fixStrings[3]="Ʒ�����ƣ�	";
 	fixStrings[4]="����	";
 	fixStrings[5]="�ͻ�����	";
 	fixStrings[6]="�ͻ�����绰��	";
 	fixStrings[7]="��ϸ��Ϣ			";
 	fixStrings[8]="�������ڣ�		";
 	fixStrings[9]="δ�ɹ�����";
 	fixStrings[10]="ʧ��ԭ��		";
 	fixStrings[11]="";
 	
 	
 	System.out.println("writeExcel");
 	try{
 			
  		//����������
      			WritableWorkbook wwb = Workbook.createWorkbook(os);  
     			
      		//����������
      			WritableSheet ws = wwb.createSheet("������Ϣ",0);
     			
  			
  		
  		//д��̶�����
		for(int i=0;i<11;i++)
		{
            		int fn=10;	//�ֺ�
        		int column =0;	//��
        		int row = 0;	//��
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            		if(i==0){fn=15;column=1;row=1;} //�������ƶ�ͨѶ��˾���ų�Ա�����ɹ���¼��������
         		if(i==1){column=1;row=3;}  	//�������ƣ�	
         		if(i==2){column=4;row=3;}	//���ű�ţ�	
           		if(i==3){column=7;row=3;}  	//��������ţ�	
         		if(i==4){column=1;row=4;}  	//����	
         		if(i==5){column=4;row=4;}  	//�ͻ�����	
         		if(i==6){column=7;row=4;}  	//�ͻ�����绰��
         		if(i==7){column=3;row=6;}  	//��ϸ��Ϣ			
         		if(i==8){column=7;row=6;}  	//���ڣ�		
         		if(i==9){column=1;row=7;}  	//δ�ɹ�����
         		if(i==10){column=4;row=7;}  	//ʧ��ԭ��		
         		 
            		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.BOLD, false);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, row, fixStrings[i], wcfF);
            		ws.addCell(labelCF);	
        	}
        	
        	//д���ֻ���
        	int phoneRow = 7;
        	while (phoneNo.hasMoreTokens()) 
        	 {
        	 	int fn=10;
            		int column =1;
            		phoneRow++;
         		WritableFont wf=null;
         		WritableCellFormat wcfF=null;
         		Label labelCF=null;
         		
         		
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            		wf.setColour(jxl.format.Colour.RED);
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, phoneRow, phoneNo.nextToken(), wcfF);
            		ws.addCell(labelCF);
            		
        	 }
    		//д�������Ϣ
    		phoneRow = 7;
    		while (returnMsg.hasMoreTokens()) 
        	 {
        	 	int fn=10;
            		int column =4;
            		phoneRow++;
         		WritableFont wf=null;
         		WritableCellFormat wcfF=null;
         		Label labelCF=null;
         		
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);
            		wf.setColour(jxl.format.Colour.RED); 
            		wcfF = new WritableCellFormat(wf);
           		labelCF = new Label(column, phoneRow, returnMsg.nextToken(), wcfF);
            		ws.addCell(labelCF);
            	   }
            	 //д��������Ϣ
            	 for(int i=0;i<inputPara.length-2;i++)
            	  {
            	  	int fn=10;	//�ֺ�
        		int column =0;	//��
        		int Row = 0;	//��
       			WritableFont wf=null;
        		WritableCellFormat wcfF=null;
       			Label labelCF=null;
            	  	
            	  	if(i==0) //��������
            	  	 { fn=10; column =2; Row=3; }
          	  
            	 	 if(i==1) //���ű��
            	  	 { fn=10; column =5;Row=3; }
            	  	
            	  	if(i==2) //���,ɾ��
            	  	 {fn=10;column =8;Row=1;}
            	  	            	  	 
            	  	if(i==3) //����  
            	  	 {fn=10; column =2; Row=4;}
            	  	 
            	  	if(i==4) //�ͻ����� 
            	  	 {fn=10; column =5; Row=4;}
            	  	 
            	  	if(i==5) //�ͻ�����绰 
            	  	 {fn=10; column =9; Row=4;}  
            	  	 
            	  	if(i==6) //����
            	  	 {fn=10; column =9; Row=6;}  
            	  	 
            	  	if(i==7)  //���������  
            	  	 {fn=10; column =9; Row=3;}   
            	  	                                                                          	
         		wf = new WritableFont(WritableFont.ARIAL, fn, WritableFont.NO_BOLD, false);  	
            		wcfF = new WritableCellFormat(wf);                                           	
           		labelCF = new Label(column, Row, inputPara[i], wcfF);                        	
            		ws.addCell(labelCF);                                                         	
            	  
            	  }
            	 
            	 
      wwb.write();
      wwb.close();

  }catch(Exception e)
  {   
      System.out.println(e.toString());
  }
 }
%>

<html>
<head>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel">
<title>�����ļ�</title>
</head>


<body>
<%
	
	String regionCode=(String)session.getAttribute("regCode");
	
	//
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	//SPubCallSvrImpl callView = new SPubCallSvrImpl();
	String sqlStr ="select  a.boss_vpmn_code,a.service_no,b.phone_no,a.org_code from dgrpcustmsg a,dbvipadm.dgrpmanagermsg b where a.service_no=b.service_no and a.unit_id = '";
	//
	String grpName="" ;		//��������
	String unitID=""  ;		//���ű��
	String op_Code="" ;		//����opcode�ж������ӻ���ɾ��
	StringTokenizer phoneNo=null;	//���ɹ��ֻ�����
	StringTokenizer returnMsg=null;	//����ԭ��
	String orgCode="";		//����
	String service_no="";		//�ͻ�����
	String service_phone_no="";	//�ͻ�����绰
	String currDate="";		//���� yyyyMMdd
	String loginAccept=""	;	//��ˮ��
	String fileName="";		//�����ļ�����
	String vpmn_code="";		//���������
	String inputPara[]=new String[9+1];
	//
	phoneNo=new StringTokenizer(request.getParameter("phoneNo"),"|");
	returnMsg=new StringTokenizer(request.getParameter("returnMsg"),"|");	
	//
	SimpleDateFormat s=new SimpleDateFormat("yyyyMMddHHmmSS");
   	Date c=new Date();
  	currDate=s.format(c)+"_";
	//
	grpName=request.getParameter("grpName");
	unitID=request.getParameter("unitID");
	op_Code=request.getParameter("op_Code");
	orgCode=request.getParameter("orgCode");
	loginAccept=request.getParameter("loginAccept")+"_";
	vpmn_code = request.getParameter("sm_name");;
	//
	if(unitID.length()>2)
	 {
	 	sqlStr=sqlStr+unitID+"'";
	 	System.out.println("===== Save xls file Msg: sqlstr="+sqlStr);
	 	try {
	 	 	//retArray = callView.sPubSelect("4",sqlStr);
	 	 	
%>

		<wtc:pubselect name="sPubSelect" outnum="4" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result" scope="end"/>

<%	 	 	
	 		//result = (String[][])retArray.get(0);
	 		int recordNum = result.length;
	 		//System.out.println("---------------result.length;------------hjw------------"+result.length);
	 		System.out.println("===== Save xls file Msg: recordMun="+recordNum);
	 		if(recordNum>=1)
	 		 {
	 		 
	 		 //System.out.println("----------------result[0][0].trim();------------hjw------------"+result[0][0].trim());
	 		 //System.out.println("----------------result[0][1].trim();------------hjw------------"+result[0][1].trim());
	 		 //System.out.println("----------------result[0][2].trim();------------hjw------------"+result[0][2].trim());
	 		 
	 		 //---------------result.length;------------hjw------------1
       //----------------result[0][0].trim();------------hjw------------4510004397
       //----------------result[0][1].trim();------------hjw------------aavg75
       //----------------result[0][2].trim();------------hjw------------13936661658
       
       
       
       
	 		 	service_no=result[0][1].trim();
	 		 	service_phone_no=result[0][2].trim();
	 		 	
	 		 }
	 		 
	 		
	 	    }
	 	catch(Exception e)
	 	    {
			System.out.println(e.toString());
                    } 
	 	
	 }
	
	//
	inputPara[0]=grpName;
	inputPara[1]=unitID;
	if(op_Code.equals("3709"))
		inputPara[2]="��ӳ�Ա"; 
	if(op_Code.equals("3704"))
	        inputPara[2]="ɾ����Ա";
	if(op_Code.equals("3605")) 
	        inputPara[2]="�ײͱ��"; 
		              
	inputPara[3]=orgCode;
	inputPara[4]=service_no;
	inputPara[5]=service_phone_no;
	inputPara[6]=s.format(c);
	inputPara[7]=vpmn_code;
	//
	
	
	//
	response.reset();//���Buffer
	response.setContentType("application/vnd.ms-excel;charset=GBK");//�ļ�����
	response.setHeader("Content-Disposition","attachment;filename=\"" +currDate+unitID+".xls" + "\"");                                                                                                                                                                                             
	writeExcel(response.getOutputStream(),phoneNo,returnMsg, inputPara);

%>
	
</body>
</html>
